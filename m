Received: from eggs.gnu.org ([2001:4830:134:3::10]:41708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaQ-0000fy-1w
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaO-0003Hn-F6
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fKqaO-0003Gb-7L
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:12 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 21 May 2018 12:35:00 -0700
Message-Id: <1526931304-7289-11-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 11/15] xen_backend: add an emulation of grant
 copy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

Not all Xen environments support the xengnttab_grant_copy() operation.
E.g. where the OS is FreeBSD or Xen is older than 4.8.0.

This patch introduces an emulation of that operation using
xengnttab_map_domain_grant_refs() and memcpy() for those environments.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
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
1.9.1
