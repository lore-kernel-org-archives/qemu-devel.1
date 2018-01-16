Received: from eggs.gnu.org ([2001:4830:134:3::10]:50600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS4J-0003IM-LM
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS4G-00051y-Ao
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:27 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS4G-000501-3o
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:24 -0500
Received: by mail-wr0-x241.google.com with SMTP id 16so15333055wry.12
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:18:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:17:15 +0100
Message-Id: <1516112253-14480-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/51] scripts/qemu-gdb: add simple tcg lock
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
index 0000000..8c7f1d7
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
1.8.3.1
