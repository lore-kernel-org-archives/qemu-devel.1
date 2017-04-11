Received: from eggs.gnu.org ([2001:4830:134:3::10]:43747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxtNT-0003YB-E3
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxtNS-0004Sk-KP
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:27 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxtNS-0004SW-Ds
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:26 -0400
Received: by mail-wm0-x22c.google.com with SMTP id o81so59948602wmb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 03:50:26 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Apr 2017 11:50:31 +0100
Message-Id: <20170411105031.28904-4-alex.bennee@linaro.org>
In-Reply-To: <20170411105031.28904-1-alex.bennee@linaro.org>
References: <20170411105031.28904-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/3] new
 script/analyse-tlb-flushes-simpletrace.py
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

This is a simple helper script to extract TLB flush stats from the a
simpletrace file and plot the results.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/analyse-tlb-flushes-simpletrace.py | 62 ++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 scripts/analyse-tlb-flushes-simpletrace.py

diff --git a/scripts/analyse-tlb-flushes-simpletrace.py b/scripts/analyse-tlb-flushes-simpletrace.py
new file mode 100755
index 0000000000..9a1191c154
--- /dev/null
+++ b/scripts/analyse-tlb-flushes-simpletrace.py
@@ -0,0 +1,62 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+#
+# Generate a simple graph of flushes over time
+#
+# Author: Alex Bennée <alex.bennee@linaro.org>
+#
+
+import os
+import simpletrace
+import argparse
+import numpy as np
+import matplotlib.pyplot as plt
+
+class CpuTLBFlushAnalyser(simpletrace.Analyzer):
+    "A simpletrace Analyser for extracting flush stats."
+
+    def __init__(self):
+        self.stats = 0
+        self.timestamps = []
+        self.flush_self = []
+        self.flush_async = []
+        self.flush_synced = []
+
+
+    def tlb_flush_stats(self, timestamp, flush_self, flush_async, flush_synced):
+        "Match for tlb_flush_stats event. Appends counts to the relevant array."
+        self.timestamps.append(timestamp)
+        self.flush_self.append(flush_self)
+        self.flush_async.append(flush_async)
+        self.flush_synced.append(flush_synced)
+        self.stats += 1
+
+
+def get_args():
+    "Grab options"
+    parser = argparse.ArgumentParser()
+    parser.add_argument("--output", "-o", type=str, help="Render plot to file")
+    parser.add_argument("events", type=str, help='trace file read from')
+    parser.add_argument("tracefile", type=str, help='trace file read from')
+    return parser.parse_args()
+
+if __name__ == '__main__':
+    args = get_args()
+
+    # Gather data from the trace
+    analyzer = CpuTLBFlushAnalyser()
+    simpletrace.process(args.events, args.tracefile, analyzer)
+
+#    x = np.arange(analyzer.stats)
+    fself, = plt.plot(analyzer.timestamps, analyzer.flush_self, label="Self")
+    fasync, = plt.plot(analyzer.timestamps, analyzer.flush_async, label="Async")
+    fsynced, = plt.plot(analyzer.timestamps, analyzer.flush_synced, label="Synced")
+
+    plt.legend(handles=[fself, fasync, fsynced])
+    plt.xlabel("Execution Time")
+    plt.ylabel("Culmlative count")
+
+    if args.output:
+        plt.savefig(args.output)
+    else:
+        plt.show()
-- 
2.11.0
