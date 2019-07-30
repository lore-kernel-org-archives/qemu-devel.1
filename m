Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE74C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F9820693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F9820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVrN-0003oc-DL
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32883)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hsVqP-00022p-HH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hsVqO-0001HL-1O
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hsVqK-0001EO-JY; Tue, 30 Jul 2019 13:23:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DAD33308FC5F;
 Tue, 30 Jul 2019 17:23:19 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7470960BE5;
 Tue, 30 Jul 2019 17:23:12 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, kevin.tian@intel.com
Date: Tue, 30 Jul 2019 19:21:32 +0200
Message-Id: <20190730172137.23114-11-eric.auger@redhat.com>
In-Reply-To: <20190730172137.23114-1-eric.auger@redhat.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 30 Jul 2019 17:23:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 v10 10/15] virtio-iommu: Implement
 probe request
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements the PROBE request. At the moment,
no reserved regions are returned as none are registered
per device. Only a NONE property is returned.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v8 -> v9:
- fix filling of properties (changes induced by v0.7 -> v0.8 spec
  evolution)
- return VIRTIO_IOMMU_S_INVAL in case of error

v7 -> v8:
- adapt to removal of value filed in virtio_iommu_probe_property

v6 -> v7:
- adapt to the change in virtio_iommu_probe_resv_mem fields
- use get_endpoint() instead of directly checking the EP
  was registered.

v4 -> v5:
- initialize bufstate.error to false
- add cpu_to_le64(size)
---
 hw/virtio/trace-events   |   2 +
 hw/virtio/virtio-iommu.c | 168 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8257065159..2e557dffb4 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -75,3 +75,5 @@ virtio_iommu_unmap_left_interval(uint64_t low, uint64_t=
 high, uint64_t next_low,
 virtio_iommu_unmap_right_interval(uint64_t low, uint64_t high, uint64_t =
next_low, uint64_t next_high) "Unmap right [0x%"PRIx64",0x%"PRIx64"], new=
 interval=3D[0x%"PRIx64",0x%"PRIx64"]"
 virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t high) "Unmap inc =
[0x%"PRIx64",0x%"PRIx64"]"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint3=
2_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
+virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_=
t start, uint64_t end, uint32_t flags, size_t filled) "dev=3D %d, subtype=
=3D%d start=3D0x%"PRIx64" end=3D0x%"PRIx64" flags=3D%d filled=3D0x%lx"
+virtio_iommu_fill_none_property(uint32_t devid) "devid=3D%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index a8de583f9a..66be9a4627 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -37,6 +37,10 @@
=20
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
+#define VIOMMU_PROBE_SIZE 512
+
+#define SUPPORTED_PROBE_PROPERTIES (\
+    1 << VIRTIO_IOMMU_PROBE_T_RESV_MEM)
=20
 typedef struct viommu_domain {
     uint32_t id;
@@ -49,6 +53,7 @@ typedef struct viommu_endpoint {
     viommu_domain *domain;
     QLIST_ENTRY(viommu_endpoint) next;
     VirtIOIOMMU *viommu;
+    GTree *reserved_regions;
 } viommu_endpoint;
=20
 typedef struct viommu_interval {
@@ -63,6 +68,13 @@ typedef struct viommu_mapping {
     uint32_t flags;
 } viommu_mapping;
=20
+typedef struct viommu_property_buffer {
+    viommu_endpoint *endpoint;
+    size_t filled;
+    uint8_t *start;
+    bool error;
+} viommu_property_buffer;
+
 static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
@@ -102,6 +114,9 @@ static viommu_endpoint *virtio_iommu_get_endpoint(Vir=
tIOIOMMU *s,
     ep->viommu =3D s;
     trace_virtio_iommu_get_endpoint(ep_id);
     g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
+    ep->reserved_regions =3D g_tree_new_full((GCompareDataFunc)interval_=
cmp,
+                                            NULL, (GDestroyNotify)g_free=
,
+                                            (GDestroyNotify)g_free);
     return ep;
 }
=20
@@ -115,6 +130,7 @@ static void virtio_iommu_put_endpoint(gpointer data)
     }
=20
     trace_virtio_iommu_put_endpoint(ep->id);
+    g_tree_destroy(ep->reserved_regions);
     g_free(ep);
 }
=20
@@ -348,6 +364,125 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     return VIRTIO_IOMMU_S_INVAL;
 }
