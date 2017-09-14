Received: from eggs.gnu.org ([2001:4830:134:3::10]:49570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz0-0000Oj-1t
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYyv-0000Mo-Jk
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:26 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:54885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYyv-0000Ln-C0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:21 -0400
Received: by mail-pg0-x233.google.com with SMTP id c137so111643pga.11
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:19 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-103-167.tukw.qwest.net.
	[97.126.103.167]) by smtp.gmail.com with ESMTPSA id
	l85sm32473848pfb.176.2017.09.14.11.35.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Sep 2017 11:35:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:06 -0700
Message-Id: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/10] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As occasionally discussed on this list, due to licensing conflicts,
we are restricted to a version of libopcodes that pre-dates its
upstream re-licensing to gplv3.  That makes our copy rather old
and dated.

I've already seen this as problematic for s390x guest.  I'm sure
the same problem exists for Power8+, though I haven't looked.
As we go forward with vector operations we'll see this for x86 host.

An alternative is to use a BSD-licensed disassembler:

  https://www.capstone-engine.org/

This is an actively maintained project derived from llvm.  Moreover,
it is already in the major Linux distributions, which makes it easy
to phase in its use.

I've arranged the code such that we attempt to use capstone first,
and if that initialization fails, fall back to the existing code
from binutils.


r~


Richard Henderson (10):
  target/i386: Convert to disas_set_info hook
  target/ppc: Convert to disas_set_info hook
  disas: Remove unused flags arguments
  disas: Support the Capstone disassembler library
  target/i386: Support Capstone in disas_set_info
  target/arm: Support Capstone in disas_set_info
  target/ppc: Support Capstone in disas_set_info
  target/s390x: Support Capstone in disas_set_info
  target/sparc: Support Capstone in disas_set_info
  target/mips: Support Capstone in disas_set_info

 include/disas/bfd.h           |   4 ++
 include/disas/capstone.h      |  38 ++++++++++
 include/disas/disas.h         |   4 +-
 include/exec/log.h            |   4 +-
 target/mips/cpu.h             |   2 +
 disas.c                       | 161 +++++++++++++++++++++++-------------------
 monitor.c                     |  29 +-------
 target/alpha/translate.c      |   2 +-
 target/arm/cpu.c              |  21 +++++-
 target/arm/translate-a64.c    |   3 +-
 target/arm/translate.c        |   3 +-
 target/cris/translate.c       |   3 +-
 target/hppa/translate.c       |   2 +-
 target/i386/cpu.c             |  19 +++++
 target/i386/translate.c       |   8 +--
 target/lm32/translate.c       |   2 +-
 target/m68k/translate.c       |   2 +-
 target/microblaze/translate.c |   2 +-
 target/mips/cpu.c             |   8 ---
 target/mips/translate.c       |   2 +-
 target/mips/translate_init.c  |  36 ++++++++++
 target/nios2/translate.c      |   2 +-
 target/openrisc/translate.c   |   2 +-
 target/ppc/translate.c        |   5 +-
 target/ppc/translate_init.c   |  27 +++++++
 target/s390x/cpu.c            |   2 +
 target/s390x/translate.c      |   2 +-
 target/sh4/translate.c        |   2 +-
 target/sparc/cpu.c            |   3 +
 target/sparc/translate.c      |   2 +-
 target/tricore/translate.c    |   2 +-
 target/unicore32/translate.c  |   2 +-
 target/xtensa/translate.c     |   2 +-
 configure                     |  17 +++++
 34 files changed, 279 insertions(+), 146 deletions(-)
 create mode 100644 include/disas/capstone.h

-- 
2.13.5
