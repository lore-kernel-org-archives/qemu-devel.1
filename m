Received: from eggs.gnu.org ([2001:4830:134:3::10]:47555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBd-00051p-KJ
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBa-00029e-HD
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:27:01 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f4jBa-00029J-CQ
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:58 -0400
Received: by mail-pf0-x242.google.com with SMTP id x16so2379399pfm.4
	for <qemu-devel@nongnu.org>; Sat, 07 Apr 2018 01:26:58 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  7 Apr 2018 16:26:34 +0800
Message-Id: <1523089594-1422-6-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 5/5] migration: disable RDMA WRITR after
 postcopy started.
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

RDMA write operations are performed with no notification to the destination
qemu, then the destination qemu can not wakeup. So disable RDMA WRITE after
postcopy started.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/qemu-file.c |  3 ++-
 migration/rdma.c      | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 8acb574..a64ac3a 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -260,7 +260,8 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
         int ret = f->hooks->save_page(f, f->opaque, block_offset,
                                       offset, size, bytes_sent);
         f->bytes_xfer += size;
-        if (ret != RAM_SAVE_CONTROL_DELAYED) {
+        if (ret != RAM_SAVE_CONTROL_DELAYED &&
+            ret != RAM_SAVE_CONTROL_NOT_SUPP) {
             if (bytes_sent && *bytes_sent > 0) {
                 qemu_update_position(f, *bytes_sent);
             } else if (ret < 0) {
diff --git a/migration/rdma.c b/migration/rdma.c
index 81be482..8529ddd 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2964,6 +2964,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return RAM_SAVE_CONTROL_NOT_SUPP;
+    }
+
     qemu_fflush(f);
 
     if (size > 0) {
@@ -3528,6 +3532,10 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return 0;
+    }
+
     trace_qemu_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     qemu_fflush(f);
@@ -3550,6 +3558,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return 0;
+    }
+
     qemu_fflush(f);
     ret = qemu_rdma_drain_cq(f, rdma);
 
-- 
1.8.3.1
