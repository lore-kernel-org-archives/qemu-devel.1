Received: from eggs.gnu.org ([2001:4830:134:3::10]:52089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MR-0000hF-3o
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MO-00007Y-I8
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:42 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MK-0008OL-Op
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:38 -0500
Received: by mail-wm1-x32d.google.com with SMTP id y139so6132306wmc.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:29 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:29 +0100
Message-Id: <1544628195-37728-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/54] memory: extract
 flat_range_coalesced_io_{del, add}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Extract two new functions from memory_region_update_coalesced_range_as.
To avoid duplication in the creation of the MemoryRegionSection, use
MEMORY_LISTENER_UPDATE_REGION instead of MEMORY_LISTENER_CALL
to invoke the listener callback.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/memory.c b/memory.c
index d14c6de..119b6e4 100644
--- a/memory.c
+++ b/memory.c
@@ -850,6 +850,33 @@ static void address_space_update_ioeventfds(AddressSpace *as)
     flatview_unref(view);
 }
 
+static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
+{
+    MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
+                                  int128_get64(fr->addr.start),
+                                  int128_get64(fr->addr.size));
+}
+
+static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
+{
+    MemoryRegion *mr = fr->mr;
+    CoalescedMemoryRange *cmr;
+    AddrRange tmp;
+
+    QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
+        tmp = addrrange_shift(cmr->addr,
+                              int128_sub(fr->addr.start,
+                                         int128_make64(fr->offset_in_region)));
+        if (!addrrange_intersects(tmp, fr->addr)) {
+            continue;
+        }
+        tmp = addrrange_intersection(tmp, fr->addr);
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, coalesced_io_add,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    }
+}
+
 static void address_space_update_topology_pass(AddressSpace *as,
                                                const FlatView *old_view,
                                                const FlatView *new_view,
@@ -2136,34 +2163,12 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
 {
     FlatView *view;
     FlatRange *fr;
-    CoalescedMemoryRange *cmr;
-    AddrRange tmp;
-    MemoryRegionSection section;
 
     view = address_space_get_flatview(as);
     FOR_EACH_FLAT_RANGE(fr, view) {
         if (fr->mr == mr) {
-            section = (MemoryRegionSection) {
-                .fv = view,
-                .offset_within_address_space = int128_get64(fr->addr.start),
-                .size = fr->addr.size,
-            };
-
-            MEMORY_LISTENER_CALL(as, coalesced_io_del, Reverse, &section,
-                                 int128_get64(fr->addr.start),
-                                 int128_get64(fr->addr.size));
-            QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
-                tmp = addrrange_shift(cmr->addr,
-                                      int128_sub(fr->addr.start,
-                                                 int128_make64(fr->offset_in_region)));
-                if (!addrrange_intersects(tmp, fr->addr)) {
-                    continue;
-                }
-                tmp = addrrange_intersection(tmp, fr->addr);
-                MEMORY_LISTENER_CALL(as, coalesced_io_add, Forward, &section,
-                                     int128_get64(tmp.start),
-                                     int128_get64(tmp.size));
-            }
+            flat_range_coalesced_io_del(fr, as);
+            flat_range_coalesced_io_add(fr, as);
         }
     }
     flatview_unref(view);
-- 
1.8.3.1
