Received: from eggs.gnu.org ([2001:4830:134:3::10]:37582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1fYmmE-0007Z8-HF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1fYmmD-0006NH-M6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:21:02 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 29 Jun 2018 16:20:24 +1000
Message-Id: <20180629062024.20477-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH] ppc/tcg: Ignore bit 6 in the eieio
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The kernel patch
"powerpc/64s: Add support for a store forwarding barrier at kernel entry/exit"
adds an eieio barrier instruction to kernel entry and exit points on
the POWER9 platform. The eieio instruction form used has bit 6 set.
This bit is ignored by hardware however under tcg it causes an illegal
instruction.

To allow these kernels to run under tcg, modify the eieio instruction
to ignore bit 6.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3457d29f8e..b1ad1e2a22 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6496,7 +6496,7 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
 GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
-GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x03FFF801, PPC_MEM_EIEIO),
+GEN_HANDLER(eieio, 0x1F, 0x16, 0x1A, 0x01FFF801, PPC_MEM_EIEIO),
 GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
 GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
-- 
2.13.6
