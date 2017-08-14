Received: from eggs.gnu.org ([2001:4830:134:3::10]:35225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh683-0004qw-0n
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh681-0007q5-IS
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dh681-0007pj-8m
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:21 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2017 11:33:07 +0800
Message-Id: <1502681591-31362-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1502681591-31362-1-git-send-email-jasowang@redhat.com>
References: <1502681591-31362-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] net/rocker: Remove the dead error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Memory allocation functions like world_alloc, desc_ring_alloc etc,
they are all wrappers around g_malloc, g_new etc. But g_malloc and
similar functions doesn't return null. Because they ignore the fact
that g_malloc() of 0 bytes returns null. So error checks for these
allocation failure are superfluous. Now, remove them entirely.

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: armbru@redhat.com
Cc: f4bug@amsat.org
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rocker/rocker.c        | 47 +------------------------------------------
 hw/net/rocker/rocker_desc.c   | 10 ---------
 hw/net/rocker/rocker_fp.c     |  4 ----
 hw/net/rocker/rocker_of_dpa.c | 20 ------------------
 hw/net/rocker/rocker_world.c  | 12 +++++------
 5 files changed, 6 insertions(+), 87 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 4f0f6d7..7496752 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -239,10 +239,6 @@ static int tx_consume(Rocker *r, DescInfo *info)
         }
         iov[iovcnt].iov_len = frag_len;
         iov[iovcnt].iov_base = g_malloc(frag_len);
-        if (!iov[iovcnt].iov_base) {
-            err = -ROCKER_ENOMEM;
-            goto err_no_mem;
-        }
 
         pci_dma_read(dev, frag_addr, iov[iovcnt].iov_base,
                      iov[iovcnt].iov_len);
@@ -259,7 +255,6 @@ static int tx_consume(Rocker *r, DescInfo *info)
     err = fp_port_eg(r->fp_port[port], iov, iovcnt);
 
 err_too_many_frags:
