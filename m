Received: from eggs.gnu.org ([2001:4830:134:3::10]:50493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66809d549=Paul.Durrant@citrix.com>)
	id 1fJKwx-0005FT-Aw
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66809d549=Paul.Durrant@citrix.com>)
	id 1fJKws-0006Ss-9i
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:36:15 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 17 May 2018 16:35:50 +0100
Message-ID: <1526571358-26685-2-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1526571358-26685-1-git-send-email-paul.durrant@citrix.com>
References: <1526571358-26685-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/9] xen: add a meaningful declaration of
 grant_copy_segment into xen_common.h
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

Currently the xen_disk source has to carry #ifdef exclusions to compile
against Xen older then 4.8. This is a bit messy so this patch lifts the
definition of struct xengnttab_grant_copy_segment and adds it into the
pre-4.8 compat area in xen_common.h, which allows xen_disk to be cleaned
up.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

v4:
 - New in v4
---
 hw/block/xen_disk.c         | 18 ------------------
 include/hw/xen/xen_common.h | 17 +++++++++++++++--
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
index f74fcd4..78bfb41 100644
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -496,8 +496,6 @@ static int ioreq_map(struct ioreq *ioreq)
     return 0;
 }
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40800
-
 static void ioreq_free_copy_buffers(struct ioreq *ioreq)
 {
     int i;
@@ -579,22 +577,6 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
 
     return rc;
 }
-#else
-static void ioreq_free_copy_buffers(struct ioreq *ioreq)
-{
-    abort();
-}
-
-static int ioreq_init_copy_buffers(struct ioreq *ioreq)
-{
-    abort();
-}
-
-static int ioreq_grant_copy(struct ioreq *ioreq)
-{
-    abort();
-}
-#endif
 
 static int ioreq_runio_qemu_aio(struct ioreq *ioreq);
 
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 5f1402b..bbf207d 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -667,8 +667,21 @@ static inline int xen_domain_create(xc_interface *xc, uint32_t ssidref,
 
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40800
 
-
-typedef void *xengnttab_grant_copy_segment_t;
+struct xengnttab_grant_copy_segment {
+    union xengnttab_copy_ptr {
+        void *virt;
+        struct {
+            uint32_t ref;
+            uint16_t offset;
+            uint16_t domid;
+        } foreign;
+    } source, dest;
+    uint16_t len;
+    uint16_t flags;
+    int16_t status;
+};
+
+typedef struct xengnttab_grant_copy_segment xengnttab_grant_copy_segment_t;
 
 static inline int xengnttab_grant_copy(xengnttab_handle *xgt, uint32_t count,
                                        xengnttab_grant_copy_segment_t *segs)
-- 
2.1.4
