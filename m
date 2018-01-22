Received: from eggs.gnu.org ([2001:4830:134:3::10]:52358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edVCV-0000bQ-Ou
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1edVCU-0004c4-Lg
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1edVCU-0004bf-DF
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 01:03:22 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 22 Jan 2018 14:02:44 +0800
Message-Id: <20180122060244.29368-5-peterx@redhat.com>
In-Reply-To: <20180122060244.29368-1-peterx@redhat.com>
References: <20180122060244.29368-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] memory: do explicit cleanup when remove
 listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com

When unregister memory listeners, we should call, e.g.,
region_del() (and possibly other undo operations) on every existing
memory region sections there, otherwise we may leak resources that are
held during the region_add(). This patch undo the stuff for the
listeners, which emulates the case when the address space is set from
current to an empty state.

I found this problem when debugging a refcount leak issue that leads to
a device unplug event lost (please see the "Bug:" line below).  In that
case, the leakage of resource is the PCI BAR memory region refcount.
And since memory regions are not keeping their own refcount but onto
their owners, so the vfio-pci device's (who is the owner of the PCI BAR
memory regions) refcount is leaked, and event missing.

We had encountered similar issues before and fixed in other
way (ee4c112846, "vhost: Release memory references on cleanup"). This
patch can be seen as a more high-level fix of similar problems that are
caused by the resource leaks from memory listeners. So now we can remove
the explicit unref of memory regions since that'll be done altogether
during unregistering of listeners now.

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1531393
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/virtio/vhost.c |  4 ----
 memory.c          | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 19a7a3cb37..54480ffd85 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1368,10 +1368,6 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     if (hdev->mem) {
         /* those are only safe after successful init */
         memory_listener_unregister(&hdev->memory_listener);
-        for (i = 0; i < hdev->n_mem_sections; ++i) {
-            MemoryRegionSection *section = &hdev->mem_sections[i];
-            memory_region_unref(section->mr);
-        }
         QLIST_REMOVE(hdev, entry);
     }
     if (hdev->migration_blocker) {
diff --git a/memory.c b/memory.c
index 4b41fb837b..9ad98b701b 100644
--- a/memory.c
+++ b/memory.c
@@ -2609,6 +2609,32 @@ static void listener_add_address_space(MemoryListener *listener,
     flatview_unref(view);
 }
 
+static void listener_del_address_space(MemoryListener *listener,
+                                       AddressSpace *as)
+{
+    FlatView *view;
+    FlatRange *fr;
+
+    if (listener->begin) {
+        listener->begin(listener);
+    }
+    view = address_space_get_flatview(as);
+    FOR_EACH_FLAT_RANGE(fr, view) {
+        MemoryRegionSection section = section_from_flat_range(fr, view);
+
+        if (fr->dirty_log_mask && listener->log_stop) {
+            listener->log_stop(listener, &section, fr->dirty_log_mask, 0);
+        }
+        if (listener->region_del) {
+            listener->region_del(listener, &section);
+        }
+    }
+    if (listener->commit) {
+        listener->commit(listener);
+    }
+    flatview_unref(view);
+}
+
 void memory_listener_register(MemoryListener *listener, AddressSpace *as)
 {
     MemoryListener *other = NULL;
@@ -2649,6 +2675,7 @@ void memory_listener_unregister(MemoryListener *listener)
         return;
     }
 
+    listener_del_address_space(listener, listener->address_space);
     QTAILQ_REMOVE(&memory_listeners, listener, link);
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
     listener->address_space = NULL;
-- 
2.14.3
