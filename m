Received: from eggs.gnu.org ([2001:4830:134:3::10]:48720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzn-0003jo-MZ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzm-0005sU-UY
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:59 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fDEzm-0005rz-Oi
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:01:58 -0400
Received: by mail-wr0-x243.google.com with SMTP id v60-v6so9125600wrc.7
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:01:58 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon, 30 Apr 2018 23:02:19 +0300
Message-Id: <20180430200223.4119-4-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH 3/7] hw/rdma: Delete port's pkey table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org

From: Yuval Shaia <yuval.shaia@oracle.com>

Support for PKEY is not yet implemented. Removing the unneeded table
until a support will be added.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm_defs.h    |  3 +--
 hw/rdma/vmw/pvrdma_main.c | 15 ---------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index fc646da61f..45503f14e0 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -21,7 +21,7 @@
 #define MAX_PORTS             1
 #define MAX_PORT_GIDS         1
 #define MAX_PORT_PKEYS        1
-#define MAX_PKEYS             1
+#define MAX_PKEYS             MAX_PORT_PKEYS
 #define MAX_GIDS              2048
 #define MAX_UCS               512
 #define MAX_MR_SIZE           (1UL << 27)
@@ -87,7 +87,6 @@ typedef struct RdmaRmQP {
 typedef struct RdmaRmPort {
     union ibv_gid gid_tbl[MAX_PORT_GIDS];
     enum ibv_port_state state;
-    int *pkey_tbl; /* TODO: Not yet supported */
 } RdmaRmPort;
 
 typedef struct RdmaDeviceResources {
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index c552248c90..994220b58e 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -275,15 +275,6 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
     pr_dbg("Initialized\n");
 }
 
-static void free_ports(PVRDMADev *dev)
-{
-    int i;
-
-    for (i = 0; i < MAX_PORTS; i++) {
-        g_free(dev->rdma_dev_res.ports[i].gid_tbl);
-    }
-}
-
 static void init_ports(PVRDMADev *dev, Error **errp)
 {
     int i;
@@ -292,10 +283,6 @@ static void init_ports(PVRDMADev *dev, Error **errp)
 
     for (i = 0; i < MAX_PORTS; i++) {
         dev->rdma_dev_res.ports[i].state = IBV_PORT_DOWN;
-
-        dev->rdma_dev_res.ports[i].pkey_tbl =
-            g_malloc0(sizeof(*dev->rdma_dev_res.ports[i].pkey_tbl) *
-                      MAX_PORT_PKEYS);
     }
 }
 
@@ -622,8 +609,6 @@ static void pvrdma_exit(PCIDevice *pdev)
 
     pvrdma_qp_ops_fini();
 
-    free_ports(dev);
-
     rdma_rm_fini(&dev->rdma_dev_res);
 
     rdma_backend_fini(&dev->backend_dev);
-- 
2.14.3
