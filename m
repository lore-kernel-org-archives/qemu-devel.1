Received: from eggs.gnu.org ([2001:4830:134:3::10]:33279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GA-0008L7-Qx
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1G7-0002AD-M4
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:46 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1G7-00029T-FX
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:43 -0400
Received: by mail-pf0-x242.google.com with SMTP id y7so18581603pfd.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:27 -0700
Message-Id: <20170619181839.25249-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/12] TCG queued patches
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

This contains Emilio's moving the TB struct into code_gen_buffer,
my taking advantage of that in the aa64 and aa32 tcg backends,
and the communal fixes for the goto_ptr hangs.

I've droppped the target/mips goto_ptr patch from Paolo, as Aurelien
has said he'd come up with a more complete fix.

I've dropped the "-accel tcg,thread=*" fix as it is apparently also
in Paolo's misc patches tree.


r~


The following changes since commit cef8fd68364ad754d4f0050a215376cdf0ec744a:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170614-1' into staging (2017-06-19 17:54:30 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170619

for you to fetch changes up to 8da54b2507c1cabf60c2de904cf0383b23239231:

  target/arm: Exit after clearing aarch64 interrupt mask (2017-06-19 11:11:26 -0700)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------
Emilio G. Cota (3):
      util: add cacheinfo
      tcg: allocate TB structs before the corresponding translated code
      translate-all: consolidate tb init in tb_gen_code

Richard Henderson (9):
      tcg/aarch64: Use ADR in tcg_out_movi
      tcg/arm: Use indirect branch for goto_tb
      tcg/arm: Remove limit on code buffer size
      tcg/arm: Try pc-relative addresses for movi
      tcg/arm: Use ldr (literal) for goto_tb
      tcg: Increase hit rate of lookup_tb_ptr
      target/alpha: Use tcg_gen_lookup_and_goto_ptr
      target/s390x: Exit after changing PSW mask
      target/arm: Exit after clearing aarch64 interrupt mask

 include/exec/exec-all.h      |   5 +-
 include/exec/tb-context.h    |   3 +-
 include/qemu/osdep.h         |   3 +
 target/alpha/translate.c     |  27 +++++--
 target/arm/translate-a64.c   |   7 +-
 target/s390x/translate.c     |  14 +++-
 tcg-runtime.c                |  28 +++----
 tcg/aarch64/tcg-target.inc.c |   7 +-
 tcg/arm/tcg-target.inc.c     |  78 ++++++++++--------
 tcg/ppc/tcg-target.inc.c     |  71 +----------------
 tcg/tcg.c                    |  20 +++++
 tcg/tcg.h                    |   2 +-
 translate-all.c              |  46 ++++++-----
 util/Makefile.objs           |   1 +
 util/cacheinfo.c             | 185 +++++++++++++++++++++++++++++++++++++++++++
 15 files changed, 345 insertions(+), 152 deletions(-)
 create mode 100644 util/cacheinfo.c
