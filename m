Received: from eggs.gnu.org ([2001:4830:134:3::10]:41233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJN-0007hN-RY
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJG-0003pP-70
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:19 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59758)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJE-0003nO-9I
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:13 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:59:06 +0300
Message-ID: <154409754657.5432.6639535359256257810.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 05/39] windbg: add WindbgState
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

Add definition of the WindbgState struct and its initialization.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 windbgstub.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/windbgstub.c b/windbgstub.c
index 4673703b66..b073cc6a3f 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -13,7 +13,38 @@
 #include "exec/windbgstub.h"
 #include "exec/windbgstub-utils.h"
 
+typedef struct WindbgState {
+    bool is_loaded;
+    bool catched_breakin_byte;
+    uint32_t wait_packet_type;
+    uint32_t curr_packet_id;
+} WindbgState;
+
+static WindbgState *windbg_state;
+
+static void windbg_state_clean(WindbgState *state)
+{
+    state->is_loaded = false;
+    state->catched_breakin_byte = false;
+    state->wait_packet_type = 0;
+    state->curr_packet_id = INITIAL_PACKET_ID | SYNC_PACKET_ID;
+}
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
+    windbg_state_clean(windbg_state);
+
+    atexit(windbg_exit);
     return 0;
 }
