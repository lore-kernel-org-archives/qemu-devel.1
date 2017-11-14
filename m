Received: from eggs.gnu.org ([2001:4830:134:3::10]:41218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQa-0000w4-Dm
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQZ-0007L6-4Z
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:40 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52890)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQY-0007Kh-On
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:39 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 14 Nov 2017 11:18:46 +0300
Message-ID: <20171114081846.27640.12424.stgit@pasha-VirtualBox>
In-Reply-To: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 24/26]
 scripts/analyse-locks-simpletrace.py: script to analyse lock times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This script allows analysis of mutex acquisition and hold times based
on a trace file. Given a trace control file of:

  qemu_mutex_lock
  qemu_mutex_locked
  qemu_mutex_unlock

And running with:

  $QEMU $QEMU_ARGS -trace events=3D./lock-trace

You can analyse the results with:

  ./scripts/analyse-locks-simpletrace.py trace-events-all ./trace-21812

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

---
 scripts/analyse-locks-simpletrace.py |   99 ++++++++++++++++++++++++++++=
++++++
 1 file changed, 99 insertions(+)
 create mode 100755 scripts/analyse-locks-simpletrace.py

diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks=
-simpletrace.py
new file mode 100755
index 0000000..b72c951
--- /dev/null
+++ b/scripts/analyse-locks-simpletrace.py
@@ -0,0 +1,99 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+#
+# Analyse lock events and
+#
+# Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
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
+        self.locks =3D 0
+        self.locked =3D 0
+        self.unlocks =3D 0
+        self.mutex_records =3D {}
+
+    def _get_mutex(self, mutex):
+        if not mutex in self.mutex_records:
+            self.mutex_records[mutex] =3D {"locks": 0,
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
+        self.locks +=3D 1
+        rec =3D self._get_mutex(mutex)
+        rec["locks"] +=3D 1
+        rec["lock_time"] =3D timestamp[0]
+        rec["lock_loc"] =3D (filename, line)
+
+    def qemu_mutex_locked(self, timestamp, mutex, filename, line):
+        self.locked +=3D 1
+        rec =3D self._get_mutex(mutex)
+        rec["locked"] +=3D 1
+        rec["locked_time"] =3D timestamp[0]
+        acquire_time =3D rec["locked_time"] - rec["lock_time"]
+        rec["locked_loc"] =3D (filename, line)
+        rec["acquire_times"].append(acquire_time)
+
+    def qemu_mutex_unlock(self, timestamp, mutex, filename, line):
+        self.unlocks +=3D 1
+        rec =3D self._get_mutex(mutex)
+        rec["unlocked"] +=3D 1
+        held_time =3D timestamp[0] - rec["locked_time"]
+        rec["held_times"].append(held_time)
+        rec["unlock_loc"] =3D (filename, line)
+
+
+def get_args():
+    "Grab options"
+    parser =3D argparse.ArgumentParser()
+    parser.add_argument("--output", "-o", type=3Dstr, help=3D"Render plo=
t to file")
+    parser.add_argument("events", type=3Dstr, help=3D'trace file read fr=
om')
+    parser.add_argument("tracefile", type=3Dstr, help=3D'trace file read=
 from')
+    return parser.parse_args()
+
+if __name__ =3D=3D '__main__':
+    args =3D get_args()
+
+    # Gather data from the trace
+    analyser =3D MutexAnalyser()
+    simpletrace.process(args.events, args.tracefile, analyser)
+
+    print ("Total locks: %d, locked: %d, unlocked: %d" %
+           (analyser.locks, analyser.locked, analyser.unlocks))
+
+    # Now dump the individual lock stats
+    for key, val in sorted(analyser.mutex_records.iteritems(),
+                           key=3Dlambda (k,v): v["locks"]):
+        print ("Lock: %#x locks: %d, locked: %d, unlocked: %d" %
+               (key, val["locks"], val["locked"], val["unlocked"]))
+
+        acquire_times =3D np.array(val["acquire_times"])
+        if len(acquire_times) > 0:
+            print ("  Acquire Time: min:%d median:%d avg:%.2f max:%d" %
+                   (acquire_times.min(), np.median(acquire_times),
+                    acquire_times.mean(), acquire_times.max()))
+
+        held_times =3D np.array(val["held_times"])
+        if len(held_times) > 0:
+            print ("  Held Time: min:%d median:%d avg:%.2f max:%d" %
+                   (held_times.min(), np.median(held_times),
+                    held_times.mean(), held_times.max()))
+
+        # Check if any locks still held
+        if val["locks"] > val["locked"]:
+            print ("  LOCK HELD (%s:%s)" % (val["locked_loc"]))
+            print ("  BLOCKED   (%s:%s)" % (val["lock_loc"]))
