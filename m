Received: from eggs.gnu.org ([2001:4830:134:3::10]:45421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hf-0001FD-6U
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hc-00089K-31
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:03 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:52 -0500
Message-Id: <20180619014319.28272-27-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 026/113] sparc: fix leon3 casa instruction when
 MMU is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: KONRAD Frederic <frederic.konrad@adacore.com>

Since the commit af7a06bac7d3abb2da48ef3277d2a415772d2ae8:
`casa [..](10), .., ..` (and probably others alternate space instructions)
triggers a data access exception when the MMU is disabled.

When we enter get_asi(...) dc->mem_idx is set to MMU_PHYS_IDX when the MMU
is disabled. Just keep mem_idx unchanged in this case so we passthrough the
MMU when it is disabled.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit 6e10f37c86068e35151f982c976a85f1bec07ef2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/sparc/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 849a02aebd..63693f72e3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2093,6 +2093,11 @@ static DisasASI get_asi(DisasContext *dc, int insn, TCGMemOp memop)
             type = GET_ASI_BFILL;
             break;
         }
+
+        /* MMU_PHYS_IDX is used when the MMU is disabled to passthrough the
+         * permissions check in get_physical_address(..).
+         */
+        mem_idx = (dc->mem_idx == MMU_PHYS_IDX) ? MMU_PHYS_IDX : mem_idx;
     } else {
         gen_exception(dc, TT_PRIV_INSN);
         type = GET_ASI_EXCP;
-- 
2.11.0
