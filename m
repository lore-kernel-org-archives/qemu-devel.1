Received: from eggs.gnu.org ([2001:4830:134:3::10]:44867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBb-0001xQ-3g
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBa-0007Mq-9f
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XBa-0007Mb-3j
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:57:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02836C04BD42
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:57:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:55:59 +0200
Message-Id: <20170421115646.15544-19-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 18/65] ram: Remove norm_mig_bytes_transferred
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Its value can be calculated by other exported.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h | 1 -
 migration/migration.c         | 3 ++-
 migration/ram.c               | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index bd0b60b..87d0cc5 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -277,7 +277,6 @@ void free_xbzrle_decoded_buf(void);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
 
 uint64_t dup_mig_pages_transferred(void);
-uint64_t norm_mig_bytes_transferred(void);
 uint64_t norm_mig_pages_transferred(void);
 uint64_t xbzrle_mig_bytes_transferred(void);
 uint64_t xbzrle_mig_pages_transferred(void);
diff --git a/migration/migration.c b/migration/migration.c
index 34c1a83..7f7bab9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -654,7 +654,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     /* legacy value.  It is not used anymore */
     info->ram->skipped = 0;
     info->ram->normal = norm_mig_pages_transferred();
-    info->ram->normal_bytes = norm_mig_bytes_transferred();
+    info->ram->normal_bytes = norm_mig_pages_transferred() *
+        (1ul << qemu_target_page_bits());
     info->ram->mbps = s->mbps;
     info->ram->dirty_sync_count = s->dirty_sync_count;
     info->ram->postcopy_requests = s->postcopy_requests;
diff --git a/migration/ram.c b/migration/ram.c
index 587e2c7..85d66ea 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -197,11 +197,6 @@ uint64_t dup_mig_pages_transferred(void)
     return ram_state.zero_pages;
 }
 
-uint64_t norm_mig_bytes_transferred(void)
-{
-    return ram_state.norm_pages * TARGET_PAGE_SIZE;
-}
-
 uint64_t norm_mig_pages_transferred(void)
 {
     return ram_state.norm_pages;
-- 
2.9.3
