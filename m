Received: from eggs.gnu.org ([2001:4830:134:3::10]:54030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1g9G23-00070j-Ko
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 16:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1g9G1y-0006WB-LO
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 16:52:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:38165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1g9G1y-0006V2-B8
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 16:52:02 -0400
Date: Sun, 7 Oct 2018 22:51:53 +0200
From: Helge Deller <deller@gmx.de>
Message-ID: <20181007205153.GA30270@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] qemu-system-hppa: Raise exception 26 on
 emulated hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On PCXS chips (PA7000, pa 1.1a), trap #18 is raised on memory faults,
while all later chips (>= PA7100) generate either trap #26, #27 or #28
(depending on the fault type).

Since the current qemu emulation emulates a B160L machine (with a
PA7300LC PCX-L2 chip, we should raise trap #26 (EXCP_DMAR) instead of
#18 (EXCP_DMP) on access faults by the Linux kernel to page zero.

With the patch we now get the correct output (I tested against real
hardware):
 Kernel Fault: Code=26 (Data memory access rights trap) (Addr=00000004)
instead of:
 Kernel Fault: Code=18 (Data memory protection/unaligned access trap) (Addr=00000004)

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index ab160c2a74..aecf3075f6 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -137,7 +137,8 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     if (unlikely(!(prot & type))) {
         /* The access isn't allowed -- Inst/Data Memory Protection Fault.  */
-        ret = (type & PAGE_EXEC ? EXCP_IMP : EXCP_DMP);
+        ret = (type & PAGE_EXEC ? EXCP_IMP :
+               prot & PAGE_READ ? EXCP_DMP : EXCP_DMAR);
         goto egress;
     }
 
