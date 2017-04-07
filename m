Received: from eggs.gnu.org ([2001:4830:134:3::10]:53338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1o-0002OT-7i
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1k-0007PF-6b
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:24 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cwW1j-0007Ns-VE
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:20 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w64so1695738wma.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:42:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  7 Apr 2017 16:42:09 +0100
Message-Id: <20170407154221.26918-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/12] icount and misc MTTCG fixes for
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

This doesn't change much from v2 earlier this week:

  https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg00661.html

There was a minor improvement to the cpu_update_icount to not use a
potentially expensive atomic_add (which is CST) when you can get away
with weaker semantics with a single writer.

I've also fixed a compile error on 32bit guests. It only falls back to
non-atomic code if CONFIG_ATOMIC64 is not set which isn't the case for
ARMv7 as it can use load/store-exclusive pair to do the operation.
This does require using the __no_check atomic variants though.

I still plan to roll a pull-request on Monday and get it sent to Peter
in good time for cutting -rc4.

Cheers,


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
 cpus.c                    | 109 ++++++++++++++-----
 include/qemu/timer.h      |   1 +
 include/qom/cpu.h         |   1 +
 replay/replay-internal.c  |   4 +
 replay/replay.c           |   4 +
 scripts/qemu-gdb.py       |   3 +-
 scripts/qemugdb/mtree.py  |  12 +-
 scripts/qemugdb/timers.py |  54 +++++++++
 scripts/replay-dump.py    | 272 ++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/misc_helper.c |   3 +
 11 files changed, 437 insertions(+), 40 deletions(-)
 create mode 100644 scripts/qemugdb/timers.py
 create mode 100755 scripts/replay-dump.py

-- 
2.11.0
