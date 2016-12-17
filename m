Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUX-0007ei-Eo
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUW-0008Ap-9b
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUW-0007ss-0c
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:24 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:25 +0800
Message-Id: <1481971427-11094-16-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 15/37] vhost-pci-slave/msg:
 VHOST_USER_SET_MEM_TABLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

Map the peer memory in QEMU, and prepare the memory for the guest using
MemoryRegion. The controlq message of the memory info is constructed
here, and it will be sent to the guest when the guest controlq is ready. With the
the peer memory info reveived in the message, the guest will be able to
translate any peer guest physical address to its own guest physical
address.

Also add a cleanup function to free the related memory that has been
set up.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c                    | 91 +++++++++++++++++++++++++-
 include/hw/virtio/vhost-pci-slave.h            |  9 +++
 include/standard-headers/linux/vhost_pci_net.h | 11 ++++
 3 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 9b854b1..5170ab5 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -26,6 +26,20 @@
 
 VhostPCISlave *vp_slave;
 
+static void vp_slave_cleanup(void)
+{
+    int ret;
+    uint32_t i, nregions;
+
+    nregions = vp_slave->pmem_msg.nregions;
+    for (i = 0; i < nregions; i++) {
+        ret = munmap(vp_slave->mr_map_base[i], vp_slave->mr_map_size[i]);
+        if (ret < 0)
+            error_report("cleanup: failed to unmap mr");
+        memory_region_del_subregion(vp_slave->bar_mr, vp_slave->sub_mr+i);
+    }
+}
+
 static int vp_slave_write(CharBackend *chr_be, VhostUserMsg *msg)
 {
     int size;
@@ -107,6 +121,72 @@ static int vp_slave_get_queue_num(CharBackend *chr_be, VhostUserMsg *msg)
     return vp_slave_write(chr_be, msg);
 }
 
