Received: from eggs.gnu.org ([2001:4830:134:3::10]:48988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duK3Z-0007zx-8M
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duK3V-0003bi-80
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:25 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:57289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duK3V-0003Yf-4J
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:21 -0400
Received: by mail-io0-x236.google.com with SMTP id m103so681256iod.13
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:03:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Sep 2017 10:03:05 -0500
Message-Id: <20170919150313.10833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/8] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

Changes since v1:
  * Don't silently ignore unknown insns.
  * Don't copy memory when dumping host insns.
  * More properly handle dumping from the monitor.
  * Drop enabling for s390x, sparc, mips.

    The s390x and sparc support in capstone is pretty poor.  It seems
    to only handle userland instructions -- at least that's the impression
    I get from the hordes of insns rendered as ".byte" within the first
    few TB of booting each machine.  I dropped the mips patch simply
    because there are too many capstone options and it probably needs
    more testing than I've given it.

    If there are any IBM folk paying attention, it would be awesome if
    some time could be found somewhere to improve capstone for zSeries.
    You're in the same boat that i386 is in -- namely that our ancient
    binutils gplv2 code is neigh useless for modern systems.  It would
    be really really nice to have a better disassembler for qemu.


r~


Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>

Richard Henderson (8):
  target/i386: Convert to disas_set_info hook
  target/ppc: Convert to disas_set_info hook
  disas: Remove unused flags arguments
  disas: Support the Capstone disassembler library
  i386: Support Capstone in disas_set_info
  arm: Support Capstone in disas_set_info
  ppc: Support Capstone in disas_set_info
  disas: Remove monitor_disas_is_physical

 include/disas/bfd.h           |   4 +
 include/disas/capstone.h      |  38 ++++++
 include/disas/disas.h         |   4 +-
 include/exec/log.h            |   4 +-
 disas.c                       | 310 ++++++++++++++++++++++++++++++------------
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
 configure                     |  26 ++++
 29 files changed, 380 insertions(+), 152 deletions(-)
 create mode 100644 include/disas/capstone.h

-- 
2.13.5
