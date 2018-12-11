Received: from eggs.gnu.org ([2001:4830:134:3::10]:38488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gWehh-0008M0-Vb
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gWehf-00083l-Cp
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:49 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:51512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gWehf-0007zX-0f
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:47 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 11 Dec 2018 17:50:57 +0800
Message-Id: <20181211095057.14623-8-fli@suse.com>
In-Reply-To: <20181211095057.14623-1-fli@suse.com>
References: <20181211095057.14623-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v8 7/7] qemu_thread_join: fix
 segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>

To avoid the segmentation fault in qemu_thread_join(), just directly
return when the QemuThread *thread failed to be created in either
qemu-thread-posix.c or qemu-thread-win32.c.

Cc: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 util/qemu-thread-posix.c | 3 +++
 util/qemu-thread-win32.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 81b40a1ece..cb3722a4f4 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -566,6 +566,9 @@ void *qemu_thread_join(QemuThread *thread)
     int err;
     void *ret;
 
+    if (!thread->thread) {
+        return NULL;
+    }
     err = pthread_join(thread->thread, &ret);
     if (err) {
         error_exit(err, __func__);
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 57b1143e97..ca4d5329e3 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -367,7 +367,7 @@ void *qemu_thread_join(QemuThread *thread)
     HANDLE handle;
 
     data = thread->data;
-    if (data->mode == QEMU_THREAD_DETACHED) {
+    if (data == NULL || data->mode == QEMU_THREAD_DETACHED) {
         return NULL;
     }
 
-- 
2.13.7
