Received: from eggs.gnu.org ([2001:4830:134:3::10]:46207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUBB-0005bg-2T
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB7-0003m3-7p
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:37 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:11:59 +0000
Message-ID: <20181121151211.15997-7-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 06/18] xen: add grant table interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

The legacy PV backend infrastructure provides functions to map, unmap and
copy pages granted by frontends. Similar functionality will be required
by XenDevice implementations so this patch adds the necessary support.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c         | 145 +++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen-bus.h |  25 ++++++++
 2 files changed, 170 insertions(+)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 99988f8568..7a152d2a2f 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -447,6 +447,138 @@ static void xen_device_frontend_destroy(XenDevice *xendev)
     g_free(xendev->frontend_path);
 }
 
+void xen_device_set_max_grant_refs(XenDevice *xendev, unsigned int nr_refs,
+                                   Error **errp)
+{
+    if (xengnttab_set_max_grants(xendev->xgth, nr_refs)) {
+        error_setg_errno(errp, errno, "xengnttab_set_max_grants failed");
+    }
+}
+
+void *xen_device_map_grant_refs(XenDevice *xendev, uint32_t *refs,
+                                unsigned int nr_refs, int prot,
+                                Error **errp)
+{
+    void *map = xengnttab_map_domain_grant_refs(xendev->xgth, nr_refs,
+                                                xendev->frontend_id, refs,
+                                                prot);
+
+    if (!map) {
+        error_setg_errno(errp, errno,
+                         "xengnttab_map_domain_grant_refs failed");
+    }
+
+    return map;
+}
+
+void xen_device_unmap_grant_refs(XenDevice *xendev, void *map,
+                                 unsigned int nr_refs, Error **errp)
+{
+    if (xengnttab_unmap(xendev->xgth, map, nr_refs)) {
+        error_setg_errno(errp, errno, "xengnttab_unmap failed");
+    }
+}
+
+static void compat_copy_grant_refs(XenDevice *xendev, bool to_domain,
+                                   XenDeviceGrantCopySegment segs[],
+                                   unsigned int nr_segs, Error **errp)
+{
+    uint32_t *refs = g_new(uint32_t, nr_segs);
+    int prot = to_domain ? PROT_WRITE : PROT_READ;
+    void *map;
+    unsigned int i;
+
+    for (i = 0; i < nr_segs; i++) {
+        XenDeviceGrantCopySegment *seg = &segs[i];
+
+        refs[i] = to_domain ? seg->dest.foreign.ref :
+            seg->source.foreign.ref;
+    }
+
+    map = xengnttab_map_domain_grant_refs(xendev->xgth, nr_segs,
+                                          xendev->frontend_id, refs,
+                                          prot);
+    if (!map) {
+        error_setg_errno(errp, errno,
+                         "xengnttab_map_domain_grant_refs failed");
+        goto done;
+    }
+
+    for (i = 0; i < nr_segs; i++) {
+        XenDeviceGrantCopySegment *seg = &segs[i];
+        void *page = map + (i * XC_PAGE_SIZE);
+
+        if (to_domain) {
+            memcpy(page + seg->dest.foreign.offset, seg->source.virt,
+                   seg->len);
+        } else {
+            memcpy(seg->dest.virt, page + seg->source.foreign.offset,
+                   seg->len);
+        }
+    }
+
+    if (xengnttab_unmap(xendev->xgth, map, nr_segs)) {
+        error_setg_errno(errp, errno, "xengnttab_unmap failed");
+    }
+
+done:
+    g_free(refs);
+}
+
+void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
+                                XenDeviceGrantCopySegment segs[],
+                                unsigned int nr_segs, Error **errp)
+{
+    xengnttab_grant_copy_segment_t *xengnttab_segs;
+    unsigned int i;
+
+    if (!xendev->feature_grant_copy) {
+        compat_copy_grant_refs(xendev, to_domain, segs, nr_segs, errp);
+        return;
+    }
+
+    xengnttab_segs = g_new0(xengnttab_grant_copy_segment_t, nr_segs);
+
+    for (i = 0; i < nr_segs; i++) {
+        XenDeviceGrantCopySegment *seg = &segs[i];
+        xengnttab_grant_copy_segment_t *xengnttab_seg = &xengnttab_segs[i];
+
+        if (to_domain) {
+            xengnttab_seg->flags = GNTCOPY_dest_gref;
+            xengnttab_seg->dest.foreign.domid = xendev->frontend_id;
+            xengnttab_seg->dest.foreign.ref = seg->dest.foreign.ref;
+            xengnttab_seg->dest.foreign.offset = seg->dest.foreign.offset;
+            xengnttab_seg->source.virt = seg->source.virt;
+        } else {
+            xengnttab_seg->flags = GNTCOPY_source_gref;
+            xengnttab_seg->source.foreign.domid = xendev->frontend_id;
+            xengnttab_seg->source.foreign.ref = seg->source.foreign.ref;
+            xengnttab_seg->source.foreign.offset =
+                seg->source.foreign.offset;
+            xengnttab_seg->dest.virt = seg->dest.virt;
+        }
+
+        xengnttab_seg->len = seg->len;
+    }
+
+    if (xengnttab_grant_copy(xendev->xgth, nr_segs, xengnttab_segs)) {
+        error_setg_errno(errp, errno, "xengnttab_grant_copy failed");
+        goto done;
+    }
+
+    for (i = 0; i < nr_segs; i++) {
+        xengnttab_grant_copy_segment_t *xengnttab_seg = &xengnttab_segs[i];
+
+        if (xengnttab_seg->status != GNTST_okay) {
+            error_setg(errp, "xengnttab_grant_copy seg[%u] failed", i);
+            break;
+        }
+    }
+
+done:
+    g_free(xengnttab_segs);
+}
+
 static void xen_device_unrealize(DeviceState *dev, Error **errp)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -470,6 +602,10 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
     xen_device_frontend_destroy(xendev);
     xen_device_backend_destroy(xendev);
 
