Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBW-0004uh-5G
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBV-00027L-57
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:54 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f4jBU-00026u-UK
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:53 -0400
Received: by mail-pl0-x242.google.com with SMTP id x4-v6so2040160pln.7
	for <qemu-devel@nongnu.org>; Sat, 07 Apr 2018 01:26:52 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  7 Apr 2018 16:26:31 +0800
Message-Id: <1523089594-1422-3-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 2/5] migration: add the interface to set
 get_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

The default get_return_path function of iochannel does not work for
RDMA live migration. So add the interface to set get_return_path.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/qemu-file-channel.c | 12 ++++++++----
 migration/qemu-file.c         | 10 ++++++++--
 migration/qemu-file.h         |  2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index e202d73..d4dd8c4 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -156,7 +156,6 @@ static const QEMUFileOps channel_input_ops = {
     .close = channel_close,
     .shut_down = channel_shutdown,
     .set_blocking = channel_set_blocking,
-    .get_return_path = channel_get_input_return_path,
 };
 
 
@@ -165,18 +164,23 @@ static const QEMUFileOps channel_output_ops = {
     .close = channel_close,
     .shut_down = channel_shutdown,
     .set_blocking = channel_set_blocking,
-    .get_return_path = channel_get_output_return_path,
 };
 
 
 QEMUFile *qemu_fopen_channel_input(QIOChannel *ioc)
 {
+    QEMUFile *f;
     object_ref(OBJECT(ioc));
-    return qemu_fopen_ops(ioc, &channel_input_ops);
+    f = qemu_fopen_ops(ioc, &channel_input_ops);
+    qemu_file_set_return_path(f, channel_get_input_return_path);
+    return f;
 }
 
 QEMUFile *qemu_fopen_channel_output(QIOChannel *ioc)
 {
+    QEMUFile *f;
     object_ref(OBJECT(ioc));
-    return qemu_fopen_ops(ioc, &channel_output_ops);
+    f = qemu_fopen_ops(ioc, &channel_output_ops);
+    qemu_file_set_return_path(f, channel_get_output_return_path);
+    return f;
 }
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index bb63c77..8acb574 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -36,6 +36,7 @@
 struct QEMUFile {
     const QEMUFileOps *ops;
     const QEMUFileHooks *hooks;
+    QEMURetPathFunc *get_return_path;
     void *opaque;
 
     int64_t bytes_xfer;
@@ -72,10 +73,15 @@ int qemu_file_shutdown(QEMUFile *f)
  */
 QEMUFile *qemu_file_get_return_path(QEMUFile *f)
 {
-    if (!f->ops->get_return_path) {
+    if (!f->get_return_path) {
         return NULL;
     }
-    return f->ops->get_return_path(f->opaque);
+    return f->get_return_path(f->opaque);
+}
+
+void qemu_file_set_return_path(QEMUFile *f, QEMURetPathFunc *get_return_path)
+{
+    f->get_return_path = get_return_path;
 }
 
 bool qemu_file_mode_is_not_valid(const char *mode)
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index f4f356a..74210b7 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -102,7 +102,6 @@ typedef struct QEMUFileOps {
     QEMUFileCloseFunc *close;
     QEMUFileSetBlocking *set_blocking;
     QEMUFileWritevBufferFunc *writev_buffer;
-    QEMURetPathFunc *get_return_path;
     QEMUFileShutdownFunc *shut_down;
 } QEMUFileOps;
 
@@ -114,6 +113,7 @@ typedef struct QEMUFileHooks {
 } QEMUFileHooks;
 
 QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops);
+void qemu_file_set_return_path(QEMUFile *f, QEMURetPathFunc *get_return_path);
 void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks);
 int qemu_get_fd(QEMUFile *f);
 int qemu_fclose(QEMUFile *f);
-- 
1.8.3.1
