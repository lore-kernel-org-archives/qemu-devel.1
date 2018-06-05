Received: from eggs.gnu.org ([2001:4830:134:3::10]:53778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQBst-0000S3-8l
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQBsr-0006Yd-To
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQBsr-0006YI-NR
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:21 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Jun 2018 21:19:44 +0800
Message-Id: <20180605131944.14649-4-peterx@redhat.com>
In-Reply-To: <20180605131944.14649-1-peterx@redhat.com>
References: <20180605131944.14649-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 3/3] memory: introduce IOMMU_NOTIFIER_USER_[UN]SET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Add two more IOMMU notifier flags to selectively choose whether the
notifier would like to listen to an event that with USER bit set/unset.
Note that all existing notifiers should always been registered with both
of the flags set to make sure they'll receive the notification no matter
whether the USER bit is set or unset in the attributes.  To simplify
this procedure, some new macros are defined.  The old UNMAP-only
notifiers should now be registered with IOMMU_NOTIFIER_UNMAP_ALL
flags (rather than the old IOMMU_NOTIFIER_UNMAP flag), while the old
MAP+UNMAP case can keep to use the IOMMU_NOTIFIER_ALL flag.

Now if a new notifier would like to register to only UNMAP notifications
with USER bit set, it should register with below flag:

  IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_USER_SET

Then when we want to notify a DMA invalidation (we call it IOMMUTLBEntry
in QEMU), we should do this:

  IOMMUTLBEntry entry;
  ... (set up the fields)
  entry.perm = IOMMU_NONE;
  entry.attrs.user = 1;
  memory_region_notify_iommu(mr, &entry);

Then only the notifiers registered with IOMMU_NOTIFIER_USER_SET will
receive this notification.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 48 ++++++++++++++++++++++++++++++++++++++-----
 hw/virtio/vhost.c     |  2 +-
 memory.c              | 10 +++++++++
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 12865a4890..fb9a7059c6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -82,18 +82,56 @@ struct IOMMUTLBEntry {
 };
 
 /*
- * Bitmap for different IOMMUNotifier capabilities. Each notifier can
- * register with one or multiple IOMMU Notifier capability bit(s).
+ * Bitmap for different IOMMUNotifier capabilities.  Please refer to
+ * comments for each notifier capability to know its usage. Note that,
+ * a notifier registered with (UNMAP | USER_SET) does not mean that
+ * it'll notify both MAP notifies and USER_SET notifies, instead it
+ * means it'll only be notified for the events that are UNMAP
+ * meanwhile with USER attribute set.
  */
 typedef enum {
     IOMMU_NOTIFIER_NONE = 0,
-    /* Notify cache invalidations */
+    /*
+     * When set, will notify deleted entries (cache invalidations).
+     * When unset, will not notify deleted entries.
+     */
     IOMMU_NOTIFIER_UNMAP = 0x1,
-    /* Notify entry changes (newly created entries) */
+    /*
+     * When set, will notify newly created entries.  When unset, will
+     * not notify newly created entries.
+     */
     IOMMU_NOTIFIER_MAP = 0x2,
+    /*
+     * When set, will notify when the USER bit is set in
+     * IOMMUTLBEntry.attrs.  When unset, will not notify when the USER
+     * bit is set.
+     */
+    IOMMU_NOTIFIER_USER_SET = 0x4,
+    /*
+     * When set, will notify when the USER bit is cleared in
+     * IOMMUTLBEntry.attrs.  When unset, will not notify when the USER
+     * bit is cleared.
+     */
+    IOMMU_NOTIFIER_USER_UNSET = 0x8,
 } IOMMUNotifierFlag;
 
-#define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
+/* Use this when the notifier does not care about USER bit */
+#define IOMMU_NOTIFIER_USER_ALL \
+    (IOMMU_NOTIFIER_USER_SET | IOMMU_NOTIFIER_USER_UNSET)
+
+/* Use this when the notifier does not care about any attribute */
+#define IOMMU_NOTIFIER_ATTRS_ALL \
+    (IOMMU_NOTIFIER_USER_ALL)
+
+/* Use this to notify all UNMAP notifications */
+#define IOMMU_NOTIFIER_UNMAP_ALL \
+    (IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_ATTRS_ALL)
+
+/* Use this to notify all notifications */
+#define IOMMU_NOTIFIER_ALL (                    \
+        IOMMU_NOTIFIER_MAP |                    \
+        IOMMU_NOTIFIER_UNMAP |                  \
+        IOMMU_NOTIFIER_ATTRS_ALL)
 
 struct IOMMUNotifier;
 typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 96175b214d..da6efeadad 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -672,7 +672,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
                      section->size);
     end = int128_sub(end, int128_one());
     iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
-                        IOMMU_NOTIFIER_UNMAP,
+                        IOMMU_NOTIFIER_UNMAP_ALL,
                         section->offset_within_region,
                         int128_get64(end));
     iommu->mr = section->mr;
diff --git a/memory.c b/memory.c
index 376f72b19c..9e4617df5a 100644
--- a/memory.c
+++ b/memory.c
@@ -1880,6 +1880,16 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
         return;
     }
 
+    if (!(notifier->notifier_flags & IOMMU_NOTIFIER_USER_SET) &&
+        entry->attrs.user) {
+        return;
+    }
+
+    if (!(notifier->notifier_flags & IOMMU_NOTIFIER_USER_UNSET) &&
+        !entry->attrs.user) {
+        return;
+    }
+
     if (entry->perm & IOMMU_RW) {
         request_flags = IOMMU_NOTIFIER_MAP;
     } else {
-- 
2.17.0
