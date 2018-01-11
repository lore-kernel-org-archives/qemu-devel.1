Received: from eggs.gnu.org ([2001:4830:134:3::10]:47313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCd-0001H1-Hl
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCc-0002Hf-DX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:11 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41960)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCc-0002GZ-5R
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:10 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:27:11 +0300
Message-ID: <20180111082711.27295.21310.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 24/30] scripts/qemu-gdb: add simple tcg
 lock status helper
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

Add a simple helper to dump lock state.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 scripts/qemu-gdb.py    |    3 ++-
 scripts/qemugdb/tcg.py |   46 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 scripts/qemugdb/tcg.py

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
index b3f8e04..d58213e 100644
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -26,7 +26,7 @@ import os, sys
=20
 sys.path.append(os.path.dirname(__file__))
=20
-from qemugdb import aio, mtree, coroutine
+from qemugdb import aio, mtree, coroutine, tcg
=20
 class QemuCommand(gdb.Command):
     '''Prefix for QEMU debug support commands'''
@@ -38,6 +38,7 @@ QemuCommand()
 coroutine.CoroutineCommand()
 mtree.MtreeCommand()
 aio.HandlersCommand()
+tcg.TCGLockStatusCommand()
=20
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
+#  Alex Benn=C3=A9e <alex.bennee@linaro.org>
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
+        gdb.Command.__init__(self, 'qemu tcg-lock-status', gdb.COMMAND_D=
ATA,
+                             gdb.COMPLETE_NONE)
+
+    def invoke(self, arg, from_tty):
+        gdb.write("Thread, BQL (iothread_mutex), Replay, Blocked?\n")
+        for thread in gdb.inferiors()[0].threads():
+            thread.switch()
+
+            iothread =3D gdb.parse_and_eval("iothread_locked")
+            replay =3D gdb.parse_and_eval("replay_locked")
+
+            frame =3D gdb.selected_frame()
+            if frame.name() =3D=3D "__lll_lock_wait":
+                frame.older().select()
+                mutex =3D gdb.parse_and_eval("mutex")
+                owner =3D gdb.parse_and_eval("mutex->__data.__owner")
+                blocked =3D ("__lll_lock_wait waiting on %s from %d" %
+                           (mutex, owner))
+            else:
+                blocked =3D "not blocked"
+
+            gdb.write("%d/%d, %s, %s, %s\n" % (thread.num, thread.ptid[1=
],
+                                               iothread, replay, blocked=
))
