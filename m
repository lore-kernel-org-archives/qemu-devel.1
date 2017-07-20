Received: from eggs.gnu.org ([2001:4830:134:3::10]:53323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0F-0004Ff-GD
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0A-0007hz-Nf
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:35 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0A-0007hP-8d
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:30 -0400
Received: by mail-wr0-x233.google.com with SMTP id v105so41830071wrb.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:30 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:03 +0100
Message-Id: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 00/23] Implementing FP16 for
 ARMv8.2 using SoftFloat2a and 3c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

As this is an RFC patch it is not a complete implementation but
exploring the two options for implementing half-precision floating
point going forward.

The first few patches shuffle the two softfloat implementations around
so they can live side-by-side. The SoftFloat3c library has been
structured to allow better embedding in libraries so comes with a set
of primitives, base files as well as the individual operations. The
build is somewhat complicated by the fact various specialisations are
supported for SSE like enabled processors. This is controlled by the
presence of CONFIG_SOFTFLOAT3_FAST_INT64.

I then implement a few random functions using the softfloat3c code. To
keep things clean the helper functions are all in advsimd_helper.c. As
the two implementations are sitting side by side we need to copy the
exception flags back and forth to ensure the virtual FPU state is
correct between operations implemented by both libraries. This can
obviously be removed is an architecture fully transitions to a later
library.

When I came to implement the half-precision AdvSIMD across lanes it
made sense to re-factor the existing code. As there was already some
support that had been added for float16 to the existing 2a code I
thought I'd see how easy this was to add. Adding the new templated
compare function was easy enough with a few helpers but I also spent
some time chasing down a bug with propagation of signalling NaNs which
I assume would have affected the existing ARM usage as well. The IEEE
spec is a little fuzzy on propagation across multiple steps which is
how these functions use it.

As this patch series is a bit of a monster on account of all the
importing and mangling steps you may prefer to take a copy from:

  https://github.com/stsquad/qemu/tree/softfloat-and-arm-fp16

It is based on-top of my latest set of CI updates so gets a fairly
broad compile test. One failure is because of a fix that hadn't yet
gotten into master and the other is due to a clash of os-win32.h
bringing in windows headers that clash on the definition of
LITTLEENDIAN.

So while any review is gratefully accepted my main interest is if this
sort of duel approach is worth it?

I think the long term aim would be to move fully over to the newer
library if we can but I appreciate a not inconsiderable amount of work
has gone into the existing 2a code. Having said that as long as the
testing is good we are likely to pick up bugs in both implementations.
While its nice to have a more modern SoftFloat library it still lags
somewhat on QEMUs general requirements claiming only direct support
for IEEE754 1985 whereas most modern CPUs are closer to the 2008
revision of the specification.

Cheers,

