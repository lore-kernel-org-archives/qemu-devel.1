Received: from eggs.gnu.org ([2001:4830:134:3::10]:35339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2XC-00052g-MK
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2XB-0002Gx-Nq
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2XB-0002Gn-H1
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:29 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:23 +0200
Message-Id: <20180829153624.12299-20-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 19/20] virtio-pmem: hotplug support functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

virtio-pmem devices will have to be hotplugged using the machine hotplug
handler just like other memory devices. Therefore, all machines that
want to support virtio-pmem will have to modify their machine hotplug
handler.

virtio-pmem devices are realized when their parent proxy device
(virtio-pmem-pci) is realized. Therefore, they are attached to a bus
without a hotplug handler. This makes things a lot easier, because
without a hotplug handler, we can directly get control over the device
in the machine hotplug handler (otherwise we would have to overwrite
control and pass control to the bus hotplug handler from the machine
hotplug handler).

As we have to implement support for each machine we want to support,
add a safety net ("pre_plugged") that catches if the pre_plug handler
was not called - if trying to realize it with a machine that does not
support it.

Otherwise creating and realizing virtio-pmem-pci along with virtio-pmem
would work, however the memory-device part would not properly get
hotplugged.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-pmem.c         | 34 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-pmem.h | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 27ff064682..ca65be4af2 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -112,6 +112,12 @@ static void virtio_pmem_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* pre_plug handler wasn't executed (e.g. from machine hotplug handler) */
+    if (!pmem->pre_plugged) {
+        error_setg(errp, "virtio-pmem is not compatible with the machine");
+        return;
+    }
+
     host_memory_backend_set_mapped(pmem->memdev, true);
     virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
                                           sizeof(struct virtio_pmem_config));
@@ -203,6 +209,34 @@ static void virtio_pmem_class_init(ObjectClass *klass, void *data)
     mdc->fill_device_info = virtio_pmem_md_fill_device_info;
 }
 
+void virtio_pmem_pre_plug(VirtIOPMEM *pmem, MachineState *ms, Error **errp)
+{
+    /*
+     * The proxy device (e.g. virtio-pmem-pci) has an hotplug handler and
+     * will attach the virtio-pmem device to its bus (parent_bus). This
+     * device will realize the virtio-mem device from its realize function,
+     * therefore when it is hotplugged itself. The proxy device bus
+     * therefore has no hotplug handler and we don't have to forward any
+     * calls.
+     */
+    if (!DEVICE(pmem)->parent_bus ||
+        DEVICE(pmem)->parent_bus->hotplug_handler) {
+        error_setg(errp, "virtio-pmem is not compatible with the proxy.");
+    }
+    memory_device_pre_plug(MEMORY_DEVICE(pmem), ms, NULL, errp);
+    pmem->pre_plugged = true;
+}
+
+void virtio_pmem_plug(VirtIOPMEM *pmem, MachineState *ms, Error **errp)
+{
+    memory_device_plug(MEMORY_DEVICE(pmem), ms);
+}
+
+void virtio_pmem_unplug(VirtIOPMEM *pmem, MachineState *ms, Error **errp)
+{
+    memory_device_unplug(MEMORY_DEVICE(pmem), ms);
+}
+
 static TypeInfo virtio_pmem_info = {
     .name          = TYPE_VIRTIO_PMEM,
     .parent        = TYPE_VIRTIO_DEVICE,
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index 11e549e0f1..640051f3b6 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -31,10 +31,21 @@ typedef struct VirtIOPMEM {
     VirtQueue *rq_vq;
     uint64_t start;
     HostMemoryBackend *memdev;
+
+    /*
+     * Safety net to make sure we can catch trying to be realized on a
+     * machine that is not prepared to properly hotplug virtio-pmem from
+     * its machine hotplug handler.
+     */
+    bool pre_plugged;
 } VirtIOPMEM;
 
 struct virtio_pmem_config {
     uint64_t start;
     uint64_t size;
 };
+
+void virtio_pmem_pre_plug(VirtIOPMEM *pmem, MachineState *ms, Error **errp);
+void virtio_pmem_plug(VirtIOPMEM *pmem, MachineState *ms, Error **errp);
+void virtio_pmem_unplug(VirtIOPMEM *pmem, MachineState *ms, Error **errp);
 #endif
-- 
2.17.1
