Received: from eggs.gnu.org ([2001:4830:134:3::10]:33402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RdW-0003gY-PZ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RdO-0005G8-BU
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:20 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56730)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RdO-0005ET-4E
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:10:14 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:10:03 +0300
Message-ID: <150824580366.6816.5820779598615789570.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 13/43] windbg: handler of parsing context
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

Implemented handler of parsing context.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub.c |   36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/windbgstub.c b/windbgstub.c
index 8c33e0de0a..b71449e369 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "sysemu/sysemu.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qemu/cutils.h"
@@ -97,7 +98,6 @@ static void windbg_send_data_packet(uint8_t *data, uint16_t byte_count,
     windbg_state->data_packet_id ^= 1;
 }
 
-__attribute__ ((unused)) /* unused yet */
 static void windbg_send_control_packet(uint16_t type)
 {
     KD_PACKET packet = {
@@ -116,9 +116,41 @@ static void windbg_send_control_packet(uint16_t type)
     windbg_state->ctrl_packet_id ^= 1;
 }
 
-static void windbg_ctx_handler(ParsingContext *ctx)
+static void windbg_process_data_packet(ParsingContext *ctx)
 {}
 
+static void windbg_process_control_packet(ParsingContext *ctx)
+{}
+
+static void windbg_ctx_handler(ParsingContext *ctx)
+{
+    switch (ctx->result) {
+    case RESULT_NONE:
+        break;
+
+    case RESULT_BREAKIN_BYTE:
+        vm_stop(RUN_STATE_PAUSED);
+        break;
+
+    case RESULT_CONTROL_PACKET:
+        windbg_process_control_packet(ctx);
+        break;
+
+    case RESULT_DATA_PACKET:
+        windbg_process_data_packet(ctx);
+        break;
+
+    case RESULT_UNKNOWN_PACKET:
+    case RESULT_ERROR:
+        windbg_state->ctrl_packet_id = 0;
+        windbg_send_control_packet(PACKET_TYPE_KD_RESEND);
+        break;
+
+    default:
+        break;
+    }
+}
+
 static void windbg_read_byte(ParsingContext *ctx, uint8_t byte)
 {
     switch (ctx->state) {
