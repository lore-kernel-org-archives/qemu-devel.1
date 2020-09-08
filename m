Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82253C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB2021897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZtncQTNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB2021897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWBn-0005T9-8R
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3O-0006Bz-AJ; Tue, 08 Sep 2020 01:20:26 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:44533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3M-0005xr-A7; Tue, 08 Sep 2020 01:20:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkm3Gp0z9sV5; Tue,  8 Sep 2020 15:20:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542400;
 bh=PeIhZBLtydKrEKfpTxjVJjL8zkvkMJjiCuSHLy0Dyv4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZtncQTNjzI6CYgyaR3Qzd3u+WUOGUUPK6y+r5Kq+xd7BQDg4EcgHf6SwZ/MR6ocJP
 giTY5ZQsttrQwAUGiWa0/ADPMUqDqrZ+RXn4QAbsb+8BecOolCwddMcAr1VYNzfWrJ
 xZUhBp5CSbU6WHyFXVOAy7OhnVMcoXMpA7NDGKRI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 13/33] spapr,
 spapr_nvdimm: fold NVDIMM validation in the same place
Date: Tue,  8 Sep 2020 15:19:33 +1000
Message-Id: <20200908051953.1616885-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

NVDIMM has different contraints and conditions than the regular
DIMM and we'll need to add at least one more.

Instead of relying on 'if (nvdimm)' conditionals in the body of
spapr_memory_pre_plug(), use the existing spapr_nvdimm_validate_opts()
and put all NVDIMM handling code there. Rename it to
spapr_nvdimm_validate() to reflect that the function is now checking
more than the nvdimm device options. This makes spapr_memory_pre_plug()
a bit easier to follow, and we can tune in NVDIMM parameters
and validation in the same place.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200825215749.213536-3-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                | 18 ++++++------------
 hw/ppc/spapr_nvdimm.c         | 10 ++++++++--
 include/hw/ppc/spapr_nvdimm.h |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dd2fa4826b..b0a04443fb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3520,7 +3520,6 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     const SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
-    const MachineClass *mc = MACHINE_CLASS(smc);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     Error *local_err = NULL;
@@ -3533,27 +3532,22 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (is_nvdimm && !mc->nvdimm_supported) {
-        error_setg(errp, "NVDIMM hotplug not supported for this machine");
-        return;
-    }
-
     size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
-        error_setg(errp, "Hotplugged memory size must be a multiple of "
-                   "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
-        return;
-    } else if (is_nvdimm) {
-        spapr_nvdimm_validate_opts(NVDIMM(dev), size, &local_err);
+    if (is_nvdimm) {
+        spapr_nvdimm_validate(hotplug_dev, NVDIMM(dev), size, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
+    } else if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+        error_setg(errp, "Hotplugged memory size must be a multiple of "
+                   "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
+        return;
     }
 
     memdev = object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 9a20a65640..bc2b65420c 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -30,13 +30,19 @@
 #include "hw/ppc/fdt.h"
 #include "qemu/range.h"
 
-void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
-                                Error **errp)
+void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
+                           uint64_t size, Error **errp)
 {
+    const MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     g_autofree char *uuidstr = NULL;
     QemuUUID uuid;
     int ret;
 
+    if (!mc->nvdimm_supported) {
+        error_setg(errp, "NVDIMM hotplug not supported for this machine");
+        return;
+    }
+
     if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
                                 &error_abort) == 0) {
         error_setg(errp, "PAPR requires NVDIMM devices to have label-size set");
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index b3330cc485..fd1736634c 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -29,8 +29,8 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp);
 int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm);
 void spapr_dt_persistent_memory(void *fdt);
-void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
-                                Error **errp);
+void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
+                           uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
 void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
 
-- 
2.26.2


