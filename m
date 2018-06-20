Received: from eggs.gnu.org ([2001:4830:134:3::10]:35837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVjhf-0001Hk-7l
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVjhc-0004RD-4I
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:27:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fVjhb-0004R3-UO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:27:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DC01406C792
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 20:27:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Wed, 20 Jun 2018 22:27:36 +0200
Message-Id: <20180620202736.21399-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2] postcopy: drop ram_pages parameter from
 postcopy_ram_incoming_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

Not needed. Don't expose last_ram_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Make "last_ram_page" static

 exec.c                   | 2 +-
 include/exec/ram_addr.h  | 1 -
 migration/postcopy-ram.c | 4 ++--
 migration/postcopy-ram.h | 2 +-
 migration/ram.c          | 4 +---
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index 9f4706db19..cc1c102d95 100644
--- a/exec.c
+++ b/exec.c
@@ -1940,7 +1940,7 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
     return offset;
 }
 
-unsigned long last_ram_page(void)
+static unsigned long last_ram_page(void)
 {
     RAMBlock *block;
     ram_addr_t last = 0;
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9295c01a89..d6687690fb 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -71,7 +71,6 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 }
 
 long qemu_getrampagesize(void);
-unsigned long last_ram_page(void);
 RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    bool share, const char *mem_path,
                                    Error **errp);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 48e51556a7..932f188949 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -500,7 +500,7 @@ static int cleanup_range(const char *block_name, void *host_addr,
  * postcopy later; must be called prior to any precopy.
  * called from arch_init's similarly named ram_postcopy_incoming_init
  */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages)
+int postcopy_ram_incoming_init(MigrationIncomingState *mis)
 {
     if (qemu_ram_foreach_migratable_block(init_range, NULL)) {
         return -1;
@@ -1265,7 +1265,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
     return false;
 }
 
-int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages)
+int postcopy_ram_incoming_init(MigrationIncomingState *mis)
 {
     error_report("postcopy_ram_incoming_init: No OS support");
     return -1;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index d900d9c34f..9d55536fd1 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -27,7 +27,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis);
  * postcopy later; must be called prior to any precopy.
  * called from ram.c's similarly named ram_postcopy_incoming_init
  */
-int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages);
+int postcopy_ram_incoming_init(MigrationIncomingState *mis);
 
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
diff --git a/migration/ram.c b/migration/ram.c
index cd5f55117d..8de7ab683e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3107,9 +3107,7 @@ static int ram_load_cleanup(void *opaque)
  */
 int ram_postcopy_incoming_init(MigrationIncomingState *mis)
 {
-    unsigned long ram_pages = last_ram_page();
-
-    return postcopy_ram_incoming_init(mis, ram_pages);
+    return postcopy_ram_incoming_init(mis);
 }
 
 /**
-- 
2.17.1
