Received: from eggs.gnu.org ([209.51.188.92]:58769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKZ-0003oL-C4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKX-00045e-TB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:27 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:34 +0200
Message-Id: <20190425132134.2839-20-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 19/19] exec: Introduce qemu_maxrampagesize() and
 rename qemu_getrampagesize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Rename qemu_getrampagesize() to qemu_minrampagesize(). While at it,
properly rename find_max_supported_pagesize() to
find_min_backend_pagesize().

s390x is actually interested into the maximum ram pagesize, so
introduce and use qemu_maxrampagesize().

Add a TODO, indicating that looking at any mapped memory backends is not
100% correct in some cases.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190417113143.5551-3-david@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 exec.c                     | 44 ++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr_caps.c        |  4 ++--
 hw/s390x/s390-virtio-ccw.c |  2 +-
 hw/vfio/spapr.c            |  2 +-
 include/exec/ram_addr.h    |  3 ++-
 target/ppc/kvm.c           |  2 +-
 6 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/exec.c b/exec.c
index 2646207661d4..bb1dff423aaf 100644
--- a/exec.c
+++ b/exec.c
@@ -1688,7 +1688,7 @@ void ram_block_dump(Monitor *mon)
  * when we actually open and map them.  Iterate over the file
  * descriptors instead, and use qemu_fd_getpagesize().
  */
-static int find_max_supported_pagesize(Object *obj, void *opaque)
+static int find_min_backend_pagesize(Object *obj, void *opaque)
 {
     long *hpsize_min = opaque;
 
@@ -1704,7 +1704,27 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
     return 0;
 }
 
-long qemu_getrampagesize(void)
+static int find_max_backend_pagesize(Object *obj, void *opaque)
+{
+    long *hpsize_max = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
+        HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+        long hpsize = host_memory_backend_pagesize(backend);
+
+        if (host_memory_backend_is_mapped(backend) && (hpsize > *hpsize_max)) {
+            *hpsize_max = hpsize;
+        }
+    }
+
+    return 0;
+}
+
+/*
+ * TODO: We assume right now that all mapped host memory backends are
+ * used as RAM, however some might be used for different purposes.
+ */
+long qemu_minrampagesize(void)
 {
     long hpsize = LONG_MAX;
     long mainrampagesize;
@@ -1724,7 +1744,7 @@ long qemu_getrampagesize(void)
      */
     memdev_root = object_resolve_path("/objects", NULL);
     if (memdev_root) {
-        object_child_foreach(memdev_root, find_max_supported_pagesize, &hpsize);
+        object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsize);
     }
     if (hpsize == LONG_MAX) {
         /* No additional memory regions found ==> Report main RAM page size */
@@ -1747,8 +1767,24 @@ long qemu_getrampagesize(void)
 
     return hpsize;
 }
+
+long qemu_maxrampagesize(void)
+{
+    long pagesize = qemu_mempath_getpagesize(mem_path);
+    Object *memdev_root = object_resolve_path("/objects", NULL);
+
+    if (memdev_root) {
+        object_child_foreach(memdev_root, find_max_backend_pagesize,
+                             &pagesize);
+    }
+    return pagesize;
+}
 #else
-long qemu_getrampagesize(void)
+long qemu_minrampagesize(void)
+{
+    return getpagesize();
+}
+long qemu_maxrampagesize(void)
 {
     return getpagesize();
 }
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index edc5ed0e0c4e..9b1c10baa6c5 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -347,7 +347,7 @@ static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
         warn_report("Many guests require at least 64kiB hpt-max-page-size");
     }
 
-    spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
+    spapr_check_pagesize(spapr, qemu_minrampagesize(), errp);
 }
 
 static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
@@ -609,7 +609,7 @@ static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
         uint8_t mps;
 
         if (kvmppc_hpt_needs_host_contiguous_pages()) {
-            mps = ctz64(qemu_getrampagesize());
+            mps = ctz64(qemu_minrampagesize());
         } else {
             mps = 34; /* allow everything up to 16GiB, i.e. everything */
         }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3be567965736..7e256d3d31b8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -188,7 +188,7 @@ static void s390_memory_init(ram_addr_t mem_size)
      * Configure the maximum page size. As no memory devices were created
      * yet, this is the page size of initial memory only.
      */
-    s390_set_max_pagesize(qemu_getrampagesize(), &local_err);
+    s390_set_max_pagesize(qemu_maxrampagesize(), &local_err);
     if (local_err) {
         error_report_err(local_err);
         exit(EXIT_FAILURE);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 57fe758e5441..96c0ad9d9b7e 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -148,7 +148,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
     unsigned entries, bits_total, bits_per_level, max_levels;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
-    long rampagesize = qemu_getrampagesize();
+    long rampagesize = qemu_minrampagesize();
 
     /*
      * The host might not support the guest supported IOMMU page size,
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9ecd911c3e78..139ad79390fa 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -73,7 +73,8 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 
 bool ramblock_is_pmem(RAMBlock *rb);
 
-long qemu_getrampagesize(void);
+long qemu_minrampagesize(void);
+long qemu_maxrampagesize(void);
 
 /**
  * qemu_ram_alloc_from_file,
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2427c8ee13ae..59d92c42751e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2136,7 +2136,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
     /* Find the largest hardware supported page size that's less than
      * or equal to the (logical) backing page size of guest RAM */
     kvm_get_smmu_info(&info, &error_fatal);
-    rampagesize = qemu_getrampagesize();
+    rampagesize = qemu_minrampagesize();
     best_page_shift = 0;
 
     for (i = 0; i < KVM_PPC_PAGE_SIZES_MAX_SZ; i++) {
-- 
2.17.2
