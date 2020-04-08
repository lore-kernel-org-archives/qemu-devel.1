Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59A3C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 12:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A666206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 12:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A666206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMAJ6-0001jz-I8
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 08:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1jMAI6-0008VE-6t
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1jMAI4-000578-D5
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3735 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1jMAI4-00054k-1T
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DB99FAAF32453AD37B68;
 Wed,  8 Apr 2020 20:58:39 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 20:58:32 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v6 2/8] fw_cfg: Write the extra roots into the fw_cfg
Date: Wed, 8 Apr 2020 20:58:10 +0800
Message-ID: <20200408125816.955-3-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200408125816.955-1-miaoyubo@huawei.com>
References: <20200408125816.955-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: berrange@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Write the extra roots into the fw_cfg therefore the uefi could
get the extra roots. Only if the uefi know there are extra roots,
the config space of devices behind the root could be obtained.

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 hw/arm/virt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7dc96abf72..0fdfe4129c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -77,6 +77,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/pci/pci_bus.h"
=20
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1435,6 +1436,12 @@ void virt_machine_done(Notifier *notifier, void *d=
ata)
     ARMCPU *cpu =3D ARM_CPU(first_cpu);
     struct arm_boot_info *info =3D &vms->bootinfo;
     AddressSpace *as =3D arm_boot_address_space(cpu, info);
+    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path_type("",
+                                   "pcie-host-bridge", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
+
+    PCIBus *bus =3D s->bus;
=20
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
@@ -1453,6 +1460,22 @@ void virt_machine_done(Notifier *notifier, void *d=
ata)
         exit(1);
     }
=20
+    if (bus) {
+        int extra_hosts =3D 0;
+        QLIST_FOREACH(bus, &bus->child, sibling) {
+            /* look for expander root buses */
+            if (pci_bus_is_root(bus)) {
+                extra_hosts++;
+            }
+        }
+        if (extra_hosts && vms->fw_cfg) {
+            uint64_t *val =3D g_malloc(sizeof(*val));
+            *val =3D cpu_to_le64(extra_hosts);
+            fw_cfg_add_file(vms->fw_cfg,
+                   "etc/extra-pci-roots", val, sizeof(*val));
+        }
+    }
+
     virt_acpi_setup(vms);
     virt_build_smbios(vms);
 }
--=20
2.19.1



