Received: from eggs.gnu.org ([2001:4830:134:3::10]:50780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dB0JB-0001qc-K0
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dB0JA-0004hH-Cr
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:13 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dB0JA-0004gT-3T
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:52:12 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l9so12462915wre.1
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 07:52:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 17 May 2017 15:52:59 +0100
Message-Id: <20170517145259.28979-7-alex.bennee@linaro.org>
In-Reply-To: <20170517145259.28979-1-alex.bennee@linaro.org>
References: <20170517145259.28979-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/6] new
 script/analyse-tlb-flushes-simpletrace.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a simple helper script to extract TLB flush stats from the a
simpletrace file and plot the results.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - re-factored for new trace events
  - added time and latency graphs
---
 scripts/analyse-tlb-flushes-simpletrace.py | 144 +++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100755 scripts/analyse-tlb-flushes-simpletrace.py

diff --git a/scripts/analyse-tlb-flushes-simpletrace.py b/scripts/analyse-tlb-flushes-simpletrace.py
new file mode 100755
index 0000000000..03fab8c86b
--- /dev/null
+++ b/scripts/analyse-tlb-flushes-simpletrace.py
@@ -0,0 +1,144 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+#
+# Generate a simple graph of flushes over time
+#
+# Author: Alex Bennée <alex.bennee@linaro.org>
+#
+# analyzer = CpuTLBFlushAnalyser(4)
+# simpletrace.process("../trace-events-all", "../trace-22464", analyzer)
+
+import os
+import simpletrace
+import argparse
+import numpy as np
+import matplotlib
+# Force matplotlib to not use any Xwindows backend.
+matplotlib.use('Agg')
+import matplotlib.pyplot as plt
+
+class FlushType:
+    Self, Async, Synced = range(3)
+
+class CpuTLBFlushAnalyser(simpletrace.Analyzer):
+    "A simpletrace Analyser for extracting flush stats."
+
+    def __init__(self, nvcpus):
+        self.flush_total = 0
+        self.flush_all = 0
+        self.nvcpus = nvcpus
+        self.vcpu_last = [[] for _ in range(nvcpus)]
+        self.flush_self = []
+        self.flush_self_times = []
+        self.flush_async = []
+        self.flush_async_times = []
+        self.flush_synced = []
+        self.flush_synced_times = []
+        self.flush_work = []
+
+        self.unmatched_work = []
+
+    def __save_queue(self, vcpu, record):
+        self.flush_total += 1
+        # FIXME: don't seem to see -1
+        if vcpu > 0x7fffffff:
+            self.flush_all += 1
+            for i in range(0, self.nvcpus):
+                self.vcpu_last[i].append(record)
+        else:
+            self.vcpu_last[vcpu].append(record)
+
+    def tlb_flush_self(self, timestamp, fn, vcpu):
+        self.__save_queue(vcpu, (timestamp[0], FlushType.Self))
+        self.flush_self.append((timestamp[0], vcpu))
+
+    def tlb_flush_async_schedule(self, timestamp, fn, from_vcpu, to_vcpu):
+        self.__save_queue(to_vcpu, (timestamp[0], FlushType.Async,
+                                    to_vcpu, from_vcpu))
+        self.flush_async.append((timestamp[0], to_vcpu))
+
+    def tlb_flush_synced_schedule(self, timestamp, fn, from_vcpu, to_vcpu):
+        self.__save_queue(to_vcpu, (timestamp[0], FlushType.Synced,
+                                    to_vcpu, from_vcpu))
+        self.flush_synced.append((timestamp[0], to_vcpu))
+
+    def tlb_flush_work(self, timestamp, fn, vcpu):
+        "Check when it was queued and work out how long it took"
+
+        if len(self.vcpu_last[vcpu]):
+            last = self.vcpu_last[vcpu].pop(0)
+            latency = timestamp[0] - last[0]
+            switcher = {
+                FlushType.Self: lambda a: a.flush_self_times.append(latency),
+                FlushType.Async: lambda a: a.flush_async_times.append(latency),
+                FlushType.Synced: lambda a: a.flush_synced_times.append(latency),
+            }
+            switcher.get(last[1])(self)
+
+            self.flush_work.append((timestamp[0], vcpu))
+        else:
+            self.unmatched_work.append((timestamp[0], vcpu, fn))
+
+
+
+
+def get_args():
+    "Grab options"
+    parser = argparse.ArgumentParser()
+    parser.add_argument("--output", "-o", type=str, help="Render plot to file")
+    parser.add_argument("--vcpus", type=int, help="Number of vCPUS")
+    parser.add_argument("--graph", choices=['time', 'latency'], default='time')
+    parser.add_argument("events", type=str, help='trace file read from')
+    parser.add_argument("tracefile", type=str, help='trace file read from')
+    return parser.parse_args()
+
+def plot_time_series(time_data, label):
+    "Plot one timeseries, return star and end time limits"
+    counts = np.arange(0, len(time_data))
+    times = [x[0] for x in time_data]
+    plt.plot(times, counts, label=label)
+    return (times[0],times[-1])
+
+
+if __name__ == '__main__':
+    args = get_args()
+
+    # Gather data from the trace
+    analyzer = CpuTLBFlushAnalyser(args.vcpus)
+
+    simpletrace.process(args.events, args.tracefile, analyzer)
+
+    # Print some summary stats
+    print ("Flushes: self:%d async:%d synced:%d" %
+           ( len(analyzer.flush_self),
+             len(analyzer.flush_async),
+             len(analyzer.flush_synced)))
+
+    if args.graph == 'time':
+        start_self, end_self = plot_time_series(analyzer.flush_self, "Self")
+        start_async, end_async = plot_time_series(analyzer.flush_async, "Async")
+        start_synced, end_synced = plot_time_series(analyzer.flush_synced, "Self")
+
+        # start right at the edge
+        plt.xlim(xmin=min(start_self, start_async, start_synced))
+    elif args.graph == 'latency':
+
+        # Three subplots, the axes array is 1-d
+
+        f, (ax_self, ax_async, ax_synced) = plt.subplots(3, sharex=True)
+        ax_self.set_title("Distribution")
+
+        ax_self.hist(analyzer.flush_self_times, 10, normed=1,
+                     facecolor='green', alpha=0.5)
+        ax_self.hist(analyzer.flush_async_times, 10, normed=1,
+                     facecolor='blue', alpha=0.5)
+        ax_self.hist(analyzer.flush_synced_times,
+                     10, normed=1,
+                     facecolor='red', alpha=0.5)
+    else:
+        raise ValueError("Bad graph type")
+
+    if args.output:
+        plt.savefig(args.output)
+    else:
+        plt.show()
-- 
2.11.0
