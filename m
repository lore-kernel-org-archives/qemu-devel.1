Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0443C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9450920B80
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9450920B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLAA-0007VK-UA
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoheyi@linux.alibaba.com>)
 id 1jrIFB-0006jK-Vo; Fri, 03 Jul 2020 05:44:29 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:26366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoheyi@linux.alibaba.com>)
 id 1jrIF5-0007Bp-4S; Fri, 03 Jul 2020 05:44:25 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01422; MF=guoheyi@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0U1ZX4ow_1593769422; 
Received: from
 laochao-HP-ProDesk-680-G1-TWR.hz.ali.com(mailfrom:guoheyi@linux.alibaba.com
 fp:SMTPD_---0U1ZX4ow_1593769422) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Jul 2020 17:43:53 +0800
From: Heyi Guo <guoheyi@linux.alibaba.com>
To: qemu-devel@nongnu.org
Subject: [RFC] virt/acpi: set PSCI flag even when psci_conduit is disabled
Date: Fri,  3 Jul 2020 17:43:29 +0800
Message-Id: <1593769409-13534-1-git-send-email-guoheyi@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=47.88.44.36;
 envelope-from=guoheyi@linux.alibaba.com; helo=out4436.biz.mail.alibaba.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:44:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 03 Jul 2020 08:50:53 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>, yitian.ly@alibaba-inc.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Heyi Guo <guoheyi@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vms->psci_conduit being disabled only means PSCI is not implemented by
qemu; it doesn't mean PSCI is not supported on this virtual machine.
Actually vms->psci_conduit is set to disabled when vms->secure and
firmware_loaded are both set, which means we will run ARM trusted
firmware, which will definitely provide PSCI.

The issue can be reproduced when running qemu in TCG mode with secure
enabled, while using ARM trusted firmware + qemu virt UEFI as firmware
binaries, and we can see secondary cores will not be waken up.

Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>

---
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
---
 hw/arm/virt-acpi-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1384a2c..7622b97 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -728,13 +728,16 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
     };
 
     switch (vms->psci_conduit) {
-    case QEMU_PSCI_CONDUIT_DISABLED:
-        fadt.arm_boot_arch = 0;
-        break;
     case QEMU_PSCI_CONDUIT_HVC:
         fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT |
                              ACPI_FADT_ARM_PSCI_USE_HVC;
         break;
+    /*
+     * QEMU_PSCI_CONDUIT_DISABLED only means PSCI is not implemented by qemu,
+     * but typically it will still be provided by secure firmware, and it should
+     * use SMC as PSCI conduit.
+     */
+    case QEMU_PSCI_CONDUIT_DISABLED:
     case QEMU_PSCI_CONDUIT_SMC:
         fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT;
         break;
-- 
2.7.4


