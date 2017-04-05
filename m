Received: from eggs.gnu.org ([2001:4830:134:3::10]:54499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvq-0004VS-Pw
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvkvn-0000CV-LI
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:06 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvkvn-0000CH-DZ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:25:03 -0400
Received: by mail-wr0-x229.google.com with SMTP id t20so14810844wra.1
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 06:25:03 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  5 Apr 2017 14:24:51 +0100
Message-Id: <20170405132503.32125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/12] icount and misc MTTCG fixes for
 2.9-rc4
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

Here is my current queue for icount and miscellaneous MTTCG related
fixes. The main difference from the RFC series is I have dropped the
graceful handling of backward time events in the replay log in favour
of updating the global qemu_icount more frequently. The graceful
handling is now replaced with an assertion about the arrow of time.

With these changes I was able to dispenses with additional BQL locking
which I had been applying during cpu_handle_exception.

It doesn't completely solve the problem of keeping the main-loop and
vCPU events stream in sync but it works pretty reliably in my test
case. Given the current release time-line I think this is the best
solution for now. Options for post-2.9 include either replacing the
BQL mediated sequencing with a new lock (pushing replay_lock up the
tree?) or marshalling events through a single thread which can then
keep things in order.

Aside from that other patches have had various r-b and a-b tags
applied from the original posting.

I hope to roll a pull request with these fixes by the end of the week
so we there isn't a rush for next Tuesday's rc4. Expedient comments
and reviews are therefor gratefully received ;-)

Regards,


Alex Bennée (12):
  scripts/qemugdb/mtree.py: fix up mtree dump
  scripts/qemu-gdb/timers.py: new helper to dump timer state
  scripts/replay-dump.py: replay log dumper
  target/i386/misc_helper: wrap BQL around another IRQ generator
  cpus: remove icount handling from qemu_tcg_cpu_thread_fn
  cpus: check cpu->running in cpu_get_icount_raw()
  cpus: move icount preparation out of tcg_exec_cpu
  cpus: don't credit executed instructions before they have run
  cpus: introduce cpu_update_icount helper
  cpu-exec: update icount after each TB_EXIT
  cpus: call cpu_update_icount on read
  replay: assert time only goes forward

 cpu-exec.c                |  14 +--
 cpus.c                    |  98 ++++++++++++-----
 include/qemu/timer.h      |   1 +
 include/qom/cpu.h         |   1 +
 replay/replay-internal.c  |   4 +
 replay/replay.c           |   4 +
 scripts/qemu-gdb.py       |   3 +-
 scripts/qemugdb/mtree.py  |  12 +-
 scripts/qemugdb/timers.py |  54 +++++++++
 scripts/replay-dump.py    | 272 ++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/misc_helper.c |   3 +
 11 files changed, 426 insertions(+), 40 deletions(-)
 create mode 100644 scripts/qemugdb/timers.py
 create mode 100755 scripts/replay-dump.py

-- 
2.11.0
