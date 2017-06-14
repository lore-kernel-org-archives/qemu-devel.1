Received: from eggs.gnu.org ([2001:4830:134:3::10]:39620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1dLI06-0007Iw-Gp
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 19:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1dLI01-0007OH-Mb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 19:47:02 -0400
From: Anton Blanchard <anton@ozlabs.org>
Date: Thu, 15 Jun 2017 09:46:44 +1000
Message-Id: <20170614234645.12058-1-anton@ozlabs.org>
Subject: [Qemu-devel] [PATCH 1/2] powerpc: Fix emulation of mcrf in
 emulate_step()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de, aneesh.kumar@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

From: Anton Blanchard <anton@samba.org>

The mcrf emulation code was looking at the CR fields in the reverse
order. It also relied on reserved fields being zero which is somewhat
fragile, so fix that too.

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/sstep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 33117f8a0882..fb84f51b1f0b 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -683,8 +683,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
 	case 19:
 		switch ((instr >> 1) & 0x3ff) {
 		case 0:		/* mcrf */
-			rd = (instr >> 21) & 0x1c;
-			ra = (instr >> 16) & 0x1c;
+			rd = 7 - ((instr >> 23) & 0x7);
+			ra = 7 - ((instr >> 18) & 0x7);
+			rd *= 4;
+			ra *= 4;
 			val = (regs->ccr >> ra) & 0xf;
 			regs->ccr = (regs->ccr & ~(0xfUL << rd)) | (val << rd);
 			goto instr_done;
-- 
2.11.0
