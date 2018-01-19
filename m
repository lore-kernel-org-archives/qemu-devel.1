Received: from eggs.gnu.org ([2001:4830:134:3::10]:53558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ecSG0-0008V2-Md
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ecSFz-0004Dk-MD
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ecSFz-00045s-Fm
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:39 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 Jan 2018 16:42:18 +0800
Message-Id: <20180119084219.31187-2-peterx@redhat.com>
In-Reply-To: <20180119084219.31187-1-peterx@redhat.com>
References: <20180119084219.31187-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 1/2] memory: do explicit cleanup when remove
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
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>

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

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1531393
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/memory.c b/memory.c
index 4b41fb837b..7d0064bd52 100644
--- a/memory.c
+++ b/memory.c
@@ -2609,6 +2609,29 @@ static void listener_add_address_space(MemoryListener *listener,
     flatview_unref(view);
 }
 
+static void listener_del_address_space(MemoryListener *listener,
+                                       AddressSpace *as)
+{
+    FlatView *view;
+    FlatRange *fr;
+
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
@@ -2649,6 +2672,7 @@ void memory_listener_unregister(MemoryListener *listener)
         return;
     }
 
+    listener_del_address_space(listener, listener->address_space);
     QTAILQ_REMOVE(&memory_listeners, listener, link);
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as);
     listener->address_space = NULL;
-- 
2.14.3
