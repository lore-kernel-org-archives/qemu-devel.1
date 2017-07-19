Received: from eggs.gnu.org ([2001:4830:134:3::10]:41496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3H-0003Fn-Bi
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3C-00024k-Kz
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:35 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3C-00024Z-DY
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:57:30 -0400
Received: by mail-pg0-x241.google.com with SMTP id v190so5446386pgv.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:57:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:08 -1000
Message-Id: <20170719045722.25492-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/14] tcg-next patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This edition is a real mix:
  * Code gen improvement for mips64 host (Jiang)
  * Build fix for ppc-linux (Philippe)
  * Runtime fix for tci (Philippe)
  * Fix atomic helper names in debugging dumps (rth)

  * Cross-target tcg code gen improvements (Philippe)
    This one had no obvious tree through which it should go,
    so I went ahead and took them all.

  * Cherry-picked the first patch from Lluis' generic translate loop,
    wherein the interface to gen_intermediate_code changes trivially.
    It's the only patch from that series that touches all targets,
    and I see little point carrying it around further.


r~


The following changes since commit 6887dc6700ccb7820d8a9d370f421ee361c748e8:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170718' into staging (2017-07-18 21:13:48 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170718

for you to fetch changes up to 3d48caee9e2c18385be60bb0467fa1f61d325c64:

  tcg: Pass generic CPUState to gen_intermediate_code() (2017-07-18 14:26:13 -1000)

----------------------------------------------------------------
Queued tcg and tcg code gen related cleanups

----------------------------------------------------------------
Aurelien Jarno (1):
      target/arm: optimize aarch32 rev16

Jiang Biao (1):
      tcg/mips: reserve a register for the guest_base.

Lluís Vilanova (1):
      tcg: Pass generic CPUState to gen_intermediate_code()

Philippe Mathieu-Daudé (9):
      util/cacheinfo: Add missing include for ppc linux
      coccinelle: ignore ASTs pre-parsed cached C files
      coccinelle: add a script to optimize tcg op using tcg_gen_extract()
      target/m68k: optimize bcd_flags() using extract op
      target/ppc: optimize various functions using extract op
      target/sparc: optimize various functions using extract op
      target/sparc: optimize gen_op_mulscc() using deposit op
      target/alpha: optimize gen_cvtlq() using deposit op
      tcg/tci: enable bswap16_i64

Richard Henderson (2):
      tcg: Expand glue macros before stringifying helper names
      target/arm: Optimize aarch64 rev16

 include/exec/exec-all.h                  |   2 +-
 include/exec/helper-tcg.h                |  17 +++--
 target/arm/translate.h                   |   4 +-
 accel/tcg/translate-all.c                |   2 +-
 target/alpha/translate.c                 |  13 ++--
 target/arm/translate-a64.c               |  30 +++------
 target/arm/translate.c                   |  12 ++--
 target/cris/translate.c                  |   7 +-
 target/hppa/translate.c                  |   5 +-
 target/i386/translate.c                  |   5 +-
 target/lm32/translate.c                  |   4 +-
 target/m68k/translate.c                  |   8 +--
 target/microblaze/translate.c            |   4 +-
 target/mips/translate.c                  |   5 +-
 target/moxie/translate.c                 |   4 +-
 target/nios2/translate.c                 |   5 +-
 target/openrisc/translate.c              |   4 +-
 target/ppc/translate.c                   |  26 +++-----
 target/ppc/translate/vsx-impl.inc.c      |  24 +++----
 target/s390x/translate.c                 |   5 +-
 target/sh4/translate.c                   |   5 +-
 target/sparc/translate.c                 |  25 +++-----
 target/tilegx/translate.c                |   5 +-
 target/tricore/translate.c               |   5 +-
 target/unicore32/translate.c             |   5 +-
 target/xtensa/translate.c                |   5 +-
 tcg/mips/tcg-target.inc.c                |  17 +++--
 tcg/tci.c                                |   1 -
 util/cacheinfo.c                         |   1 +
 .gitignore                               |   2 +
 scripts/coccinelle/tcg_gen_extract.cocci | 107 +++++++++++++++++++++++++++++++
 31 files changed, 218 insertions(+), 146 deletions(-)
 create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci
