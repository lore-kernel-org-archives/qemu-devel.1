Received: from eggs.gnu.org ([2001:4830:134:3::10]:53416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdDZI-0007qK-K3
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdDZE-0007XA-H6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdDZE-0007X4-7p
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:08 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8402C80F6B
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 10:09:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Feb 2017 11:08:49 +0100
Message-Id: <20170213100906.23486-2-pbonzini@redhat.com>
In-Reply-To: <20170213100906.23486-1-pbonzini@redhat.com>
References: <20170213100906.23486-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/18] block: move AioContext, QEMUTimer,
 main-loop to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

AioContext is fairly self contained, the only dependency is QEMUTimer but
that in turn doesn't need anything else.  So move them out of block-obj-y
to avoid introducing a dependency from io/ to block-obj-y.

main-loop and its dependency iohandler also need to be moved, because
later in this series io/ will call iohandler_get_aio_context.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs                       |  4 ---
 block/io.c                          | 29 -------------------
 stubs/Makefile.objs                 |  1 +
 stubs/linux-aio.c                   | 32 +++++++++++++++++++++
 stubs/set-fd-handler.c              | 11 --------
 tests/Makefile.include              | 11 ++++----
 util/Makefile.objs                  |  6 +++-
 aio-posix.c => util/aio-posix.c     |  0
 aio-win32.c => util/aio-win32.c     |  0
 util/aiocb.c                        | 55 +++++++++++++++++++++++++++++++++++++
 async.c => util/async.c             |  3 +-
 iohandler.c => util/iohandler.c     |  0
 main-loop.c => util/main-loop.c     |  0
 qemu-timer.c => util/qemu-timer.c   |  0
 thread-pool.c => util/thread-pool.c |  0
 15 files changed, 101 insertions(+), 51 deletions(-)
 create mode 100644 stubs/linux-aio.c
 rename aio-posix.c => util/aio-posix.c (100%)
 rename aio-win32.c => util/aio-win32.c (100%)
 create mode 100644 util/aiocb.c
 rename async.c => util/async.c (99%)
 rename iohandler.c => util/iohandler.c (100%)
 rename main-loop.c => util/main-loop.c (100%)
 rename qemu-timer.c => util/qemu-timer.c (100%)
 rename thread-pool.c => util/thread-pool.c (100%)

diff --git a/Makefile.objs b/Makefile.objs
index 431fc59..b4b29c2 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -9,12 +9,8 @@ chardev-obj-y = chardev/
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
-block-obj-y = async.o thread-pool.o
 block-obj-y += nbd/
 block-obj-y += block.o blockjob.o
-block-obj-y += main-loop.o iohandler.o qemu-timer.o
-block-obj-$(CONFIG_POSIX) += aio-posix.o
-block-obj-$(CONFIG_WIN32) += aio-win32.o
 block-obj-y += block/
 block-obj-y += qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
diff --git a/block/io.c b/block/io.c
index c42b34a..76dfaf4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2239,35 +2239,6 @@ BlockAIOCB *bdrv_aio_flush(BlockDriverState *bs,
     return &acb->common;
 }
 
-void *qemu_aio_get(const AIOCBInfo *aiocb_info, BlockDriverState *bs,
-                   BlockCompletionFunc *cb, void *opaque)
-{
-    BlockAIOCB *acb;
-
-    acb = g_malloc(aiocb_info->aiocb_size);
-    acb->aiocb_info = aiocb_info;
-    acb->bs = bs;
-    acb->cb = cb;
-    acb->opaque = opaque;
-    acb->refcnt = 1;
-    return acb;
-}
-
-void qemu_aio_ref(void *p)
-{
-    BlockAIOCB *acb = p;
-    acb->refcnt++;
-}
-
-void qemu_aio_unref(void *p)
-{
-    BlockAIOCB *acb = p;
-    assert(acb->refcnt > 0);
-    if (--acb->refcnt == 0) {
-        g_free(acb);
-    }
-}
-
 /**************************************************************/
 /* Coroutine block device emulation */
 
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index a187295..aa6050f 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -16,6 +16,7 @@ stub-obj-y += get-vm-name.o
 stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
+stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
 stub-obj-y += monitor.o
