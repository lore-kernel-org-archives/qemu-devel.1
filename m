Received: from eggs.gnu.org ([2001:4830:134:3::10]:55517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eeKrh-0003DM-LX
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eeKre-0003cV-CF
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:13:21 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eeKre-0003bY-24
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:13:18 -0500
Received: by mail-wr0-x230.google.com with SMTP id s5so2647530wra.0
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:13:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 24 Jan 2018 13:12:53 +0000
Message-Id: <20180124131315.30567-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is the third iteration of my softfloat re-factor patches. You can
see the discussion about v2 here:

    https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg01475.html

Most of the changes are addressing review comments but I also have
added another patch early on to try and reduce the re-builds triggered
by touching softfloat.h. This involves a bit of mechanical churn but
is worth it to avoid the complete re-build. There is still a bit of a
dependency in the MIPS cpu.h due to it's need to tweak the signalling
NaN bit.

The biggest change from the review comments are shorter names and a
reduction of the size of the function names and related structures.

I've fixed most of the checkpatch warnings but there is one line which
tops 80 chars by one character. The other I think is a false positive
about the position of a -.

As usual the details of the changes are in the individual commit
messages.

There are a few comments where I haven't made changes yet as I'm
pondering the best way forward. The main unresolved bit is
re-factoring the specialisation code that deals with the variation of
NaN behaviour. I'm wary of exposing the internals to the wider world
so perhaps a softfloat-internals.h and
target/foo/softfloat-specialize.o?

I've added one simple helper (is_nan(x)) internal to softfloat. I
haven't used it more widely than asked in the comments to avoid too
much churn. Maybe is_inf and is_zero would be additional helpful
internal helpers or for softfloat-internals.h.

I suppose the question is do we want to do that in this series or have
a follow-up as we fix the existing bugs? If we can follow-up then I
think this series is ready to go.


Alex Bennée (22):
  fpu/softfloat: implement float16_squash_input_denormal
  include/fpu/softfloat: remove USE_SOFTFLOAT_STRUCT_TYPES
  fpu/softfloat-types: new header to prevent excessive re-builds
  target/*/cpu.h: remove softfloat.h
  include/fpu/softfloat: implement float16_abs helper
  include/fpu/softfloat: implement float16_chs helper
  include/fpu/softfloat: implement float16_set_sign helper
  include/fpu/softfloat: add some float16 constants
  fpu/softfloat: improve comments on ARM NaN propagation
  fpu/softfloat: move the extract functions to the top of the file
  fpu/softfloat: define decompose structures
  fpu/softfloat: re-factor add/sub
  fpu/softfloat: re-factor mul
  fpu/softfloat: re-factor div
  fpu/softfloat: re-factor muladd
  fpu/softfloat: re-factor round_to_int
  fpu/softfloat: re-factor float to int/uint
  fpu/softfloat: re-factor int/uint to float
  fpu/softfloat: re-factor scalbn
  fpu/softfloat: re-factor minmax
  fpu/softfloat: re-factor compare
  fpu/softfloat: re-factor sqrt

 fpu/softfloat-macros.h          |   44 +
 fpu/softfloat-specialize.h      |  109 +-
 fpu/softfloat.c                 | 4538 ++++++++++++++++-----------------------
 include/fpu/softfloat-types.h   |  179 ++
 include/fpu/softfloat.h         |  202 +-
 include/qemu/bswap.h            |    2 +-
 target/alpha/cpu.h              |    2 -
 target/arm/cpu.c                |    1 +
 target/arm/cpu.h                |    2 -
 target/arm/helper-a64.c         |    1 +
 target/arm/helper.c             |    1 +
 target/arm/neon_helper.c        |    1 +
 target/hppa/cpu.c               |    1 +
 target/hppa/cpu.h               |    1 -
 target/hppa/op_helper.c         |    1 +
 target/i386/cpu.h               |    4 -
 target/i386/fpu_helper.c        |    1 +
 target/m68k/cpu.c               |    2 +-
 target/m68k/cpu.h               |    1 -
 target/m68k/fpu_helper.c        |    1 +
 target/m68k/helper.c            |    1 +
 target/m68k/translate.c         |    2 +
 target/microblaze/cpu.c         |    1 +
 target/microblaze/cpu.h         |    2 +-
 target/microblaze/op_helper.c   |    1 +
 target/moxie/cpu.h              |    1 -
 target/nios2/cpu.h              |    1 -
 target/openrisc/cpu.h           |    1 -
 target/openrisc/fpu_helper.c    |    1 +
 target/ppc/cpu.h                |    1 -
 target/ppc/fpu_helper.c         |    1 +
 target/ppc/int_helper.c         |    1 +
 target/ppc/translate_init.c     |    1 +
 target/s390x/cpu.c              |    1 +
 target/s390x/cpu.h              |    2 -
 target/s390x/fpu_helper.c       |    1 +
 target/sh4/cpu.c                |    1 +
 target/sh4/cpu.h                |    2 -
 target/sh4/op_helper.c          |    1 +
 target/sparc/cpu.h              |    2 -
 target/sparc/fop_helper.c       |    1 +
 target/tricore/cpu.h            |    1 -
 target/tricore/fpu_helper.c     |    1 +
 target/tricore/helper.c         |    1 +
 target/unicore32/cpu.c          |    1 +
 target/unicore32/cpu.h          |    1 -
 target/unicore32/ucf64_helper.c |    1 +
 target/xtensa/cpu.h             |    1 -
 target/xtensa/op_helper.c       |    1 +
 49 files changed, 2188 insertions(+), 2940 deletions(-)
 create mode 100644 include/fpu/softfloat-types.h

-- 
2.15.1
