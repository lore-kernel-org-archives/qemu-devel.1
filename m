Received: from eggs.gnu.org ([209.51.188.92]:59455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nKz-0001Y9-Lc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nKy-0004Dl-Tf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nKy-0004DJ-KQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:04 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:20:57 -0800
Message-Id: <20190307072057.8150-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 02/37] multi-process: util:
 Add qemu_thread_cancel() to cancel running thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, pbonzini@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

qemu_thread_cancel() added to destroy a given running thread.
This will be needed in the following patches.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 include/qemu/thread.h    |  1 +
 util/qemu-thread-posix.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 55d83a9..78791be 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -156,6 +156,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
                         void *(*start_routine)(void *),
                         void *arg, int mode);
 void *qemu_thread_join(QemuThread *thread);
+void qemu_thread_cancel(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
 void qemu_thread_exit(void *retval);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 1bf5e65..7c89071 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -573,3 +573,13 @@ void *qemu_thread_join(QemuThread *thread)
     }
     return ret;
 }
+
+void qemu_thread_cancel(QemuThread *thread)
+{
+    int err;
+
+    err = pthread_cancel(thread->thread);
+    if (err) {
+        error_exit(err, __func__);
+    }
+}
-- 
1.8.3.1
