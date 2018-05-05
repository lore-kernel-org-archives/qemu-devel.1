Received: from eggs.gnu.org ([2001:4830:134:3::10]:58389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyI9-0008Mk-08
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyI7-00084m-UQ
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:05 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fEyI7-00084C-Nj
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:03 -0400
Received: by mail-pg0-x243.google.com with SMTP id a13-v6so17326052pgu.4
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 07:36:03 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  5 May 2018 22:35:31 +0800
Message-Id: <1525530936-21835-2-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
References: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v3 1/6] migration: disable RDMA WRITE after
 postcopy started
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

RDMA WRITE operations are performed with no notification to the destination
qemu, then the destination qemu can not wakeup. This patch disable RDMA WRITE
after postcopy started.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/qemu-file.c |  8 ++++++--
 migration/rdma.c      | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 0463f4c..977b9ae 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -253,8 +253,12 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
     if (f->hooks && f->hooks->save_page) {
         int ret = f->hooks->save_page(f, f->opaque, block_offset,
                                       offset, size, bytes_sent);
-        f->bytes_xfer += size;
-        if (ret != RAM_SAVE_CONTROL_DELAYED) {
+        if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
+            f->bytes_xfer += size;
+        }
+
+        if (ret != RAM_SAVE_CONTROL_DELAYED &&
+            ret != RAM_SAVE_CONTROL_NOT_SUPP) {
             if (bytes_sent && *bytes_sent > 0) {
                 qemu_update_position(f, *bytes_sent);
             } else if (ret < 0) {
diff --git a/migration/rdma.c b/migration/rdma.c
index da474fc..a22be43 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2927,6 +2927,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return RAM_SAVE_CONTROL_NOT_SUPP;
+    }
+
     qemu_fflush(f);
 
     if (size > 0) {
@@ -3482,6 +3486,10 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return 0;
+    }
+
     trace_qemu_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     qemu_fflush(f);
@@ -3504,6 +3512,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return 0;
+    }
+
     qemu_fflush(f);
     ret = qemu_rdma_drain_cq(f, rdma);
 
-- 
1.8.3.1
