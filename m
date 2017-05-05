Received: from eggs.gnu.org ([2001:4830:134:3::10]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acS-0001nR-Du
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acR-0006n9-Hq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:52 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6acR-0006lv-C1
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:51 -0400
Received: by mail-wm0-x22d.google.com with SMTP id u65so20032188wmu.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:37:51 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 May 2017 11:38:20 +0100
Message-Id: <20170505103822.20641-8-alex.bennee@linaro.org>
In-Reply-To: <20170505103822.20641-1-alex.bennee@linaro.org>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 7/9] scripts/qemu-gdb: add simple tcg
 lock status helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Add a simple helper to dump lock state.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/qemu-gdb.py    |  3 ++-
 scripts/qemugdb/tcg.py | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 scripts/qemugdb/tcg.py

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index b3f8e04f77..d58213e549 100644
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -26,7 +26,7 @@ import os, sys
 
 sys.path.append(os.path.dirname(__file__))
 
-from qemugdb import aio, mtree, coroutine
+from qemugdb import aio, mtree, coroutine, tcg
 
 class QemuCommand(gdb.Command):
     '''Prefix for QEMU debug support commands'''
@@ -38,6 +38,7 @@ QemuCommand()
 coroutine.CoroutineCommand()
 mtree.MtreeCommand()
 aio.HandlersCommand()
+tcg.TCGLockStatusCommand()
 
 coroutine.CoroutineSPFunction()
 coroutine.CoroutinePCFunction()
diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
new file mode 100644
index 0000000000..8c7f1d7454
--- /dev/null
+++ b/scripts/qemugdb/tcg.py
@@ -0,0 +1,46 @@
+#!/usr/bin/python
+# -*- coding: utf-8 -*-
+#
+# GDB debugging support, TCG status
+#
+# Copyright 2016 Linaro Ltd
+#
+# Authors:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+#
+# Contributions after 2012-01-13 are licensed under the terms of the
+# GNU GPL, version 2 or (at your option) any later version.
+
+# 'qemu tcg-lock-status' -- display the TCG lock status across threads
+
+import gdb
+
+class TCGLockStatusCommand(gdb.Command):
+    '''Display TCG Execution Status'''
+    def __init__(self):
+        gdb.Command.__init__(self, 'qemu tcg-lock-status', gdb.COMMAND_DATA,
+                             gdb.COMPLETE_NONE)
+
+    def invoke(self, arg, from_tty):
+        gdb.write("Thread, BQL (iothread_mutex), Replay, Blocked?\n")
+        for thread in gdb.inferiors()[0].threads():
+            thread.switch()
+
+            iothread = gdb.parse_and_eval("iothread_locked")
+            replay = gdb.parse_and_eval("replay_locked")
+
+            frame = gdb.selected_frame()
+            if frame.name() == "__lll_lock_wait":
+                frame.older().select()
+                mutex = gdb.parse_and_eval("mutex")
+                owner = gdb.parse_and_eval("mutex->__data.__owner")
+                blocked = ("__lll_lock_wait waiting on %s from %d" %
+                           (mutex, owner))
+            else:
+                blocked = "not blocked"
+
+            gdb.write("%d/%d, %s, %s, %s\n" % (thread.num, thread.ptid[1],
+                                               iothread, replay, blocked))
-- 
2.11.0
