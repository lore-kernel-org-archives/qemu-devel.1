Received: from eggs.gnu.org ([2001:4830:134:3::10]:42145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI0-0004dQ-GV
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHz-0007tJ-JG
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:24 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHz-0007sv-CL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:23 -0500
Received: by mail-wr0-x243.google.com with SMTP id t94so18347922wrc.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:23 -0800 (PST)
Received: from 640k.lan ([82.84.102.245])
	by smtp.gmail.com with ESMTPSA id f9sm6870298wmf.12.2018.02.13.04.02.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Feb 2018 04:02:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:49 +0100
Message-Id: <1518523252-49106-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/48] memory: remove
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

It is unused after g364fb has been converted to use DirtyBitmapSnapshot.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 24 +++---------------------
 memory.c              |  8 --------
 2 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 783ef64..6779d14 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1091,32 +1091,14 @@ void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size);
 
 /**
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
-/**
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
index 93258a6..9e75bb9 100644
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
1.8.3.1
