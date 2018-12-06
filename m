Received: from eggs.gnu.org ([2001:4830:134:3::10]:41301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJV-0007kf-Lt
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJR-00041E-J0
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:29 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59794)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJN-0003qY-Q3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:23 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:59:12 +0300
Message-ID: <154409755217.5432.7126529786056101192.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 06/39] windbg: add chardev
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

Add chardev for listening to windbg client. Target device is a parameter
in the '-windbg' option.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 windbgstub.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/windbgstub.c b/windbgstub.c
index b073cc6a3f..85e2215f73 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -10,6 +10,10 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "qemu/cutils.h"
 #include "exec/windbgstub.h"
 #include "exec/windbgstub-utils.h"
 
@@ -18,6 +22,8 @@ typedef struct WindbgState {
     bool catched_breakin_byte;
     uint32_t wait_packet_type;
     uint32_t curr_packet_id;
+
+    CharBackend chr;
 } WindbgState;
 
 static WindbgState *windbg_state;
@@ -30,6 +36,15 @@ static void windbg_state_clean(WindbgState *state)
     state->curr_packet_id = INITIAL_PACKET_ID | SYNC_PACKET_ID;
 }
 
+static int windbg_chr_can_receive(void *opaque)
+{
+    return PACKET_MAX_SIZE;
+}
+
+static void windbg_chr_receive(void *opaque, const uint8_t *buf, int size)
+{
+}
+
 static void windbg_exit(void)
 {
     g_free(windbg_state);
@@ -37,14 +52,30 @@ static void windbg_exit(void)
 
 int windbg_server_start(const char *device)
 {
+    Chardev *chr = NULL;
+
     if (windbg_state) {
         WINDBG_ERROR("Multiple instances of windbg are not supported.");
         exit(1);
     }
 
+    if (!strstart(device, "pipe:", NULL)) {
+        WINDBG_ERROR("Unsupported device. Supported only pipe.");
+        exit(1);
+    }
+
     windbg_state = g_new0(WindbgState, 1);
     windbg_state_clean(windbg_state);
 
+    chr = qemu_chr_new_noreplay("windbg", device, true);
+    if (!chr) {
+        return -1;
+    }
+
+    qemu_chr_fe_init(&windbg_state->chr, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&windbg_state->chr, windbg_chr_can_receive,
+                             windbg_chr_receive, NULL, NULL, NULL, NULL, true);
+
     atexit(windbg_exit);
     return 0;
 }
