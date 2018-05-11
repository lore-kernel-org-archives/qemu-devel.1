Received: from eggs.gnu.org ([2001:4830:134:3::10]:51921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwA5-00079J-Vf
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwA2-0004nR-TE
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:54 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGwA2-0004nC-NL
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:50 -0400
Received: by mail-pg0-x244.google.com with SMTP id n9-v6so1676535pgq.5
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:43:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 17:43:26 -0700
Message-Id: <20180511004345.26708-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/19] softfloat: Clean up NaN handling
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

This is intended to address Peter's comments wrt Alex's float-to-float
conversion patches.  In particular, the handling of NaNs therein, where
some SNaN get converted to Inf instead of the appropriate QNaN.

I canonicalize NaNs within FloatParts much like we do with the original
softfpu commonNaNT.  With this, a couple of new specialize functions
allows me to remove the float_class_dnan/float_class_msnan placeholders.

This is based on some of Alex's work, which includes both the check-tcg
and the float-to-float patches.  My guess is that in the end we should
order this first.  But writing it this way was easier, for testing.

The full tree is

  git://github.com/rth7680/qemu.git fpu-snan

with these patches beginning at the merge at 537ab46101f5.


r~


Richard Henderson (19):
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
  fpu/softfloat: Introduce SNAN_BIT_IS_ONE
  fpu/softfloat: Pass FloatClass to pickNaN
  fpu/softfloat: Pass FloatClass to pickNaNMulAdd

 fpu/softfloat-specialize.h    | 621 +++++++++++++++++++---------------
 include/fpu/softfloat-types.h |   1 +
 include/fpu/softfloat.h       |  14 +-
 target/mips/cpu.h             |   4 +-
 fpu/softfloat.c               | 162 ++++-----
 target/arm/helper-a64.c       |   7 +-
 target/arm/helper.c           |  24 +-
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
 18 files changed, 430 insertions(+), 441 deletions(-)

-- 
2.17.0
