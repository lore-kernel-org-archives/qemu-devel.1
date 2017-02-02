Received: from eggs.gnu.org ([2001:4830:134:3::10]:52976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kN-00085H-FV
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kF-0004PK-Ls
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:41 +1100
Message-Id: <20170202051445.5735-104-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 103/107] tcg/POWER9: NOOP the cp_abort
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The cp_abort instruction is used to remove the state of an in progress
copy paste sequence. POWER9 compilers add this in various places, such
as context switches which causes illegal instruction signals since we
don't yet implement this instruction.

Given there is no implementation of the copy paste facility and that we
don't claim to support it, we can just noop this instruction.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5934185..b48abae 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6020,6 +6020,10 @@ GEN_TM_NOOP(tabortwci);
 GEN_TM_NOOP(tabortdc);
 GEN_TM_NOOP(tabortdci);
 GEN_TM_NOOP(tsr);
+static inline void gen_cp_abort(DisasContext *ctx)
+{
+    // Do Nothing
+}
 
 static void gen_tcheck(DisasContext *ctx)
 {
@@ -6170,6 +6174,7 @@ GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
 GEN_HANDLER_E(cnttzw, 0x1F, 0x1A, 0x10, 0x00000000, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(or, 0x1F, 0x1C, 0x0D, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(xor, 0x1F, 0x1C, 0x09, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(ori, 0x18, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-- 
2.9.3
