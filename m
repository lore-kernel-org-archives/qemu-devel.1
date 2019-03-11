Received: from eggs.gnu.org ([209.51.188.92]:60968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODm-0007J5-PE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODk-0003fr-Ri
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:14 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODj-0003b5-5V
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:12 -0400
Received: by mail-wr1-x42d.google.com with SMTP id t18so5945364wrx.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:32 +0100
Message-Id: <1552323335-46779-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 28/31] exec.c: refactor function
 flatview_add_to_dispatch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wei Yang <richardw.yang@linux.intel.com>

From: Wei Yang <richardw.yang@linux.intel.com>

flatview_add_to_dispatch() registers page based on the condition of
*section*, which may looks like this:

    |s|PPPPPPP|s|

where s stands for subpage and P for page.

The procedure of this function could be described as:

    - register first subpage
    - register page
    - register last subpage

This means the procedure could be simplified into these three steps
instead of a loop iteration.

This patch refactors the function into three corresponding steps and
adds some comment to clarify it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190311054252.6094-1-richardw.yang@linux.intel.com>
[Paolo: move exit before adjustment of remain.offset_within_*,
 otherwise int128_get64 fails when a region is 2^64 bytes long]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/exec.c b/exec.c
index 1d4f378..86a38d3 100644
--- a/exec.c
+++ b/exec.c
@@ -1599,35 +1599,49 @@ static void register_multipage(FlatView *fv,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
+/*
+ * The range in *section* may look like this:
+ *
+ *      |s|PPPPPPP|s|
+ *
+ * where s stands for subpage and P for page.
+ */
 void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
 {
-    MemoryRegionSection now = *section, remain = *section;
+    MemoryRegionSection remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
 
-    if (now.offset_within_address_space & ~TARGET_PAGE_MASK) {
-        uint64_t left = TARGET_PAGE_ALIGN(now.offset_within_address_space)
-                       - now.offset_within_address_space;
+    /* register first subpage */
+    if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
+        uint64_t left = TARGET_PAGE_ALIGN(remain.offset_within_address_space)
+                        - remain.offset_within_address_space;
 
+        MemoryRegionSection now = remain;
         now.size = int128_min(int128_make64(left), now.size);
         register_subpage(fv, &now);
-    } else {
-        now.size = int128_zero();
-    }
-    while (int128_ne(remain.size, now.size)) {
+        if (int128_eq(remain.size, now.size)) {
+            return;
+        }
         remain.size = int128_sub(remain.size, now.size);
         remain.offset_within_address_space += int128_get64(now.size);
         remain.offset_within_region += int128_get64(now.size);
-        now = remain;
-        if (int128_lt(remain.size, page_size)) {
-            register_subpage(fv, &now);
-        } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
-            now.size = page_size;
-            register_subpage(fv, &now);
-        } else {
-            now.size = int128_and(now.size, int128_neg(page_size));
-            register_multipage(fv, &now);
+    }
+
+    /* register whole pages */
+    if (int128_ge(remain.size, page_size)) {
+        MemoryRegionSection now = remain;
+        now.size = int128_and(now.size, int128_neg(page_size));
+        register_multipage(fv, &now);
+        if (int128_eq(remain.size, now.size)) {
+            return;
         }
+        remain.size = int128_sub(remain.size, now.size);
+        remain.offset_within_address_space += int128_get64(now.size);
+        remain.offset_within_region += int128_get64(now.size);
     }
+
+    /* register last subpage */
+    register_subpage(fv, &remain);
 }
 
 void qemu_flush_coalesced_mmio_buffer(void)
-- 
1.8.3.1
