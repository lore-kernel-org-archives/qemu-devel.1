Received: from eggs.gnu.org ([2001:4830:134:3::10]:33391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej6Pu-0000T6-5G
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej6Pq-0004ds-3U
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:48:22 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej6Pp-0004c4-PR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:48:18 -0500
Received: by mail-wr0-x22b.google.com with SMTP id w50so2658085wrc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 08:48:17 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  6 Feb 2018 16:47:53 +0000
Message-Id: <20180206164815.10084-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/22] re-factor softfloat and add fp16
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

Hi,

The main change is applying the __attribute__((flatten)) to some of
the public functions that show up in Emilio's dbt-benchmark. This
seems to be a cleaner solution that squashing inlines higher up the
chain and still leaves the chance for re-use for the less widely used
functions. The results are an improvement over v3 by some margin:

                         NBench score; higher is better

    5 +-+-----------+-------------+------------+-------------+-----------+-+
      |                     ****### %%%%  +++                              |
  4.5 +-+...................*..*..#.%..%..****##..%%%%+ system-2.5       +-+
      |                     *  *  # %  %  *  * #  %  %      master         |
    4 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-v3       +-+
  3.5 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-%%%%.....+-+
      |                     *  *  # %  %  *  * #  %  %  * *  #  %  %       |
    3 +-+...................*..*..#.%..%..*..*.#..%..%..*.*..#..%..%.....+-+
      |                     *  *  #+%  %  *  * #$$$  %  * *  #  %  %       |
  2.5 +-+........####.......*..*..#$$..%..*..*.#..$..%..*.*..#..%..%.....+-+
      |       ****  #  %%%  *  *  # $  %  *  * #  $  %  * *  #$$$  %       |
    2 +-+.....*..*..#..%.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....+-+
      |       *  *  #  % %  *  *  # $  %  *  * #  $  %  * *  #  $  %       |
  1.5 +-+.....*..*..#$$$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....+-+
    1 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....+-+
      |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %       |
  0.5 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....+-+
      |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %       |
    0 +-+-----****###$$$%%--****###$$%%%--****##$$$%%%--***###$$$%%%-----+-+
                 FOURIER     NEURAL NETLU DECOMPOSITION    gmean

Slightly easier to read PNG:

    https://i.imgur.com/XEeL0bC.png

I think it's pretty ready for a merge. Shall I submit a pull myself or
does it make sense going via someone else? According to MAINTAINERS
Peter and Aurelien are responsible for this code...

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
 fpu/softfloat.c                 | 4545 ++++++++++++++++-----------------------
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
 49 files changed, 2199 insertions(+), 2941 deletions(-)
 create mode 100644 include/fpu/softfloat-types.h

-- 
2.15.1
