Received: from eggs.gnu.org ([2001:4830:134:3::10]:39074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9DN-0008R6-R2
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9DM-0002KY-SM
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:53 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37746)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9DM-0002KP-Ka
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:52 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:07:50 +0300
Message-ID: <151127326975.6888.7412598949426946227.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 06/45] windbg: added WindbgState
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

Added definition of the WindbgState struct and its initialization.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/windbgstub.c b/windbgstub.c
index 3830446988..0863da73fd 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -10,10 +10,38 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "qemu/cutils.h"
 #include "exec/windbgstub.h"
 #include "exec/windbgstub-utils.h"
 
+typedef struct WindbgState {
+    bool is_loaded;
+
+    uint32_t ctrl_packet_id;
+    uint32_t data_packet_id;
+} WindbgState;
+
+static WindbgState *windbg_state;
+
+static void windbg_exit(void)
+{
+    g_free(windbg_state);
+}
+
 int windbg_server_start(const char *device)
 {
+    if (windbg_state) {
+        WINDBG_ERROR("Multiple instances of windbg are not supported.");
+        exit(1);
+    }
+
+    windbg_state = g_new0(WindbgState, 1);
+    windbg_state->ctrl_packet_id = RESET_PACKET_ID;
+    windbg_state->data_packet_id = INITIAL_PACKET_ID;
+
+    atexit(windbg_exit);
     return 0;
 }
