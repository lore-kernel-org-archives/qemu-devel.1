Received: from eggs.gnu.org ([2001:4830:134:3::10]:43878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwwFW-0002sZ-RU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwwFT-00035r-UC
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:34 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:47568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwwFT-00035L-OV
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 16:14:31 -0400
Received: by mail-pf0-x22b.google.com with SMTP id u12so6083887pfl.4
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 13:14:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Sep 2017 13:14:18 -0700
Message-Id: <20170926201427.2833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/9] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org

Changes since v2:
  * Fix a minor buglet in the monitor disassembly
  * Add capstone as a submodule, preferring that when present.

The submodule idea came from discussion with PMM.  The idea is that
we would potentially remove the old binutils code, and libvxil, and
rely on capstone entirely.  Which would then of course require capstone
to be present in order to get reasonable debugging.

I have not done the actual removal yet, but that is an easy next step.


r~

PS: Comments from the ppc folk?  Can I encourage you to try this and
sanity check what capstone is emitting?  Unlike for s390x, it doesn't
look obviously wrong to me...


Richard Henderson (9):
  target/i386: Convert to disas_set_info hook
  target/ppc: Convert to disas_set_info hook
  disas: Remove unused flags arguments
  disas: Support the Capstone disassembler library
  i386: Support Capstone in disas_set_info
  arm: Support Capstone in disas_set_info
  ppc: Support Capstone in disas_set_info
  disas: Remove monitor_disas_is_physical
  disas: Add capstone as submodule

 Makefile                      |   4 +
 include/disas/bfd.h           |   4 +
 include/disas/capstone.h      |  38 ++++++
 include/disas/disas.h         |   4 +-
 include/exec/log.h            |   4 +-
 disas.c                       | 308 ++++++++++++++++++++++++++++++------------
 monitor.c                     |  29 +---
 target/alpha/translate.c      |   2 +-
 target/arm/cpu.c              |  21 ++-
 target/arm/translate-a64.c    |   3 +-
 target/arm/translate.c        |   3 +-
 target/cris/translate.c       |   3 +-
 target/hppa/translate.c       |   2 +-
 target/i386/cpu.c             |  19 +++
 target/i386/translate.c       |   8 +-
 target/lm32/translate.c       |   2 +-
 target/m68k/translate.c       |   2 +-
 target/microblaze/translate.c |   2 +-
 target/mips/translate.c       |   2 +-
 target/nios2/translate.c      |   2 +-
 target/openrisc/translate.c   |   2 +-
 target/ppc/translate.c        |   5 +-
 target/ppc/translate_init.c   |  27 ++++
 target/s390x/translate.c      |   2 +-
 target/sh4/translate.c        |   2 +-
 target/sparc/translate.c      |   2 +-
 target/tricore/translate.c    |   2 +-
 target/unicore32/translate.c  |   2 +-
 target/xtensa/translate.c     |   2 +-
 .gitmodules                   |   3 +
 capstone                      |   1 +
 configure                     |  36 +++++
 32 files changed, 397 insertions(+), 151 deletions(-)
 create mode 100644 include/disas/capstone.h
 create mode 160000 capstone

-- 
2.13.5
