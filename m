Received: from eggs.gnu.org ([2001:4830:134:3::10]:35642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Bs-0006Sz-05
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006I4-Sw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:46:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006HV-Mp
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31224407604F
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 10:45:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Feb 2018 11:45:43 +0100
Message-Id: <20180209104546.29401-2-pbonzini@redhat.com>
In-Reply-To: <20180209104546.29401-1-pbonzini@redhat.com>
References: <20180209104546.29401-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] memory: remove
 memory_region_test_and_clear_dirty
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

It is unused after g364fb has been converted to use DirtyBitmapSnapshot.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 24 +++---------------------
 memory.c              |  8 --------
 2 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 783ef64570..6779d14a7b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1090,33 +1090,15 @@ bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
 void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size);
 
-/**
- * memory_region_test_and_clear_dirty: Check whether a range of bytes is dirty
- *                                     for a specified client. It clears them.
- *
- * Checks whether a range of bytes has been written to since the last
- * call to memory_region_reset_dirty() with the same @client.  Dirty logging
- * must be enabled.
- *
- * @mr: the memory region being queried.
- * @addr: the address (relative to the start of the region) being queried.
- * @size: the size of the range being queried.
- * @client: the user of the logging information; %DIRTY_MEMORY_MIGRATION or
- *          %DIRTY_MEMORY_VGA.
- */
-bool memory_region_test_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
-                                        hwaddr size, unsigned client);
-
 /**
  * memory_region_snapshot_and_clear_dirty: Get a snapshot of the dirty
  *                                         bitmap and clear it.
  *
  * Creates a snapshot of the dirty bitmap, clears the dirty bitmap and
  * returns the snapshot.  The snapshot can then be used to query dirty
- * status, using memory_region_snapshot_get_dirty.  Unlike
- * memory_region_test_and_clear_dirty this allows to query the same
- * page multiple times, which is especially useful for display updates
- * where the scanlines often are not page aligned.
+ * status, using memory_region_snapshot_get_dirty.  Snapshotting allows
+ * querying the same page multiple times, which is especially useful for
+ * display updates where the scanlines often are not page aligned.
  *
  * The dirty bitmap region which gets copyed into the snapshot (and
  * cleared afterwards) can be larger than requested.  The boundaries
diff --git a/memory.c b/memory.c
index 93258a6655..9e75bb9526 100644
--- a/memory.c
+++ b/memory.c
@@ -1971,14 +1971,6 @@ void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                                         memory_region_get_dirty_log_mask(mr));
 }
 
-bool memory_region_test_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
-                                        hwaddr size, unsigned client)
-{
-    assert(mr->ram_block);
-    return cpu_physical_memory_test_and_clear_dirty(
-                memory_region_get_ram_addr(mr) + addr, size, client);
-}
-
 DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
                                                             hwaddr addr,
                                                             hwaddr size,
-- 
2.14.3