=20
+/**
+ * virtio_iommu_fill_resv_mem_prop - Add a RESV_MEM probe
+ * property into the probe request buffer
+ *
+ * @key: interval handle
+ * @value: handle to the reserved memory region
+ * @data: handle to the probe request buffer state
+ */
+static gboolean virtio_iommu_fill_resv_mem_prop(gpointer key,
+                                                gpointer value,
+                                                gpointer data)
+{
+    struct virtio_iommu_probe_resv_mem *resv =3D
+        (struct virtio_iommu_probe_resv_mem *)value;
+    struct virtio_iommu_probe_resv_mem *buf_prop;
+    viommu_property_buffer *bufstate =3D (viommu_property_buffer *)data;
+    size_t prop_size =3D sizeof(*resv);
+
+    if (bufstate->filled + prop_size >=3D VIOMMU_PROBE_SIZE) {
+        bufstate->error =3D true;
+        /* get the traversal stopped by returning true */
+        return true;
+    }
+    buf_prop =3D (struct virtio_iommu_probe_resv_mem *)
+                (bufstate->start + bufstate->filled);
+    *buf_prop =3D *resv;
+
+    bufstate->filled +=3D prop_size;
+    trace_virtio_iommu_fill_resv_property(bufstate->endpoint->id,
+                                          resv->subtype, resv->start,
+                                          resv->end, resv->subtype,
+                                          bufstate->filled);
+    return false;
+}
+
+static int virtio_iommu_fill_none_prop(viommu_property_buffer *bufstate)
+{
+    struct virtio_iommu_probe_property *prop;
+
+    prop =3D (struct virtio_iommu_probe_property *)
+                (bufstate->start + bufstate->filled);
+    prop->type =3D 0;
+    prop->length =3D 0;
+    bufstate->filled +=3D sizeof(*prop);
+    trace_virtio_iommu_fill_none_property(bufstate->endpoint->id);
+    return 0;
+}
+
+/* Fill the properties[] buffer with properties of type @type */
+static int virtio_iommu_fill_property(int type,
+                                      viommu_property_buffer *bufstate)
+{
+    int ret =3D -ENOSPC;
+
+    if (bufstate->filled + sizeof(struct virtio_iommu_probe_property)
+            >=3D VIOMMU_PROBE_SIZE) {
+        /* no space left for the header */
+        bufstate->error =3D true;
+        goto out;
+    }
+
+    switch (type) {
+    case VIRTIO_IOMMU_PROBE_T_NONE:
+        ret =3D virtio_iommu_fill_none_prop(bufstate);
+        break;
+    case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
+    {
+        viommu_endpoint *ep =3D bufstate->endpoint;
+
+        g_tree_foreach(ep->reserved_regions,
+                       virtio_iommu_fill_resv_mem_prop,
+                       bufstate);
+        if (!bufstate->error) {
+            ret =3D 0;
+        }
+        break;
+    }
+    default:
+        ret =3D -ENOENT;
+        break;
+    }
+out:
+    if (ret) {
+        error_report("%s property of type=3D%d could not be filled (%d),=
"
+                     " remaining size =3D 0x%lx",
+                     __func__, type, ret, bufstate->filled);
+    }
+    return ret;
+}
+
+/**
+ * virtio_iommu_probe - Fill the probe request buffer with all
+ * the properties the device is able to return and add a NONE
+ * property at the end. @buf points to properties[].
+ */
+static int virtio_iommu_probe(VirtIOIOMMU *s,
+                              struct virtio_iommu_req_probe *req,
+                              uint8_t *buf)
+{
+    uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    viommu_endpoint *ep =3D virtio_iommu_get_endpoint(s, ep_id);
+    int16_t prop_types =3D SUPPORTED_PROBE_PROPERTIES, type;
+    viommu_property_buffer bufstate =3D {.start =3D buf, .filled =3D 0,
+                                       .error =3D false, .endpoint =3D e=
p};
+
+    while ((type =3D ctz32(prop_types)) !=3D 32) {
+        if (virtio_iommu_fill_property(type, &bufstate)) {
+            goto failure;
+        }
+        prop_types &=3D ~(1 << type);
+    }
+    if (virtio_iommu_fill_property(VIRTIO_IOMMU_PROBE_T_NONE, &bufstate)=
) {
+        goto failure;
+    }
+    return VIRTIO_IOMMU_S_OK;
+failure:
+    return VIRTIO_IOMMU_S_INVAL;
+}
+
 static int virtio_iommu_iov_to_req(struct iovec *iov,
                                    unsigned int iov_cnt,
                                    void *req, size_t req_sz)
@@ -398,6 +533,17 @@ static int virtio_iommu_handle_unmap(VirtIOIOMMU *s,
     return ret ? ret : virtio_iommu_unmap(s, &req);
 }
=20
+static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
+                                     struct iovec *iov,
+                                     unsigned int iov_cnt,
+                                     uint8_t *buf)
+{
+    struct virtio_iommu_req_probe req;
+    int ret =3D virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(req))=
;
+
+    return ret ? ret : virtio_iommu_probe(s, &req, buf);
+}
+
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *v=
q)
 {
     VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
@@ -443,17 +589,33 @@ static void virtio_iommu_handle_command(VirtIODevic=
e *vdev, VirtQueue *vq)
         case VIRTIO_IOMMU_T_UNMAP:
             tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt);
             break;
+        case VIRTIO_IOMMU_T_PROBE:
+        {
+            struct virtio_iommu_req_tail *ptail;
+            uint8_t *buf =3D g_malloc0(s->config.probe_size + sizeof(tai=
l));
+
+            ptail =3D (struct virtio_iommu_req_tail *)
+                        (buf + s->config.probe_size);
+            ptail->status =3D virtio_iommu_handle_probe(s, iov, iov_cnt,=
 buf);
+
+            sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
+                              buf, s->config.probe_size + sizeof(tail));
+            g_free(buf);
+            assert(sz =3D=3D s->config.probe_size + sizeof(tail));
+            goto push;
+        }
         default:
             tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
         }
-        qemu_mutex_unlock(&s->mutex);
=20
 out:
         sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
                           &tail, sizeof(tail));
         assert(sz =3D=3D sizeof(tail));
=20
-        virtqueue_push(vq, elem, sizeof(tail));
+push:
+        qemu_mutex_unlock(&s->mutex);
+        virtqueue_push(vq, elem, sz);
         virtio_notify(vdev, vq);
         g_free(elem);
     }
@@ -608,6 +770,7 @@ static void virtio_iommu_device_realize(DeviceState *=
dev, Error **errp)
     s->config.input_range.end =3D -1UL;
     s->config.domain_range.start =3D 0;
     s->config.domain_range.end =3D 32;
+    s->config.probe_size =3D VIOMMU_PROBE_SIZE;
=20
     virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
     virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
@@ -617,6 +780,7 @@ static void virtio_iommu_device_realize(DeviceState *=
dev, Error **errp)
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
=20
     qemu_mutex_init(&s->mutex);
=20
--=20
2.20.1


