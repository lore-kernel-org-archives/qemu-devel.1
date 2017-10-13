Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lS-0002Pe-MH
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lN-0006SL-Ji
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:46 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:52246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lN-0006Rn-AG
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:41 -0400
Received: by mail-wr0-x22e.google.com with SMTP id k62so1426220wrc.9
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:08 +0100
Message-Id: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 00/30] v8.2 half-precision support
 (work-in-progress)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is the current state of ARM v8.2 half precision operations. There
are two halves to this effort, expanding our copy of softfloat to
include the requisite operations and then plumbing in the appropriate
helpers and tcg generation code into the ARM front end.

I'm posting this today as I wanted to get feedback before too many
assumptions where baked into what is already a large patch series
which will likely be giant by the time it is finished.

SoftFloat
=========

Previously I had pondered if switching to the newer SoftFloat3 would
be a worthwhile. While the upstream project is certainly open to
accepting patches it would be a slow process given the changes we've
made over the years. As a result I've decided to stick with expanding
our current code.

Most of the helpers have been done fairly mechanically by copying the
float32 equivalent, filing off the 32's, replacing with 16's and
adjusting the constants appropriately (min/max exp, NaNs etc). I've
done this in conjunction with reading the SoftFloat3 code as a sanity
check although in places the design is a little different.

Some bits of the softfloat code were a bit magical to me so I've added
additional comments and re-written the flow to be a bit more obvious.
Currently there a whole bunch of checkpatch things to fix, now we
"own" this copy of softfloat I'm intending for the new code to follow
our own internal coding standards.

The tests/test-softfloat is slightly hacked up. I do want to build one
for each configured target as softfloat varies depending on the target
parameters but I couldn't quite get it to work with:

  @@ -156,10 +158,11 @@ check-unit-y += tests/ptimer-test$(EXESUF)
   gcov-files-ptimer-test-y = hw/core/ptimer.c
   check-unit-y += tests/test-qapi-util$(EXESUF)
   gcov-files-test-qapi-util-y = qapi/qapi-util.c
  -check-unit-y += tests/test-softfloat$(EXESUF)
  -gcov-files-test-softfloat-y = fpu/softfloat.c
  -check-unit-y += tests/test-softfloat-aarch64$(EXESUF)
  -gcov-files-test-softfloat-aarch64-y = fpu/softfloat.c
  +
  +# We built a softfloat test for each variant of softfloat we have
  +$(foreach TARGET,$(TARGETS),\
  +	$(eval check-unit-y += tests/test-softfloat-$(TARGET)$(EXESUF)) \
  +	$(eval gcov-files-test-softfloat-$(TARGET)-y = fpu/softfloat.c))

   check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh

  @@ -608,8 +611,9 @@ tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(tes
   tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
   tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
   tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
  -tests/test-softfloat$(EXESUF): tests/test-softfloat.o $(BUILD_DIR)/aarch64-softmmu/fpu/softfloat.o
  -tests/test-softfloat-aarch64$(EXESUF): tests/test-softfloat.o $(BUILD_DIR)/aarch64-softmmu/fpu/softfloat.o
  +# There is a softfloat test target for each system type/softfloat build
  +$(foreach TARGET,$(TARGETS),\
  +	$(eval tests/test-softfloat-$(TARGET)$(EXESUF): tests/test-softfloat.o $(BUILD_DIR)/$(TARGET)-softmmu/fpu/softfloat.o))

I think it would be nice to add some softfloat unit tests so any
pointers welcome.

ARM Vector Code
===============

The code follows the existing decompose into chunks and call helpers
methodology. I was originally going to base this directly on top of
Richard's TCGvec support but realised this would introduce a
dependency that might complicate further development. I have ended up
copy and pasting a bunch of the loop code, see lines like:

  for (pass = 0; pass < (is_q ? 8 : 4); pass++) {
  ...
  .. stuff per element ..
  ...
  }

I wonder if more of that could be factored away into a common iterator
which could be more easily converted when the vector code is ready.
For now following the existing conventions hopefully makes it easier
to review.


Alex Bennée (30):
  linux-user/main: support dfilter
  arm: introduce ARM_V8_FP16 feature bit
  include/exec/helper-head.h: support f16 in helper calls
  target/arm/cpu.h: update comment for half-precision values
  softfloat: implement propagateFloat16NaN
  fpu/softfloat: implement float16_squash_input_denormal
  fpu/softfloat: implement float16_abs helper
  softfloat: add half-precision expansions for MINMAX fns
  softfloat: propagate signalling NaNs in MINMAX
  softfloat: improve comments on ARM NaN propagation
  target/arm: implement half-precision F(MIN|MAX)(V|NMV)
  target/arm/translate-a64.c: handle_3same_64 comment fix
  target/arm/translate-a64.c: AdvSIMD scalar 3 Same FP16 initial decode
  softfloat: 16 bit helpers for shr, clz and rounding and packing
  softfloat: half-precision add/sub/mul/div support
  target/arm/translate-a64.c: add FP16 FADD/FMUL/FDIV to AdvSIMD 3 Same
    (!sub)
  target/arm/translate-a64.c: add FP16 FMULX
  target/arm/translate-a64.c: add AdvSIMD scalar two-reg misc skeleton
  Fix mask for AdvancedSIMD 2 reg misc
  softfloat: half-precision compare functions
  target/arm/translate-a64: add FP16 2-reg misc compare (zero)
  target/arm/translate-a64.c: add FP16 FAGCT to AdvSIMD 3 Same
  softfloat: add float16_rem and float16_muladd (!CHECK)
  disas_simd_indexed: support half-precision operations
  softfloat: float16_round_to_int
  tests/test-softfloat: add a simple test framework
  target/arm/translate-a64.c: add FP16 FRINTP to 2 reg misc
  softfloat: float16_to_int16 conversion
  tests/test-softfloat: add f16_to_int16 conversion test
  target/arm/translate-a64.c: add FP16 FCVTPS to 2 reg misc

 fpu/softfloat-macros.h     |   39 ++
 fpu/softfloat-specialize.h |  105 ++++-
 fpu/softfloat.c            | 1121 +++++++++++++++++++++++++++++++++++++++++++-
 include/exec/helper-head.h |    3 +
 include/fpu/softfloat.h    |   37 ++
 linux-user/main.c          |    7 +
 target/arm/cpu.h           |    2 +
 target/arm/cpu64.c         |    1 +
 target/arm/helper-a64.c    |  122 +++++
 target/arm/helper-a64.h    |   17 +
 target/arm/translate-a64.c |  420 ++++++++++++++---
 tests/Makefile.include     |    8 +-
 tests/test-softfloat.c     |   84 ++++
 13 files changed, 1883 insertions(+), 83 deletions(-)
 create mode 100644 tests/test-softfloat.c

-- 
2.14.1
