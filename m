Received: from eggs.gnu.org ([2001:4830:134:3::10]:47476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBY-0004vd-4c
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBX-000287-3f
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:56 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f4jBW-00027x-TU
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:55 -0400
Received: by mail-pf0-x241.google.com with SMTP id u86so2381298pfd.2
	for <qemu-devel@nongnu.org>; Sat, 07 Apr 2018 01:26:54 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  7 Apr 2018 16:26:32 +0800
Message-Id: <1523089594-1422-4-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 3/5] migration: implement the get_return_path
 for RDMA iochannel
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

the default get_return_path function does not work for RDMA live
migration, the patch implement the get_return_path for RDMA iochannel.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/rdma.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 230bd97..53773c7 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3638,6 +3638,40 @@ err:
     return ret;
 }
 
+static QEMUFile *qio_channel_rdma_get_return_path(void *opaque, int input)
+{
+    QIOChannel *ioc = opaque;
+    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    RDMAContext *rdma = rioc->rdma;
+
+    QIOChannelRDMA *rioc_return_path;
+    RDMAContext *rdma_return_path = rdma->return_path;
+
+    if (!rdma_return_path) {
+        return NULL;
+    }
+
+    rioc_return_path = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
+    rioc_return_path->rdma = rdma_return_path;
+    if (input) {
+        rioc_return_path->file = qemu_fopen_channel_output(
+                                 QIO_CHANNEL(rioc_return_path));
+    } else {
+        rioc_return_path->file = qemu_fopen_channel_input(
+                                 QIO_CHANNEL(rioc_return_path));
+    }
+    return rioc_return_path->file;
+}
+
+static QEMUFile *qio_channel_rdma_get_output_return_path(void *opaque)
+{
+   return qio_channel_rdma_get_return_path(opaque, 0);
+}
+
+static QEMUFile *qio_channel_rdma_get_input_return_path(void *opaque)
+{
+   return qio_channel_rdma_get_return_path(opaque, 1);
+}
 static const QEMUFileHooks rdma_read_hooks = {
     .hook_ram_load = rdma_load_hook,
 };
@@ -3700,9 +3734,13 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
     if (mode[0] == 'w') {
         rioc->file = qemu_fopen_channel_output(QIO_CHANNEL(rioc));
         qemu_file_set_hooks(rioc->file, &rdma_write_hooks);
+        qemu_file_set_return_path(rioc->file,
+                                  qio_channel_rdma_get_output_return_path);
     } else {
         rioc->file = qemu_fopen_channel_input(QIO_CHANNEL(rioc));
         qemu_file_set_hooks(rioc->file, &rdma_read_hooks);
+        qemu_file_set_return_path(rioc->file,
+                                  qio_channel_rdma_get_input_return_path);
     }
 
     return rioc->file;
-- 
1.8.3.1
