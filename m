Received: from eggs.gnu.org ([2001:4830:134:3::10]:52689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flW9q-0001O0-S1
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flW9p-0001BI-0m
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:02 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:42315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1flW9o-0001AO-PD
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id y4-v6so2562664pgp.9
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 02:14:00 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Fri,  3 Aug 2018 17:13:39 +0800
Message-Id: <1533287630-4221-2-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
References: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v6 01/12] migration: disable RDMA WRITE after
 postcopy started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

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
index 8bd7159..76424a5 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2921,6 +2921,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return RAM_SAVE_CONTROL_NOT_SUPP;
+    }
+
     qemu_fflush(f);
 
     if (size > 0) {
@@ -3480,6 +3484,10 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return 0;
+    }
+
     trace_qemu_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     qemu_fflush(f);
@@ -3502,6 +3510,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
 
     CHECK_ERROR_STATE();
 
+    if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        return 0;
+    }
+
     qemu_fflush(f);
     ret = qemu_rdma_drain_cq(f, rdma);
 
-- 
1.8.3.1
