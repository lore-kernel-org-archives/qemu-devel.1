Received: from eggs.gnu.org ([2001:4830:134:3::10]:34983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvW-0005tW-Py
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvT-0002K8-Fs
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxvT-0002JR-6m
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:35 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 20:45:31 +0200
Message-Id: <20181217184540.4571-15-yuval.shaia@oracle.com>
In-Reply-To: <20181217184540.4571-1-yuval.shaia@oracle.com>
References: <20181217184540.4571-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v8 14/23] hw/rdma: Initialize node_guid from
 vmxnet3 mac address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

node_guid should be set once device is load.
Make node_guid be GID format (32 bit) of PCI function 0 vmxnet3 device's
MAC.

A new function was added to do the conversion.
So for example the MAC 56:b6:44:e9:62:dc will be converted to GID
54b6:44ff:fee9:62dc.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_utils.h      |  9 +++++++++
 hw/rdma/vmw/pvrdma_cmd.c  | 10 ----------
 hw/rdma/vmw/pvrdma_main.c |  5 ++++-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index 4532ca8e2f..9669c55f3e 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -64,4 +64,13 @@ extern unsigned long pr_dbg_cnt;
 void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
 void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
 
+static inline void addrconf_addr_eui48(uint8_t *eui, const char *addr)
+{
+    memcpy(eui, addr, 3);
+    eui[3] = 0xFF;
+    eui[4] = 0xFE;
+    memcpy(eui + 5, addr + 3, 3);
+    eui[0] ^= 2;
+}
+
 #endif
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index a334f6205e..2979582fac 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -592,16 +592,6 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
         return -EINVAL;
     }
 
-    /* TODO: Since drivers stores node_guid at load_dsr phase then this
-     * assignment is not relevant, i need to figure out a way how to
-     * retrieve MAC of our netdev */
-    if (!cmd->index) {
-        dev->node_guid =
-            dev->rdma_dev_res.ports[0].gid_tbl[0].gid.global.interface_id;
-        pr_dbg("dev->node_guid=0x%llx\n",
-               (long long unsigned int)be64_to_cpu(dev->node_guid));
-    }
-
     return 0;
 }
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index b35b5dc5f0..150404dfa6 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -264,7 +264,7 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
     dsr->caps.sys_image_guid = 0;
     pr_dbg("sys_image_guid=%" PRIx64 "\n", dsr->caps.sys_image_guid);
 
-    dsr->caps.node_guid = cpu_to_be64(dev->node_guid);
+    dsr->caps.node_guid = dev->node_guid;
     pr_dbg("node_guid=%" PRIx64 "\n", be64_to_cpu(dsr->caps.node_guid));
 
     dsr->caps.phys_port_cnt = MAX_PORTS;
@@ -588,6 +588,9 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     }
     dev->func0 = VMXNET3(func0);
 
+    addrconf_addr_eui48((unsigned char *)&dev->node_guid,
+                        (const char *)&dev->func0->conf.macaddr.a);
+
     memdev_root = object_resolve_path("/objects", NULL);
     if (memdev_root) {
         object_child_foreach(memdev_root, pvrdma_check_ram_shared, &ram_shared);
-- 
2.17.2
