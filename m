Received: from eggs.gnu.org ([2001:4830:134:3::10]:43725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F92-0008PT-I0
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F90-00087n-WE
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F90-00084S-OF
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8v-0006wP-6V
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:58 +0100
Message-Id: <1492706470-10921-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/24] cadence_gem: Correct the multi-queue can
 rx logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Correct the buffer descriptor busy logic to work correctly when using
multiple queues.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 8a7e8059984e27d46a276a66299d035a0afd280f.1491947224.git.alistair.francis@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 17c229d..a66a9cc 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -481,14 +481,17 @@ static int gem_can_receive(NetClientState *nc)
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
+            DB_PRINT("can't receive - all the buffer descriptors are busy\n");
         }
+        return 0;
     }
 
     if (s->can_rx_state != 0) {
-- 
2.7.4
