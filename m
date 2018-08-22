Received: from eggs.gnu.org ([2001:4830:134:3::10]:38932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpB-0006hs-Ih
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRp5-0008Me-97
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRp0-0008HZ-FG
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:13 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:35 +0200
Message-Id: <20180822120050.12694-6-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 05/20] migration: disable RDMA WRITE after
 postcopy started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

RDMA WRITE operations are performed with no notification to the destination
qemu, then the destination qemu can not wakeup. This patch disable RDMA WRITE
after postcopy started.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c |  8 ++++++--
 migration/rdma.c      | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 0463f4c321..977b9ae07c 100644
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
index 8bd7159059..76424a5e38 100644
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
2.17.1
