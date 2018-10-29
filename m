Received: from eggs.gnu.org ([2001:4830:134:3::10]:47099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH9rV-0000PW-Ox
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH9rO-0000Uj-Iv
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:53:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gH9rO-0000SH-2m
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:53:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id p2-v6so8443584wmc.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:53:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 29 Oct 2018 15:53:35 +0000
Message-Id: <20181029155339.15280-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] target/arm: Minimize TLB flushing for ASID
 changes
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

In http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg04181.html
(already upstream) I added a check for ASID changes without realizing
that TTBCR_EL1 has the A1 bit, controlling which register actually
contains the active ASID.

In http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg04182.html
I suggested a set of mmu_idx to flush when the ASID does change.  In
follow-up, Peter suggested more.

I now choose secure vs non-secure mmu_idx based on which register is being
modified, not the current state of the cpu.  Unless I am mistaken, secure
state can write to the non-secure registers.  Which means that the current
state of the cpu is irrelevant and only the register matters.

Peter suggested flushing S1E3 when changing ttbr0_s.  I can see how this
is overlapped onto the EL3 (Secure Monitor) state, but I cannot see how
the ASID is used from EL3.  The best evidence I can find for this is that
there is no TLBIASID* register that is applicable to flushing EL3; that's
not conclusive proof though.  So while I'm not sure it's necessary, I'm
also not sure it isn't necessary, and so I've included S1E3 in the flush.

I now also use the VMID to conditionally invalidate the stage 2 translation
state.  This shows how I anticipaged @depmap to be used in patch 1.


r~


Richard Henderson (4):
  cputlb: Add tlb_set_asid_for_mmuidx
  target/arm: Install ASIDs for long-form from EL1
  target/arm: Install ASIDs for short-form from EL1
  target/arm: Install ASIDs for EL2

 include/exec/cpu-defs.h |   2 +
 include/exec/exec-all.h |  19 ++++++
 accel/tcg/cputlb.c      |  23 +++++++
 target/arm/helper.c     | 133 ++++++++++++++++++++++++++--------------
 4 files changed, 131 insertions(+), 46 deletions(-)

-- 
2.17.2
