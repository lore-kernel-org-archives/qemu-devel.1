Received: from eggs.gnu.org ([2001:4830:134:3::10]:43741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxtNT-0003Y8-Ci
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxtNQ-0004S6-Aj
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:27 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxtNQ-0004Rw-3o
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:24 -0400
Received: by mail-wr0-x234.google.com with SMTP id z109so26151911wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 03:50:23 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Apr 2017 11:50:28 +0100
Message-Id: <20170411105031.28904-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/3] Fix cputlb flush stats and exporting
 data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com, rth@twiddle.net, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is mostly just an RFC for discussion as I know a number of GSoC
projects will involve a degree of instrumentation and measurement of
the internals of the TCG.

The first patch just fixes and expands the counters. The second uses
(abuses?) the trace mechanism to export the data via the simpletrace
binary trace format. The final patch is a script that then allows us
to plot the collected data.

So this series raises a few questions/thoughts:

 - doing an atomic_inc(__ATOMIC_SEQ_CST) is inefficient

 It would probably be better to have per-thread counters that are
 summed when needed rather than enforcing sequential consistency on a
 global counter.

 - I could encode the events directly and count them in the script

 This would be more trace-like but we'd loose the counters in the MMI
 which is helpful on a live non-trace-enabled builds if you want to
 get an idea of whats happening.

 - Tracing is very event focused, would it be worth adding some sort
   of counter/sampling support?

 Currently the insertion of the trace_tlb_flushes() event in the entry
 to the run loop is a massive hack. Most of the time the numbers
 haven't changed. I could have just spawned a sampling helper on a
 main-loop timer but I feel this might be a use case thinking about
 for the tracing system.

 - timestamps could be replaced with icount for some analysis

 The icount mechanism would allow for a fairly fine grained matching of
 events to execution time in TCG. Maybe this could be an optional
 replacement?

 - The simpletrace binary format is more efficient than debug output

 One problem I have as a TCG hacker is the normal -d foo output is
 very verbose and generates massive logs. -dfilter was an attempt to
 make that easier but I'm quite happy with the trace approach. A boot
 and build takes only about 85M in trace files compared to the
 gigabytes a text file can take up.

Alex Bennée (3):
  cputlb: fix and enhance TLB statistics
  cpus: dump TLB flush counts as trace event
  new script/analyse-tlb-flushes-simpletrace.py

 cpus.c                                     |  6 +++
 cputlb.c                                   | 27 +++++++++++--
 include/exec/cputlb.h                      |  4 +-
 scripts/analyse-tlb-flushes-simpletrace.py | 62 ++++++++++++++++++++++++++++++
 trace-events                               |  3 ++
 translate-all.c                            |  4 +-
 6 files changed, 101 insertions(+), 5 deletions(-)
 create mode 100755 scripts/analyse-tlb-flushes-simpletrace.py

-- 
2.11.0
