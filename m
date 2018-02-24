Received: from eggs.gnu.org ([2001:4830:134:3::10]:33555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epgGt-0001tx-Ui
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epgGq-0007hj-NT
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:18:15 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:59765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1epgGq-0007f4-D2
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 15:18:12 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Feb 2018 21:17:58 +0100
Message-Id: <20180224201802.911-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 0/4] target/m68k: implement 680x0 FPU (part
 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

Implement fmod, frem, fscale, fgetman and fgetexp.

Instead of using functions of libm (v1 of this series)
and converting between host long double and floatx80 type
the new version (v2) adds new floatx80 functions in softfloat.

All the floatx80 functions are copied from "Previous",
the NeXT Computer Emulator, and written by Andreas Grabher.

v4: fix floatx80_to_int64() to check for NaN, not for infinity
    fix floatx80_is_infinity() to ignore mantissa's MSB

v3: Move all new functions to target/m68k/softfloat.c
    Exports needed functions from fpu/softfloat.c

Laurent Vivier (4):
  softfloat: export some functions
  target/m68k: add fmod/frem
  softfloat: use floatx80_infinity in softfloat
  target/m68k: add fscale, fgetman and fgetexp

 fpu/softfloat-specialize.h              |  17 ++-
 fpu/softfloat.c                         | 130 +++++------------
 {fpu => include/fpu}/softfloat-macros.h |  10 +-
 include/fpu/softfloat.h                 | 133 ++++++++++++++++-
 target/m68k/Makefile.objs               |   3 +-
 target/m68k/cpu.h                       |   1 +
 target/m68k/fpu_helper.c                |  50 ++++++-
 target/m68k/helper.h                    |   5 +
 target/m68k/softfloat.c                 | 249 ++++++++++++++++++++++++++++++++
 target/m68k/softfloat.h                 |  29 ++++
 target/m68k/translate.c                 |  15 ++
 11 files changed, 536 insertions(+), 106 deletions(-)
 rename {fpu => include/fpu}/softfloat-macros.h (98%)
 create mode 100644 target/m68k/softfloat.c
 create mode 100644 target/m68k/softfloat.h

-- 
2.14.3
