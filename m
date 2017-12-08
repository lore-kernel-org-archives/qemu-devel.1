Received: from eggs.gnu.org ([2001:4830:134:3::10]:50102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNPKW-0002JD-Sc
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNPKU-0001K8-PH
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eNPKU-0001Jq-IL
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:33:06 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Dec 2017 20:32:50 +0000
Message-Id: <20171208203257.13102-2-dgilbert@redhat.com>
In-Reply-To: <20171208203257.13102-1-dgilbert@redhat.com>
References: <20171208203257.13102-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 1/8] memory: address_space_iterate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Iterate through an address space calling a function for each
section.  The iteration is done in order.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/exec/memory.h | 23 +++++++++++++++++++++++
 memory.c              | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042f87..f5a9df642e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1987,6 +1987,29 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
     address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
+/**
+ * ASIterateCallback: Function type called by address_space_iterate
+ *
+ * Return 0 on success or a negative error code.
+ *
+ * @mrs: Memory region section for this range
+ * @opaque: The opaque value passed in to the iterator.
+ */
+typedef int (*ASIterateCallback)(MemoryRegionSection *mrs, void *opaque);
+
+/**
+ * address_space_iterate: Call the function for each address range in the
+ *                        AddressSpace, in sorted order.
+ *
+ * Return 0 on success or a negative error code.
+ *
+ * @as: Address space to iterate over
+ * @cb: Function to call.  If the function returns none-0 the iteration will
+ *     stop.
+ * @opaque: Value to pass to the function
+ */
+int
+address_space_iterate(AddressSpace *as, ASIterateCallback cb, void *opaque);
 #endif
 
 #endif
diff --git a/memory.c b/memory.c
index e26e5a3b1d..f45137f25e 100644
--- a/memory.c
+++ b/memory.c
@@ -2810,6 +2810,28 @@ void address_space_destroy(AddressSpace *as)
     call_rcu(as, do_address_space_destroy, rcu);
 }
 
+int address_space_iterate(AddressSpace *as, ASIterateCallback cb,
+                          void *opaque)
+{
+    int res = 0;
+    FlatView *fv = address_space_to_flatview(as);
+    FlatRange *range;
+
+    flatview_ref(fv);
+
+    FOR_EACH_FLAT_RANGE(range, fv) {
+        MemoryRegionSection mrs = section_from_flat_range(range, fv);
+        res = cb(&mrs, opaque);
+        if (res) {
+            break;
+        }
+    }
+
+    flatview_unref(fv);
+
+    return res;
+}
+
 static const char *memory_region_type(MemoryRegion *mr)
 {
     if (memory_region_is_ram_device(mr)) {
-- 
2.14.3
