Received: from eggs.gnu.org ([2001:4830:134:3::10]:56590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gBhoj-0008G3-Qt
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gBhoe-0001Wc-Jr
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:56:29 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:34831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gBhoe-0001W0-85
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:56:24 -0400
Received: by mail-lj1-x231.google.com with SMTP id o14-v6so15231797ljj.2
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 07:56:24 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Sun, 14 Oct 2018 20:55:06 +0600
Message-Id: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] Introduce attributes for timers subsystem
 and remove QEMU_CLOCK_VIRTUAL_EXT clock type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

Recent patches from series [PATCH v6] "Fixing record/replay and adding reverse debugging" introduced new clock type QEMU_CLOCK_VIRTUAL_EXT and replaced virtual timers in some external subsystems with it.
This resulted in small change to existing behavior, which I consider to be unacceptable.
Processing of virtual timers, belonging to new clock type, was kicked off to main loop, which made them asynchronous with vCPU thread and, in icount mode, with whole guest execution. This breaks expected determinism in non-record/replay icount mode of emulation where these "external subsystems" are isolated from host (i.e. they external only to guest core, not to emulation environment).

Example for slirp ("user" backend for network device):
User runs qemu in icount mode with rtc clock=vm without any external communication interfaces but with "-netdev user,restrict=on". It expects deterministic execution, because network services are emulated inside qemu and isolated from host. There are no reasons to get reply from DHCP server with different delay or something like that.

These series of patches revert those commits and reimplement their modifications in a better way.

Current implementation of timers/clock processing is confusing (at least for me) because of exceptions from design concept behind them, introduced by icount mode (which adds QEMU_CLOCK_VIRTUAL_RT). Adding QEMU_CLOCK_VIRTUAL_EXT just made things even more complicated. I consider these "alternative" virtual clocks to be some kind of hacks being convinient only to authors of relevant qemu features. Lets don't touch fundamental clock types and keep them orthogonal to special cases of timers handling.

As far as I understand, original intention of author was just to make optimization in replay log by avoiding storing extra events which don't change guest state directly. Indeed, for example, ipv6 icmp timer in slirp does things which external to guest core and ends with sending network packet to guest, but record/replay will anyway catch event, corresponding to packet reception in guest network frontend, and store it to replay log, so there are no need in making checkpoint for corresponding clock when that timer fires.
If so, then we just need to skip checkpoints for clock values, when only these specific timers are run. It is individual timers which are specific, not clock.
Adding some kind of attribute/flag/property to individual timer allows any special qemu feature (such as record/replay) to inspect it in any place of code and handle as needed. This design acheives less dependencies, more transparency and has more intuitive and clear sense. For record/replay feature it's acheived with 'EXTERNAL' attribute. The only drawback is that it required to add extra cycle of traversal through active timer list in timerlist_run_timers() function (see patch 3), but I've optimized it in a way that performance degradation expected to be very small and appear only in record/replay mode.

P.S. I've tried to test record/replay with slirp, but in replay mode qemu stucks at guest linux boot after "Configuring network interfaces..." message, where DHCP communication takes place. It's broken in a same way both in master and master with reverted commits being fixed.


Artem Pisarenko (3):
  Revert some patches from recent series [PATCH v6] "Fixing
    record/replay and adding reverse debugging", which introduced new
    virtual clock type for use in external subsystems.     These changes
    breaks desired behavior in non-record/replay usage scenarios.
  Introduce attributes to qemu timer subsystem
  Restores record/replay behavior related to special virtual clock
    processing for timers used in external subsystems.

 include/block/aio.h         |  50 +++++++++++++++++-
 include/qemu/coroutine.h    |   5 +-
 include/qemu/timer.h        | 125 ++++++++++++++++++++++++++++++++++++--------
 slirp/ip6_icmp.c            |   9 ++--
 tests/ptimer-test-stubs.c   |   7 +--
 ui/input.c                  |   9 ++--
 util/qemu-coroutine-sleep.c |   6 ++-
 util/qemu-timer.c           |  81 +++++++++++++++++++---------
 8 files changed, 227 insertions(+), 65 deletions(-)

-- 
2.7.4
