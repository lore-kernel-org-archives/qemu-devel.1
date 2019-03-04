Received: from eggs.gnu.org ([209.51.188.92]:39972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h0hRw-0007WR-0l
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h0hRu-0003cN-1s
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:51:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:52781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h0hRr-0003YB-Uy
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 01:51:41 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon,  4 Mar 2019 14:51:02 +0800
Message-Id: <20190304065102.26447-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] exec.c: remove an unnecessary condition in
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
Cc: rth@twiddle.net, pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

flatview_add_to_dispatch() registers page based on the condition of
*section*, which may looks like this:

    |s|PPPPPPP|s|

where s stands for subpage and P for page.

The procedure of this function could be described as:

    - register first subpage
    - register page
    - register last subpage

This means only the first offset_within_address_space could be not
TARGET_PAGE_SIZE aligned. During the wile loop, this will not happen.

This patch just removes the unnecessary condition and adds some comment
to clarify it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 exec.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index 518064530b..e6221d52ba 100644
--- a/exec.c
+++ b/exec.c
@@ -1599,12 +1599,26 @@ static void register_multipage(FlatView *fv,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
+/*
+ * The range in *section* may look like this:
+ *
+ *      |s|PPPPPPP|s|
+ *
+ * where s stands for subpage and P for page.
+ *
+ * The procedure in following function could be described as:
+ *
+ * - register first subpage
+ * - register page
+ * - register last subpage
+ */
 void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
 {
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
 
     if (now.offset_within_address_space & ~TARGET_PAGE_MASK) {
+        /* register first subpage */
         uint64_t left = TARGET_PAGE_ALIGN(now.offset_within_address_space)
                        - now.offset_within_address_space;
 
@@ -1619,11 +1633,10 @@ void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
         remain.offset_within_region += int128_get64(now.size);
         now = remain;
         if (int128_lt(remain.size, page_size)) {
-            register_subpage(fv, &now);
-        } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
-            now.size = page_size;
+            /* register last subpage */
             register_subpage(fv, &now);
         } else {
+            /* register page */
             now.size = int128_and(now.size, int128_neg(page_size));
             register_multipage(fv, &now);
         }
-- 
2.19.1
