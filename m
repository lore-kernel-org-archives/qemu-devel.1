Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C802DC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDDA20856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDDA20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAZtH-00074U-78
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 09:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iAZhC-0004Vk-4r
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iAZhA-0003TY-Rc
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:08:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2174 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iAZh8-0003Ql-0Y; Wed, 18 Sep 2019 09:08:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 090A599A5E7BA1C8636A;
 Wed, 18 Sep 2019 21:08:28 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 18 Sep 2019 21:08:16 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Date: Wed, 18 Sep 2019 14:06:29 +0100
Message-ID: <20190918130633.4872-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
References: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH-for-4.2 v11 07/11] hw/arm: Factor out powerdown
 notifier from GPIO
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 mst@redhat.com, linuxarm@huawei.com, xuwei5@hisilicon.com,
 shannon.zhaosl@gmail.com, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is in preparation of using GED device for
system_powerdown event. Make the powerdown notifier
registration independent of create_gpio() fn.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt.c         | 12 ++++--------
 include/hw/arm/virt.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d221841c42..dbd8c18f36 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -797,10 +797,6 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
 }
 
-static Notifier virt_system_powerdown_notifier = {
-    .notify = virt_powerdown_req
-};
-
 static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
 {
     char *nodename;
@@ -841,10 +837,6 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
                           KEY_POWER);
     qemu_fdt_setprop_cells(vms->fdt, "/gpio-keys/poweroff",
                            "gpios", phandle, 3, 0);
-
-    /* connect powerdown request */
-    qemu_register_powerdown_notifier(&virt_system_powerdown_notifier);
-
     g_free(nodename);
 }
 
@@ -1737,6 +1729,10 @@ static void machvirt_init(MachineState *machine)
         vms->acpi_dev = create_acpi_ged(vms, pic);
     }
 
+     /* connect powerdown request */
+     vms->powerdown_notifier.notify = virt_powerdown_req;
+     qemu_register_powerdown_notifier(&vms->powerdown_notifier);
+
     /* Create mmio transports, so the user can create virtio backends
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 577ee49b4b..0b41083e9d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -137,6 +137,7 @@ typedef struct {
     int psci_conduit;
     hwaddr highest_gpa;
     DeviceState *acpi_dev;
+    Notifier powerdown_notifier;
 } VirtMachineState;
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.17.1



