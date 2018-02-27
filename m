Received: from eggs.gnu.org ([2001:4830:134:3::10]:55691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPF-0003ZD-Jj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPA-0007tS-Hu
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:01 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:42406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgPA-0007sx-BS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:38:56 -0500
Received: by mail-wr0-x22a.google.com with SMTP id k9so25124029wre.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:38:55 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:21 +0000
Message-Id: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/31] Add ARMv8.2 half-precision functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A few minor fixes and a chunk of Richard's r-b tags. Now all that is
left is:

  patch 0014/arm translate a64 add FP16 FMULX MLS FMLA to simd.patch needs review

Otherwise see comments bellow --- for other changes

Alex Bennée (31):
  include/exec/helper-head.h: support f16 in helper calls
  target/arm/cpu64: introduce ARM_V8_FP16 feature bit
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
 include/fpu/softfloat.h    |   16 +-
 target/arm/cpu.h           |   34 +-
 target/arm/cpu64.c         |    1 +
 target/arm/helper-a64.c    |  269 ++++++++++
 target/arm/helper-a64.h    |   33 ++
 target/arm/helper.c        |  479 +++++++++--------
 target/arm/helper.h        |   14 +-
 target/arm/translate-a64.c | 1260 +++++++++++++++++++++++++++++++++++++-------
 target/arm/translate.c     |   12 +-
 10 files changed, 1694 insertions(+), 427 deletions(-)

-- 
2.15.1
