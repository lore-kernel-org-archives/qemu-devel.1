Received: from eggs.gnu.org ([2001:4830:134:3::10]:39884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dYiYW-0007FM-Uj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dYiYW-0001fu-5T
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dYiYV-0001cu-VT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:46:04 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri, 21 Jul 2017 17:46:00 -0700
Message-Id: <1500684361-20532-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1707211740220.22381@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1707211740220.22381@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL for-2.10 1/2] xen: fix compilation on 32-bit
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Igor Druzhinin <igor.druzhinin@citrix.com>

From: Igor Druzhinin <igor.druzhinin@citrix.com>

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen-mapcache.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 2a1fbd1..bb1078c 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -527,7 +527,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
         entry = entry->next;
     }
     if (!entry) {
-        DPRINTF("Trying to update an entry for %lx " \
+        DPRINTF("Trying to update an entry for "TARGET_FMT_plx \
                 "that is not in the mapcache!\n", old_phys_addr);
         return NULL;
     }
@@ -535,15 +535,16 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
     address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
     address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
 
-    fprintf(stderr, "Replacing a dummy mapcache entry for %lx with %lx\n",
-            old_phys_addr, new_phys_addr);
+    fprintf(stderr, "Replacing a dummy mapcache entry for "TARGET_FMT_plx \
+            " with "TARGET_FMT_plx"\n", old_phys_addr, new_phys_addr);
 
     xen_remap_bucket(entry, entry->vaddr_base,
                      cache_size, address_index, false);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
-        DPRINTF("Unable to update a mapcache entry for %lx!\n", old_phys_addr);
+        DPRINTF("Unable to update a mapcache entry for "TARGET_FMT_plx"!\n",
+                old_phys_addr);
         return NULL;
     }
 
-- 
1.9.1
