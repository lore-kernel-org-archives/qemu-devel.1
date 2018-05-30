Received: from eggs.gnu.org ([2001:4830:134:3::10]:40315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fNxeH-0000Q0-NL
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fNxeE-0006ps-K6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:05 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:42774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fNxeE-0006pg-EP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:44:02 -0400
Received: by mail-pf0-x22a.google.com with SMTP id p14-v6so8747481pfh.9
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 02:44:02 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Wed, 30 May 2018 17:43:28 +0800
Message-Id: <1527673416-31268-5-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
References: <1527673416-31268-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v4 04/12] migration: avoid concurrent invoke
 channel_close by different threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com, aviadye@mellanox.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

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
