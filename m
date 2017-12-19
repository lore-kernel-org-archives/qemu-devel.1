Received: from eggs.gnu.org ([2001:4830:134:3::10]:49041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAci-0000Z9-Mp
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAch-0001bk-DK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:28 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eRAch-0001aZ-5j
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:27 -0500
Received: by mail-wr0-x22b.google.com with SMTP id y21so17008223wrc.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 21:39:26 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Dec 2017 21:38:36 -0800
Message-Id: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 00/16] target/xtensa: switch to libisa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series adds libisa to the Xtensa target, changes decoder and
instruction translators to use it, switches existing xtensa cores
to use it, adds support for a number of new instructions and adds
disassembler for Xtensa.

Libisa is the canonical way of dealing with Xtensa instructions
decoding and encoding. Libisa is a configuration-independent library
with a stable interface plus generated configuration-specific
xtensa-modules.c file with implementations of decoding and encoding
functions. Libisa is MIT-licensed and originally distributed
xtensa-modules.c files are also MIT-licensed and are available as a
part of the xtensa configuration overlay.

This transition makes it possible to support variable-encoding
instructions of the core ISA, like const16, and will allow to support
advanced Xtensa features, like FLIX and TIE.

Development branch is available at:

   git://github.com/OSLL/qemu-xtensa.git xtensa-libisa

Changes v1->v2:
- add sed transformation to target/xtensa/import-core.sh that drops
  #include "ansidecl.h" from imported xtensa-modules.c;
- drop #include "ansidecl.h" from xtensa-modules.c for converted cores;
- reimplement translate_const16 using tcg_gen_deposit_i32.

Max Filippov (16):
  target/xtensa: pass actual frame size to the entry helper
  target/xtensa: import libisa source
  target/xtensa: extract core opcode translators
  target/xtensa: extract FPU2000 opcode translators
  target/xtensa: update import_core.sh script for libisa
  target/xtensa: switch dc232b to libisa
  target/xtensa: switch dc233c to libisa
  target/xtensa: switch fsf to libisa
  target/xtensa: use libisa for instruction decoding
  target/xtensa: tests: fix memctl SR test
  target/xtensa: drop DisasContext::litbase
  target/xtensa: add internal/noop SRs and opcodes
  target/xtensa: implement salt/saltu
  target/xtensa: implement GPIO32
  target/xtensa: implement const16
  target/xtensa: implement disassembler

 MAINTAINERS                                |     1 +
 disas/Makefile.objs                        |     1 +
 disas/xtensa.c                             |   133 +
 include/disas/bfd.h                        |     1 +
 include/hw/xtensa/xtensa-isa.h             |   838 ++
 target/xtensa/Makefile.objs                |     1 +
 target/xtensa/core-dc232b.c                |     4 +
 target/xtensa/core-dc232b/xtensa-modules.c | 14105 +++++++++++++++++++++++++
 target/xtensa/core-dc233c.c                |     4 +
 target/xtensa/core-dc233c/xtensa-modules.c | 15232 +++++++++++++++++++++++++++
 target/xtensa/core-fsf.c                   |     5 +
 target/xtensa/core-fsf/xtensa-modules.c    |  9841 +++++++++++++++++
 target/xtensa/cpu.c                        |     9 +
 target/xtensa/cpu.h                        |    31 +
 target/xtensa/helper.c                     |    37 +
 target/xtensa/import_core.sh               |    15 +
 target/xtensa/op_helper.c                  |     2 +-
 target/xtensa/translate.c                  |  5883 +++++++----
 target/xtensa/xtensa-isa-internal.h        |   231 +
 target/xtensa/xtensa-isa.c                 |  1745 +++
 target/xtensa/xtensa-isa.h                 |     1 +
 tests/tcg/xtensa/test_sr.S                 |     2 +-
 22 files changed, 45949 insertions(+), 2173 deletions(-)
 create mode 100644 disas/xtensa.c
 create mode 100644 include/hw/xtensa/xtensa-isa.h
 create mode 100644 target/xtensa/core-dc232b/xtensa-modules.c
 create mode 100644 target/xtensa/core-dc233c/xtensa-modules.c
 create mode 100644 target/xtensa/core-fsf/xtensa-modules.c
 create mode 100644 target/xtensa/xtensa-isa-internal.h
 create mode 100644 target/xtensa/xtensa-isa.c
 create mode 100644 target/xtensa/xtensa-isa.h

-- 
2.1.4
