Received: from eggs.gnu.org ([2001:4830:134:3::10]:37042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g9sX1-0005of-OE
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g9sWx-0007UB-OW
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g9sWx-0007Qb-D4
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 307CA315009E
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 13:58:32 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  9 Oct 2018 15:50:25 +0200
Message-Id: <1539093025-101599-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] memory: move MemoryRegion::size cleanup to
 memory_region_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, pbonzini@redhat.com

It's not necessary to clean up MemoryRegion::size manually in multiple places
like it's been implemented in
 (1cd3d49262 "memory: cleanup side effects of  memory_region_init_foo() on failure")
since each memory_region_init_foo() now calls object_unparent(mr) on failure,
memory region destructor memory_region_finalize() will be called upon its
completion for each memory_region_init_foo().
It's sufficient to clean MemoryRegion::size only from memory_region_finalize(),
so do it.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
smoke tested with reproducer from 1cd3d49262, thing still works as expected
---
 memory.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/memory.c b/memory.c
index d852f11..ad24b57 100644
--- a/memory.c
+++ b/memory.c
@@ -1491,7 +1491,6 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
     mr->ram_block = qemu_ram_alloc(size, share, mr, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
-        mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
     }
@@ -1516,7 +1515,6 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
                                               mr, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
-        mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
     }
@@ -1541,7 +1539,6 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
-        mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
     }
@@ -1565,7 +1562,6 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
                                            fd, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
-        mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
     }
@@ -1628,7 +1624,6 @@ void memory_region_init_rom_nomigrate(MemoryRegion *mr,
     mr->ram_block = qemu_ram_alloc(size, false, mr, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
-        mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
     }
@@ -1652,7 +1647,6 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc(size, false,  mr, &err);
     if (err) {
-        mr->size = int128_zero();
         object_unparent(OBJECT(mr));
         error_propagate(errp, err);
     }
@@ -1701,6 +1695,7 @@ static void memory_region_finalize(Object *obj)
     memory_region_clear_coalescing(mr);
     g_free((char *)mr->name);
     g_free(mr->ioeventfds);
+    mr->size = int128_zero();
 }
 
 Object *memory_region_owner(MemoryRegion *mr)
-- 
2.7.4