+static uint64_t vp_slave_peer_mem_size_get(VhostUserMemory *pmem)
+{
+    int i;
+    uint64_t total_size = 0;
+    uint32_t nregions = pmem->nregions;
+    VhostUserMemoryRegion *pmem_regions = pmem->regions;
+
+    for (i = 0; i < nregions; i++) {
+        total_size += pmem_regions[i].memory_size;
+    }
+
+    return total_size;
+}
+
+static int vp_slave_set_mem_table(VhostUserMsg *msg, int *fds, int fd_num)
+{
+    VhostUserMemory *pmem = &msg->payload.memory;
+    VhostUserMemoryRegion *pmem_region = pmem->regions;
+    uint32_t i, nregions = pmem->nregions;
+    struct peer_mem_msg *pmem_msg = &vp_slave->pmem_msg;
+    pmem_msg->nregions = nregions;
+    MemoryRegion *bar_mr, *sub_mr;
+    uint64_t bar_size, bar_map_offset = 0;
+    void *mr_qva;
+
+    /* Sanity Check */
+    if (fd_num != nregions)
+        error_report("SET_MEM_TABLE: fd num doesn't match region num");
+
+    if (vp_slave->bar_mr == NULL)
+        vp_slave->bar_mr = g_malloc(sizeof(MemoryRegion));
+    if (vp_slave->sub_mr == NULL)
+        vp_slave->sub_mr = g_malloc(nregions * sizeof(MemoryRegion));
+    bar_mr = vp_slave->bar_mr;
+    sub_mr = vp_slave->sub_mr;
+
+    /*
+     * The top half of the bar area holds the peer memory, and the bottom
+     * half is reserved for memory hotplug
+     */
+    bar_size = 2 * vp_slave_peer_mem_size_get(pmem);
+    bar_size = pow2ceil(bar_size);
+    memory_region_init(bar_mr, NULL, "Peer Memory", bar_size);
+    for (i = 0; i < nregions; i++) {
+        vp_slave->mr_map_size[i] = pmem_region[i].memory_size
+                                       + pmem_region[i].mmap_offset;
+        vp_slave->mr_map_base[i] = mmap(NULL, vp_slave->mr_map_size[i],
+                      PROT_READ | PROT_WRITE, MAP_SHARED, fds[i], 0);
+        if (vp_slave->mr_map_base[i] == MAP_FAILED) {
+            error_report("SET_MEM_TABLE: map peer memory region %d failed", i);
+            return -1;
+        }
+
+        mr_qva = vp_slave->mr_map_base[i] + pmem_region[i].mmap_offset;
+        memory_region_init_ram_ptr(&sub_mr[i], NULL, "Peer Memory",
+                                   pmem_region[i].memory_size, mr_qva);
+        memory_region_add_subregion(bar_mr, bar_map_offset, &sub_mr[i]);
+        bar_map_offset += pmem_region[i].memory_size;
+        pmem_msg->regions[i].gpa = pmem_region[i].guest_phys_addr;
+        pmem_msg->regions[i].size = pmem_region[i].memory_size;
+    }
+    vp_slave->bar_map_offset = bar_map_offset;
+
+    return 0;
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -114,7 +194,7 @@ static int vp_slave_can_read(void *opaque)
 
 static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
 {
-    int ret;
+    int ret, fd_num, fds[MAX_GUEST_REGION];
     VhostUserMsg msg;
     uint8_t *p = (uint8_t *) &msg;
     CharBackend *chr_be = (CharBackend *)opaque;
@@ -165,6 +245,10 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
         break;
     case VHOST_USER_SET_OWNER:
         break;
+    case VHOST_USER_SET_MEM_TABLE:
+        fd_num = qemu_chr_fe_get_msgfds(chr_be, fds, sizeof(fds) / sizeof(int));
+        vp_slave_set_mem_table(&msg, fds, fd_num);
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
@@ -198,6 +282,8 @@ int vhost_pci_slave_init(QemuOpts *opts)
         return -1;
     }
     vp_slave->feature_bits =  1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+    vp_slave->bar_mr = NULL;
+    vp_slave->sub_mr = NULL;
     qemu_chr_fe_init(&vp_slave->chr_be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&vp_slave->chr_be, vp_slave_can_read,
                              vp_slave_read, vp_slave_event,
@@ -208,7 +294,10 @@ int vhost_pci_slave_init(QemuOpts *opts)
 
 int vhost_pci_slave_cleanup(void)
 {
+    vp_slave_cleanup();
     qemu_chr_fe_deinit(&vp_slave->chr_be);
+    g_free(vp_slave->sub_mr);
+    g_free(vp_slave->bar_mr);
     g_free(vp_slave);
 
     return 0;
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index 8b162dc..03e23eb 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -2,11 +2,20 @@
 #define QEMU_VHOST_PCI_SLAVE_H
 
 #include "sysemu/char.h"
+#include "exec/memory.h"
+#include "standard-headers/linux/vhost_pci_net.h"
 
 typedef struct VhostPCISlave {
     CharBackend chr_be;
     uint16_t dev_type;
     uint64_t feature_bits;
+    /* hotplugged memory should be mapped following the offset */
+    uint64_t bar_map_offset;
+    MemoryRegion *bar_mr;
+    MemoryRegion *sub_mr;
+    void *mr_map_base[MAX_GUEST_REGION];
+    uint64_t mr_map_size[MAX_GUEST_REGION];
+    struct peer_mem_msg pmem_msg;
 } VhostPCISlave;
 
 extern VhostPCISlave *vp_slave;
diff --git a/include/standard-headers/linux/vhost_pci_net.h b/include/standard-headers/linux/vhost_pci_net.h
index bac293f..f4c8d0b 100644
--- a/include/standard-headers/linux/vhost_pci_net.h
+++ b/include/standard-headers/linux/vhost_pci_net.h
@@ -29,6 +29,17 @@
 
 #include "standard-headers/linux/virtio_ids.h"
 
+struct pmem_region_msg {
+	uint64_t gpa;
+	uint64_t size;
+};
+
+#define MAX_GUEST_REGION 8
+struct peer_mem_msg {
+	uint32_t nregions;
+	struct pmem_region_msg regions[MAX_GUEST_REGION];
+};
+
 #define VPNET_S_LINK_UP	1	/* Link is up */
 
 struct vhost_pci_net_config {
-- 
2.7.4
