Received: from eggs.gnu.org ([2001:4830:134:3::10]:36265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtF-0001bC-DU
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtC-0001m5-O3
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:13 -0400
Received: from [59.151.112.132] (port=34797 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtB-0001lQ-OX
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:10 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 17 May 2017 19:12:23 +0800
Message-ID: <7b167e0f406b66ae11313d4cde04396952d0902f.1495018956.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/3] net/rocker: Remove the dead error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, f4bug@amsat.org, armbru@redhat.com

The function of_dpa_world_alloc is a wrapper around world_alloc(), which
returns null only when g_malloc0(size_t size) does. But g_malloc0() also
is a wrapper around g_malloc0_n(1, size) that ignore the fact that
g_malloc0() of 0 bytes, it doesn't returns null. So the error handling is
dead. Similar like desc_ring_alloc(), fp_port_alloc() etc. Remove these
entirely.

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: f4bug@amsat.org
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/net/rocker/rocker.c      | 32 --------------------------------
 hw/net/rocker/rocker_desc.c |  3 ---
 hw/net/rocker/rocker_fp.c   |  4 ----
 3 files changed, 39 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 6e70fdd..b2b6dc7 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1313,13 +1313,6 @@ static int pci_rocker_init(PCIDevice *dev)
 
     r->worlds[ROCKER_WORLD_TYPE_OF_DPA] = of_dpa_world_alloc(r);
 
-    for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
-        if (!r->worlds[i]) {
-            err = -ENOMEM;
-            goto err_world_alloc;
-        }
-    }
-
     if (!r->world_name) {
         r->world_name = g_strdup(world_name(r->worlds[ROCKER_WORLD_TYPE_OF_DPA]));
     }
@@ -1396,9 +1389,6 @@ static int pci_rocker_init(PCIDevice *dev)
     }
 
     r->rings = g_new(DescRing *, rocker_pci_ring_count(r));
-    if (!r->rings) {
-        goto err_rings_alloc;
-    }
 
     /* Rings are ordered like this:
      * - command ring
@@ -1410,14 +1400,9 @@ static int pci_rocker_init(PCIDevice *dev)
      * .....
      */
 
-    err = -ENOMEM;
     for (i = 0; i < rocker_pci_ring_count(r); i++) {
         DescRing *ring = desc_ring_alloc(r, i);
 
-        if (!ring) {
-            goto err_ring_alloc;
-        }
-
         if (i == ROCKER_RING_CMD) {
             desc_ring_set_consume(ring, cmd_consume, ROCKER_MSIX_VEC_CMD);
         } else if (i == ROCKER_RING_EVENT) {
@@ -1437,10 +1422,6 @@ static int pci_rocker_init(PCIDevice *dev)
             fp_port_alloc(r, r->name, &r->fp_start_macaddr,
                           i, &r->fp_ports_peers[i]);
 
-        if (!port) {
-            goto err_port_alloc;
-        }
-
         r->fp_port[i] = port;
         fp_port_set_world(port, r->world_dflt);
     }
@@ -1449,25 +1430,12 @@ static int pci_rocker_init(PCIDevice *dev)
 
     return 0;
 
-err_port_alloc:
-    for (--i; i >= 0; i--) {
-        FpPort *port = r->fp_port[i];
-        fp_port_free(port);
-    }
-    i = rocker_pci_ring_count(r);
-err_ring_alloc:
-    for (--i; i >= 0; i--) {
-        desc_ring_free(r->rings[i]);
-    }
-    g_free(r->rings);
-err_rings_alloc:
 err_duplicate:
     rocker_msix_uninit(r);
 err_msix_init:
     object_unparent(OBJECT(&r->msix_bar));
     object_unparent(OBJECT(&r->mmio));
 err_world_type_by_name:
-err_world_alloc:
     for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
         if (r->worlds[i]) {
             world_free(r->worlds[i]);
diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
index ac02797..bd7e364 100644
--- a/hw/net/rocker/rocker_desc.c
+++ b/hw/net/rocker/rocker_desc.c
@@ -347,9 +347,6 @@ DescRing *desc_ring_alloc(Rocker *r, int index)
     DescRing *ring;
 
     ring = g_new0(DescRing, 1);
-    if (!ring) {
-        return NULL;
-    }
 
     ring->r = r;
     ring->index = index;
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 1305ac3..4b3c984 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -226,10 +226,6 @@ FpPort *fp_port_alloc(Rocker *r, char *sw_name,
 {
     FpPort *port = g_new0(FpPort, 1);
 
-    if (!port) {
-        return NULL;
-    }
-
     port->r = r;
     port->index = index;
     port->pport = index + 1;
-- 
2.9.3
