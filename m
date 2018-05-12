Received: from eggs.gnu.org ([2001:4830:134:3::10]:33191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHId3-0003uE-40
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHId2-0002nf-8M
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:17 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHId2-0002nR-1t
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:16 -0400
Received: by mail-pl0-x243.google.com with SMTP id ay10-v6so4144194plb.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:44 -0700
Message-Id: <20180512004311.9299-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/27] softfloat patch roundup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

This is my SNaN patch set, Alex's float-float refactor, and a couple
of other random outstanding fpu patches.  This has been reordered so
as to be bisectable, since the float-float refactor requires the snan
work to avoid breakage.

It probably doesn't matter, but this was built on top of my arm fp16
patch set simply to make it easier to test.  The whole tree is

  git://github.com/rth7680/qemu.git fpu-roundup


r~


Alex Bennée (5):
  fpu/softfloat: int_to_float ensure r fully initialised
  fpu/softfloat: re-factor float to float conversions
  fpu/softfloat: support ARM Alternative half-precision
  target/arm: convert conversion helpers to fpst/ahp_flag
  target/arm: squash FZ16 behaviour for conversions

Peter Maydell (2):
  fpu/softfloat: Don't set Invalid for float-to-int(MAXINT)
  target/arm: Fix fp_status_f16 tininess before rounding

Richard Henderson (20):
  fpu/softfloat: Merge NO_SIGNALING_NANS definitions
  fpu/softfloat: Split floatXX_silence_nan from floatXX_maybe_silence_nan
  fpu/softfloat: Move softfloat-specialize.h below FloatParts definition
  fpu/softfloat: Canonicalize NaN fraction
  fpu/softfloat: Introduce parts_is_snan_frac
  fpu/softfloat: Replace float_class_dnan with parts_default_nan
  fpu/softfloat: Replace float_class_msnan with parts_silence_nan
  target/arm: Use floatX_silence_nan when we have already checked for SNaN
  target/arm: Remove floatX_maybe_silence_nan from conversions
  target/hppa: Remove floatX_maybe_silence_nan from conversions
  target/m68k: Use floatX_silence_nan when we have already checked for SNaN
  target/mips: Remove floatX_maybe_silence_nan from conversions
  target/riscv: Remove floatX_maybe_silence_nan from conversions
  target/s390x: Remove floatX_maybe_silence_nan from conversions
  fpu/softfloat: Use float*_silence_nan in propagateFloat*NaN
  fpu/softfloat: Remove floatX_maybe_silence_nan
  fpu/softfloat: Specialize on snan_bit_is_one
  fpu/softfloat: Make is_nan et al available to softfloat-specialize.h
  fpu/softfloat: Pass FloatClass to pickNaN
  fpu/softfloat: Pass FloatClass to pickNaNMulAdd

 fpu/softfloat-specialize.h    | 668 ++++++++++++++++++----------------
 include/fpu/softfloat-types.h |   1 +
 include/fpu/softfloat.h       |  22 +-
 target/arm/helper.h           |  10 +-
 target/arm/translate.h        |  12 +
 target/mips/cpu.h             |   4 +-
 fpu/softfloat.c               | 665 ++++++++++-----------------------
 target/arm/cpu.c              |   2 +
 target/arm/helper-a64.c       |   7 +-
 target/arm/helper.c           | 114 +++---
 target/arm/translate-a64.c    |  38 +-
 target/arm/translate.c        |  74 +++-
 target/hppa/cpu.c             |   1 -
 target/hppa/op_helper.c       |   2 -
 target/m68k/softfloat.c       |   3 +-
 target/mips/msa_helper.c      |   4 -
 target/mips/op_helper.c       |   2 -
 target/mips/translate_init.c  |   4 +-
 target/ppc/fpu_helper.c       |   1 -
 target/riscv/fpu_helper.c     |   6 +-
 target/s390x/fpu_helper.c     |  12 +-
 target/sh4/cpu.c              |   1 -
 target/unicore32/cpu.c        |   2 -
 23 files changed, 730 insertions(+), 925 deletions(-)

-- 
2.17.0
