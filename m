Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E48C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C7820738
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYZ4OWU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C7820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUms-0002Ry-8Q
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUjA-0001EX-Rd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:50:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUj9-00007p-PZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591195846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mw0mdLx23EtKAhBPfCJG/99vuq8yCLcIMrtP0pgjnI8=;
 b=HYZ4OWU8F9ktT8rpjCkd30MCWF2GqQ8dgnE5y5aaF3BmjzYgJHK91VWllihGiMVUaacHwt
 qU9QuwbHptik1kP4ByLkTpBchgoIzrFWV8xvmnbwKzMHtZ4K3kcDM5evtMUKAPkU9Iy0UR
 kdk0UXpGU+m8SObTZHlLrc6O79Ck6FE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-bTRVF0CNM5qxP2Gz2Ekumw-1; Wed, 03 Jun 2020 10:50:45 -0400
X-MC-Unique: bTRVF0CNM5qxP2Gz2Ekumw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FFEB80058E;
 Wed,  3 Jun 2020 14:50:44 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE98C5D9CD;
 Wed,  3 Jun 2020 14:50:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/20] virtio-pci: Send qapi events when the virtio-mem
 size changes
Date: Wed,  3 Jun 2020 16:49:11 +0200
Message-Id: <20200603144914.41645-18-david@redhat.com>
In-Reply-To: <20200603144914.41645-1-david@redhat.com>
References: <20200603144914.41645-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's register the notifier and trigger the qapi event with the right
device id.

MEMORY_DEVICE_SIZE_CHANGE is similar to BALLOON_CHANGE, however on a
memory device level.

Don't unregister the notifier (we neither have finalize() nor unrealize()
for VirtIOPCIProxy, so it's not that simple to do it) - both devices are
expected to vanish at the same time.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem-pci.c | 28 ++++++++++++++++++++++++++++
 hw/virtio/virtio-mem-pci.h |  1 +
 monitor/monitor.c          |  1 +
 qapi/misc.json             | 25 +++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index b325303b32..1a8e854123 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-mem-pci.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-misc.h"
 
 static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
@@ -74,6 +75,21 @@ static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
     info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
 }
 
+static void virtio_mem_pci_size_change_notify(Notifier *notifier, void *data)
+{
+    VirtIOMEMPCI *pci_mem = container_of(notifier, VirtIOMEMPCI,
+                                         size_change_notifier);
+    DeviceState *dev = DEVICE(pci_mem);
+    const uint64_t * const size_p = data;
+    const char *id = NULL;
+
+    if (dev->id) {
+        id = g_strdup(dev->id);
+    }
+
+    qapi_event_send_memory_device_size_change(!!id, id, *size_p);
+}
+
 static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -98,9 +114,21 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
 static void virtio_mem_pci_instance_init(Object *obj)
 {
     VirtIOMEMPCI *dev = VIRTIO_MEM_PCI(obj);
+    VirtIOMEMClass *vmc;
+    VirtIOMEM *vmem;
 
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_MEM);
+
+    dev->size_change_notifier.notify = virtio_mem_pci_size_change_notify;
+    vmem = VIRTIO_MEM(&dev->vdev);
+    vmc = VIRTIO_MEM_GET_CLASS(vmem);
+    /*
+     * We never remove the notifier again, as we expect both devices to
+     * disappear at the same time.
+     */
+    vmc->add_size_change_notifier(vmem, &dev->size_change_notifier);
+
     object_property_add_alias(obj, VIRTIO_MEM_BLOCK_SIZE_PROP,
                               OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
     object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
diff --git a/hw/virtio/virtio-mem-pci.h b/hw/virtio/virtio-mem-pci.h
index 8820cd6628..b51a28b275 100644
--- a/hw/virtio/virtio-mem-pci.h
+++ b/hw/virtio/virtio-mem-pci.h
@@ -28,6 +28,7 @@ typedef struct VirtIOMEMPCI VirtIOMEMPCI;
 struct VirtIOMEMPCI {
     VirtIOPCIProxy parent_obj;
     VirtIOMEM vdev;
+    Notifier size_change_notifier;
 };
 
 #endif /* QEMU_VIRTIO_MEM_PCI_H */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 125494410a..19dcb8fbe3 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -235,6 +235,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
     [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
+    [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
 };
 
 /*
diff --git a/qapi/misc.json b/qapi/misc.json
index e1c5547b65..4b25daeadb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1432,6 +1432,31 @@
 ##
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
 
+##
+# @MEMORY_DEVICE_SIZE_CHANGE:
+#
+# Emitted when the size of a memory device changes. Only emitted for memory
+# devices that can actually change the size (e.g., virtio-mem due to guest
+# action).
+#
+# @id: device's ID
+# @size: the new size of memory that the device provides
+#
+# Note: this event is rate-limited.
+#
+# Since: 5.1
+#
+# Example:
+#
+# <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
+#      "data": { "id": "vm0", "size": 1073741824},
+#      "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
+#
+##
+{ 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
+  'data': { '*id': 'str', 'size': 'size' } }
+
+
 ##
 # @MEM_UNPLUG_ERROR:
 #
-- 
2.25.4