Alex Bennée (23):
  softfloat: move existing softfloat2a into versioned directory
  fpu: import SoftFloat3c
  softfloat3c: dos2unix all files
  softfloat3c: fixup include paths
  softfloat3c: initial build machinery
  softfloat3c: silence compiler warning
  softfloat3c: f16_to_f128M remove unused variable
  target-aarch64: enable SoftFloat3 build for FP16
  arm: introduce ARM_V8_FP16 feature bit
  target/arm/translate-a64.c: handle_3same_64 comment fix
  target/arm/translate-a64.c: AdvSIMD scalar 3 Same FP16 initial decode
  target/arm/translate-a64.c: add FP16 FAGCT to AdvSIMD 3 Same
  target/arm/translate-a64.c: add FP16 FADD to AdvSIMD 3 Same
  target/arm/translate-a64.c: add ARMv8.2 fadd scalar half-precision
  target/arm/translate-a64.c: AdvSIMD scalar 2 register misc decode
  include/exec/helper-head.h: support f16 in helper calls
  fpu/softfloat2a: implement propagateFloat16NaN
  fpu/softfloat2a: implement float16_squash_input_denormal
  fpu/softfloat2a: implement float16_abs helper
  fpu/softfloat2a: add half-precision expansions for MINMAX fns
  fpu/softfloat2a: propagate signalling NaNs in MINMAX
  fpu/softfloat2a: improve comments on ARM NaN propagation
  target/arm: implement half-precision F(MIN|MAX)(V|NMV)

 Makefile.target                                   |    2 +-
 configure                                         |   24 +
 default-configs/aarch64-common.mak                |    3 +
 default-configs/aarch64-linux-user.mak            |    2 +
 default-configs/aarch64-softmmu.mak               |    2 +
 fpu/Makefile.objs                                 |  147 +++
 fpu/{ => softfloat2a}/softfloat-macros.h          |    0
 fpu/{ => softfloat2a}/softfloat-specialize.h      |   53 +-
 fpu/{ => softfloat2a}/softfloat.c                 |   27 +-
 fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c |   57 +
 fpu/softfloat3c/8086-SSE/f128M_isSignalingNaN.c   |   60 ++
 fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80M.c   |   56 +
 fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80UI.c  |   56 +
 fpu/softfloat3c/8086-SSE/s_commonNaNToF128M.c     |   56 +
 fpu/softfloat3c/8086-SSE/s_commonNaNToF128UI.c    |   55 +
 fpu/softfloat3c/8086-SSE/s_commonNaNToF16UI.c     |   51 +
 fpu/softfloat3c/8086-SSE/s_commonNaNToF32UI.c     |   51 +
 fpu/softfloat3c/8086-SSE/s_commonNaNToF64UI.c     |   53 +
 fpu/softfloat3c/8086-SSE/s_extF80MToCommonNaN.c   |   62 ++
 fpu/softfloat3c/8086-SSE/s_extF80UIToCommonNaN.c  |   62 ++
 fpu/softfloat3c/8086-SSE/s_f128MToCommonNaN.c     |   62 ++
 fpu/softfloat3c/8086-SSE/s_f128UIToCommonNaN.c    |   65 ++
 fpu/softfloat3c/8086-SSE/s_f16UIToCommonNaN.c     |   59 ++
 fpu/softfloat3c/8086-SSE/s_f32UIToCommonNaN.c     |   59 ++
 fpu/softfloat3c/8086-SSE/s_f64UIToCommonNaN.c     |   59 ++
 fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80M.c  |  107 ++
 fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80UI.c |  106 ++
 fpu/softfloat3c/8086-SSE/s_propagateNaNF128M.c    |   76 ++
 fpu/softfloat3c/8086-SSE/s_propagateNaNF128UI.c   |   81 ++
 fpu/softfloat3c/8086-SSE/s_propagateNaNF16UI.c    |   63 ++
 fpu/softfloat3c/8086-SSE/s_propagateNaNF32UI.c    |   63 ++
 fpu/softfloat3c/8086-SSE/s_propagateNaNF64UI.c    |   63 ++
 fpu/softfloat3c/8086-SSE/softfloat_raiseFlags.c   |   52 +
 fpu/softfloat3c/8086/extF80M_isSignalingNaN.c     |   57 +
 fpu/softfloat3c/8086/f128M_isSignalingNaN.c       |   60 ++
 fpu/softfloat3c/8086/s_commonNaNToExtF80M.c       |   56 +
 fpu/softfloat3c/8086/s_commonNaNToExtF80UI.c      |   56 +
 fpu/softfloat3c/8086/s_commonNaNToF128M.c         |   56 +
 fpu/softfloat3c/8086/s_commonNaNToF128UI.c        |   55 +
 fpu/softfloat3c/8086/s_commonNaNToF16UI.c         |   51 +
 fpu/softfloat3c/8086/s_commonNaNToF32UI.c         |   51 +
 fpu/softfloat3c/8086/s_commonNaNToF64UI.c         |   53 +
 fpu/softfloat3c/8086/s_extF80MToCommonNaN.c       |   62 ++
 fpu/softfloat3c/8086/s_extF80UIToCommonNaN.c      |   62 ++
 fpu/softfloat3c/8086/s_f128MToCommonNaN.c         |   62 ++
 fpu/softfloat3c/8086/s_f128UIToCommonNaN.c        |   65 ++
 fpu/softfloat3c/8086/s_f16UIToCommonNaN.c         |   59 ++
 fpu/softfloat3c/8086/s_f32UIToCommonNaN.c         |   59 ++
 fpu/softfloat3c/8086/s_f64UIToCommonNaN.c         |   59 ++
 fpu/softfloat3c/8086/s_propagateNaNExtF80M.c      |  107 ++
 fpu/softfloat3c/8086/s_propagateNaNExtF80UI.c     |  106 ++
 fpu/softfloat3c/8086/s_propagateNaNF128M.c        |  108 ++
 fpu/softfloat3c/8086/s_propagateNaNF128UI.c       |  105 ++
 fpu/softfloat3c/8086/s_propagateNaNF16UI.c        |   84 ++
 fpu/softfloat3c/8086/s_propagateNaNF32UI.c        |   84 ++
 fpu/softfloat3c/8086/s_propagateNaNF64UI.c        |   84 ++
 fpu/softfloat3c/8086/softfloat_raiseFlags.c       |   52 +
 fpu/softfloat3c/8086/specialize.h                 |  375 +++++++
 fpu/softfloat3c/extF80M_add.c                     |  100 ++
 fpu/softfloat3c/extF80M_div.c                     |  194 ++++
 fpu/softfloat3c/extF80M_eq.c                      |   98 ++
 fpu/softfloat3c/extF80M_eq_signaling.c            |   92 ++
 fpu/softfloat3c/extF80M_le.c                      |  106 ++
 fpu/softfloat3c/extF80M_le_quiet.c                |  112 ++
 fpu/softfloat3c/extF80M_lt.c                      |  106 ++
 fpu/softfloat3c/extF80M_lt_quiet.c                |  112 ++
 fpu/softfloat3c/extF80M_mul.c                     |  139 +++
 fpu/softfloat3c/extF80M_rem.c                     |  204 ++++
 fpu/softfloat3c/extF80M_roundToInt.c              |  169 +++
 fpu/softfloat3c/extF80M_sqrt.c                    |  176 ++++
 fpu/softfloat3c/extF80M_sub.c                     |  100 ++
 fpu/softfloat3c/extF80M_to_f128M.c                |  125 +++
 fpu/softfloat3c/extF80M_to_f16.c                  |  112 ++
 fpu/softfloat3c/extF80M_to_f32.c                  |  112 ++
 fpu/softfloat3c/extF80M_to_f64.c                  |  112 ++
 fpu/softfloat3c/extF80M_to_i32.c                  |  100 ++
 fpu/softfloat3c/extF80M_to_i32_r_minMag.c         |  120 +++
 fpu/softfloat3c/extF80M_to_i64.c                  |   97 ++
 fpu/softfloat3c/extF80M_to_i64_r_minMag.c         |  115 ++
 fpu/softfloat3c/extF80M_to_ui32.c                 |  101 ++
 fpu/softfloat3c/extF80M_to_ui32_r_minMag.c        |  111 ++
 fpu/softfloat3c/extF80M_to_ui64.c                 |   97 ++
 fpu/softfloat3c/extF80M_to_ui64_r_minMag.c        |  108 ++
 fpu/softfloat3c/extF80_add.c                      |   80 ++
 fpu/softfloat3c/extF80_div.c                      |  203 ++++
 fpu/softfloat3c/extF80_eq.c                       |   73 ++
 fpu/softfloat3c/extF80_eq_signaling.c             |   67 ++
 fpu/softfloat3c/extF80_isSignalingNaN.c           |   51 +
 fpu/softfloat3c/extF80_le.c                       |   73 ++
 fpu/softfloat3c/extF80_le_quiet.c                 |   78 ++
 fpu/softfloat3c/extF80_lt.c                       |   73 ++
 fpu/softfloat3c/extF80_lt_quiet.c                 |   78 ++
 fpu/softfloat3c/extF80_mul.c                      |  158 +++
 fpu/softfloat3c/extF80_rem.c                      |  225 ++++
 fpu/softfloat3c/extF80_roundToInt.c               |  147 +++
 fpu/softfloat3c/extF80_sqrt.c                     |  168 +++
 fpu/softfloat3c/extF80_sub.c                      |   80 ++
 fpu/softfloat3c/extF80_to_f128.c                  |   75 ++
 fpu/softfloat3c/extF80_to_f16.c                   |   96 ++
 fpu/softfloat3c/extF80_to_f32.c                   |   96 ++
 fpu/softfloat3c/extF80_to_f64.c                   |   96 ++
 fpu/softfloat3c/extF80_to_i32.c                   |   83 ++
 fpu/softfloat3c/extF80_to_i32_r_minMag.c          |   97 ++
 fpu/softfloat3c/extF80_to_i64.c                   |   89 ++
 fpu/softfloat3c/extF80_to_i64_r_minMag.c          |   94 ++
 fpu/softfloat3c/extF80_to_ui32.c                  |   83 ++
 fpu/softfloat3c/extF80_to_ui32_r_minMag.c         |   88 ++
 fpu/softfloat3c/extF80_to_ui64.c                  |   84 ++
 fpu/softfloat3c/extF80_to_ui64_r_minMag.c         |   88 ++
 fpu/softfloat3c/f128M_add.c                       |   97 ++
 fpu/softfloat3c/f128M_div.c                       |  187 ++++
 fpu/softfloat3c/f128M_eq.c                        |  100 ++
 fpu/softfloat3c/f128M_eq_signaling.c              |   92 ++
 fpu/softfloat3c/f128M_le.c                        |   93 ++
 fpu/softfloat3c/f128M_le_quiet.c                  |   96 ++
 fpu/softfloat3c/f128M_lt.c                        |   93 ++
 fpu/softfloat3c/f128M_lt_quiet.c                  |   96 ++
 fpu/softfloat3c/f128M_mul.c                       |  158 +++
 fpu/softfloat3c/f128M_mulAdd.c                    |   92 ++
 fpu/softfloat3c/f128M_rem.c                       |  182 ++++
 fpu/softfloat3c/f128M_roundToInt.c                |  216 ++++
 fpu/softfloat3c/f128M_sqrt.c                      |  216 ++++
 fpu/softfloat3c/f128M_sub.c                       |   97 ++
 fpu/softfloat3c/f128M_to_extF80M.c                |  101 ++
 fpu/softfloat3c/f128M_to_f16.c                    |  113 ++
 fpu/softfloat3c/f128M_to_f32.c                    |  109 ++
 fpu/softfloat3c/f128M_to_f64.c                    |  112 ++
 fpu/softfloat3c/f128M_to_i32.c                    |   98 ++
 fpu/softfloat3c/f128M_to_i32_r_minMag.c           |  106 ++
 fpu/softfloat3c/f128M_to_i64.c                    |  102 ++
 fpu/softfloat3c/f128M_to_i64_r_minMag.c           |  124 +++
 fpu/softfloat3c/f128M_to_ui32.c                   |   98 ++
 fpu/softfloat3c/f128M_to_ui32_r_minMag.c          |  102 ++
 fpu/softfloat3c/f128M_to_ui64.c                   |  102 ++
 fpu/softfloat3c/f128M_to_ui64_r_minMag.c          |  114 ++
 fpu/softfloat3c/f128_add.c                        |   78 ++
 fpu/softfloat3c/f128_div.c                        |  199 ++++
 fpu/softfloat3c/f128_eq.c                         |   73 ++
 fpu/softfloat3c/f128_eq_signaling.c               |   67 ++
 fpu/softfloat3c/f128_isSignalingNaN.c             |   51 +
 fpu/softfloat3c/f128_le.c                         |   72 ++
 fpu/softfloat3c/f128_le_quiet.c                   |   78 ++
 fpu/softfloat3c/f128_lt.c                         |   72 ++
 fpu/softfloat3c/f128_lt_quiet.c                   |   78 ++
 fpu/softfloat3c/f128_mul.c                        |  163 +++
 fpu/softfloat3c/f128_mulAdd.c                     |   63 ++
 fpu/softfloat3c/f128_rem.c                        |  190 ++++
 fpu/softfloat3c/f128_roundToInt.c                 |  160 +++
 fpu/softfloat3c/f128_sqrt.c                       |  194 ++++
 fpu/softfloat3c/f128_sub.c                        |   78 ++
 fpu/softfloat3c/f128_to_extF80.c                  |  109 ++
 fpu/softfloat3c/f128_to_f16.c                     |   95 ++
 fpu/softfloat3c/f128_to_f32.c                     |   95 ++
 fpu/softfloat3c/f128_to_f64.c                     |  100 ++
 fpu/softfloat3c/f128_to_i32.c                     |   85 ++
 fpu/softfloat3c/f128_to_i32_r_minMag.c            |  100 ++
 fpu/softfloat3c/f128_to_i64.c                     |   95 ++
 fpu/softfloat3c/f128_to_i64_r_minMag.c            |  113 ++
 fpu/softfloat3c/f128_to_ui32.c                    |   86 ++
 fpu/softfloat3c/f128_to_ui32_r_minMag.c           |   89 ++
 fpu/softfloat3c/f128_to_ui64.c                    |   96 ++
 fpu/softfloat3c/f128_to_ui64_r_minMag.c           |  105 ++
 fpu/softfloat3c/f16_add.c                         |   70 ++
 fpu/softfloat3c/f16_div.c                         |  186 ++++
 fpu/softfloat3c/f16_eq.c                          |   66 ++
 fpu/softfloat3c/f16_eq_signaling.c                |   61 ++
 fpu/softfloat3c/f16_isSignalingNaN.c              |   51 +
 fpu/softfloat3c/f16_le.c                          |   66 ++
 fpu/softfloat3c/f16_le_quiet.c                    |   71 ++
 fpu/softfloat3c/f16_lt.c                          |   66 ++
 fpu/softfloat3c/f16_lt_quiet.c                    |   71 ++
 fpu/softfloat3c/f16_mul.c                         |  140 +++
 fpu/softfloat3c/f16_mulAdd.c                      |   60 ++
 fpu/softfloat3c/f16_rem.c                         |  171 +++
 fpu/softfloat3c/f16_roundToInt.c                  |  112 ++
 fpu/softfloat3c/f16_sqrt.c                        |  136 +++
 fpu/softfloat3c/f16_sub.c                         |   70 ++
 fpu/softfloat3c/f16_to_extF80.c                   |  101 ++
 fpu/softfloat3c/f16_to_extF80M.c                  |  111 ++
 fpu/softfloat3c/f16_to_f128.c                     |   96 ++
 fpu/softfloat3c/f16_to_f128M.c                    |  111 ++
 fpu/softfloat3c/f16_to_f32.c                      |   93 ++
 fpu/softfloat3c/f16_to_f64.c                      |   93 ++
 fpu/softfloat3c/f16_to_i32.c                      |   87 ++
 fpu/softfloat3c/f16_to_i32_r_minMag.c             |   88 ++
 fpu/softfloat3c/f16_to_i64.c                      |   87 ++
 fpu/softfloat3c/f16_to_i64_r_minMag.c             |   88 ++
 fpu/softfloat3c/f16_to_ui32.c                     |   84 ++
 fpu/softfloat3c/f16_to_ui32_r_minMag.c            |   87 ++
 fpu/softfloat3c/f16_to_ui64.c                     |   84 ++
 fpu/softfloat3c/f16_to_ui64_r_minMag.c            |   87 ++
 fpu/softfloat3c/f32_add.c                         |   70 ++
 fpu/softfloat3c/f32_div.c                         |  180 ++++
 fpu/softfloat3c/f32_eq.c                          |   66 ++
 fpu/softfloat3c/f32_eq_signaling.c                |   61 ++
 fpu/softfloat3c/f32_isSignalingNaN.c              |   51 +
 fpu/softfloat3c/f32_le.c                          |   66 ++
 fpu/softfloat3c/f32_le_quiet.c                    |   71 ++
 fpu/softfloat3c/f32_lt.c                          |   66 ++
 fpu/softfloat3c/f32_lt_quiet.c                    |   71 ++
 fpu/softfloat3c/f32_mul.c                         |  137 +++
 fpu/softfloat3c/f32_mulAdd.c                      |   60 ++
 fpu/softfloat3c/f32_rem.c                         |  168 +++
 fpu/softfloat3c/f32_roundToInt.c                  |  112 ++
 fpu/softfloat3c/f32_sqrt.c                        |  121 +++
 fpu/softfloat3c/f32_sub.c                         |   70 ++
 fpu/softfloat3c/f32_to_extF80.c                   |  101 ++
 fpu/softfloat3c/f32_to_extF80M.c                  |  111 ++
 fpu/softfloat3c/f32_to_f128.c                     |   96 ++
 fpu/softfloat3c/f32_to_f128M.c                    |  115 ++
 fpu/softfloat3c/f32_to_f16.c                      |   88 ++
 fpu/softfloat3c/f32_to_f64.c                      |   93 ++
 fpu/softfloat3c/f32_to_i32.c                      |   84 ++
 fpu/softfloat3c/f32_to_i32_r_minMag.c             |   89 ++
 fpu/softfloat3c/f32_to_i64.c                      |   96 ++
 fpu/softfloat3c/f32_to_i64_r_minMag.c             |   94 ++
 fpu/softfloat3c/f32_to_ui32.c                     |   84 ++
 fpu/softfloat3c/f32_to_ui32_r_minMag.c            |   88 ++
 fpu/softfloat3c/f32_to_ui64.c                     |   96 ++
 fpu/softfloat3c/f32_to_ui64_r_minMag.c            |   90 ++
 fpu/softfloat3c/f64_add.c                         |   74 ++
 fpu/softfloat3c/f64_div.c                         |  172 +++
 fpu/softfloat3c/f64_eq.c                          |   66 ++
 fpu/softfloat3c/f64_eq_signaling.c                |   61 ++
 fpu/softfloat3c/f64_isSignalingNaN.c              |   51 +
 fpu/softfloat3c/f64_le.c                          |   67 ++
 fpu/softfloat3c/f64_le_quiet.c                    |   72 ++
 fpu/softfloat3c/f64_lt.c                          |   67 ++
 fpu/softfloat3c/f64_lt_quiet.c                    |   72 ++
 fpu/softfloat3c/f64_mul.c                         |  150 +++
 fpu/softfloat3c/f64_mulAdd.c                      |   60 ++
 fpu/softfloat3c/f64_rem.c                         |  189 ++++
 fpu/softfloat3c/f64_roundToInt.c                  |  112 ++
 fpu/softfloat3c/f64_sqrt.c                        |  133 +++
 fpu/softfloat3c/f64_sub.c                         |   74 ++
 fpu/softfloat3c/f64_to_extF80.c                   |  101 ++
 fpu/softfloat3c/f64_to_extF80M.c                  |  111 ++
 fpu/softfloat3c/f64_to_f128.c                     |   98 ++
 fpu/softfloat3c/f64_to_f128M.c                    |  117 +++
 fpu/softfloat3c/f64_to_f16.c                      |   88 ++
 fpu/softfloat3c/f64_to_f32.c                      |   88 ++
 fpu/softfloat3c/f64_to_i32.c                      |   82 ++
 fpu/softfloat3c/f64_to_i32_r_minMag.c             |   96 ++
 fpu/softfloat3c/f64_to_i64.c                      |  103 ++
 fpu/softfloat3c/f64_to_i64_r_minMag.c             |  100 ++
 fpu/softfloat3c/f64_to_ui32.c                     |   82 ++
 fpu/softfloat3c/f64_to_ui32_r_minMag.c            |   88 ++
 fpu/softfloat3c/f64_to_ui64.c                     |  103 ++
 fpu/softfloat3c/f64_to_ui64_r_minMag.c            |   93 ++
 fpu/softfloat3c/i32_to_extF80.c                   |   65 ++
 fpu/softfloat3c/i32_to_extF80M.c                  |   78 ++
 fpu/softfloat3c/i32_to_f128.c                     |   64 ++
 fpu/softfloat3c/i32_to_f128M.c                    |   81 ++
 fpu/softfloat3c/i32_to_f16.c                      |   71 ++
 fpu/softfloat3c/i32_to_f32.c                      |   58 ++
 fpu/softfloat3c/i32_to_f64.c                      |   65 ++
 fpu/softfloat3c/i64_to_extF80.c                   |   65 ++
 fpu/softfloat3c/i64_to_extF80M.c                  |   78 ++
 fpu/softfloat3c/i64_to_f128.c                     |   72 ++
 fpu/softfloat3c/i64_to_f128M.c                    |   92 ++
 fpu/softfloat3c/i64_to_f16.c                      |   70 ++
 fpu/softfloat3c/i64_to_f32.c                      |   70 ++
 fpu/softfloat3c/i64_to_f64.c                      |   58 ++
 fpu/softfloat3c/platform.h                        |   65 ++
 fpu/softfloat3c/s_add128.c                        |   55 +
 fpu/softfloat3c/s_add256M.c                       |   65 ++
 fpu/softfloat3c/s_addCarryM.c                     |   70 ++
 fpu/softfloat3c/s_addComplCarryM.c                |   70 ++
 fpu/softfloat3c/s_addExtF80M.c                    |  186 ++++
 fpu/softfloat3c/s_addF128M.c                      |  211 ++++
 fpu/softfloat3c/s_addM.c                          |   70 ++
 fpu/softfloat3c/s_addMagsExtF80.c                 |  156 +++
 fpu/softfloat3c/s_addMagsF128.c                   |  154 +++
 fpu/softfloat3c/s_addMagsF16.c                    |  183 ++++
 fpu/softfloat3c/s_addMagsF32.c                    |  126 +++
 fpu/softfloat3c/s_addMagsF64.c                    |  128 +++
 fpu/softfloat3c/s_approxRecip32_1.c               |   66 ++
 fpu/softfloat3c/s_approxRecipSqrt32_1.c           |   73 ++
 fpu/softfloat3c/s_approxRecipSqrt_1Ks.c           |   49 +
 fpu/softfloat3c/s_approxRecip_1Ks.c               |   49 +
 fpu/softfloat3c/s_compare128M.c                   |   62 ++
 fpu/softfloat3c/s_compare96M.c                    |   62 ++
 fpu/softfloat3c/s_compareNonnormExtF80M.c         |  111 ++
 fpu/softfloat3c/s_countLeadingZeros16.c           |   60 ++
 fpu/softfloat3c/s_countLeadingZeros32.c           |   64 ++
 fpu/softfloat3c/s_countLeadingZeros64.c           |   73 ++
 fpu/softfloat3c/s_countLeadingZeros8.c            |   59 ++
 fpu/softfloat3c/s_eq128.c                         |   51 +
 fpu/softfloat3c/s_invalidExtF80M.c                |   49 +
 fpu/softfloat3c/s_invalidF128M.c                  |   53 +
 fpu/softfloat3c/s_isNaNF128M.c                    |   57 +
 fpu/softfloat3c/s_le128.c                         |   51 +
 fpu/softfloat3c/s_lt128.c                         |   51 +
 fpu/softfloat3c/s_mul128By32.c                    |   58 ++
 fpu/softfloat3c/s_mul128MTo256M.c                 |  100 ++
 fpu/softfloat3c/s_mul128To256M.c                  |   71 ++
 fpu/softfloat3c/s_mul64ByShifted32To128.c         |   56 +
 fpu/softfloat3c/s_mul64To128.c                    |   66 ++
 fpu/softfloat3c/s_mul64To128M.c                   |   68 ++
 fpu/softfloat3c/s_mulAddF128.c                    |  350 +++++++
 fpu/softfloat3c/s_mulAddF128M.c                   |  382 +++++++
 fpu/softfloat3c/s_mulAddF16.c                     |  226 ++++
 fpu/softfloat3c/s_mulAddF32.c                     |  224 ++++
 fpu/softfloat3c/s_mulAddF64.c                     |  496 +++++++++
 fpu/softfloat3c/s_negXM.c                         |   63 ++
 fpu/softfloat3c/s_normExtF80SigM.c                |   52 +
 fpu/softfloat3c/s_normRoundPackMToExtF80M.c       |   78 ++
 fpu/softfloat3c/s_normRoundPackMToF128M.c         |   73 ++
 fpu/softfloat3c/s_normRoundPackToExtF80.c         |   71 ++
 fpu/softfloat3c/s_normRoundPackToF128.c           |   81 ++
 fpu/softfloat3c/s_normRoundPackToF16.c            |   58 ++
 fpu/softfloat3c/s_normRoundPackToF32.c            |   58 ++
 fpu/softfloat3c/s_normRoundPackToF64.c            |   58 ++
 fpu/softfloat3c/s_normSubnormalExtF80Sig.c        |   52 +
 fpu/softfloat3c/s_normSubnormalF128Sig.c          |   65 ++
 fpu/softfloat3c/s_normSubnormalF128SigM.c         |   61 ++
 fpu/softfloat3c/s_normSubnormalF16Sig.c           |   52 +
 fpu/softfloat3c/s_normSubnormalF32Sig.c           |   52 +
 fpu/softfloat3c/s_normSubnormalF64Sig.c           |   52 +
 fpu/softfloat3c/s_remStepMBy32.c                  |   86 ++
 fpu/softfloat3c/s_roundMToI64.c                   |   88 ++
 fpu/softfloat3c/s_roundMToUI64.c                  |   84 ++
 fpu/softfloat3c/s_roundPackMToExtF80M.c           |  256 +++++
 fpu/softfloat3c/s_roundPackMToF128M.c             |  178 ++++
 fpu/softfloat3c/s_roundPackToExtF80.c             |  256 +++++
 fpu/softfloat3c/s_roundPackToF128.c               |  171 +++
 fpu/softfloat3c/s_roundPackToF16.c                |  113 ++
 fpu/softfloat3c/s_roundPackToF32.c                |  113 ++
 fpu/softfloat3c/s_roundPackToF64.c                |  117 +++
 fpu/softfloat3c/s_roundToI32.c                    |   84 ++
 fpu/softfloat3c/s_roundToI64.c                    |   89 ++
 fpu/softfloat3c/s_roundToUI32.c                   |   80 ++
 fpu/softfloat3c/s_roundToUI64.c                   |   85 ++
 fpu/softfloat3c/s_shiftLeftM.c                    |   91 ++
 fpu/softfloat3c/s_shiftNormSigF128M.c             |   78 ++
 fpu/softfloat3c/s_shiftRightJam128.c              |   69 ++
 fpu/softfloat3c/s_shiftRightJam128Extra.c         |   77 ++
 fpu/softfloat3c/s_shiftRightJam256M.c             |  126 +++
 fpu/softfloat3c/s_shiftRightJam32.c               |   51 +
 fpu/softfloat3c/s_shiftRightJam64.c               |   51 +
 fpu/softfloat3c/s_shiftRightJam64Extra.c          |   62 ++
 fpu/softfloat3c/s_shiftRightJamM.c                |  101 ++
 fpu/softfloat3c/s_shiftRightM.c                   |   91 ++
 fpu/softfloat3c/s_shortShiftLeft128.c             |   55 +
 fpu/softfloat3c/s_shortShiftLeft64To96M.c         |   56 +
 fpu/softfloat3c/s_shortShiftLeftM.c               |   70 ++
 fpu/softfloat3c/s_shortShiftRight128.c            |   55 +
 fpu/softfloat3c/s_shortShiftRightExtendM.c        |   73 ++
 fpu/softfloat3c/s_shortShiftRightJam128.c         |   60 ++
 fpu/softfloat3c/s_shortShiftRightJam128Extra.c    |   59 ++
 fpu/softfloat3c/s_shortShiftRightJam64.c          |   50 +
 fpu/softfloat3c/s_shortShiftRightJam64Extra.c     |   56 +
 fpu/softfloat3c/s_shortShiftRightJamM.c           |   72 ++
 fpu/softfloat3c/s_shortShiftRightM.c              |   70 ++
 fpu/softfloat3c/s_sub128.c                        |   55 +
 fpu/softfloat3c/s_sub1XM.c                        |   60 ++
 fpu/softfloat3c/s_sub256M.c                       |   65 ++
 fpu/softfloat3c/s_subM.c                          |   70 ++
 fpu/softfloat3c/s_subMagsExtF80.c                 |  158 +++
 fpu/softfloat3c/s_subMagsF128.c                   |  139 +++
 fpu/softfloat3c/s_subMagsF16.c                    |  187 ++++
 fpu/softfloat3c/s_subMagsF32.c                    |  143 +++
 fpu/softfloat3c/s_subMagsF64.c                    |  141 +++
 fpu/softfloat3c/s_tryPropagateNaNExtF80M.c        |   64 ++
 fpu/softfloat3c/s_tryPropagateNaNF128M.c          |   55 +
 fpu/softfloat3c/softfloat_state.c                 |   52 +
 fpu/softfloat3c/specialize.h                      |  375 +++++++
 fpu/softfloat3c/ui32_to_extF80.c                  |   59 ++
 fpu/softfloat3c/ui32_to_extF80M.c                 |   74 ++
 fpu/softfloat3c/ui32_to_f128.c                    |   60 ++
 fpu/softfloat3c/ui32_to_f128M.c                   |   76 ++
 fpu/softfloat3c/ui32_to_f16.c                     |   65 ++
 fpu/softfloat3c/ui32_to_f32.c                     |   57 +
 fpu/softfloat3c/ui32_to_f64.c                     |   59 ++
 fpu/softfloat3c/ui64_to_extF80.c                  |   59 ++
 fpu/softfloat3c/ui64_to_extF80M.c                 |   74 ++
 fpu/softfloat3c/ui64_to_f128.c                    |   68 ++
 fpu/softfloat3c/ui64_to_f128M.c                   |   86 ++
 fpu/softfloat3c/ui64_to_f16.c                     |   64 ++
 fpu/softfloat3c/ui64_to_f32.c                     |   64 ++
 fpu/softfloat3c/ui64_to_f64.c                     |   59 ++
 include/exec/helper-head.h                        |    3 +
 include/fpu/{ => softfloat2a}/softfloat.h         |   19 +
 include/fpu/softfloat3c/primitiveTypes.h          |   85 ++
 include/fpu/softfloat3c/primitives.h              | 1160 +++++++++++++++++++++
 include/fpu/softfloat3c/softfloat-internals.h     |  278 +++++
 include/fpu/softfloat3c/softfloat.h               |  372 +++++++
 include/fpu/softfloat3c/softfloat_types.h         |   81 ++
 include/qemu/bswap.h                              |    2 +-
 linux-user/arm/nwfpe/double_cpdo.c                |    2 +-
 linux-user/arm/nwfpe/extended_cpdo.c              |    2 +-
 linux-user/arm/nwfpe/fpa11.h                      |    2 +-
 linux-user/arm/nwfpe/fpa11_cpdt.c                 |    2 +-
 linux-user/arm/nwfpe/fpa11_cprt.c                 |    2 +-
 linux-user/arm/nwfpe/fpopcode.c                   |    2 +-
 linux-user/arm/nwfpe/single_cpdo.c                |    2 +-
 scripts/analyze-inclusions                        |    2 +-
 target/alpha/cpu.h                                |    2 +-
 target/alpha/fpu_helper.c                         |    2 +-
 target/alpha/helper.c                             |    2 +-
 target/alpha/vax_helper.c                         |    2 +-
 target/arm/Makefile.objs                          |    1 +
 target/arm/advsimd_2a_helper.c                    |   34 +
 target/arm/advsimd_helper.c                       |  100 ++
 target/arm/cpu.h                                  |    3 +-
 target/arm/cpu64.c                                |    1 +
 target/arm/helper-a64.h                           |    9 +
 target/arm/translate-a64.c                        |  352 ++++++-
 target/hppa/cpu.h                                 |    2 +-
 target/hppa/helper.c                              |    2 +-
 target/i386/cpu.h                                 |    2 +-
 target/m68k/cpu.h                                 |    2 +-
 target/microblaze/cpu.h                           |    2 +-
 target/mips/cpu.h                                 |    2 +-
 target/moxie/cpu.h                                |    2 +-
 target/nios2/cpu.h                                |    2 +-
 target/openrisc/cpu.h                             |    2 +-
 target/ppc/cpu.h                                  |    2 +-
 target/s390x/cpu.h                                |    2 +-
 target/sh4/cpu.h                                  |    2 +-
 target/sparc/cpu.h                                |    2 +-
 target/tricore/cpu.h                              |    2 +-
 target/unicore32/cpu.h                            |    2 +-
 target/xtensa/cpu.h                               |    2 +-
 424 files changed, 38313 insertions(+), 95 deletions(-)
 create mode 100644 default-configs/aarch64-common.mak
 create mode 100644 fpu/Makefile.objs
 rename fpu/{ => softfloat2a}/softfloat-macros.h (100%)
 rename fpu/{ => softfloat2a}/softfloat-specialize.h (96%)
 rename fpu/{ => softfloat2a}/softfloat.c (99%)
 create mode 100644 fpu/softfloat3c/8086-SSE/extF80M_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/f128M_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80M.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_commonNaNToExtF80UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_commonNaNToF128M.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_commonNaNToF128UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_commonNaNToF16UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_commonNaNToF32UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_commonNaNToF64UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_extF80MToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_extF80UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_f128MToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_f128UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_f16UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_f32UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_f64UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80M.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_propagateNaNExtF80UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_propagateNaNF128M.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_propagateNaNF128UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_propagateNaNF16UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_propagateNaNF32UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/s_propagateNaNF64UI.c
 create mode 100644 fpu/softfloat3c/8086-SSE/softfloat_raiseFlags.c
 create mode 100644 fpu/softfloat3c/8086/extF80M_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/8086/f128M_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/8086/s_commonNaNToExtF80M.c
 create mode 100644 fpu/softfloat3c/8086/s_commonNaNToExtF80UI.c
 create mode 100644 fpu/softfloat3c/8086/s_commonNaNToF128M.c
 create mode 100644 fpu/softfloat3c/8086/s_commonNaNToF128UI.c
 create mode 100644 fpu/softfloat3c/8086/s_commonNaNToF16UI.c
 create mode 100644 fpu/softfloat3c/8086/s_commonNaNToF32UI.c
 create mode 100644 fpu/softfloat3c/8086/s_commonNaNToF64UI.c
 create mode 100644 fpu/softfloat3c/8086/s_extF80MToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086/s_extF80UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086/s_f128MToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086/s_f128UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086/s_f16UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086/s_f32UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086/s_f64UIToCommonNaN.c
 create mode 100644 fpu/softfloat3c/8086/s_propagateNaNExtF80M.c
 create mode 100644 fpu/softfloat3c/8086/s_propagateNaNExtF80UI.c
 create mode 100644 fpu/softfloat3c/8086/s_propagateNaNF128M.c
 create mode 100644 fpu/softfloat3c/8086/s_propagateNaNF128UI.c
 create mode 100644 fpu/softfloat3c/8086/s_propagateNaNF16UI.c
 create mode 100644 fpu/softfloat3c/8086/s_propagateNaNF32UI.c
 create mode 100644 fpu/softfloat3c/8086/s_propagateNaNF64UI.c
 create mode 100644 fpu/softfloat3c/8086/softfloat_raiseFlags.c
 create mode 100644 fpu/softfloat3c/8086/specialize.h
 create mode 100644 fpu/softfloat3c/extF80M_add.c
 create mode 100644 fpu/softfloat3c/extF80M_div.c
 create mode 100644 fpu/softfloat3c/extF80M_eq.c
 create mode 100644 fpu/softfloat3c/extF80M_eq_signaling.c
 create mode 100644 fpu/softfloat3c/extF80M_le.c
 create mode 100644 fpu/softfloat3c/extF80M_le_quiet.c
 create mode 100644 fpu/softfloat3c/extF80M_lt.c
 create mode 100644 fpu/softfloat3c/extF80M_lt_quiet.c
 create mode 100644 fpu/softfloat3c/extF80M_mul.c
 create mode 100644 fpu/softfloat3c/extF80M_rem.c
 create mode 100644 fpu/softfloat3c/extF80M_roundToInt.c
 create mode 100644 fpu/softfloat3c/extF80M_sqrt.c
 create mode 100644 fpu/softfloat3c/extF80M_sub.c
 create mode 100644 fpu/softfloat3c/extF80M_to_f128M.c
 create mode 100644 fpu/softfloat3c/extF80M_to_f16.c
 create mode 100644 fpu/softfloat3c/extF80M_to_f32.c
 create mode 100644 fpu/softfloat3c/extF80M_to_f64.c
 create mode 100644 fpu/softfloat3c/extF80M_to_i32.c
 create mode 100644 fpu/softfloat3c/extF80M_to_i32_r_minMag.c
 create mode 100644 fpu/softfloat3c/extF80M_to_i64.c
 create mode 100644 fpu/softfloat3c/extF80M_to_i64_r_minMag.c
 create mode 100644 fpu/softfloat3c/extF80M_to_ui32.c
 create mode 100644 fpu/softfloat3c/extF80M_to_ui32_r_minMag.c
 create mode 100644 fpu/softfloat3c/extF80M_to_ui64.c
 create mode 100644 fpu/softfloat3c/extF80M_to_ui64_r_minMag.c
 create mode 100644 fpu/softfloat3c/extF80_add.c
 create mode 100644 fpu/softfloat3c/extF80_div.c
 create mode 100644 fpu/softfloat3c/extF80_eq.c
 create mode 100644 fpu/softfloat3c/extF80_eq_signaling.c
 create mode 100644 fpu/softfloat3c/extF80_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/extF80_le.c
 create mode 100644 fpu/softfloat3c/extF80_le_quiet.c
 create mode 100644 fpu/softfloat3c/extF80_lt.c
 create mode 100644 fpu/softfloat3c/extF80_lt_quiet.c
 create mode 100644 fpu/softfloat3c/extF80_mul.c
 create mode 100644 fpu/softfloat3c/extF80_rem.c
 create mode 100644 fpu/softfloat3c/extF80_roundToInt.c
 create mode 100644 fpu/softfloat3c/extF80_sqrt.c
 create mode 100644 fpu/softfloat3c/extF80_sub.c
 create mode 100644 fpu/softfloat3c/extF80_to_f128.c
 create mode 100644 fpu/softfloat3c/extF80_to_f16.c
 create mode 100644 fpu/softfloat3c/extF80_to_f32.c
 create mode 100644 fpu/softfloat3c/extF80_to_f64.c
 create mode 100644 fpu/softfloat3c/extF80_to_i32.c
 create mode 100644 fpu/softfloat3c/extF80_to_i32_r_minMag.c
 create mode 100644 fpu/softfloat3c/extF80_to_i64.c
 create mode 100644 fpu/softfloat3c/extF80_to_i64_r_minMag.c
 create mode 100644 fpu/softfloat3c/extF80_to_ui32.c
 create mode 100644 fpu/softfloat3c/extF80_to_ui32_r_minMag.c
 create mode 100644 fpu/softfloat3c/extF80_to_ui64.c
 create mode 100644 fpu/softfloat3c/extF80_to_ui64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f128M_add.c
 create mode 100644 fpu/softfloat3c/f128M_div.c
 create mode 100644 fpu/softfloat3c/f128M_eq.c
 create mode 100644 fpu/softfloat3c/f128M_eq_signaling.c
 create mode 100644 fpu/softfloat3c/f128M_le.c
 create mode 100644 fpu/softfloat3c/f128M_le_quiet.c
 create mode 100644 fpu/softfloat3c/f128M_lt.c
 create mode 100644 fpu/softfloat3c/f128M_lt_quiet.c
 create mode 100644 fpu/softfloat3c/f128M_mul.c
 create mode 100644 fpu/softfloat3c/f128M_mulAdd.c
 create mode 100644 fpu/softfloat3c/f128M_rem.c
 create mode 100644 fpu/softfloat3c/f128M_roundToInt.c
 create mode 100644 fpu/softfloat3c/f128M_sqrt.c
 create mode 100644 fpu/softfloat3c/f128M_sub.c
 create mode 100644 fpu/softfloat3c/f128M_to_extF80M.c
 create mode 100644 fpu/softfloat3c/f128M_to_f16.c
 create mode 100644 fpu/softfloat3c/f128M_to_f32.c
 create mode 100644 fpu/softfloat3c/f128M_to_f64.c
 create mode 100644 fpu/softfloat3c/f128M_to_i32.c
 create mode 100644 fpu/softfloat3c/f128M_to_i32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f128M_to_i64.c
 create mode 100644 fpu/softfloat3c/f128M_to_i64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f128M_to_ui32.c
 create mode 100644 fpu/softfloat3c/f128M_to_ui32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f128M_to_ui64.c
 create mode 100644 fpu/softfloat3c/f128M_to_ui64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f128_add.c
 create mode 100644 fpu/softfloat3c/f128_div.c
 create mode 100644 fpu/softfloat3c/f128_eq.c
 create mode 100644 fpu/softfloat3c/f128_eq_signaling.c
 create mode 100644 fpu/softfloat3c/f128_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/f128_le.c
 create mode 100644 fpu/softfloat3c/f128_le_quiet.c
 create mode 100644 fpu/softfloat3c/f128_lt.c
 create mode 100644 fpu/softfloat3c/f128_lt_quiet.c
 create mode 100644 fpu/softfloat3c/f128_mul.c
 create mode 100644 fpu/softfloat3c/f128_mulAdd.c
 create mode 100644 fpu/softfloat3c/f128_rem.c
 create mode 100644 fpu/softfloat3c/f128_roundToInt.c
 create mode 100644 fpu/softfloat3c/f128_sqrt.c
 create mode 100644 fpu/softfloat3c/f128_sub.c
 create mode 100644 fpu/softfloat3c/f128_to_extF80.c
 create mode 100644 fpu/softfloat3c/f128_to_f16.c
 create mode 100644 fpu/softfloat3c/f128_to_f32.c
 create mode 100644 fpu/softfloat3c/f128_to_f64.c
 create mode 100644 fpu/softfloat3c/f128_to_i32.c
 create mode 100644 fpu/softfloat3c/f128_to_i32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f128_to_i64.c
 create mode 100644 fpu/softfloat3c/f128_to_i64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f128_to_ui32.c
 create mode 100644 fpu/softfloat3c/f128_to_ui32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f128_to_ui64.c
 create mode 100644 fpu/softfloat3c/f128_to_ui64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f16_add.c
 create mode 100644 fpu/softfloat3c/f16_div.c
 create mode 100644 fpu/softfloat3c/f16_eq.c
 create mode 100644 fpu/softfloat3c/f16_eq_signaling.c
 create mode 100644 fpu/softfloat3c/f16_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/f16_le.c
 create mode 100644 fpu/softfloat3c/f16_le_quiet.c
 create mode 100644 fpu/softfloat3c/f16_lt.c
 create mode 100644 fpu/softfloat3c/f16_lt_quiet.c
 create mode 100644 fpu/softfloat3c/f16_mul.c
 create mode 100644 fpu/softfloat3c/f16_mulAdd.c
 create mode 100644 fpu/softfloat3c/f16_rem.c
 create mode 100644 fpu/softfloat3c/f16_roundToInt.c
 create mode 100644 fpu/softfloat3c/f16_sqrt.c
 create mode 100644 fpu/softfloat3c/f16_sub.c
 create mode 100644 fpu/softfloat3c/f16_to_extF80.c
 create mode 100644 fpu/softfloat3c/f16_to_extF80M.c
 create mode 100644 fpu/softfloat3c/f16_to_f128.c
 create mode 100644 fpu/softfloat3c/f16_to_f128M.c
 create mode 100644 fpu/softfloat3c/f16_to_f32.c
 create mode 100644 fpu/softfloat3c/f16_to_f64.c
 create mode 100644 fpu/softfloat3c/f16_to_i32.c
 create mode 100644 fpu/softfloat3c/f16_to_i32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f16_to_i64.c
 create mode 100644 fpu/softfloat3c/f16_to_i64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f16_to_ui32.c
 create mode 100644 fpu/softfloat3c/f16_to_ui32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f16_to_ui64.c
 create mode 100644 fpu/softfloat3c/f16_to_ui64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f32_add.c
 create mode 100644 fpu/softfloat3c/f32_div.c
 create mode 100644 fpu/softfloat3c/f32_eq.c
 create mode 100644 fpu/softfloat3c/f32_eq_signaling.c
 create mode 100644 fpu/softfloat3c/f32_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/f32_le.c
 create mode 100644 fpu/softfloat3c/f32_le_quiet.c
 create mode 100644 fpu/softfloat3c/f32_lt.c
 create mode 100644 fpu/softfloat3c/f32_lt_quiet.c
 create mode 100644 fpu/softfloat3c/f32_mul.c
 create mode 100644 fpu/softfloat3c/f32_mulAdd.c
 create mode 100644 fpu/softfloat3c/f32_rem.c
 create mode 100644 fpu/softfloat3c/f32_roundToInt.c
 create mode 100644 fpu/softfloat3c/f32_sqrt.c
 create mode 100644 fpu/softfloat3c/f32_sub.c
 create mode 100644 fpu/softfloat3c/f32_to_extF80.c
 create mode 100644 fpu/softfloat3c/f32_to_extF80M.c
 create mode 100644 fpu/softfloat3c/f32_to_f128.c
 create mode 100644 fpu/softfloat3c/f32_to_f128M.c
 create mode 100644 fpu/softfloat3c/f32_to_f16.c
 create mode 100644 fpu/softfloat3c/f32_to_f64.c
 create mode 100644 fpu/softfloat3c/f32_to_i32.c
 create mode 100644 fpu/softfloat3c/f32_to_i32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f32_to_i64.c
 create mode 100644 fpu/softfloat3c/f32_to_i64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f32_to_ui32.c
 create mode 100644 fpu/softfloat3c/f32_to_ui32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f32_to_ui64.c
 create mode 100644 fpu/softfloat3c/f32_to_ui64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f64_add.c
 create mode 100644 fpu/softfloat3c/f64_div.c
 create mode 100644 fpu/softfloat3c/f64_eq.c
 create mode 100644 fpu/softfloat3c/f64_eq_signaling.c
 create mode 100644 fpu/softfloat3c/f64_isSignalingNaN.c
 create mode 100644 fpu/softfloat3c/f64_le.c
 create mode 100644 fpu/softfloat3c/f64_le_quiet.c
 create mode 100644 fpu/softfloat3c/f64_lt.c
 create mode 100644 fpu/softfloat3c/f64_lt_quiet.c
 create mode 100644 fpu/softfloat3c/f64_mul.c
 create mode 100644 fpu/softfloat3c/f64_mulAdd.c
 create mode 100644 fpu/softfloat3c/f64_rem.c
 create mode 100644 fpu/softfloat3c/f64_roundToInt.c
 create mode 100644 fpu/softfloat3c/f64_sqrt.c
 create mode 100644 fpu/softfloat3c/f64_sub.c
 create mode 100644 fpu/softfloat3c/f64_to_extF80.c
 create mode 100644 fpu/softfloat3c/f64_to_extF80M.c
 create mode 100644 fpu/softfloat3c/f64_to_f128.c
 create mode 100644 fpu/softfloat3c/f64_to_f128M.c
 create mode 100644 fpu/softfloat3c/f64_to_f16.c
 create mode 100644 fpu/softfloat3c/f64_to_f32.c
 create mode 100644 fpu/softfloat3c/f64_to_i32.c
 create mode 100644 fpu/softfloat3c/f64_to_i32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f64_to_i64.c
 create mode 100644 fpu/softfloat3c/f64_to_i64_r_minMag.c
 create mode 100644 fpu/softfloat3c/f64_to_ui32.c
 create mode 100644 fpu/softfloat3c/f64_to_ui32_r_minMag.c
 create mode 100644 fpu/softfloat3c/f64_to_ui64.c
 create mode 100644 fpu/softfloat3c/f64_to_ui64_r_minMag.c
 create mode 100644 fpu/softfloat3c/i32_to_extF80.c
 create mode 100644 fpu/softfloat3c/i32_to_extF80M.c
 create mode 100644 fpu/softfloat3c/i32_to_f128.c
 create mode 100644 fpu/softfloat3c/i32_to_f128M.c
 create mode 100644 fpu/softfloat3c/i32_to_f16.c
 create mode 100644 fpu/softfloat3c/i32_to_f32.c
 create mode 100644 fpu/softfloat3c/i32_to_f64.c
 create mode 100644 fpu/softfloat3c/i64_to_extF80.c
 create mode 100644 fpu/softfloat3c/i64_to_extF80M.c
 create mode 100644 fpu/softfloat3c/i64_to_f128.c
 create mode 100644 fpu/softfloat3c/i64_to_f128M.c
 create mode 100644 fpu/softfloat3c/i64_to_f16.c
 create mode 100644 fpu/softfloat3c/i64_to_f32.c
 create mode 100644 fpu/softfloat3c/i64_to_f64.c
 create mode 100644 fpu/softfloat3c/platform.h
 create mode 100644 fpu/softfloat3c/s_add128.c
 create mode 100644 fpu/softfloat3c/s_add256M.c
 create mode 100644 fpu/softfloat3c/s_addCarryM.c
 create mode 100644 fpu/softfloat3c/s_addComplCarryM.c
 create mode 100644 fpu/softfloat3c/s_addExtF80M.c
 create mode 100644 fpu/softfloat3c/s_addF128M.c
 create mode 100644 fpu/softfloat3c/s_addM.c
 create mode 100644 fpu/softfloat3c/s_addMagsExtF80.c
 create mode 100644 fpu/softfloat3c/s_addMagsF128.c
 create mode 100644 fpu/softfloat3c/s_addMagsF16.c
 create mode 100644 fpu/softfloat3c/s_addMagsF32.c
 create mode 100644 fpu/softfloat3c/s_addMagsF64.c
 create mode 100644 fpu/softfloat3c/s_approxRecip32_1.c
 create mode 100644 fpu/softfloat3c/s_approxRecipSqrt32_1.c
 create mode 100644 fpu/softfloat3c/s_approxRecipSqrt_1Ks.c
 create mode 100644 fpu/softfloat3c/s_approxRecip_1Ks.c
 create mode 100644 fpu/softfloat3c/s_compare128M.c
 create mode 100644 fpu/softfloat3c/s_compare96M.c
 create mode 100644 fpu/softfloat3c/s_compareNonnormExtF80M.c
 create mode 100644 fpu/softfloat3c/s_countLeadingZeros16.c
 create mode 100644 fpu/softfloat3c/s_countLeadingZeros32.c
 create mode 100644 fpu/softfloat3c/s_countLeadingZeros64.c
 create mode 100644 fpu/softfloat3c/s_countLeadingZeros8.c
 create mode 100644 fpu/softfloat3c/s_eq128.c
 create mode 100644 fpu/softfloat3c/s_invalidExtF80M.c
 create mode 100644 fpu/softfloat3c/s_invalidF128M.c
 create mode 100644 fpu/softfloat3c/s_isNaNF128M.c
 create mode 100644 fpu/softfloat3c/s_le128.c
 create mode 100644 fpu/softfloat3c/s_lt128.c
 create mode 100644 fpu/softfloat3c/s_mul128By32.c
 create mode 100644 fpu/softfloat3c/s_mul128MTo256M.c
 create mode 100644 fpu/softfloat3c/s_mul128To256M.c
 create mode 100644 fpu/softfloat3c/s_mul64ByShifted32To128.c
 create mode 100644 fpu/softfloat3c/s_mul64To128.c
 create mode 100644 fpu/softfloat3c/s_mul64To128M.c
 create mode 100644 fpu/softfloat3c/s_mulAddF128.c
 create mode 100644 fpu/softfloat3c/s_mulAddF128M.c
 create mode 100644 fpu/softfloat3c/s_mulAddF16.c
 create mode 100644 fpu/softfloat3c/s_mulAddF32.c
 create mode 100644 fpu/softfloat3c/s_mulAddF64.c
 create mode 100644 fpu/softfloat3c/s_negXM.c
 create mode 100644 fpu/softfloat3c/s_normExtF80SigM.c
 create mode 100644 fpu/softfloat3c/s_normRoundPackMToExtF80M.c
 create mode 100644 fpu/softfloat3c/s_normRoundPackMToF128M.c
 create mode 100644 fpu/softfloat3c/s_normRoundPackToExtF80.c
 create mode 100644 fpu/softfloat3c/s_normRoundPackToF128.c
 create mode 100644 fpu/softfloat3c/s_normRoundPackToF16.c
 create mode 100644 fpu/softfloat3c/s_normRoundPackToF32.c
 create mode 100644 fpu/softfloat3c/s_normRoundPackToF64.c
 create mode 100644 fpu/softfloat3c/s_normSubnormalExtF80Sig.c
 create mode 100644 fpu/softfloat3c/s_normSubnormalF128Sig.c
 create mode 100644 fpu/softfloat3c/s_normSubnormalF128SigM.c
 create mode 100644 fpu/softfloat3c/s_normSubnormalF16Sig.c
 create mode 100644 fpu/softfloat3c/s_normSubnormalF32Sig.c
 create mode 100644 fpu/softfloat3c/s_normSubnormalF64Sig.c
 create mode 100644 fpu/softfloat3c/s_remStepMBy32.c
 create mode 100644 fpu/softfloat3c/s_roundMToI64.c
 create mode 100644 fpu/softfloat3c/s_roundMToUI64.c
 create mode 100644 fpu/softfloat3c/s_roundPackMToExtF80M.c
 create mode 100644 fpu/softfloat3c/s_roundPackMToF128M.c
 create mode 100644 fpu/softfloat3c/s_roundPackToExtF80.c
 create mode 100644 fpu/softfloat3c/s_roundPackToF128.c
 create mode 100644 fpu/softfloat3c/s_roundPackToF16.c
 create mode 100644 fpu/softfloat3c/s_roundPackToF32.c
 create mode 100644 fpu/softfloat3c/s_roundPackToF64.c
 create mode 100644 fpu/softfloat3c/s_roundToI32.c
 create mode 100644 fpu/softfloat3c/s_roundToI64.c
 create mode 100644 fpu/softfloat3c/s_roundToUI32.c
 create mode 100644 fpu/softfloat3c/s_roundToUI64.c
 create mode 100644 fpu/softfloat3c/s_shiftLeftM.c
 create mode 100644 fpu/softfloat3c/s_shiftNormSigF128M.c
 create mode 100644 fpu/softfloat3c/s_shiftRightJam128.c
 create mode 100644 fpu/softfloat3c/s_shiftRightJam128Extra.c
 create mode 100644 fpu/softfloat3c/s_shiftRightJam256M.c
 create mode 100644 fpu/softfloat3c/s_shiftRightJam32.c
 create mode 100644 fpu/softfloat3c/s_shiftRightJam64.c
 create mode 100644 fpu/softfloat3c/s_shiftRightJam64Extra.c
 create mode 100644 fpu/softfloat3c/s_shiftRightJamM.c
 create mode 100644 fpu/softfloat3c/s_shiftRightM.c
 create mode 100644 fpu/softfloat3c/s_shortShiftLeft128.c
 create mode 100644 fpu/softfloat3c/s_shortShiftLeft64To96M.c
 create mode 100644 fpu/softfloat3c/s_shortShiftLeftM.c
 create mode 100644 fpu/softfloat3c/s_shortShiftRight128.c
 create mode 100644 fpu/softfloat3c/s_shortShiftRightExtendM.c
 create mode 100644 fpu/softfloat3c/s_shortShiftRightJam128.c
 create mode 100644 fpu/softfloat3c/s_shortShiftRightJam128Extra.c
 create mode 100644 fpu/softfloat3c/s_shortShiftRightJam64.c
 create mode 100644 fpu/softfloat3c/s_shortShiftRightJam64Extra.c
 create mode 100644 fpu/softfloat3c/s_shortShiftRightJamM.c
 create mode 100644 fpu/softfloat3c/s_shortShiftRightM.c
 create mode 100644 fpu/softfloat3c/s_sub128.c
 create mode 100644 fpu/softfloat3c/s_sub1XM.c
 create mode 100644 fpu/softfloat3c/s_sub256M.c
 create mode 100644 fpu/softfloat3c/s_subM.c
 create mode 100644 fpu/softfloat3c/s_subMagsExtF80.c
 create mode 100644 fpu/softfloat3c/s_subMagsF128.c
 create mode 100644 fpu/softfloat3c/s_subMagsF16.c
 create mode 100644 fpu/softfloat3c/s_subMagsF32.c
 create mode 100644 fpu/softfloat3c/s_subMagsF64.c
 create mode 100644 fpu/softfloat3c/s_tryPropagateNaNExtF80M.c
 create mode 100644 fpu/softfloat3c/s_tryPropagateNaNF128M.c
 create mode 100644 fpu/softfloat3c/softfloat_state.c
 create mode 100644 fpu/softfloat3c/specialize.h
 create mode 100644 fpu/softfloat3c/ui32_to_extF80.c
 create mode 100644 fpu/softfloat3c/ui32_to_extF80M.c
 create mode 100644 fpu/softfloat3c/ui32_to_f128.c
 create mode 100644 fpu/softfloat3c/ui32_to_f128M.c
 create mode 100644 fpu/softfloat3c/ui32_to_f16.c
 create mode 100644 fpu/softfloat3c/ui32_to_f32.c
 create mode 100644 fpu/softfloat3c/ui32_to_f64.c
 create mode 100644 fpu/softfloat3c/ui64_to_extF80.c
 create mode 100644 fpu/softfloat3c/ui64_to_extF80M.c
 create mode 100644 fpu/softfloat3c/ui64_to_f128.c
 create mode 100644 fpu/softfloat3c/ui64_to_f128M.c
 create mode 100644 fpu/softfloat3c/ui64_to_f16.c
 create mode 100644 fpu/softfloat3c/ui64_to_f32.c
 create mode 100644 fpu/softfloat3c/ui64_to_f64.c
 rename include/fpu/{ => softfloat2a}/softfloat.h (97%)
 create mode 100644 include/fpu/softfloat3c/primitiveTypes.h
 create mode 100644 include/fpu/softfloat3c/primitives.h
 create mode 100644 include/fpu/softfloat3c/softfloat-internals.h
 create mode 100644 include/fpu/softfloat3c/softfloat.h
 create mode 100644 include/fpu/softfloat3c/softfloat_types.h
 create mode 100644 target/arm/advsimd_2a_helper.c
 create mode 100644 target/arm/advsimd_helper.c

-- 
2.13.0
