Received: from eggs.gnu.org ([2001:4830:134:3::10]:50891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1eACph-0007PW-HF
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1eACpe-0005Xr-BX
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:34:45 -0400
From: Luc MICHEL <luc.michel@git.antfield.fr>
Date: Thu,  2 Nov 2017 11:35:58 +0100
Message-Id: <20171102103559.7382-1-luc.michel@git.antfield.fr>
Subject: [Qemu-devel] [PATCH 0/1] target-ppc: booke206 tlb: fix tlbwe
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

Hi,

I was experiencing random segmentation faults of userland applications
in a guest e500 powerpc Linux. After investigating, I found that this
bug appeared with commit 9fb044911444fdd09f5f072ad0ca269d7f8b841d. This
commit introduces more MMU indices to avoid unnecessary TLB flushes when
the CPU changes mode.

It triggers a new bug however, that I finally traced down into the tlbwe
instructions simulation. When replacing a valid TLB entry with a new
one, the previous page was not flushed from QEMU TLB.

This fixes my random crashes in guest Linux. Note that I think there is
a similar issue in booke206_invalidate_ea_tlb but in my case, Linux
never triggers this code so I was not able to test.

Luc MICHEL (1):
  target-ppc: Fix booke206 tlbwe TLB instruction

 target/ppc/mmu_helper.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.14.3
