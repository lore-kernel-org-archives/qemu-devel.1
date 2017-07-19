Received: from eggs.gnu.org ([2001:4830:134:3::10]:39448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgrb-0004Wv-5b
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXgra-0006Z4-8q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:31 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXgra-0006Yv-2B
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:45:30 -0400
Received: by mail-pg0-x243.google.com with SMTP id v190so5410254pgv.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:45:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:45:14 -1000
Message-Id: <20170719044522.21114-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 0/8] target/alpha cleanups
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

The new title holder for perf top is helper_lookup_tb_ptr.
Those targets that have a complicated cpu_get_tb_cpu_state
function are going to regret that.

This cleans up the Alpha version of that function such that it is
just two loads and one mask.  Which is one practically-free mask
away from being as minimal as one can get.

Also, in anticipation of LLuis' generic translation loop, fix all
of the temporary leaks.  They all seem to have been on insns that
end the TB, so in practice they weren't harmful, but...


r~


The following changes since commit 6887dc6700ccb7820d8a9d370f421ee361c748e8:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170718' into staging (2017-07-18 21:13:48 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-axp-20170718

for you to fetch changes up to 8aa5c65fd3d4612d8ab690bef0980d26f30f381d:

  target/alpha: Log temp leaks (2017-07-18 18:42:05 -1000)

----------------------------------------------------------------
Queued target/alpha patches

----------------------------------------------------------------
Richard Henderson (8):
      target/alpha: Remove amask from tb->flags
      target/alpha: Copy tb->flags into DisasContext
      target/alpha: Merge several flag bytes into ENV->FLAGS
      target/alpha: Fix temp leak in gen_bcond
      target/alpha: Fix temp leak in gen_mtpr
      target/alpha: Fix temp leak in gen_call_pal
      target/alpha: Fix temp leak in gen_fbcond
      target/alpha: Log temp leaks

 target/alpha/cpu.h       |  79 +++++++----------
 hw/alpha/dp264.c         |   1 -
 linux-user/main.c        |  25 +++---
 target/alpha/cpu.c       |   7 +-
 target/alpha/helper.c    |  12 +--
 target/alpha/machine.c   |  10 +--
 target/alpha/translate.c | 221 +++++++++++++++++++++++++++++------------------
 7 files changed, 194 insertions(+), 161 deletions(-)
