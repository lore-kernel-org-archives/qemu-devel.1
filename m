Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D59C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E03206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7fn/ih1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E03206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcNT-0002iw-VW
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc9a-0003Lp-8L
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:33:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc9X-0008OT-8q
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOdWrTDlgPPkMHeJucHbghgUuY8aAHcAGANlC4mF4bs=;
 b=J7fn/ih1nH9/dkPQwBkvaDlrUpIyfh13Q1nfiIf40dMagpHQYJHVpqkoE+4NDtEp0dmMbM
 B+XfK4hJ+Th1OnI/RHdnPwqQtUbEIoDAfvySRjL4q9UtyegKpBDIWr+K7jIukCiDwVuthM
 Yf7aTqzBBnZw7VyZSwVLGkiDWou/JmM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-OXYJzj6EOOSr5f1GXvIZoQ-1; Mon, 04 May 2020 10:29:59 -0400
X-MC-Unique: OXYJzj6EOOSr5f1GXvIZoQ-1
Received: by mail-wm1-f70.google.com with SMTP id u11so3585431wmc.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vk5zcT78ttafQi3FbOHb+B7bkLDdTDjQjWP7o7Og/l0=;
 b=aR+sFK+H2HIqb7LwHn6q4W5MjYT/S/ICmJc7iqlKqRMEDzV4su9oIBY62sAL/BoiaS
 x5XdxDaAdQYtATDjmwL+kyE1+ZPJhnGXaa/df9OgfQdPlOruZtzznzu+gI7sAHSsIZPs
 GQA76M05/wnD4jBFwE08ePbulVZ05uqkIW9aqaRdIhRM3aO85gPANNV+D0u/ngf8Hl1h
 D4VKvdOZXd5O+I/yIDBA+FRq2ZT7D7m6gZ9ogG1K93vUz6bq5COPBTGb4Yo7H+tN8kSN
 LhDav5J3yogIHsUxkmU7oyMEWbYq8eUy3pcwepumfUjHW/IBq8zZwlVuZef8cx8Nzd8x
 Yj9A==
X-Gm-Message-State: AGi0PuakEDlVdvwM34L4adFNzEMxb9lFQk+ggeY4gvS3x7bkY3iTaj5S
 X+rQqDWnQZ8wmRmmer9Jg48/Z9oMe1Rh8UhHfIq/VwlgOsDxXBMTv1LsB26/A/6WTKkxTxES2sT
 /7/NH8fPDZuh4kn0=
X-Received: by 2002:a1c:9a81:: with SMTP id
 c123mr14208675wme.115.1588602598667; 
 Mon, 04 May 2020 07:29:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypLuIEh7/IC/hxiyMfl3Y5UBTEdFqY0OIhqmJFZYRfabUp9B5YmiSAjoskGkNPsgsJ93k8MbDA==
X-Received: by 2002:a1c:9a81:: with SMTP id
 c123mr14208656wme.115.1588602598453; 
 Mon, 04 May 2020 07:29:58 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 w4sm19316679wro.28.2020.05.04.07.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:58 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/29] hw/arm/virt: Add nvdimm hotplug support
Message-ID: <20200504142814.157589-19-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This adds support for nvdimm hotplug events through GED
and enables nvdimm for the arm/virt. Now Guests with ACPI
can have both cold and hot plug of nvdimms.

Hot removal functionality is not yet supported.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20200421125934.14952-5-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/generic_event_device.h |  1 +
 hw/acpi/generic_event_device.c         | 15 ++++++++++++++-
 hw/arm/virt.c                          | 16 +++++++++++-----
 docs/specs/acpi_hw_reduced_hotplug.rst |  3 ++-
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/gener=
ic_event_device.h
index d157eac088..9eb86ca4fd 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -82,6 +82,7 @@
  */
 #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
 #define ACPI_GED_PWR_DOWN_EVT      0x2
+#define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
=20
 typedef struct GEDState {
     MemoryRegion io;
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.=
c
index 021ed2bf23..5d17f78a1e 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -16,6 +16,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/irq.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
@@ -23,6 +24,7 @@
 static const uint32_t ged_supported_events[] =3D {
     ACPI_GED_MEM_HOTPLUG_EVT,
     ACPI_GED_PWR_DOWN_EVT,
+    ACPI_GED_NVDIMM_HOTPLUG_EVT,
 };
=20
 /*
@@ -110,6 +112,11 @@ void build_ged_aml(Aml *table, const char *name, Hotpl=
ugHandler *hotplug_dev,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_NVDIMM_HOTPLUG_EVT:
+                aml_append(if_ctx,
+                           aml_notify(aml_name("\\_SB.NVDR"),
+                                      aml_int(0x80)));
+                break;
             default:
                 /*
                  * Please make sure all the events in ged_supported_events=
[]
@@ -175,7 +182,11 @@ static void acpi_ged_device_plug_cb(HotplugHandler *ho=
tplug_dev,
     AcpiGedState *s =3D ACPI_GED(hotplug_dev);
=20
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
+        if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
+            nvdimm_acpi_plug_cb(hotplug_dev, dev);
+        } else {
+            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
+        }
     } else {
         error_setg(errp, "virt: device plug request for unsupported device=
"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -192,6 +203,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, Acp=
iEventStatusBits ev)
         sel =3D ACPI_GED_MEM_HOTPLUG_EVT;
     } else if (ev & ACPI_POWER_DOWN_STATUS) {
         sel =3D ACPI_GED_PWR_DOWN_EVT;
+    } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
+        sel =3D ACPI_GED_NVDIMM_HOTPLUG_EVT;
     } else {
         /* Unknown event. Return without generating interrupt. */
         warn_report("GED: Unsupported event %d. No irq injected", ev);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 87f29953c4..171e6908ec 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -568,6 +568,10 @@ static inline DeviceState *create_acpi_ged(VirtMachine=
State *vms)
         event |=3D ACPI_GED_MEM_HOTPLUG_EVT;
     }
=20
+    if (ms->nvdimms_state->is_enabled) {
+        event |=3D ACPI_GED_NVDIMM_HOTPLUG_EVT;
+    }
+
     dev =3D qdev_create(NULL, TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
=20
@@ -2088,19 +2092,20 @@ static void virt_memory_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
                                  Error **errp)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
+    const MachineState *ms =3D MACHINE(hotplug_dev);
     const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)=
;
=20
-    if (is_nvdimm) {
-        error_setg(errp, "nvdimm is not yet supported");
-        return;
-    }
-
     if (!vms->acpi_dev) {
         error_setg(errp,
                    "memory hotplug is not enabled: missing acpi-ged device=
");
         return;
     }
=20
+    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: add 'nvdimm=3Don' to '-M'=
");
+        return;
+    }
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
 }
=20
@@ -2245,6 +2250,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
     hc->plug =3D virt_machine_device_plug_cb;
     hc->unplug_request =3D virt_machine_device_unplug_request_cb;
     mc->numa_mem_supported =3D true;
+    mc->nvdimm_supported =3D true;
     mc->auto_enable_numa_with_memhp =3D true;
     mc->default_ram_id =3D "mach-virt.ram";
=20
diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_re=
duced_hotplug.rst
index 911a98255b..0bd3f9399f 100644
--- a/docs/specs/acpi_hw_reduced_hotplug.rst
+++ b/docs/specs/acpi_hw_reduced_hotplug.rst
@@ -63,7 +63,8 @@ GED IO interface (4 byte access)
     bits:
        0: Memory hotplug event
        1: System power down event
-    2-31: Reserved
+       2: NVDIMM hotplug event
+    3-31: Reserved
=20
 **write_access:**
=20
--=20
MST


