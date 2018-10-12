Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Ax-0008C6-PJ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Aq-0006VR-Me
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gB7Aq-0006T4-9v
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w9CNiIP7088170
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:49 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp2120.oracle.com with ESMTP id 2mxnprndsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmmhI009600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:48 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9CNmmXl012056
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:48 GMT
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Fri, 12 Oct 2018 19:48:35 -0400
Message-Id: <c92b3730c01dc292c23fcc2fefe8fb8ed6194b78.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [RFC PATCH v1 8/8] multi-process QEMU: synchronize RAM
 between QEMU & remote device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: john.g.johnson@oracle.com, Kanth.Ghatraju@oracle.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com

- Setup MemoryListener in QEMU to get all updates to sysmem, and
  forward all RAM updates to remote device process
- Remote device process updates its "system_memory" container using
  shared file descriptors provided by SYNC_SYSMEM message

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/qemu-proxy.c         | 156 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/scsi/qemu-scsi-dev.c |  10 ++++
 include/hw/qemu-proxy.h |   3 +
 3 files changed, 169 insertions(+)

diff --git a/hw/qemu-proxy.c b/hw/qemu-proxy.c
index 1712b41..79cdd3f 100644
--- a/hw/qemu-proxy.c
+++ b/hw/qemu-proxy.c
@@ -159,6 +159,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
         printf("Proxy link is not set\n");
     }
 
+    configure_memory_listener(dev);
+
     pci_conf[PCI_LATENCY_TIMER] = 0xff;
 
     memory_region_init_io(&dev->mmio_io, OBJECT(dev), &proxy_device_mmio_ops,
@@ -213,3 +215,157 @@ void init_emulation_process(PCIProxyDev *pdev, char *command, Error **errp)
 }
 
 type_init(pci_proxy_dev_register_types)
