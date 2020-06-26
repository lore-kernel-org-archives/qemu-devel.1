Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1849C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEBE2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeT0dYpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEBE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jois7-000861-25
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joij2-0001Wk-VI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:24:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joij0-0003lv-60
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593156277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5mY3LP9AHhqRx8iwuJVVbuunKfV44N7emFnc2DrY3E=;
 b=DeT0dYpoMzjiy/M/aYzBtDBJP/+NPxsToAayUKyCAPnM/V39cqUi6QoJf2RMt11+RyB0LF
 5Wtpe2Skn61puRlaYOOnxenPagMpCbY8VJ26yyef812rNY05m20YbDvE5vQ6UMUR7jky8B
 D8sxfDkCd8JSQLvmEEG8oMGGyQBatZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Qile2Tv0P4qpu1Kt2z6Ahw-1; Fri, 26 Jun 2020 03:24:33 -0400
X-MC-Unique: Qile2Tv0P4qpu1Kt2z6Ahw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B9801800D4A;
 Fri, 26 Jun 2020 07:24:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-35.ams2.redhat.com [10.36.113.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58EF17C1FB;
 Fri, 26 Jun 2020 07:24:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/21] pc: Support for virtio-mem-pci
Date: Fri, 26 Jun 2020 09:22:42 +0200
Message-Id: <20200626072248.78761-16-david@redhat.com>
In-Reply-To: <20200626072248.78761-1-david@redhat.com>
References: <20200626072248.78761-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's wire it up similar to virtio-pmem. Also disallow unplug, so it's
harder for users to shoot themselves into the foot.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/Kconfig |  1 +
 hw/i386/pc.c    | 49 ++++++++++++++++++++++++++++---------------------
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index c93f32f657..03e347b207 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -35,6 +35,7 @@ config PC
     select ACPI_PCI
     select ACPI_VMGENID
     select VIRTIO_PMEM_SUPPORTED
+    select VIRTIO_MEM_SUPPORTED
 
 config PC_PCI
     bool
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2dfd69b973..f2a18a3276 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -88,6 +88,7 @@
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
 #include "hw/virtio/virtio-pmem-pci.h"
+#include "hw/virtio/virtio-mem-pci.h"
 #include "hw/mem/memory-device.h"
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
@@ -1637,8 +1638,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
 
-static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
-                                        DeviceState *dev, Error **errp)
+static void pc_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
 {
     HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
     Error *local_err = NULL;
@@ -1649,7 +1650,8 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
          * order. We should never reach this point when hotplugging on x86,
          * however, better add a safety net.
          */
-        error_setg(errp, "virtio-pmem-pci hotplug not supported on this bus.");
+        error_setg(errp, "hotplug of virtio based memory devices not supported"
+                   " on this bus.");
         return;
     }
     /*
@@ -1664,8 +1666,8 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
-static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
-                                    DeviceState *dev, Error **errp)
+static void pc_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
+                                  DeviceState *dev, Error **errp)
 {
     HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
     Error *local_err = NULL;
@@ -1685,17 +1687,17 @@ static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
-static void pc_virtio_pmem_pci_unplug_request(HotplugHandler *hotplug_dev,
-                                              DeviceState *dev, Error **errp)
+static void pc_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **errp)
 {
-    /* We don't support virtio pmem hot unplug */
-    error_setg(errp, "virtio pmem device unplug not supported.");
+    /* We don't support hot unplug of virtio based memory devices */
+    error_setg(errp, "virtio based memory devices cannot be unplugged.");
 }
 
-static void pc_virtio_pmem_pci_unplug(HotplugHandler *hotplug_dev,
-                                      DeviceState *dev, Error **errp)
+static void pc_virtio_md_pci_unplug(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
 {
-    /* We don't support virtio pmem hot unplug */
+    /* We don't support hot unplug of virtio based memory devices */
 }
 
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
@@ -1705,8 +1707,9 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_pre_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
-        pc_virtio_pmem_pci_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        pc_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1717,8 +1720,9 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
-        pc_virtio_pmem_pci_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        pc_virtio_md_pci_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1729,8 +1733,9 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
-        pc_virtio_pmem_pci_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        pc_virtio_md_pci_unplug_request(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -1744,8 +1749,9 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_cb(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
-        pc_virtio_pmem_pci_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        pc_virtio_md_pci_unplug(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -1757,7 +1763,8 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
 
-- 
2.26.2


