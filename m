Received: from eggs.gnu.org ([2001:4830:134:3::10]:53075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNJN-0004u4-MB
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNJM-0006Yi-OW
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:01 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39522)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNJK-0006Se-N3
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:00 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 29 Nov 2018 17:28:54 +0300
Message-ID: <154350173476.8036.14500512061400455655.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
References: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 15/39] windbg: handler of parsing context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 windbgstub.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/windbgstub.c b/windbgstub.c
index c45faec43f..fe0b007a06 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -15,6 +15,7 @@
 #include "chardev/char-fe.h"
 #include "qemu/cutils.h"
 #include "sysemu/reset.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "exec/windbgstub.h"
 #include "exec/windbgstub-utils.h"
@@ -113,7 +114,6 @@ static void windbg_send_data_packet(WindbgState *state, uint8_t *data,
     state->wait_packet_type = PACKET_TYPE_KD_ACKNOWLEDGE;
 }
 
-__attribute__ ((unused)) /* unused yet */
 static void windbg_send_control_packet(WindbgState *state, uint16_t type,
                                        uint32_t id)
 {
@@ -130,8 +130,52 @@ static void windbg_send_control_packet(WindbgState *state, uint16_t type,
     qemu_chr_fe_write(&state->chr, PTR(packet), sizeof(packet));
 }
 
+static void windbg_vm_stop(void)
+{
+    vm_stop(RUN_STATE_PAUSED);
+}
+
+static void windbg_process_data_packet(WindbgState *state)
+{
+}
+
+static void windbg_process_control_packet(WindbgState *state)
+{
+}
+
 static void windbg_ctx_handler(WindbgState *state)
 {
+    if (!state->is_loaded) {
+        if (state->ctx.result == RESULT_BREAKIN_BYTE) {
+            state->catched_breakin_byte = true;
+        }
+        return;
+    }
+
+    switch (state->ctx.result) {
+    case RESULT_NONE:
+        break;
+
+    case RESULT_BREAKIN_BYTE:
+        windbg_vm_stop();
+        break;
+
+    case RESULT_CONTROL_PACKET:
+        windbg_process_control_packet(state);
+        break;
+
+    case RESULT_DATA_PACKET:
+        windbg_process_data_packet(state);
+        break;
+
+    case RESULT_UNKNOWN_PACKET:
+    case RESULT_ERROR:
+        windbg_send_control_packet(state, PACKET_TYPE_KD_RESEND, 0);
+        break;
+
+    default:
+        break;
+    }
 }
 
 static void windbg_read_byte(ParsingContext *ctx, uint8_t byte)
@@ -260,6 +304,14 @@ void windbg_try_load(void)
     if (windbg_state && !windbg_state->is_loaded) {
         if (windbg_on_load()) {
             windbg_state->is_loaded = true;
+
+            /* Handle last packet. Or we can require resend last packet. */
+            windbg_ctx_handler(windbg_state);
+
+            if (windbg_state->catched_breakin_byte == true) {
+                windbg_vm_stop();
+                windbg_state->catched_breakin_byte = false;
+            }
         }
     }
 }
