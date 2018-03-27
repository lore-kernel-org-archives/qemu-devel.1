Received: from eggs.gnu.org ([2001:4830:134:3::10]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1f0eJE-00026c-He
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1f0eJB-0005AE-9O
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:26:00 -0400
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net
	([173.201.193.233]:47661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1f0eJB-00058T-2w
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:25:57 -0400
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Mon, 26 Mar 2018 22:25:24 -0400
Message-ID: <3978804.GGRd8R3pmO@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] [PATCH 01/02] leon3: change the handling for
 ASI_LEON_NOCACHE to be aware of if the MMU is enabled or not
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

>From f512606776e20dc603b8ea3faaeb103667de3178 Mon Sep 17 00:00:00 2001
From: Steven Seeger <steven.seeger@flightsystems.net>
Date: Sun, 25 Mar 2018 17:58:21 -0400
Subject: [PATCH 1/6] leon3: change the handling for ASI_LEON_NOCACHE to be
 aware of if the MMU is enabled or not

Signed-off-by: Steven Seeger <steven.seeger@flightsystems.net>
---
 target/sparc/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f55ec28665..ab8d0a0c72 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2121,6 +2121,9 @@ static DisasASI get_asi(DisasContext *dc, int insn, 
TCGMemOp memop)
                || (asi == ASI_USERDATA
                    && (dc->def->features & CPU_FEATURE_CASA))) {
         switch (asi) {
+        case ASI_LEON_NOCACHE: /* force cache miss */
+            type = GET_ASI_DIRECT;
+            break;
         case ASI_USERDATA:   /* User data access */
             mem_idx = MMU_USER_IDX;
             type = GET_ASI_DIRECT;
@@ -2131,7 +2134,6 @@ static DisasASI get_asi(DisasContext *dc, int insn, 
TCGMemOp memop)
             break;
         case ASI_M_BYPASS:    /* MMU passthrough */
         case ASI_LEON_BYPASS: /* LEON MMU passthrough */
-        case ASI_LEON_NOCACHE:
             mem_idx = MMU_PHYS_IDX;
             type = GET_ASI_DIRECT;
             break;
-- 
2.16.1
