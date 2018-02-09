Received: from eggs.gnu.org ([2001:4830:134:3::10]:35640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Br-0006Sy-WC
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006I7-Sv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006HU-Nx
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C74CB4022905
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 10:45:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Feb 2018 11:45:46 +0100
Message-Id: <20180209104546.29401-5-pbonzini@redhat.com>
In-Reply-To: <20180209104546.29401-1-pbonzini@redhat.com>
References: <20180209104546.29401-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] memory: unify loops to sync dirty log
 bitmap
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

Now that memory_region_sync_dirty_bitmap is NULL, we can unify its
loop with memory_global_dirty_log_sync's.  The only difference is
that memory_region_sync_dirty_bitmap will no longer call log_sync on
FlatRanges that do have a zero dirty_log_mask, but this is okay because
video memory is always registered with the dirty page logging mechanism.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/memory.c b/memory.c
index 74917a19eb..586de4556d 100644
--- a/memory.c
+++ b/memory.c
@@ -1990,7 +1990,7 @@ static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
         as = listener->address_space;
         view = address_space_get_flatview(as);
         FOR_EACH_FLAT_RANGE(fr, view) {
-            if (fr->mr == mr) {
+            if (fr->dirty_log_mask && (!mr || fr->mr == mr)) {
                 MemoryRegionSection mrs = section_from_flat_range(fr, view);
                 listener->log_sync(listener, &mrs);
             }
@@ -2509,26 +2509,7 @@ bool memory_region_present(MemoryRegion *container, hwaddr addr)
 
 void memory_global_dirty_log_sync(void)
 {
-    MemoryListener *listener;
-    AddressSpace *as;
-    FlatView *view;
-    FlatRange *fr;
-
-    QTAILQ_FOREACH(listener, &memory_listeners, link) {
-        if (!listener->log_sync) {
-            continue;
-        }
-        as = listener->address_space;
-        view = address_space_get_flatview(as);
-        FOR_EACH_FLAT_RANGE(fr, view) {
-            if (fr->dirty_log_mask) {
-                MemoryRegionSection mrs = section_from_flat_range(fr, view);
-
-                listener->log_sync(listener, &mrs);
-            }
-        }
-        flatview_unref(view);
-    }
+    memory_region_sync_dirty_bitmap(NULL);
 }
 
 void memory_global_after_dirty_log_sync(void)
-- 
2.14.3
