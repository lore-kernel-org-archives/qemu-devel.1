Received: from eggs.gnu.org ([2001:4830:134:3::10]:58415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyIF-0008Qt-BM
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyIE-0008Cl-AH
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:11 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fEyIE-0008BN-3R
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:10 -0400
Received: by mail-pg0-x242.google.com with SMTP id l2-v6so17312785pgc.7
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 07:36:09 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  5 May 2018 22:35:34 +0800
Message-Id: <1525530936-21835-5-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
References: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v3 4/6] migration: avoid concurrent invoke
 channel_close by different threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

The channel_close maybe invoked by different threads. For example, source
qemu invokes qemu_fclose in main thread, migration thread and return path
thread. Destination qemu invokes qemu_fclose in main thread, listen thread
and COLO incoming thread.

Add a mutex in QEMUFile struct to avoid concurrent invoke channel_close.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/qemu-file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 977b9ae..87d0f05 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -52,6 +52,7 @@ struct QEMUFile {
     unsigned int iovcnt;
 
     int last_error;
+    QemuMutex lock;
 };
 
 /*
@@ -96,6 +97,7 @@ QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops)
 
     f = g_new0(QEMUFile, 1);
 
+    qemu_mutex_init(&f->lock);
     f->opaque = opaque;
     f->ops = ops;
     return f;
@@ -328,7 +330,9 @@ int qemu_fclose(QEMUFile *f)
     ret = qemu_file_get_error(f);
 
     if (f->ops->close) {
+        qemu_mutex_lock(&f->lock);
         int ret2 = f->ops->close(f->opaque);
+        qemu_mutex_unlock(&f->lock);
         if (ret >= 0) {
             ret = ret2;
         }
@@ -339,6 +343,7 @@ int qemu_fclose(QEMUFile *f)
     if (f->last_error) {
         ret = f->last_error;
     }
+    qemu_mutex_destroy(&f->lock);
     g_free(f);
     trace_qemu_file_fclose();
     return ret;
-- 
1.8.3.1
