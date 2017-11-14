Received: from eggs.gnu.org ([2001:4830:134:3::10]:41374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQl-0001BI-8O
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQk-0007UW-2a
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:51 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52930)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eEWQj-0007U4-Lg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:18:50 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 14 Nov 2017 11:18:57 +0300
Message-ID: <20171114081857.27640.15221.stgit@pasha-VirtualBox>
In-Reply-To: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 26/26] scripts/qemu-gdb/timers.py: new
 helper to dump timer state
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

This introduces the qemu-gdb command "qemu timers" which will dump the
state of the main timers in the system.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
 scripts/qemu-gdb.py       |    3 ++-
 scripts/qemugdb/timers.py |   54 +++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 scripts/qemugdb/timers.py

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index d58213e..690827e 100644
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -26,7 +26,7 @@ import os, sys
=20
 sys.path.append(os.path.dirname(__file__))
=20
-from qemugdb import aio, mtree, coroutine, tcg
+from qemugdb import aio, mtree, coroutine, tcg, timers
=20
 class QemuCommand(gdb.Command):
     '''Prefix for QEMU debug support commands'''
@@ -39,6 +39,7 @@ coroutine.CoroutineCommand()
 mtree.MtreeCommand()
 aio.HandlersCommand()
 tcg.TCGLockStatusCommand()
+timers.TimersCommand()
=20
 coroutine.CoroutineSPFunction()
 coroutine.CoroutinePCFunction()
diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
new file mode 100644
index 0000000..be71a00
--- /dev/null
+++ b/scripts/qemugdb/timers.py
@@ -0,0 +1,54 @@
+#!/usr/bin/python
+# GDB debugging support
+#
+# Copyright 2017 Linaro Ltd
+#
+# Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
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
+        main_timers =3D gdb.parse_and_eval("main_loop_tlg")
+
+        # This will break if QEMUClockType in timer.h is redfined
+        self.process_timerlist(main_timers['tl'][0], "Realtime")
+        self.process_timerlist(main_timers['tl'][1], "Virtual")
+        self.process_timerlist(main_timers['tl'][2], "Host")
+        self.process_timerlist(main_timers['tl'][3], "Virtual RT")
