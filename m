Received: from eggs.gnu.org ([2001:4830:134:3::10]:42191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI3-0004hC-St
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI1-0007uA-M1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:27 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:55801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZI1-0007tw-Ff
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:25 -0500
Received: by mail-wm0-x242.google.com with SMTP id a84so4246836wmi.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:25 -0800 (PST)
Received: from 640k.lan ([82.84.102.245])
	by smtp.gmail.com with ESMTPSA id f9sm6870298wmf.12.2018.02.13.04.02.23
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Feb 2018 04:02:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:51 +0100
Message-Id: <1518523252-49106-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/48] memory: unify loops to sync dirty log
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
index 8ed809c..c7f6588 100644
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
@@ -2506,26 +2506,7 @@ bool memory_region_present(MemoryRegion *container, hwaddr addr)
 
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
 
 static VMChangeStateEntry *vmstate_change;
-- 
1.8.3.1
