Received: from eggs.gnu.org ([2001:4830:134:3::10]:50535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCh8p-0006oh-CX
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCh8k-0007mr-Nr
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:19 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gCh8k-0007k2-8d
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:14 -0400
Received: by mail-lf1-x142.google.com with SMTP id n14-v6so7251036lfe.6
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 01:25:13 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 14:24:17 +0600
Message-Id: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/4] Introduce attributes for timers
 subsystem and remove QEMU_CLOCK_VIRTUAL_EXT clock type
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

Current implementation of timers/clock processing is confusing (at least for me) because of exceptions from design concept behind them, which already introduced by icount mode (which adds QEMU_CLOCK_VIRTUAL_RT). Adding QEMU_CLOCK_VIRTUAL_EXT just made things even more complicated. I consider these "alternative" virtual clocks to be some kind of hacks being convinient only to authors of relevant qemu features. Lets don't touch fundamental clock types and keep them orthogonal to special cases of timers handling.

As far as I understand, original intention of author was just to make optimization in replay log by avoiding storing extra events which don't change guest state directly. Indeed, for example, ipv6 icmp timer in slirp does things which external to guest core and ends with sending network packet to guest, but record/replay will anyway catch event, corresponding to packet reception in guest network frontend, and store it to replay log, so there are no need in making checkpoint for corresponding clock when that timer fires.
If so, then we just need to skip checkpoints for clock values, when only these specific timers are run. It is individual timers which are specific, not clock.
Adding some kind of attribute/flag/property to individual timer allows any special qemu feature (such as record/replay) to inspect it in any place of code and handle as needed. This design acheives less dependencies, more transparency and has more intuitive and clear sense. For record/replay feature it's acheived with 'EXTERNAL' attribute. The only drawback is that it required to add one extra mutex unlock/lock pair for virtual clock type in timerlist_run_timers() function (see patch 3), but it's being added only when qemu runs in record/replay mode.

Finally, this patch series optimizes checkpointing for all other clocks it applies to.


v2 changes:
 - timers/aio interface refactored and improved, addition to couroutines removed (as Paolo Bonzini suggested)
 - fixed wrong reimplementation in qemu-timer.c caused race conditions
 - added bonus patch which optimizes checkpointing for other clocks

P.S. I've tried to test record/replay with slirp, but in replay mode qemu stucks at guest linux boot after "Configuring network interfaces..." message, where DHCP communication takes place. It's broken in a same way both in master and master with reverted commits being fixed.

P.S.2. I wasn't able to test these patches on purely clean master branch because of bugs https://bugs.launchpad.net/qemu/+bug/1790460 and https://bugs.launchpad.net/qemu/+bug/1795369, which workarounded by several not-accepted (yet?) modifications.


Artem Pisarenko (4):
  Revert some patches from recent [PATCH v6] "Fixing record/replay and
    adding reverse debugging"
  Introduce attributes to qemu timer subsystem
  Restores record/replay behavior related to special virtual clock
    processing for timers used in external subsystems.
  Optimize record/replay checkpointing for all clocks it applies to

 include/block/aio.h       |  57 +++++++++++++++---
 include/qemu/timer.h      | 143 +++++++++++++++++++++++++---------------------
 slirp/ip6_icmp.c          |   9 +--
 tests/ptimer-test-stubs.c |  13 +++--
 ui/input.c                |   9 +--
 util/qemu-timer.c         | 100 ++++++++++++++++++++++----------
 6 files changed, 219 insertions(+), 112 deletions(-)

-- 
2.7.4
