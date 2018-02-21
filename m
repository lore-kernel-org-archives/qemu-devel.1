Received: from eggs.gnu.org ([2001:4830:134:3::10]:35236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDM-0003rb-9U
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDG-0006aJ-Bj
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:32 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:46810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSDG-0006a4-2g
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:26 -0500
Received: by mail-wr0-x22b.google.com with SMTP id 34so3254206wre.13
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:05:25 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:00 +0000
Message-Id: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/22] re-factor softfloat and add fp16 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit a6e0344fa0e09413324835ae122c4cadd7890231:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-request' into staging (2018-02-20 14:05:00 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-softfloat-refactor-210218-1

for you to fetch changes up to c13bb2da9eedfbc5886c8048df1bc1114b285fb0:

  fpu/softfloat: re-factor sqrt (2018-02-21 10:21:54 +0000)

----------------------------------------------------------------
This is the re-factor of softfloat:

  - shared common code path float16/32/64
  - well commented and easy to follow code
  - added a bunch of float16 support

While some operations are slower the key ones exercised by the
floating point dbt-bench are the same: https://i.imgur.com/oXNJNql.png

----------------------------------------------------------------
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

 fpu/softfloat-macros.h          |   48 +
 fpu/softfloat-specialize.h      |  109 +-
 fpu/softfloat.c                 | 4550 ++++++++++++++++-----------------------
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
 target/hppa/op_helper.c         |    2 +-
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
 49 files changed, 2204 insertions(+), 2941 deletions(-)
 create mode 100644 include/fpu/softfloat-types.h


-- 
2.15.1
