Received: from eggs.gnu.org ([2001:4830:134:3::10]:57581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQVlQ-0002Aa-8x
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQVlM-0001XO-D5
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:28 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:43360
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dQVlM-0001Wp-6P
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:29:24 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu, 29 Jun 2017 11:28:51 +0200
Message-Id: <1498728533-23160-2-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH v1 1/3] add
 memory_region_get_offset_within_address_space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com, alistair@alistair23.me, frederic.konrad@adacore.com

This is helpful in the next patch to know if a rom is pointed by an alias.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 include/exec/memory.h | 10 ++++++++++
 memory.c              | 22 ++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8503685..e342412 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1270,6 +1270,16 @@ void memory_region_set_size(MemoryRegion *mr, uint64_t size);
 void memory_region_set_alias_offset(MemoryRegion *mr,
                                     hwaddr offset);
 
+/*
+ * memory_region_get_offset_within_address_space: get the offset of a region
+ *
+ * Returns the offset of a region within its address space. @mr must be mapped
+ * to an #AddressSpace.
+ *
+ * @mr: the #MemoryRegion to check.
+ */
+hwaddr memory_region_get_offset_within_address_space(MemoryRegion *mr);
+
 /**
  * memory_region_present: checks if an address relative to a @container
  * translates into #MemoryRegion within @container
diff --git a/memory.c b/memory.c
index 1044bba..2b7439b 100644
--- a/memory.c
+++ b/memory.c
@@ -598,11 +598,18 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     return r;
 }
 
-static AddressSpace *memory_region_to_address_space(MemoryRegion *mr)
+static AddressSpace *memory_region_to_address_space(MemoryRegion *mr,
+                                                    hwaddr *offset)
 {
     AddressSpace *as;
 
+    if (offset) {
+        *offset = 0;
+    }
     while (mr->container) {
+        if (offset) {
+            *offset += mr->addr;
+        }
         mr = mr->container;
     }
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
@@ -613,6 +620,17 @@ static AddressSpace *memory_region_to_address_space(MemoryRegion *mr)
     return NULL;
 }
 
+hwaddr memory_region_get_offset_within_address_space(MemoryRegion *mr)
+{
+    hwaddr offset;
+    AddressSpace *as;
+
+    as = memory_region_to_address_space(mr, &offset);
+    assert(as);
+
+    return offset;
+}
+
 /* Render a memory region into the global view.  Ranges in @view obscure
  * ranges in @mr.
  */
@@ -2251,7 +2269,7 @@ static MemoryRegionSection memory_region_find_rcu(MemoryRegion *mr,
         addr += root->addr;
     }
 
-    as = memory_region_to_address_space(root);
+    as = memory_region_to_address_space(root, NULL);
     if (!as) {
         return ret;
     }
-- 
1.8.3.1
