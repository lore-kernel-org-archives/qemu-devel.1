Received: from eggs.gnu.org ([2001:4830:134:3::10]:55199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cvYLK-0008NQ-M7
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cvYLF-0006dq-OP
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:58:34 -0400
Received: from mail-dm3nam03on0082.outbound.protection.outlook.com
	([104.47.41.82]:1440
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cvYLF-0006cm-Fp
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:58:29 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 4 Apr 2017 16:40:07 -0700
Message-ID: <f65e921725d39ce81c2d0910d59897a020596c58.1491349058.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1491349058.git.alistair.francis@xilinx.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/5] cadence_gem: Correct the multi-queue
 can rx logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Correct the buffer descriptor busy logic to work correctly when using
multiple queues.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/net/cadence_gem.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 17c229d..3e37665 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -481,14 +481,18 @@ static int gem_can_receive(NetClientState *nc)
     }
 
     for (i = 0; i < s->num_priority_queues; i++) {
-        if (rx_desc_get_ownership(s->rx_desc[i]) == 1) {
-            if (s->can_rx_state != 2) {
-                s->can_rx_state = 2;
-                DB_PRINT("can't receive - busy buffer descriptor (q%d) 0x%x\n",
-                         i, s->rx_desc_addr[i]);
-             }
-            return 0;
+        if (rx_desc_get_ownership(s->rx_desc[i]) != 1) {
+            break;
+        }
+    };
+
+    if (i == s->num_priority_queues) {
+        if (s->can_rx_state != 2) {
+            s->can_rx_state = 2;
+            DB_PRINT("can't receive - busy buffer descriptor (q%d) 0x%x\n",
+                     i, s->rx_desc_addr[i]);
         }
+        return 0;
     }
 
     if (s->can_rx_state != 0) {
-- 
2.9.3