+
+static void proxy_ml_begin(MemoryListener *listener)
+{
+    int mrs;
+    struct proxy_device *pdev = container_of(listener, struct proxy_device,
+                                             memory_listener);
+
+    for (mrs = 0; mrs < pdev->n_mr_sections; mrs++) {
+        memory_region_unref(pdev->mr_sections[mrs].mr);
+    }
+
+    g_free(pdev->mr_sections);
+    pdev->mr_sections = NULL;
+    pdev->n_mr_sections = 0;
+}
+
+static bool proxy_mrs_can_merge(uint64_t host, uint64_t prev_host, size_t size)
+{
+    bool merge;
+    ram_addr_t offset;
+    int fd1, fd2;
+    MemoryRegion *mr;
+
+    mr = memory_region_from_host((void *)(uintptr_t)host, &offset);
+    fd1 = memory_region_get_fd(mr);
+
+    mr = memory_region_from_host((void *)(uintptr_t)prev_host, &offset);
+    fd2 = memory_region_get_fd(mr);
+
+    merge = (fd1 == fd2);
+
+    merge &= ((prev_host + size) == host);
+
+    return merge;
+}
+
+static void proxy_ml_region_addnop(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    bool need_add = true;
+    uint64_t mrs_size, mrs_gpa, mrs_page;
+    uintptr_t mrs_host;
+    RAMBlock *mrs_rb;
+    MemoryRegionSection *prev_sec;
+    struct proxy_device *pdev = container_of(listener, struct proxy_device,
+                                             memory_listener);
+
+    if (!(memory_region_is_ram(section->mr) &&
+          !memory_region_is_rom(section->mr))) {
+        return;
+    }
+
+    mrs_rb = section->mr->ram_block;
+    mrs_page = (uint64_t)qemu_ram_pagesize(mrs_rb);
+    mrs_size = int128_get64(section->size);
+    mrs_gpa = section->offset_within_address_space;
+    mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
+               section->offset_within_region;
+
+    mrs_host = mrs_host & ~(mrs_page - 1);
+    mrs_gpa = mrs_gpa & ~(mrs_page - 1);
+    mrs_size = ROUND_UP(mrs_size, mrs_page);
+
+    if (pdev->n_mr_sections) {
+        prev_sec = pdev->mr_sections + (pdev->n_mr_sections - 1);
+        uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
+        uint64_t prev_size = int128_get64(prev_sec->size);
+        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start, prev_size);
+        uint64_t prev_host_start =
+            (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
+            prev_sec->offset_within_region;
+        uint64_t prev_host_end = range_get_last(prev_host_start, prev_size);
+
+        if (mrs_gpa <= (prev_gpa_end + 1)) {
+            if (mrs_gpa < prev_gpa_start) {
+                assert(0);
+            }
+
+            if ((section->mr == prev_sec->mr) &&
+                proxy_mrs_can_merge(mrs_host, prev_host_start,
+                                    (mrs_gpa - prev_gpa_start))) {
+                uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
+               need_add = false;
+                prev_sec->offset_within_address_space =
+                    MIN(prev_gpa_start, mrs_gpa);
+                prev_sec->offset_within_region =
+                    MIN(prev_host_start, mrs_host) -
+                    (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr);
+                prev_sec->size = int128_make64(max_end - MIN(prev_host_start,
+                                                             mrs_host));
+            }
+        }
+    }
+
+    if (need_add) {
+        ++pdev->n_mr_sections;
+        pdev->mr_sections = g_renew(MemoryRegionSection, pdev->mr_sections,
+                                    pdev->n_mr_sections);
+        pdev->mr_sections[pdev->n_mr_sections - 1] = *section;
+        pdev->mr_sections[pdev->n_mr_sections - 1].fv = NULL;
+        memory_region_ref(section->mr);
+    }
+}
+
+static void proxy_ml_commit(MemoryListener *listener)
+{
+    ProcMsg msg;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+    MemoryRegionSection section;
+    uintptr_t host_addr;
+    int region;
+    struct proxy_device *pdev = container_of(listener, struct proxy_device,
+                                             memory_listener);
+
+    msg.cmd = SYNC_SYSMEM;
+    msg.bytestream = 0;
+    msg.num_fds = pdev->n_mr_sections;
+    assert(msg.num_fds <= MAX_FDS);
+
+    for (region = 0; region < pdev->n_mr_sections; region++) {
+        section = pdev->mr_sections[region];
+        msg.data1.sync_sysmem.gpas[region] =
+            section.offset_within_address_space;
+        msg.data1.sync_sysmem.sizes[region] = int128_get64(section.size);
+        host_addr = (uintptr_t)memory_region_get_ram_ptr(section.mr) +
+                    section.offset_within_region;
+        mr = memory_region_from_host((void *)host_addr, &offset);
+        msg.fds[region] = memory_region_get_fd(mr);
+    }
+    proxy_proc_send(pdev->proxy_link, &msg);
+}
+
+void deconfigure_memory_listener(PCIProxyDev *pdev)
+{
+    memory_listener_unregister(&pdev->proxy_dev.memory_listener);
+}
+
+static MemoryListener proxy_listener = {
+        .begin = proxy_ml_begin,
+        .commit = proxy_ml_commit,
+        .region_add = proxy_ml_region_addnop,
+        .region_nop = proxy_ml_region_addnop,
+        .priority = 10,
+};
+
+void configure_memory_listener(PCIProxyDev *dev)
+{
+    dev->proxy_dev.memory_listener = proxy_listener;
+    dev->proxy_dev.n_mr_sections = 0;
+    dev->proxy_dev.mr_sections = NULL;
+    memory_listener_register(&dev->proxy_dev.memory_listener,
+                             &address_space_memory);
+}
diff --git a/hw/scsi/qemu-scsi-dev.c b/hw/scsi/qemu-scsi-dev.c
index ede0c4b..ff34cbc 100644
--- a/hw/scsi/qemu-scsi-dev.c
+++ b/hw/scsi/qemu-scsi-dev.c
@@ -65,6 +65,16 @@ static void process_msg(GIOCondition cond)
         break;
     case CONF_READ:
         break;
+    case SYNC_SYSMEM:
+        /*
+         * TODO: ensure no active DMA is happening when
+         * sysmem is being updated
+         */
+        remote_sysmem_reconfig(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
diff --git a/include/hw/qemu-proxy.h b/include/hw/qemu-proxy.h
index 0903626..867c3ce 100644
--- a/include/hw/qemu-proxy.h
+++ b/include/hw/qemu-proxy.h
@@ -33,6 +33,7 @@ typedef struct proxy_device {
        int n_mr_sections;
         MemoryRegionSection *mr_sections;
         ProxyLinkState *proxy_link;
+        MemoryListener memory_listener;
         int link_up;
 } proxy_device;
 
@@ -52,5 +53,7 @@ typedef struct PCIProxyDev {
 void init_emulation_process(PCIProxyDev *pdev, char *command, Error **errp);
 int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t val, int l,
                                                        unsigned int op);
+void deconfigure_memory_listener(PCIProxyDev *pdev);
+void configure_memory_listener(PCIProxyDev *pdev);
 
 #endif
-- 
1.8.3.1
