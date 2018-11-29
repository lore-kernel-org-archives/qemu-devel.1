Received: from eggs.gnu.org ([2001:4830:134:3::10]:43625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSJB4-0005AP-7E
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSJB2-0004If-PB
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:04:10 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:49299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gSJB2-0004Hl-Ej
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:04:08 -0500
From: Fei Li <fli@suse.com>
Date: Thu, 29 Nov 2018 18:03:37 +0800
Message-Id: <20181129100340.13823-3-fli@suse.com>
In-Reply-To: <20181129100340.13823-1-fli@suse.com>
References: <20181129100340.13823-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC v2 2/5] qemu_thread_join: fix segmentation
 fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

To avoid the segmentation fault in qemu_thread_join(), just directly
return when the QemuThread *thread failed to be created in either
qemu-thread-posix.c or qemu-thread-win32.c.

Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 util/qemu-thread-posix.c | 3 +++
 util/qemu-thread-win32.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 865e476df5..b9ab5a4711 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -558,6 +558,9 @@ void *qemu_thread_join(QemuThread *thread)
     int err;
     void *ret;
 
+    if (!thread->thread) {
+        return NULL;
+    }
     err = pthread_join(thread->thread, &ret);
     if (err) {
         error_exit(err, __func__);
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 4a363ca675..1a27e1cf6f 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -366,7 +366,7 @@ void *qemu_thread_join(QemuThread *thread)
     HANDLE handle;
 
     data = thread->data;
-    if (data->mode == QEMU_THREAD_DETACHED) {
+    if (data == NULL || data->mode == QEMU_THREAD_DETACHED) {
         return NULL;
     }
 
-- 
2.13.7
