Received: from eggs.gnu.org ([2001:4830:134:3::10]:43786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6T2-00081W-37
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Sy-0005FE-VU
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:00 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:38800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6Sy-0005Ef-NO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:31:56 -0400
Received: by mail-lf0-x243.google.com with SMTP id z142-v6so3769823lff.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:31:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:16 +0200
Message-Id: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 00/36] target-microblaze: Add support for
 Extended Addressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This series adds support for Extended Addressing to our MicroBlaze
models. It adds both the non-MMU load/store EA and the extended MMU
addressing.

There are several ways to implement this but since there are further
64-bit extensions in the pipe, I've chosen to convert the cpu_SR
special regs to 64-bit. Both non-EA and EA enabled cores run out of
the same build with TARGET_LONG_BITS=64.

Patches 30 - 36 are new patches cleaning up code suggested during
review.

Comments?

Thanks & Best regards,
Edgar

ChangeLog:

v1 -> v2:
* Add patch to simplify address computation using tcg_gen_addi_i32()
* Add patches to cleanup eval_cond_jmp using tcg_gen_movcond_i32()
* Add patch to cleanup microblaze MMU logs
* Correct trap_userspace() usage when adding Extended Addressing
* Correct name for special register sr13 to redr


Edgar E. Iglesias (36):
  target-microblaze: dec_load: Use bool instead of unsigned int
  target-microblaze: dec_store: Use bool instead of unsigned int
  target-microblaze: compute_ldst_addr: Use bool instead of int
  target-microblaze: Fallback to our latest CPU version
  target-microblaze: Correct special register array sizes
  target-microblaze: Correct the PVR array size
  target-microblaze: Tighten up TCGv_i32 vs TCGv type usage
  target-microblaze: Remove USE_MMU PVR checks
  target-microblaze: Conditionalize setting of PVR11_USE_MMU
  target-microblaze: Bypass MMU with MMU_NOMMU_IDX
  target-microblaze: Make compute_ldst_addr always use a temp
  target-microblaze: Remove pointer indirection for ld/st addresses
  target-microblaze: Use TCGv for load/store addresses
  target-microblaze: Name special registers we support
  target-microblaze: Break out trap_userspace()
  target-microblaze: Break out trap_illegal()
  target-microblaze: dec_msr: Use bool and extract32
  target-microblaze: dec_msr: Reuse more code when reg-decoding
  target-microblaze: dec_msr: Fix MTS to FSR
  target-microblaze: Make special registers 64-bit
  target-microblaze: Setup for 64bit addressing
  target-microblaze: Add Extended Addressing
  target-microblaze: Implement MFSE EAR
  target-microblaze: mmu: Add R_TBLX_MISS macros
  target-microblaze: mmu: Remove unused register state
  target-microblaze: mmu: Prepare for 64-bit addresses
  target-microblaze: mmu: Add a configurable output address mask
  target-microblaze: Add support for extended access to TLBLO
  target-microblaze: Allow address sizes between 32 and 64 bits
  target-microblaze: Simplify address computation using
    tcg_gen_addi_i32()
  target-microblaze: mmu: Cleanup debug log messages
  target-microblaze: Use table based condition-codes conversion
  target-microblaze: Remove argument b in eval_cc()
  target-microblaze: Convert env_btaken to i64
  target-microblaze: Convert env_btarget to i64
  target-microblaze: Use tcg_gen_movcond in eval_cond_jmp

 configure                        |   1 +
 linux-user/microblaze/cpu_loop.c |   4 +-
 target/microblaze/cpu.c          |  30 +-
 target/microblaze/cpu.h          |  20 +-
 target/microblaze/helper.c       |  30 +-
 target/microblaze/helper.h       |   8 +-
 target/microblaze/mmu.c          |  81 ++--
 target/microblaze/mmu.h          |  17 +-
 target/microblaze/op_helper.c    |  31 +-
 target/microblaze/translate.c    | 926 +++++++++++++++++++--------------------
 10 files changed, 585 insertions(+), 563 deletions(-)

-- 
2.14.1