+    if (xendev->xgth) {
+        xengnttab_close(xendev->xgth);
+    }
+
     g_free(xendev->name);
 }
 
@@ -511,6 +647,15 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
 
     trace_xen_device_realize(type, xendev->name);
 
+    xendev->xgth = xengnttab_open(NULL, 0);
+    if (!xendev->xgth) {
+        error_setg_errno(errp, errno, "failed xengnttab_open");
+        goto unrealize;
+    }
+
+    xendev->feature_grant_copy =
+        (xengnttab_grant_copy(xendev->xgth, 0, NULL) == 0);
+
     xen_device_backend_create(xendev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 954149e51b..db14d49027 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -22,6 +22,8 @@ typedef struct XenDevice {
     enum xenbus_state backend_state, frontend_state;
     Notifier exit;
     XenWatch *frontend_state_watch;
+    xengnttab_handle *xgth;
+    bool feature_grant_copy;
 } XenDevice;
 
 typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
@@ -77,4 +79,27 @@ void xen_device_backend_set_state(XenDevice *xendev,
                                   enum xenbus_state state);
 enum xenbus_state xen_device_backend_get_state(XenDevice *xendev);
 
+void xen_device_set_max_grant_refs(XenDevice *xendev, unsigned int nr_refs,
+                                   Error **errp);
+void *xen_device_map_grant_refs(XenDevice *xendev, uint32_t *refs,
+                                unsigned int nr_refs, int prot,
+                                Error **errp);
+void xen_device_unmap_grant_refs(XenDevice *xendev, void *map,
+                                 unsigned int nr_refs, Error **errp);
+
+typedef struct XenDeviceGrantCopySegment {
+    union {
+        void *virt;
+        struct {
+            uint32_t ref;
+            off_t offset;
+        } foreign;
+    } source, dest;
+    size_t len;
+} XenDeviceGrantCopySegment;
+
+void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
+                                XenDeviceGrantCopySegment segs[],
+                                unsigned int nr_segs, Error **errp);
+
 #endif /* HW_XEN_BUS_H */
-- 
2.11.0
