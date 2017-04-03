Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MT-0001L8-GY
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MP-00011d-1G
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:33 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cv1MO-000112-Q7
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:28 -0400
Received: by mail-wr0-x231.google.com with SMTP id l43so169829970wre.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:45:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  3 Apr 2017 13:45:15 +0100
Message-Id: <20170403124524.10824-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 0/9] MTTCG and record/replay fixes for
 rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is the current state of my fixes for icount based record and
replay. It doesn't completely fix the problem (hence the RFC status)
but improves it to the point that I have been able to record and
replay the boot of a vexpress kernel.

The first 3 patches are helper scripts I've been using during my
debugging. The first is the only real fix and the following 2 should
probably be dropped from any pull request as they introduce new
features rather than fix something.

We then have another BQL fix for i386. I haven't had a chance to
replicate myself so far but it looks perfectly sane to me.

Finally the fixes for icount:

  cpus: remove icount handling from qemu_tcg_cpu_thread_fn

  Simple clean-up as we don't do icount for MTTCG

  cpus: check cpu->running in cpu_get_icount_raw()

  I'm not sure the race happens and once outside of cpu->running the
  icount counters should be zero. However it seems a sensible
  precaution.

  cpus: move icount preparation out of tcg_exec_cpu

  This is a little light re-factoring that stops the icount work
  getting in the way of the main bit of tcg_exec_cpu. It also removed
  some redundant assignment and replaced them with asserts for now.

  cpus: don't credit executed instructions before they have run

  This is the main one which ensures we never jump forward in time and
  cpu_get_icount_raw() remains consistent.

  replay: gracefully handle backward time events

  This is the most hand-wavey patch. It glosses over the disparity in
  time between the vCPU thread and the main-loop by jumping forward to
  the most current time value. However it is not really deterministic
  and runs into potential problems with sequencing of log events.

  I think a better fix would be to extend replay_lock() so all related
  log events are serialised and we don't end up with interleaved
  events from the vCPU thread and the main-loop.

I think the cpus: patches should probably go into the next
pull-request while we see if we can come up with a better final
solution for fixing record/replay. However given how long this
regression has run during the release candidate process I wanted to
update everyone on the current status and get feedback ASAP.

Cheers,


Alex Bennée (9):
  scripts/qemugdb/mtree.py: fix up mtree dump
  scripts/qemu-gdb/timers.py: new helper to dump timer state
  scripts/replay-dump.py: replay log dumper
  target/i386/misc_helper: wrap BQL around another IRQ generator
  cpus: remove icount handling from qemu_tcg_cpu_thread_fn
  cpus: check cpu->running in cpu_get_icount_raw()
  cpus: move icount preparation out of tcg_exec_cpu
  cpus: don't credit executed instructions before they have run
  replay: gracefully handle backward time events

 cpus.c                    |  94 +++++++++++-----
 include/qom/cpu.h         |   1 +
 replay/replay-internal.c  |   7 ++
 replay/replay.c           |   9 +-
 scripts/qemu-gdb.py       |   3 +-
 scripts/qemugdb/mtree.py  |  12 +-
 scripts/qemugdb/timers.py |  54 +++++++++
 scripts/replay-dump.py    | 272 ++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/misc_helper.c |   3 +
 9 files changed, 423 insertions(+), 32 deletions(-)
 create mode 100644 scripts/qemugdb/timers.py
 create mode 100755 scripts/replay-dump.py

-- 
2.11.0
