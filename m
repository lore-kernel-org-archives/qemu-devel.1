Received: from eggs.gnu.org ([2001:4830:134:3::10]:41915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ4-0007ja-KV
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ3-0005m8-Ka
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:02 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZ3-0005lV-DS
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:01 -0500
Received: by mail-wr0-x241.google.com with SMTP id f8so5037331wre.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:59 +0100
Message-Id: <1515756676-3860-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/52] scripts/qemu-gdb: add simple tcg lock
 status helper
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

Add a simple helper to dump lock state.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qemu-gdb.py    |  3 ++-
 scripts/qemugdb/tcg.py | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 scripts/qemugdb/tcg.py

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index b3f8e04..d58213e 100644
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
index 0000000..88d042e
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
+#  Alex BennÃ©e <alex.bennee@linaro.org>
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
1.8.3.1