diff --git a/stubs/linux-aio.c b/stubs/linux-aio.c
new file mode 100644
index 0000000..ed47bd4
--- /dev/null
+++ b/stubs/linux-aio.c
@@ -0,0 +1,32 @@
+/*
+ * Linux native AIO support.
+ *
+ * Copyright (C) 2009 IBM, Corp.
+ * Copyright (C) 2009 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "block/aio.h"
+#include "block/raw-aio.h"
+
+void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context)
+{
+    abort();
+}
+
+void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context)
+{
+    abort();
+}
+
+LinuxAioState *laio_init(void)
+{
+    abort();
+}
+
+void laio_cleanup(LinuxAioState *s)
+{
+    abort();
+}
diff --git a/stubs/set-fd-handler.c b/stubs/set-fd-handler.c
index acbe65c..26965de 100644
--- a/stubs/set-fd-handler.c
+++ b/stubs/set-fd-handler.c
@@ -9,14 +9,3 @@ void qemu_set_fd_handler(int fd,
 {
     abort();
 }
-
-void aio_set_fd_handler(AioContext *ctx,
-                        int fd,
-                        bool is_external,
-                        IOHandler *io_read,
-                        IOHandler *io_write,
-                        AioPollFn *io_poll,
-                        void *opaque)
-{
-    abort();
-}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 634394a..fed0bb5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -45,6 +45,9 @@ check-unit-y += tests/test-visitor-serialization$(EXESUF)
 check-unit-y += tests/test-iov$(EXESUF)
 gcov-files-test-iov-y = util/iov.c
 check-unit-y += tests/test-aio$(EXESUF)
+gcov-files-test-aio-y = util/async.c util/qemu-timer.o
+gcov-files-test-aio-$(CONFIG_WIN32) += util/aio-win32.c
+gcov-files-test-aio-$(CONFIG_POSIX) += util/aio-posix.c
 check-unit-y += tests/test-throttle$(EXESUF)
 gcov-files-test-aio-$(CONFIG_WIN32) = aio-win32.c
 gcov-files-test-aio-$(CONFIG_POSIX) = aio-posix.c
@@ -517,8 +520,7 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom-obj-y)
 tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y)
 
-tests/test-char$(EXESUF): tests/test-char.o qemu-timer.o \
-	$(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y) $(chardev-obj-y)
+tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(chardev-obj-y)
 tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-throttle$(EXESUF): tests/test-throttle.o $(test-block-obj-y)
@@ -551,8 +553,7 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	migration/vmstate.o migration/qemu-file.o \
         migration/qemu-file-channel.o migration/qjson.o \
 	$(test-io-obj-y)
-tests/test-timed-average$(EXESUF): tests/test-timed-average.o qemu-timer.o \
-	$(test-util-obj-y)
+tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o \
 	libqemuutil.a libqemustub.a
 tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o libqemustub.a
@@ -712,7 +713,7 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
 tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
 tests/postcopy-test$(EXESUF): tests/postcopy-test.o
-tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o qemu-timer.o \
+tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
 	$(chardev-obj-y)
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 56c8c23..bc629e2 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -1,14 +1,18 @@
 util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
 util-obj-y += bufferiszero.o
 util-obj-y += lockcnt.o
+util-obj-y += aiocb.o async.o thread-pool.o qemu-timer.o
+util-obj-y += main-loop.o iohandler.o
+util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += compatfd.o
 util-obj-$(CONFIG_POSIX) += event_notifier-posix.o
 util-obj-$(CONFIG_POSIX) += mmap-alloc.o
 util-obj-$(CONFIG_POSIX) += oslib-posix.o
 util-obj-$(CONFIG_POSIX) += qemu-openpty.o
 util-obj-$(CONFIG_POSIX) += qemu-thread-posix.o
-util-obj-$(CONFIG_WIN32) += event_notifier-win32.o
 util-obj-$(CONFIG_POSIX) += memfd.o
+util-obj-$(CONFIG_WIN32) += aio-win32.o
+util-obj-$(CONFIG_WIN32) += event_notifier-win32.o
 util-obj-$(CONFIG_WIN32) += oslib-win32.o
 util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
 util-obj-y += envlist.o path.o module.o
diff --git a/aio-posix.c b/util/aio-posix.c
similarity index 100%
rename from aio-posix.c
rename to util/aio-posix.c
diff --git a/aio-win32.c b/util/aio-win32.c
similarity index 100%
rename from aio-win32.c
rename to util/aio-win32.c
diff --git a/util/aiocb.c b/util/aiocb.c
new file mode 100644
index 0000000..305a9cf
--- /dev/null
+++ b/util/aiocb.c
@@ -0,0 +1,55 @@
+/*
+ * BlockAIOCB allocation
+ *
+ * Copyright (c) 2003-2017 Fabrice Bellard and the QEMU team
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/aio.h"
+
+void *qemu_aio_get(const AIOCBInfo *aiocb_info, BlockDriverState *bs,
+                   BlockCompletionFunc *cb, void *opaque)
+{
+    BlockAIOCB *acb;
+
+    acb = g_malloc(aiocb_info->aiocb_size);
+    acb->aiocb_info = aiocb_info;
+    acb->bs = bs;
+    acb->cb = cb;
+    acb->opaque = opaque;
+    acb->refcnt = 1;
+    return acb;
+}
+
+void qemu_aio_ref(void *p)
+{
+    BlockAIOCB *acb = p;
+    acb->refcnt++;
+}
+
+void qemu_aio_unref(void *p)
+{
+    BlockAIOCB *acb = p;
+    assert(acb->refcnt > 0);
+    if (--acb->refcnt == 0) {
+        g_free(acb);
+    }
+}
diff --git a/async.c b/util/async.c
similarity index 99%
rename from async.c
rename to util/async.c
index 0d218ab..75519e2 100644
--- a/async.c
+++ b/util/async.c
@@ -1,7 +1,8 @@
 /*
- * QEMU System Emulator
+ * Data plane event loop
  *
  * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2009-2017 the QEMU team
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
diff --git a/iohandler.c b/util/iohandler.c
similarity index 100%
rename from iohandler.c
rename to util/iohandler.c
diff --git a/main-loop.c b/util/main-loop.c
similarity index 100%
rename from main-loop.c
rename to util/main-loop.c
diff --git a/qemu-timer.c b/util/qemu-timer.c
similarity index 100%
rename from qemu-timer.c
rename to util/qemu-timer.c
diff --git a/thread-pool.c b/util/thread-pool.c
similarity index 100%
rename from thread-pool.c
rename to util/thread-pool.c
-- 
2.9.3
