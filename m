Received: from eggs.gnu.org ([209.51.188.92]:52353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzuN-0007t2-4x
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzuM-00044K-8v
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:39 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:46810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzuL-00042P-RI
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:38 -0500
Received: by mail-pg1-x52a.google.com with SMTP id w7so2340093pgp.13
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:31:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:30:58 +1000
Message-Id: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 00/31] target/arm: Implement ARMv8.3-PAuth
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

Lots more little changes since v2, mostly from Peter's review.
Some changes to ARMVAParameters and TBI incorporated from other
patch sets that I've been working on.

Not included are patches for linux-user to match the user-level
code that has gone into kernel mainline.  But this patch set is
big enough already...


r~


Richard Henderson (31):
  target/arm: Add state for the ARMv8.3-PAuth extension
  target/arm: Add SCTLR bits through ARMv8.5
  target/arm: Add PAuth active bit to tbflags
  target/arm: Introduce raise_exception_ra
  target/arm: Add PAuth helpers
  target/arm: Decode PAuth within system hint space
  target/arm: Rearrange decode in disas_data_proc_1src
  target/arm: Decode PAuth within disas_data_proc_1src
  target/arm: Decode PAuth within disas_data_proc_2src
  target/arm: Move helper_exception_return to helper-a64.c
  target/arm: Add new_pc argument to helper_exception_return
  target/arm: Rearrange decode in disas_uncond_b_reg
  target/arm: Decode PAuth within disas_uncond_b_reg
  target/arm: Decode Load/store register (pac)
  target/arm: Move cpu_mmu_index out of line
  target/arm: Introduce arm_mmu_idx
  target/arm: Introduce arm_stage1_mmu_idx
  target/arm: Create ARMVAParameters and helpers
  target/arm: Merge TBFLAG_AA_TB{0,1} to TBII
  target/arm: Export aa64_va_parameters to internals.h
  target/arm: Add aa64_va_parameters_both
  target/arm: Decode TBID from TCR
  target/arm: Reuse aa64_va_parameters for setting tbflags
  target/arm: Implement pauth_strip
  target/arm: Implement pauth_auth
  target/arm: Implement pauth_addpac
  target/arm: Implement pauth_computepac
  target/arm: Add PAuth system registers
  target/arm: Enable PAuth for -cpu max
  target/arm: Enable PAuth for user-only
  target/arm: Tidy TBI handling in gen_a64_set_pc

 target/arm/cpu.h           | 171 ++++++------
 target/arm/helper-a64.h    |  14 +
 target/arm/helper.h        |   1 -
 target/arm/internals.h     |  77 ++++++
 target/arm/translate.h     |   5 +-
 target/arm/cpu.c           |   3 +
 target/arm/cpu64.c         |  64 +++++
 target/arm/helper-a64.c    | 155 +++++++++++
 target/arm/helper.c        | 513 ++++++++++++++++++++++-------------
 target/arm/op_helper.c     | 174 ++----------
 target/arm/pauth_helper.c  | 496 ++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 536 ++++++++++++++++++++++++++++++++-----
 target/arm/Makefile.objs   |   1 +
 13 files changed, 1703 insertions(+), 507 deletions(-)
 create mode 100644 target/arm/pauth_helper.c

-- 
2.17.2
