Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A74C433E3
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FDF20747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItPdKa90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FDF20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn20-0007Ru-5u
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvh-0003fN-6I
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvf-0001QE-8H
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63AWt5cO2CoZEQSqdOKoxy7llPnRyvRbfqBM0GohP60=;
 b=ItPdKa90mVbw5N41yk95qykJkFh/T7C7AHf/KtV2UFHUelbupeliPPCGg6rFzmDwKYGyzf
 f9G9+e3YEBKq3xxImG6bOdQTk8tNdiKeiPeB1xD+CMXxTaumc1oqfIi1cXye/1pHt57uUH
 wM5RcdJ5PHSv8SfX5CT+xqM8Zz4g5cs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-ul3c-U9pNtSquUySKOgMFw-1; Sat, 04 Jul 2020 14:30:21 -0400
X-MC-Unique: ul3c-U9pNtSquUySKOgMFw-1
Received: by mail-wr1-f72.google.com with SMTP id z1so6561565wrn.18
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=63AWt5cO2CoZEQSqdOKoxy7llPnRyvRbfqBM0GohP60=;
 b=O1SXsXF5V4OSWvkolDznauFPh2IhQYS0NpOy55eCfMgvIQjMqlOYw09aKe+EwocbzI
 HBvR8ptxRQq4mWvTq36q7o9HU7foGnEbmiAp4gu1DGB/NOZHsyQ77beh0ph+F52QiI1D
 Ax2MQMwFyRe3MFRArHJSENWlb5pAMY4LvnnJmnHfZmq1art25XsD8S9HDWoZM633XwmD
 ZgxMhhrlFDmV3hoJMPqsJIkQeX7L/IvhxIhBPOxsmmUT1ebkvUMwcoyQdDiaRtVq42Hm
 Pr+OIWnI9uSoio3ruVL4n7BjQ19p79h3VSd3W2tOUL+MFYx6CndH9VhOxW5Wy4wUAfOu
 8JcQ==
X-Gm-Message-State: AOAM530IqEa21BHzHhmmlO5fnufM+kS9/7waNEzlfoRx5CszXCVACIAW
 8Soqv5ZiLyU3noyxCfiUKy1yQPPwWxJdkcRkg9Ukvo93/9q0nk4qiUyFKyOctyvY6azEFUN53+u
 43YtXDLWdtaUfXuQ=
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr42380732wml.33.1593887419422; 
 Sat, 04 Jul 2020 11:30:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc33upr7FFo5w/72akmzREr4WnoMR/JUYuEC2b+6uQVh+92CED8DAXUjDhERo1t5XzAIkb1Q==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr42380716wml.33.1593887419229; 
 Sat, 04 Jul 2020 11:30:19 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 a22sm16368577wmb.4.2020.07.04.11.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:18 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 20/41] virtio-pci: Send qapi events when the virtio-mem
 size changes
Message-ID: <20200704182750.1088103-21-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20200626072248.78761-18-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/misc.json             | 25 +++++++++++++++++++++++++
 hw/virtio/virtio-mem-pci.h |  1 +
 hw/virtio/virtio-mem-pci.c | 28 ++++++++++++++++++++++++++++
 monitor/monitor.c          |  1 +
 4 files changed, 55 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index 65ca3edf32..149c925246 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1434,6 +1434,31 @@
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
-- 
MST


