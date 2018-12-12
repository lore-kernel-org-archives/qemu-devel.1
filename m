Received: from eggs.gnu.org ([2001:4830:134:3::10]:52392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mc-0000tc-C2
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000HX-9T
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:54 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MY-0008Rd-HN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id m22so6399228wml.3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:31 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:31 +0100
Message-Id: <1544628195-37728-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/54] memory: update coalesced_range on
 transaction_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The e1000 driver calls memory_region_add_coalescing but
kvm_coalesce_mmio_region is never called for those regions.  The bug
dates back to the introduction of the memory region API; to fix it,
delete and re-add coalesced MMIO ranges when building the FlatViews.

Because coalesced MMIO regions apply to all address spaces, the
has_coalesced_range flag has to be changed into an int.

Fixes: 093bc2cd885e ("Hierarchical memory region API")
Reported-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index 072769a..5759f74 100644
--- a/memory.c
+++ b/memory.c
@@ -217,7 +217,7 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
-    bool has_coalesced_range;
+    int has_coalesced_range;
 };
 
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -651,7 +651,7 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode = mr->romd_mode;
     fr.readonly = readonly;
     fr.nonvolatile = nonvolatile;
-    fr.has_coalesced_range = false;
+    fr.has_coalesced_range = 0;
 
     /* Render the region itself into any gaps left by the current view. */
     for (i = 0; i < view->nr && int128_nz(remain); ++i) {
@@ -858,6 +858,10 @@ static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
         return;
     }
 
+    if (--fr->has_coalesced_range > 0) {
+        return;
+    }
+
     MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
                                   int128_get64(fr->addr.start),
                                   int128_get64(fr->addr.size));
@@ -873,7 +877,10 @@ static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
         return;
     }
 
-    fr->has_coalesced_range = true;
+    if (fr->has_coalesced_range++) {
+        return;
+    }
+
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
         tmp = addrrange_shift(cmr->addr,
                               int128_sub(fr->addr.start,
@@ -920,6 +927,7 @@ static void address_space_update_topology_pass(AddressSpace *as,
             /* In old but not in new, or in both but attributes changed. */
 
             if (!adding) {
+                flat_range_coalesced_io_del(frold, as);
                 MEMORY_LISTENER_UPDATE_REGION(frold, as, Reverse, region_del);
             }
 
@@ -927,7 +935,9 @@ static void address_space_update_topology_pass(AddressSpace *as,
         } else if (frold && frnew && flatrange_equal(frold, frnew)) {
             /* In both and unchanged (except logging may have changed) */
 
-            if (adding) {
+            if (!adding) {
+                flat_range_coalesced_io_del(frold, as);
+            } else {
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_nop);
                 if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
                     MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, log_start,
@@ -939,6 +949,7 @@ static void address_space_update_topology_pass(AddressSpace *as,
                                                   frold->dirty_log_mask,
                                                   frnew->dirty_log_mask);
                 }
+                flat_range_coalesced_io_add(frnew, as);
             }
 
             ++iold;
@@ -948,6 +959,7 @@ static void address_space_update_topology_pass(AddressSpace *as,
 
             if (adding) {
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_add);
+                flat_range_coalesced_io_add(frnew, as);
             }
 
             ++inew;
-- 
1.8.3.1
