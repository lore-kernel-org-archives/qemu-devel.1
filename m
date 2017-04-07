Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1p-0002OV-30
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cwW1l-0007R1-Ny
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:25 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cwW1l-0007QF-HO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:42:21 -0400
Received: by mail-wm0-x22a.google.com with SMTP id t189so10641151wmt.1
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:42:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  7 Apr 2017 16:42:11 +0100
Message-Id: <20170407154221.26918-3-alex.bennee@linaro.org>
In-Reply-To: <20170407154221.26918-1-alex.bennee@linaro.org>
References: <20170407154221.26918-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/12] scripts/qemu-gdb/timers.py: new
 helper to dump timer state
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

This introduces the qemu-gdb command "qemu timers" which will dump the
state of the main timers in the system.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu-gdb.py       |  3 ++-
 scripts/qemugdb/timers.py | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 scripts/qemugdb/timers.py

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index b3f8e04f77..3e7adb87dc 100644
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -26,7 +26,7 @@ import os, sys
 
 sys.path.append(os.path.dirname(__file__))
 
-from qemugdb import aio, mtree, coroutine
+from qemugdb import aio, mtree, coroutine, timers
 
 class QemuCommand(gdb.Command):
     '''Prefix for QEMU debug support commands'''
@@ -38,6 +38,7 @@ QemuCommand()
 coroutine.CoroutineCommand()
 mtree.MtreeCommand()
 aio.HandlersCommand()
+timers.TimersCommand()
 
 coroutine.CoroutineSPFunction()
 coroutine.CoroutinePCFunction()
diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
new file mode 100644
index 0000000000..be71a001e3
--- /dev/null
+++ b/scripts/qemugdb/timers.py
@@ -0,0 +1,54 @@
+#!/usr/bin/python
+# GDB debugging support
+#
+# Copyright 2017 Linaro Ltd
+#
+# Author: Alex Bennée <alex.bennee@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+
+# 'qemu timers' -- display the current timerlists
+
+import gdb
+
+class TimersCommand(gdb.Command):
+    '''Display the current QEMU timers'''
+
+    def __init__(self):
+        'Register the class as a gdb command'
+        gdb.Command.__init__(self, 'qemu timers', gdb.COMMAND_DATA,
+                             gdb.COMPLETE_NONE)
+
+    def dump_timers(self, timer):
+        "Follow a timer and recursively dump each one in the list."
+        # timer should be of type QemuTimer
+        gdb.write("    timer %s/%s (cb:%s,opq:%s)\n" % (
+            timer['expire_time'],
+            timer['scale'],
+            timer['cb'],
+            timer['opaque']))
+
+        if int(timer['next']) > 0:
+            self.dump_timers(timer['next'])
+
+
+    def process_timerlist(self, tlist, ttype):
+        gdb.write("Processing %s timers\n" % (ttype))
+        gdb.write("  clock %s is enabled:%s, last:%s\n" % (
+            tlist['clock']['type'],
+            tlist['clock']['enabled'],
+            tlist['clock']['last']))
+        if int(tlist['active_timers']) > 0:
+            self.dump_timers(tlist['active_timers'])
+
+
+    def invoke(self, arg, from_tty):
+        'Run the command'
+        main_timers = gdb.parse_and_eval("main_loop_tlg")
+
+        # This will break if QEMUClockType in timer.h is redfined
+        self.process_timerlist(main_timers['tl'][0], "Realtime")
+        self.process_timerlist(main_timers['tl'][1], "Virtual")
+        self.process_timerlist(main_timers['tl'][2], "Host")
+        self.process_timerlist(main_timers['tl'][3], "Virtual RT")
-- 
2.11.0
