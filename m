Received: from eggs.gnu.org ([2001:4830:134:3::10]:42165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZP-000855-Kv
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZO-00066R-Kq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:23 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:41786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZO-00065r-CN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:22 -0500
Received: by mail-wm0-x22e.google.com with SMTP id g75so11524094wme.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:16 +0100
Message-Id: <1515756676-3860-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 52/52] scripts/analyse-locks-simpletrace.py:
 script to analyse lock times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

This script allows analysis of mutex acquisition and hold times based
on a trace file. Given a trace control file of:

  qemu_mutex_lock
  qemu_mutex_locked
  qemu_mutex_unlock

And running with:

  $QEMU $QEMU_ARGS -trace events=./lock-trace

You can analyse the results with:

  ./scripts/analyse-locks-simpletrace.py trace-events-all ./trace-21812

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/analyse-locks-simpletrace.py | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100755 scripts/analyse-locks-simpletrace.py

diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks-simpletrace.py
new file mode 100755
index 0000000..a69ed5c
--- /dev/null
+++ b/scripts/analyse-locks-simpletrace.py
@@ -0,0 +1,99 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+#
+# Analyse lock events and
+#
+# Author: Alex BennÃ©e <alex.bennee@linaro.org>
+#
+
+import os
+import simpletrace
+import argparse
+import numpy as np
+
+class MutexAnalyser(simpletrace.Analyzer):
+    "A simpletrace Analyser for checking locks."
+
+    def __init__(self):
+        self.locks = 0
+        self.locked = 0
+        self.unlocks = 0
+        self.mutex_records = {}
+
+    def _get_mutex(self, mutex):
+        if not mutex in self.mutex_records:
+            self.mutex_records[mutex] = {"locks": 0,
+                                         "lock_time": 0,
+                                         "acquire_times": [],
+                                         "locked": 0,
+                                         "locked_time": 0,
+                                         "held_times": [],
+                                         "unlocked": 0}
+
+        return self.mutex_records[mutex]
+
+    def qemu_mutex_lock(self, timestamp, mutex, filename, line):
+        self.locks += 1
+        rec = self._get_mutex(mutex)
+        rec["locks"] += 1
+        rec["lock_time"] = timestamp[0]
+        rec["lock_loc"] = (filename, line)
+
+    def qemu_mutex_locked(self, timestamp, mutex, filename, line):
+        self.locked += 1
+        rec = self._get_mutex(mutex)
+        rec["locked"] += 1
+        rec["locked_time"] = timestamp[0]
+        acquire_time = rec["locked_time"] - rec["lock_time"]
+        rec["locked_loc"] = (filename, line)
+        rec["acquire_times"].append(acquire_time)
+
+    def qemu_mutex_unlock(self, timestamp, mutex, filename, line):
+        self.unlocks += 1
+        rec = self._get_mutex(mutex)
+        rec["unlocked"] += 1
+        held_time = timestamp[0] - rec["locked_time"]
+        rec["held_times"].append(held_time)
+        rec["unlock_loc"] = (filename, line)
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
+    analyser = MutexAnalyser()
+    simpletrace.process(args.events, args.tracefile, analyser)
+
+    print ("Total locks: %d, locked: %d, unlocked: %d" %
+           (analyser.locks, analyser.locked, analyser.unlocks))
+
+    # Now dump the individual lock stats
+    for key, val in sorted(analyser.mutex_records.iteritems(),
+                           key=lambda (k,v): v["locks"]):
+        print ("Lock: %#x locks: %d, locked: %d, unlocked: %d" %
+               (key, val["locks"], val["locked"], val["unlocked"]))
+
+        acquire_times = np.array(val["acquire_times"])
+        if len(acquire_times) > 0:
+            print ("  Acquire Time: min:%d median:%d avg:%.2f max:%d" %
+                   (acquire_times.min(), np.median(acquire_times),
+                    acquire_times.mean(), acquire_times.max()))
+
+        held_times = np.array(val["held_times"])
+        if len(held_times) > 0:
+            print ("  Held Time: min:%d median:%d avg:%.2f max:%d" %
+                   (held_times.min(), np.median(held_times),
+                    held_times.mean(), held_times.max()))
+
+        # Check if any locks still held
+        if val["locks"] > val["locked"]:
+            print ("  LOCK HELD (%s:%s)" % (val["locked_loc"]))
+            print ("  BLOCKED   (%s:%s)" % (val["lock_loc"]))
-- 
1.8.3.1
