Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4138AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAF720771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXZutLM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAF720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnBT-0000Lc-9j
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvb-0003TF-Oo
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvZ-0001Pr-K2
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JOwCv9MKVFDSFgjABrGrn+AVAUp/DMrwQ11TkrNg4cg=;
 b=WXZutLM5+SurtjqGOXINuF+HIaWM0xq4jzhwWNcLDTRatD4VA/v+/SFXNI3+VtDUaNmPWM
 kuA8hujpJYe6WSZUDUqgWINX9Fh1hyk/37nOcft467v5fh4rwuo2cdUVLI7ojj9wTUFZt+
 vV2Uo8yLNYrtGrbI+QTmHWCjWxmtNxY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-9_pX3sr0PNCzm32s7LzL-Q-1; Sat, 04 Jul 2020 14:30:15 -0400
X-MC-Unique: 9_pX3sr0PNCzm32s7LzL-Q-1
Received: by mail-wr1-f70.google.com with SMTP id f5so36198623wrv.22
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JOwCv9MKVFDSFgjABrGrn+AVAUp/DMrwQ11TkrNg4cg=;
 b=S+d3s2Ic4k5bltno2y8q9itNNaFZu1Ro6aUyy1ezI8OBrs6hjCnv5Vzfsg4yWh0Asi
 Sjd5rTNmkzCrQYGzZBIWloaGYK+H7xzbDYq+0l1odtFX9bIAqIlF1b08D5U28DWzJs8+
 UDynCtQbDpjE+tPYZJzvmoUJehB3NxbIq6T6BBN4snRc8KDcJCt0sjyTwUo8Yrr3c5pC
 BRsdVpphrqeCXF4N9sLsZWDrhfKiniY3IprclbG4x4AbeEcfYPSPratwHRO6IfKvIqgn
 GEWavlUWm0Ms5eziE/vZCpqWM3OGTXQYLpqrgDT6KNxs3d6apyW+TdlLo4OAR51lEP1U
 vIpA==
X-Gm-Message-State: AOAM533tsJdKhpnX8YFmEbM2dhWSc+ag9rkrmc3+Q7QrkLx9Nl4kiTMl
 TjJW4qsvrE9D72Zys3zdfKTBouD7fyhZ7Jd6DQ2+20GVS1FdDmv436VuZODs8cj7ZQffG/V5dd8
 OZl3MhGqZaBSAblw=
X-Received: by 2002:adf:f484:: with SMTP id l4mr41375447wro.248.1593887413634; 
 Sat, 04 Jul 2020 11:30:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwJDF3MNrlhs1bobKirRMt/jfcHQZLi6Uli3gnpNXiogqOmeKVhat+xYx4nnqPI5V0A74ehA==
X-Received: by 2002:adf:f484:: with SMTP id l4mr41375431wro.248.1593887413403; 
 Sat, 04 Jul 2020 11:30:13 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 r3sm19906990wrg.70.2020.07.04.11.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:12 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 18/41] pc: Support for virtio-mem-pci
Message-ID: <20200704182750.1088103-19-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20200626072248.78761-16-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c    | 49 ++++++++++++++++++++++++++++---------------------
 hw/i386/Kconfig |  1 +
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 58b1425c17..576f2502f9 100644
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
-- 
MST


