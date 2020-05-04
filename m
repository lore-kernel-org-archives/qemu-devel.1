Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB76C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4073206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1VLfRid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4073206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcQi-0000M2-QV
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc8h-00020t-7H
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:32:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc8f-0008DD-Eb
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyofElCtLr0NGuMPjOyHWPcjCxNtZ4I/3Dffj/xN218=;
 b=A1VLfRidjlZ7tTB40G18t81L11nTTaft9AHyzawWXzA7QmoQCV2Y0JWebpOZrgLXz6oxBX
 mxNDaYR9SfmQs/KGqUn8WKTfSeTrl/mcNYc5xX5HPbN/iFJegYNkiwqTXAZrNqNhrv5gHd
 T01XkW7BYmleYg9JSWVtFxTVzcoUYPo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-v--rp5gjP7aGEsTflSk8yA-1; Mon, 04 May 2020 10:29:58 -0400
X-MC-Unique: v--rp5gjP7aGEsTflSk8yA-1
Received: by mail-wr1-f71.google.com with SMTP id r11so10843145wrx.21
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aaE2UTNnjw9bskNnUaoM6ia/J5Yf/idoEwzallZh50c=;
 b=HlVshVFaZd/9hlmZ8Z2QivKkMRXQZKcw4zrKlFNySdIHBEQWkaCBZTMmnr8lRLDwVQ
 m/WZLgpUwm7fW42P8vW948Re7xrgvxmoHHf/06eo0ljNV/z/auUKTsKmSYLcAhP4Suvv
 lx0lg3WHaQDOLw6B//DWECtj2nps1zTegbp2dNXu18WbvcHsFnSUB8ogJutj4P4Dtdhi
 630Ymkd1KIV+lVb0CHVh8zoCqoVqOl/1Cdu6mCo74SZol9WaHjTHtQESeh0b3ILnDMan
 MJAQElaBzRu+3DkBzSVeHs6vNvcGB1jj6m1p5ChQ/KQCUuoyZkgJuSwMzToyEPNKp1VV
 UF9g==
X-Gm-Message-State: AGi0PubqLjhQok6DcABq5YMb5RTP5s1gmHfZovPVkVx7ZG2gXWFz2Bu9
 BM5sJuko9myGIYSkBejpVnDeyU3A/lD5vNjN23Jppo8Bmjtk2BfiGH4yH62sWnJaPxTsd1F/bxt
 boFHn9X5sjXQQ8AU=
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr3980267wrw.29.1588602596389;
 Mon, 04 May 2020 07:29:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypLKle9XSLgHXV6pyTwHwzBBzsE2cGWidLqcaLEW6t5ZRQIIfmS/KbS6ZtqQX3GvkUAdU4+76A==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr3980238wrw.29.1588602596135;
 Mon, 04 May 2020 07:29:56 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id v7sm270738wmg.3.2020.05.04.07.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:55 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/29] hw/arm/virt: Add nvdimm hot-plug infrastructure
Message-ID: <20200504142814.157589-18-mst@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Kwangwoo Lee <kwangwoo.lee@sk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kwangwoo Lee <kwangwoo.lee@sk.com>

This adds support to init nvdimm acpi state and build nvdimm acpi tables.
Please note nvdimm_support is not yet enabled.

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200421125934.14952-4-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt-acpi-build.c |  6 ++++++
 hw/arm/virt.c            | 19 +++++++++++++++++++
 hw/arm/Kconfig           |  1 +
 hw/mem/Kconfig           |  2 +-
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 60b2f521eb..6d67ace76e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -79,6 +79,7 @@ enum {
     VIRT_SECURE_MEM,
     VIRT_PCDIMM_ACPI,
     VIRT_ACPI_GED,
+    VIRT_NVDIMM_ACPI,
     VIRT_LOWMEMMAP_LAST,
 };
=20
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 81d41a3990..f22b1e6097 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -44,6 +44,7 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
+#include "hw/mem/nvdimm.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
 #include "kvm_arm.h"
@@ -826,6 +827,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildT=
ables *tables)
         }
     }
=20
+    if (ms->nvdimms_state->is_enabled) {
+        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
+                          ms->nvdimms_state, ms->ram_slots);
+    }
+
     if (its_class_name() && !vmc->no_its) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 626822554d..87f29953c4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -150,6 +150,7 @@ static const MemMapEntry base_memmap[] =3D {
     [VIRT_SMMU] =3D               { 0x09050000, 0x00020000 },
     [VIRT_PCDIMM_ACPI] =3D        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =3D           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
+    [VIRT_NVDIMM_ACPI] =3D        { 0x09090000, NVDIMM_ACPI_IO_LEN},
     [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that siz=
e */
     [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
@@ -1884,6 +1885,18 @@ static void machvirt_init(MachineState *machine)
=20
     create_platform_bus(vms);
=20
+    if (machine->nvdimms_state->is_enabled) {
+        const struct AcpiGenericAddress arm_virt_nvdimm_acpi_dsmio =3D {
+            .space_id =3D AML_AS_SYSTEM_MEMORY,
+            .address =3D vms->memmap[VIRT_NVDIMM_ACPI].base,
+            .bit_width =3D NVDIMM_ACPI_IO_LEN << 3
+        };
+
+        nvdimm_init_acpi_state(machine->nvdimms_state, sysmem,
+                               arm_virt_nvdimm_acpi_dsmio,
+                               vms->fw_cfg, OBJECT(vms));
+    }
+
     vms->bootinfo.ram_size =3D machine->ram_size;
     vms->bootinfo.nb_cpus =3D smp_cpus;
     vms->bootinfo.board_id =3D -1;
@@ -2095,6 +2108,8 @@ static void virt_memory_plug(HotplugHandler *hotplug_=
dev,
                              DeviceState *dev, Error **errp)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
+    MachineState *ms =3D MACHINE(hotplug_dev);
+    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     Error *local_err =3D NULL;
=20
     pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
@@ -2102,6 +2117,10 @@ static void virt_memory_plug(HotplugHandler *hotplug=
_dev,
         goto out;
     }
=20
+    if (is_nvdimm) {
+        nvdimm_plug(ms->nvdimms_state);
+    }
+
     hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
                          dev, &error_abort);
=20
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 188419dc1e..5364172537 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -25,6 +25,7 @@ config ARM_VIRT
     select DIMM
     select ACPI_MEMORY_HOTPLUG
     select ACPI_HW_REDUCED
+    select ACPI_NVDIMM
=20
 config CHEETAH
     bool
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 2ad052a536..c27844900d 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -8,4 +8,4 @@ config MEM_DEVICE
 config NVDIMM
     bool
     default y
-    depends on (PC || PSERIES)
+    depends on (PC || PSERIES || ARM_VIRT)
--=20
MST


