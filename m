Received: from eggs.gnu.org ([2001:4830:134:3::10]:53427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Wj-0002pp-JA
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Wg-0000el-EY
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:53 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:39492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1Wg-0000eZ-7d
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:50 -0400
Received: by mail-wr0-x232.google.com with SMTP id q3-v6so2764343wrj.6
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:51:49 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:08 +0200
Message-Id: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 00/38] target-microblaze: Add support for
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This series adds support for Extended Addressing to our MicroBlaze
models. It adds both the non-MMU load/store EA and the extended MMU
addressing.

There are several ways to implement this but since there are further
64-bit extensions in the pipe, I've chosen to convert the cpu_SR
special regs to 64-bit. Both non-EA and EA enabled cores run out of
the same build with TARGET_LONG_BITS=64.

Comments?

The following lacks review:
$ grep -L Reviewed v3/patches/*
v3/patches/0000-cover-letter.patch
v3/patches/0028-target-microblaze-dec_msr-Plug-a-temp-leak.patch
v3/patches/0029-target-microblaze-Add-support-for-extended-access-to.patch
v3/patches/0035-target-microblaze-Convert-env_btarget-to-i64.patch
v3/patches/0036-target-microblaze-Use-tcg_gen_movcond-in-eval_cond_j.patch
v3/patches/0037-target-microblaze-cpu_mmu_index-Fixup-indentation.patch
v3/patches/0038-target-microblaze-Consolidate-MMU-enabled-checks.patch

Thanks & Best regards,
Edgar

ChangeLog:

v2 -> v3:
* Add patch to consolidate MMU enabled checks
* Remove patch to convert env_btaken to 64bits
* Add patch to plug tcg_const leakage
* Fix TLBLO access patch to avoid leaking tcg consts

v1 -> v2:
* Add patch to simplify address computation using tcg_gen_addi_i32()
* Add patches to cleanup eval_cond_jmp using tcg_gen_movcond_i32()
* Add patch to cleanup microblaze MMU logs
* Correct trap_userspace() usage when adding Extended Addressing
* Correct name for special register sr13 to redr


Edgar E. Iglesias (38):
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
  target-microblaze: dec_msr: Plug a temp leak
  target-microblaze: Add support for extended access to TLBLO
  target-microblaze: Allow address sizes between 32 and 64 bits
  target-microblaze: Simplify address computation using
    tcg_gen_addi_i32()
  target-microblaze: mmu: Cleanup debug log messages
  target-microblaze: Use table based condition-codes conversion
  target-microblaze: Remove argument b in eval_cc()
  target-microblaze: Convert env_btarget to i64
  target-microblaze: Use tcg_gen_movcond in eval_cond_jmp
  target-microblaze: cpu_mmu_index: Fixup indentation
  target-microblaze: Consolidate MMU enabled checks

 configure                        |   1 +
 linux-user/microblaze/cpu_loop.c |   4 +-
 target/microblaze/cpu.c          |  30 +-
 target/microblaze/cpu.h          |  34 +-
 target/microblaze/helper.c       |  32 +-
 target/microblaze/helper.h       |   8 +-
 target/microblaze/mmu.c          |  81 ++--
 target/microblaze/mmu.h          |  17 +-
 target/microblaze/op_helper.c    |  30 +-
 target/microblaze/translate.c    | 930 +++++++++++++++++++--------------------
 10 files changed, 598 insertions(+), 569 deletions(-)

-- 
2.14.1
