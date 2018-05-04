Received: from eggs.gnu.org ([2001:4830:134:3::10]:50405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEbBk-0004wg-A9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEbBf-0003R5-Si
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:55:56 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 4 May 2018 14:55:30 +0100
Message-ID: <1525442134-20488-5-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525442134-20488-1-git-send-email-paul.durrant@citrix.com>
References: <1525442134-20488-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/8] xen_backend: add an emulation of grant
 copy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

Not all Xen environments support the xengnttab_grant_copy() operation.
E.g. where the OS is FreeBSD or Xen is older than 4.8.0.

This patch introduces an emulation of that operation using
xengnttab_map_domain_grant_refs() and memcpy() for those environments.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

v2:
 - New in v2
---
 hw/xen/xen_backend.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 50412d6..3c3fc2c 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -146,6 +146,55 @@ void xen_be_unmap_grant_refs(struct XenDevice *xendev, void *ptr,
     }
 }
 
+static int compat_copy_grant_refs(struct XenDevice *xendev,
+                                  bool to_domain,
+                                  XenGrantCopySegment segs[],
+                                  unsigned int nr_segs)
+{
+    uint32_t *refs = g_new(uint32_t, nr_segs);
+    int prot = to_domain ? PROT_WRITE : PROT_READ;
+    void *pages;
+    unsigned int i;
+
+    for (i = 0; i < nr_segs; i++) {
+        XenGrantCopySegment *seg = &segs[i];
+
+        refs[i] = to_domain ?
+            seg->dest.foreign.ref : seg->source.foreign.ref;
+    }
+
+    pages = xengnttab_map_domain_grant_refs(xendev->gnttabdev, nr_segs,
+                                            xen_domid, refs, prot);
+    if (!pages) {
+        xen_pv_printf(xendev, 0,
+                      "xengnttab_map_domain_grant_refs failed: %s\n",
+                      strerror(errno));
+        g_free(refs);
+        return -1;
+    }
+
+    for (i = 0; i < nr_segs; i++) {
+        XenGrantCopySegment *seg = &segs[i];
+        void *page = pages + (i * XC_PAGE_SIZE);
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
+    if (xengnttab_unmap(xendev->gnttabdev, pages, nr_segs)) {
+        xen_pv_printf(xendev, 0, "xengnttab_unmap failed: %s\n",
+                      strerror(errno));
+    }
+
+    g_free(refs);
+    return 0;
+}
+
 int xen_be_copy_grant_refs(struct XenDevice *xendev,
                            bool to_domain,
                            XenGrantCopySegment segs[],
@@ -157,6 +206,10 @@ int xen_be_copy_grant_refs(struct XenDevice *xendev,
 
     assert(xendev->ops->flags & DEVOPS_FLAG_NEED_GNTDEV);
 
+    if (!xen_feature_grant_copy) {
+        return compat_copy_grant_refs(xendev, to_domain, segs, nr_segs);
+    }
+
     xengnttab_segs = g_new0(xengnttab_grant_copy_segment_t, nr_segs);
 
     for (i = 0; i < nr_segs; i++) {
-- 
2.1.4
