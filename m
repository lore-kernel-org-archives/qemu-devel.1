Received: from eggs.gnu.org ([2001:4830:134:3::10]:35998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHZ-0007n5-F8
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHW-0003ba-99
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:47:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gJeHW-0003bO-2g
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:47:02 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon,  5 Nov 2018 14:45:59 +0200
Message-Id: <20181105124559.21561-19-yuval.shaia@oracle.com>
In-Reply-To: <20181105124559.21561-1-yuval.shaia@oracle.com>
References: <20181105124559.21561-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 18/18] hw/rdma: Remove unneeded code that
 handles more that one port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

Device supports only one port, let's remove a dead code that handles
more than one port.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_rm.c      | 34 ++++++++++++++++------------------
 hw/rdma/rdma_rm.h      |  2 +-
 hw/rdma/rdma_rm_defs.h |  4 ++--
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 04f88139c2..a743cc42fe 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -545,7 +545,7 @@ int rdma_rm_add_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
         return -EINVAL;
     }
 
-    memcpy(&dev_res->ports[0].gid_tbl[gid_idx].gid, gid, sizeof(*gid));
+    memcpy(&dev_res->port.gid_tbl[gid_idx].gid, gid, sizeof(*gid));
 
     return 0;
 }
@@ -556,14 +556,14 @@ void rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     int rc;
 
     rc = rdma_backend_del_gid(backend_dev, ifname,
-                              &dev_res->ports[0].gid_tbl[gid_idx].gid);
+                              &dev_res->port.gid_tbl[gid_idx].gid);
     if (rc < 0) {
         pr_dbg("Fail to delete gid\n");
     }
 
-    memset(dev_res->ports[0].gid_tbl[gid_idx].gid.raw, 0,
-           sizeof(dev_res->ports[0].gid_tbl[gid_idx].gid));
-    dev_res->ports[0].gid_tbl[gid_idx].backend_gid_index = -1;
+    memset(dev_res->port.gid_tbl[gid_idx].gid.raw, 0,
+           sizeof(dev_res->port.gid_tbl[gid_idx].gid));
+    dev_res->port.gid_tbl[gid_idx].backend_gid_index = -1;
 }
 
 int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
@@ -574,16 +574,16 @@ int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
         return -EINVAL;
     }
 
-    if (unlikely(dev_res->ports[0].gid_tbl[sgid_idx].backend_gid_index == -1)) {
-        dev_res->ports[0].gid_tbl[sgid_idx].backend_gid_index =
+    if (unlikely(dev_res->port.gid_tbl[sgid_idx].backend_gid_index == -1)) {
+        dev_res->port.gid_tbl[sgid_idx].backend_gid_index =
         rdma_backend_get_gid_index(backend_dev,
-                                       &dev_res->ports[0].gid_tbl[sgid_idx].gid);
+                                   &dev_res->port.gid_tbl[sgid_idx].gid);
     }
 
     pr_dbg("backend_gid_index=%d\n",
-           dev_res->ports[0].gid_tbl[sgid_idx].backend_gid_index);
+           dev_res->port.gid_tbl[sgid_idx].backend_gid_index);
 
-    return dev_res->ports[0].gid_tbl[sgid_idx].backend_gid_index;
+    return dev_res->port.gid_tbl[sgid_idx].backend_gid_index;
 }
 
 static void destroy_qp_hash_key(gpointer data)
@@ -593,15 +593,13 @@ static void destroy_qp_hash_key(gpointer data)
 
 static void init_ports(RdmaDeviceResources *dev_res)
 {
-    int i, j;
+    int i;
 
-    memset(dev_res->ports, 0, sizeof(dev_res->ports));
+    memset(&dev_res->port, 0, sizeof(dev_res->port));
 
-    for (i = 0; i < MAX_PORTS; i++) {
-        dev_res->ports[i].state = IBV_PORT_DOWN;
-        for (j = 0; j < MAX_PORT_GIDS; j++) {
-            dev_res->ports[i].gid_tbl[j].backend_gid_index = -1;
-        }
+    dev_res->port.state = IBV_PORT_DOWN;
+    for (i = 0; i < MAX_PORT_GIDS; i++) {
+        dev_res->port.gid_tbl[i].backend_gid_index = -1;
     }
 }
 
@@ -610,7 +608,7 @@ static void fini_ports(RdmaDeviceResources *dev_res,
 {
     int i;
 
-    dev_res->ports[0].state = IBV_PORT_DOWN;
+    dev_res->port.state = IBV_PORT_DOWN;
     for (i = 0; i < MAX_PORT_GIDS; i++) {
         rdma_rm_del_gid(dev_res, backend_dev, ifname, i);
     }
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index 89596f4de1..140c0cea97 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -79,7 +79,7 @@ int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
 static inline union ibv_gid *rdma_rm_get_gid(RdmaDeviceResources *dev_res,
                                              int sgid_idx)
 {
-    return &dev_res->ports[0].gid_tbl[sgid_idx].gid;
+    return &dev_res->port.gid_tbl[sgid_idx].gid;
 }
 
 #endif
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 7b3435f991..0ba61d1838 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -18,7 +18,7 @@
 
 #include "rdma_backend_defs.h"
 
-#define MAX_PORTS             1
+#define MAX_PORTS             1 /* Do not change - we support only one port */
 #define MAX_PORT_GIDS         255
 #define MAX_GIDS              MAX_PORT_GIDS
 #define MAX_PORT_PKEYS        1
@@ -97,7 +97,7 @@ typedef struct RdmaRmPort {
 } RdmaRmPort;
 
 typedef struct RdmaDeviceResources {
-    RdmaRmPort ports[MAX_PORTS];
+    RdmaRmPort port;
     RdmaRmResTbl pd_tbl;
     RdmaRmResTbl mr_tbl;
     RdmaRmResTbl uc_tbl;
-- 
2.17.2