-err_no_mem:
 err_bad_attr:
     for (i = 0; i < ROCKER_TX_FRAGS_MAX; i++) {
         g_free(iov[i].iov_base);
@@ -671,10 +666,7 @@ int rx_produce(World *world, uint32_t pport,
      */
 
     data = g_malloc(data_size);
-    if (!data) {
-        err = -ROCKER_ENOMEM;
-        goto out;
-    }
+
     iov_to_buf(iov, iovcnt, 0, data, data_size);
     pci_dma_write(dev, frag_addr, data, data_size);
     g_free(data);
@@ -719,11 +711,6 @@ static void rocker_test_dma_ctrl(Rocker *r, uint32_t val)
 
     buf = g_malloc(r->test_dma_size);
 
-    if (!buf) {
-        DPRINTF("test dma buffer alloc failed");
-        return;
-    }
-
     switch (val) {
     case ROCKER_TEST_DMA_CTRL_CLEAR:
         memset(buf, 0, r->test_dma_size);
@@ -1310,13 +1297,6 @@ static int pci_rocker_init(PCIDevice *dev)
 
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
@@ -1393,9 +1373,6 @@ static int pci_rocker_init(PCIDevice *dev)
     }
 
     r->rings = g_new(DescRing *, rocker_pci_ring_count(r));
-    if (!r->rings) {
-        goto err_rings_alloc;
-    }
 
     /* Rings are ordered like this:
      * - command ring
@@ -1407,14 +1384,9 @@ static int pci_rocker_init(PCIDevice *dev)
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
@@ -1434,10 +1406,6 @@ static int pci_rocker_init(PCIDevice *dev)
             fp_port_alloc(r, r->name, &r->fp_start_macaddr,
                           i, &r->fp_ports_peers[i]);
 
-        if (!port) {
-            goto err_port_alloc;
-        }
-
         r->fp_port[i] = port;
         fp_port_set_world(port, r->world_dflt);
     }
@@ -1446,25 +1414,12 @@ static int pci_rocker_init(PCIDevice *dev)
 
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
index 6184c40..b009da4 100644
--- a/hw/net/rocker/rocker_desc.c
+++ b/hw/net/rocker/rocker_desc.c
@@ -65,10 +65,6 @@ char *desc_get_buf(DescInfo *info, bool read_only)
         info->buf_size = size;
     }
 
-    if (!info->buf) {
-        return NULL;
-    }
-
     pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf, size);
 
     return info->buf;
@@ -142,9 +138,6 @@ bool desc_ring_set_size(DescRing *ring, uint32_t size)
     ring->head = ring->tail = 0;
 
     ring->info = g_renew(DescInfo, ring->info, size);
-    if (!ring->info) {
-        return false;
-    }
 
     memset(ring->info, 0, size * sizeof(DescInfo));
 
@@ -345,9 +338,6 @@ DescRing *desc_ring_alloc(Rocker *r, int index)
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
diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 9b1e0d2..191a58e 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -368,9 +368,6 @@ static OfDpaFlow *of_dpa_flow_alloc(uint64_t cookie)
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) / 1000;
 
     flow = g_new0(OfDpaFlow, 1);
-    if (!flow) {
-        return NULL;
-    }
 
     flow->cookie = cookie;
     flow->mask.tbl_id = 0xffffffff;
@@ -813,10 +810,6 @@ static OfDpaGroup *of_dpa_group_alloc(uint32_t id)
 {
     OfDpaGroup *group = g_new0(OfDpaGroup, 1);
 
-    if (!group) {
-        return NULL;
-    }
-
     group->id = id;
 
     return group;
@@ -1867,9 +1860,6 @@ static int of_dpa_cmd_flow_add(OfDpa *of_dpa, uint64_t cookie,
     }
 
     flow = of_dpa_flow_alloc(cookie);
-    if (!flow) {
-        return -ROCKER_ENOMEM;
-    }
 
     err = of_dpa_cmd_flow_add_mod(of_dpa, flow, flow_tlvs);
     if (err) {
@@ -2040,17 +2030,10 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_dpa, OfDpaGroup *group,
         rocker_tlv_get_le16(group_tlvs[ROCKER_TLV_OF_DPA_GROUP_COUNT]);
 
     tlvs = g_new0(RockerTlv *, group->l2_flood.group_count + 1);
-    if (!tlvs) {
-        return -ROCKER_ENOMEM;
-    }
 
     g_free(group->l2_flood.group_ids);
     group->l2_flood.group_ids =
         g_new0(uint32_t, group->l2_flood.group_count);
-    if (!group->l2_flood.group_ids) {
-        err = -ROCKER_ENOMEM;
-        goto err_out;
-    }
 
     rocker_tlv_parse_nested(tlvs, group->l2_flood.group_count,
                             group_tlvs[ROCKER_TLV_OF_DPA_GROUP_IDS]);
@@ -2157,9 +2140,6 @@ static int of_dpa_cmd_group_add(OfDpa *of_dpa, uint32_t group_id,
     }
 
     group = of_dpa_group_alloc(group_id);
-    if (!group) {
-        return -ROCKER_ENOMEM;
-    }
 
     err = of_dpa_cmd_group_do(of_dpa, group_id, group, group_tlvs);
     if (err) {
diff --git a/hw/net/rocker/rocker_world.c b/hw/net/rocker/rocker_world.c
index 89777e9..f73c534 100644
--- a/hw/net/rocker/rocker_world.c
+++ b/hw/net/rocker/rocker_world.c
@@ -51,13 +51,11 @@ World *world_alloc(Rocker *r, size_t sizeof_private,
 {
     World *w = g_malloc0(sizeof(World) + sizeof_private);
 
-    if (w) {
-        w->r = r;
-        w->type = type;
-        w->ops = ops;
-        if (w->ops->init) {
-            w->ops->init(w);
-        }
+    w->r = r;
+    w->type = type;
+    w->ops = ops;
+    if (w->ops->init) {
+        w->ops->init(w);
     }
 
     return w;
-- 
2.7.4
