Received: from eggs.gnu.org ([2001:4830:134:3::10]:53641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9KA-0007L0-2V
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9K6-0003ME-92
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9K6-0003Lf-2q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:42 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DB183B731
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:50:01 +0100
Message-Id: <20170315135021.6978-12-quintela@redhat.com>
In-Reply-To: <20170315135021.6978-1-quintela@redhat.com>
References: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/31] ram: Remove unused pages_skiped variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

For compatibility, we need to still send a value, but just specify it
and comment the fact.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  2 --
 migration/migration.c         |  3 ++-
 migration/ram.c               | 11 -----------
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 3e6bb68..9c83951 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -277,8 +277,6 @@ void free_xbzrle_decoded_buf(void);
 void acct_update_position(QEMUFile *f, size_t size, bool zero);
 
 uint64_t dup_mig_pages_transferred(void);
-uint64_t skipped_mig_bytes_transferred(void);
-uint64_t skipped_mig_pages_transferred(void);
 uint64_t norm_mig_bytes_transferred(void);
 uint64_t norm_mig_pages_transferred(void);
 uint64_t xbzrle_mig_bytes_transferred(void);
diff --git a/migration/migration.c b/migration/migration.c
index 3dab684..c3e1b95 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -639,7 +639,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->transferred = ram_bytes_transferred();
     info->ram->total = ram_bytes_total();
     info->ram->duplicate = dup_mig_pages_transferred();
-    info->ram->skipped = skipped_mig_pages_transferred();
+    /* legacy value.  It is not used anymore */
+    info->ram->skipped = 0;
     info->ram->normal = norm_mig_pages_transferred();
     info->ram->normal_bytes = norm_mig_bytes_transferred();
     info->ram->mbps = s->mbps;
diff --git a/migration/ram.c b/migration/ram.c
index 83fe20a..468f042 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -169,7 +169,6 @@ static RAMState ram_state;
 
 /* accounting for migration statistics */
 typedef struct AccountingInfo {
-    uint64_t skipped_pages;
     uint64_t norm_pages;
     uint64_t iterations;
     uint64_t xbzrle_bytes;
@@ -191,16 +190,6 @@ uint64_t dup_mig_pages_transferred(void)
     return ram_state.zero_pages;
 }
 
-uint64_t skipped_mig_bytes_transferred(void)
-{
-    return acct_info.skipped_pages * TARGET_PAGE_SIZE;
-}
-
-uint64_t skipped_mig_pages_transferred(void)
-{
-    return acct_info.skipped_pages;
-}
-
 uint64_t norm_mig_bytes_transferred(void)
 {
     return acct_info.norm_pages * TARGET_PAGE_SIZE;
-- 
2.9.3
