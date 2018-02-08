Received: from eggs.gnu.org ([2001:4830:134:3::10]:54076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3I-0003EV-GA
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3F-0006Na-60
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:04 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:43108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3E-0006MB-Ux
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:01 -0500
Received: by mail-wr0-x236.google.com with SMTP id b52so5552048wrd.10
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:00 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:25 +0000
Message-Id: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/32] Add ARMv8.2 half-precision functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Some of this was posted before as part of the various partial patch
series when we first started messing around with FP16 in softfloat.
This series is now just the ARM bits and expects to have the V4
softfloat patches as a prerequisite:

  https://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg01330.html

Alternatively you can grab the full tree from:

  https://github.com/stsquad/qemu/tree/arm-fp16-v2

I've tested with the following RISU test binaries:

  http://people.linaro.org/~alex.bennee/testcases/arm64.risu/testcases.armv8.2_hp.tar.xz

And of course I ran the original RISU tests with:

  -cpu any,fp16=off

But I guess we really just need to carefully regenerate the testcases
to not include UNDEF's which get added with future revisions of the
specification.

Anyway please review.

Alex Bennée (32):
  include/exec/helper-head.h: support f16 in helper calls
  target/arm/cpu64: introduce ARM_V8_FP16 feature bit
  target/arm/cpu64: allow fp16 to be disabled
  target/arm/cpu.h: update comment for half-precision values
  target/arm/cpu.h: add additional float_status flags
  target/arm/helper: pass explicit fpst to set_rmode
  arm/translate-a64: implement half-precision F(MIN|MAX)(V|NMV)
  arm/translate-a64: handle_3same_64 comment fix
  arm/translate-a64: initial decode for simd_three_reg_same_fp16
  arm/translate-a64: add FP16 FADD/FABD/FSUB/FMUL/FDIV to
    simd_three_reg_same_fp16
  arm/translate-a64: add FP16 F[A]C[EQ/GE/GT] to
    simd_three_reg_same_fp16
  arm/translate-a64: add FP16 FMULA/X/S to simd_three_reg_same_fp16
  arm/translate-a64: add FP16 FR[ECP/SQRT]S to simd_three_reg_same_fp16
  arm/translate-a64: add FP16 pairwise ops simd_three_reg_same_fp16
  arm/translate-a64: add FP16 FMULX/MLS/FMLA to simd_indexed
  arm/translate-a64: add FP16 x2 ops for simd_indexed
  arm/translate-a64: initial decode for simd_two_reg_misc_fp16
  arm/translate-a64: add FP16 FPRINTx to simd_two_reg_misc_fp16
  arm/translate-a64: add FCVTxx to simd_two_reg_misc_fp16
  arm/translate-a64: add FP16 FCMxx (zero) to simd_two_reg_misc_fp16
  arm/translate-a64: add FP16 SCVTF/UCVFT to simd_two_reg_misc_fp16
  arm/translate-a64: add FP16 FNEG/FABS to simd_two_reg_misc_fp16
  arm/helper.c: re-factor recpe and add recepe_f16
  arm/translate-a64: add FP16 FRECPE
  arm/translate-a64: add FP16 FRCPX to simd_two_reg_misc_fp16
  arm/translate-a64: add FP16 FSQRT to simd_two_reg_misc_fp16
  arm/helper.c: re-factor rsqrte and add rsqrte_f16
  arm/translate-a64: add FP16 FRSQRTE to simd_two_reg_misc_fp16
  arm/translate-a64: add FP16 FMOV to simd_mod_imm
  arm/translate-a64: add all FP16 ops in simd_scalar_pairwise
  arm/translate-a64: implement simd_scalar_three_reg_same_fp16
  arm/translate-a64: add all single op FP16 to handle_fp_1src_half

 include/exec/helper-head.h |    3 +
 target/arm/cpu.h           |   24 +-
 target/arm/cpu64.c         |   28 +
 target/arm/helper-a64.c    |  274 ++++++++++
 target/arm/helper-a64.h    |   34 ++
 target/arm/helper.c        |  466 +++++++++--------
 target/arm/helper.h        |   14 +-
 target/arm/translate-a64.c | 1229 +++++++++++++++++++++++++++++++++++++-------
 target/arm/translate.c     |   12 +-
 9 files changed, 1676 insertions(+), 408 deletions(-)

-- 
2.15.1
