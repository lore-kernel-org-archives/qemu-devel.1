Received: from eggs.gnu.org ([2001:4830:134:3::10]:47232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBed-0004UC-1Y
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBeY-0004oP-2d
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:47 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:45544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBeX-0004oB-Q1
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:41 -0500
Received: by mail-pg0-x232.google.com with SMTP id m136so15978715pga.12
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:11:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:12 -0800
Message-Id: <20180204041136.17525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/24] re-factor and add fp16 using glibc
 soft-fp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

As discussed on list, the structure and inline function solution that
Alex and I have been writing from scratch introduces a sizeable
performance regression.  Alex and I have done some work earlier
in the week that improved things some, but not enough.

Which leaves us with a bit of a problem.  The were two existing
code bases that we originally considered:

There's softfloat v3, which would need a large structural reorg in
order to be able to handle multiple float_status contexts.  But when
Alex communicated with upstream they weren't ready to accept patches.

Or there's the code from glibc.  I know Peter didn't like the idea;
debugging this code is fairly painful -- the massive preprocessor
macros mean that you can't step through anything.  But at least we
have a good relationship with glibc, so merging patches back and
forth should be easy.

The result seems to perform slightly better than mainline.
With an aarch64 guest and a i7-8550U host, nbench gives

- FLOATING-POINT INDEX: 3.095
+ FLOATING-POINT INDEX: 3.438

I've also run this through my usual set of aarch64 RISU tests.

Thoughts?


r~


Alex Bennée (9):
  fpu/softfloat: implement float16_squash_input_denormal
  include/fpu/softfloat: remove USE_SOFTFLOAT_STRUCT_TYPES
  fpu/softfloat-types: new header to prevent excessive re-builds
  target/*/cpu.h: remove softfloat.h
  include/fpu/softfloat: implement float16_abs helper
  include/fpu/softfloat: implement float16_chs helper
  include/fpu/softfloat: implement float16_set_sign helper
  include/fpu/softfloat: add some float16 constants
  fpu/softfloat: improve comments on ARM NaN propagation

Richard Henderson (15):
  fpu/soft-fp: Import soft-fp from glibc
  fpu/soft-fp: Adjust soft-fp types
  fpu/soft-fp: Add ties_away and to_odd rounding modes
  fpu/soft-fp: Add arithmetic macros to half.h
  fpu/soft-fp: Adjust _FP_CMP_CHECK_NAN
  fpu: Implement add/sub/mul/div with soft-fp.h
  fpu: Implement float_to_int/uint with soft-fp.h
  fpu: Implement int/uint_to_float with soft-fp.h
  fpu: Implement compares with soft-fp.h
  fpu: Implement min/max with soft-fp.h
  fpu: Implement sqrt with soft-fp.h
  fpu: Implement scalbn with soft-fp.h
  fpu: Implement float_to_float with soft-fp.h
  fpu: Implement muladd with soft-fp.h
  fpu: Implement round_to_int with soft-fp.h

 Makefile.target                 |    5 +
 fpu/double.h                    |  321 +++
 fpu/half.h                      |  180 ++
 fpu/op-1.h                      |  369 +++
 fpu/op-2.h                      |  705 ++++++
 fpu/op-4.h                      |  875 +++++++
 fpu/op-8.h                      |    1 +
 fpu/op-common.h                 | 2154 +++++++++++++++++
 fpu/quad.h                      |  328 +++
 fpu/sfp-machine.h               |  222 ++
 fpu/single.h                    |  197 ++
 fpu/soft-fp-specialize.h        |  254 ++
 fpu/soft-fp.h                   |  379 +++
 fpu/softfloat-specialize.h      |  273 +--
 include/fpu/softfloat-types.h   |  179 ++
 include/fpu/softfloat.h         |  254 +-
 include/qemu/bswap.h            |    2 +-
 target/alpha/cpu.h              |    2 -
 target/arm/cpu.h                |    2 -
 target/hppa/cpu.h               |    1 -
 target/i386/cpu.h               |    4 -
 target/m68k/cpu.h               |    1 -
 target/microblaze/cpu.h         |    2 +-
 target/moxie/cpu.h              |    1 -
 target/nios2/cpu.h              |    1 -
 target/openrisc/cpu.h           |    1 -
 target/ppc/cpu.h                |    1 -
 target/s390x/cpu.h              |    2 -
 target/sh4/cpu.h                |    2 -
 target/sparc/cpu.h              |    2 -
 target/tricore/cpu.h            |    1 -
 target/unicore32/cpu.h          |    1 -
 target/xtensa/cpu.h             |    1 -
 fpu/float128.c                  |   35 +
 fpu/float16.c                   |   43 +
 fpu/float32.c                   |   35 +
 fpu/float64.c                   |   35 +
 fpu/floatconv.c                 |  154 ++
 fpu/floatxx.inc.c               |  541 +++++
 fpu/softfloat.c                 | 5092 +--------------------------------------
 target/arm/cpu.c                |    1 +
 target/arm/helper-a64.c         |    1 +
 target/arm/helper.c             |    1 +
 target/arm/neon_helper.c        |    1 +
 target/hppa/cpu.c               |    1 +
 target/hppa/op_helper.c         |    1 +
 target/i386/fpu_helper.c        |    1 +
 target/m68k/cpu.c               |    2 +-
 target/m68k/fpu_helper.c        |    1 +
 target/m68k/helper.c            |    1 +
 target/m68k/translate.c         |    2 +
 target/microblaze/cpu.c         |    1 +
 target/microblaze/op_helper.c   |    1 +
 target/openrisc/fpu_helper.c    |    1 +
 target/ppc/fpu_helper.c         |    1 +
 target/ppc/int_helper.c         |    1 +
 target/ppc/translate_init.c     |    1 +
 target/s390x/cpu.c              |    1 +
 target/s390x/fpu_helper.c       |    1 +
 target/sh4/cpu.c                |    1 +
 target/sh4/op_helper.c          |    1 +
 target/sparc/fop_helper.c       |    1 +
 target/tricore/fpu_helper.c     |    1 +
 target/tricore/helper.c         |    1 +
 target/unicore32/cpu.c          |    1 +
 target/unicore32/ucf64_helper.c |    1 +
 target/xtensa/op_helper.c       |    1 +
 67 files changed, 7184 insertions(+), 5503 deletions(-)
 create mode 100644 fpu/double.h
 create mode 100644 fpu/half.h
 create mode 100644 fpu/op-1.h
 create mode 100644 fpu/op-2.h
 create mode 100644 fpu/op-4.h
 create mode 100644 fpu/op-8.h
 create mode 100644 fpu/op-common.h
 create mode 100644 fpu/quad.h
 create mode 100644 fpu/sfp-machine.h
 create mode 100644 fpu/single.h
 create mode 100644 fpu/soft-fp-specialize.h
 create mode 100644 fpu/soft-fp.h
 create mode 100644 include/fpu/softfloat-types.h
 create mode 100644 fpu/float128.c
 create mode 100644 fpu/float16.c
 create mode 100644 fpu/float32.c
 create mode 100644 fpu/float64.c
 create mode 100644 fpu/floatconv.c
 create mode 100644 fpu/floatxx.inc.c

-- 
2.14.3
