Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC380C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DADA2226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LgwDRzb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DADA2226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpg1-00089H-3x
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVV-0005GK-LS
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:14 -0400
Received: from ozlabs.org ([203.11.71.1]:56381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVT-0001nH-Qm
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wY1kmXz9sW8; Fri,  9 Oct 2020 21:19:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238797;
 bh=WcyYV+kZY+086wNw+Z/Sbe9MiDsZS9bDNtuk6FQ7o84=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LgwDRzb8US2vMVl60mseFjIkYu43O+TvaE+Yuxi9043gnzUNlYwT6z6mEacf2Z3gN
 YMnx7+JiOFkgjrJJ7qF173tQo5pbE+29eh0J286dIz8ef1lX/6DpqlyHBf1Tq1eit2
 7A7g9zy2bZNXXN8T0RhnsYl9T8NVTkLXvC3ov7gg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 13/20] spapr: Add a return value to spapr_nvdimm_validate()
Date: Fri,  9 Oct 2020 21:19:44 +1100
Message-Id: <20201009101951.1569252-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 06:19:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 dbarboza@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nonngu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

As recommended in "qapi/error.h", return true on success and false on
failure. This allows to reduce error propagation overhead in the callers.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200914123505.612812-13-groug@kaod.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                |  4 +---
 hw/ppc/spapr_nvdimm.c         | 14 ++++++++------
 include/hw/ppc/spapr_nvdimm.h |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c6af456cfc..7f3a620d41 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3478,9 +3478,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     if (is_nvdimm) {
-        spapr_nvdimm_validate(hotplug_dev, NVDIMM(dev), size, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!spapr_nvdimm_validate(hotplug_dev, NVDIMM(dev), size, errp)) {
             return;
         }
     } else if (size % SPAPR_MEMORY_BLOCK_SIZE) {
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index c06f903e5b..b3a489e9fe 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -33,7 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr_numa.h"
 
-void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
+bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp)
 {
     const MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
@@ -45,7 +45,7 @@ void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
 
     if (!mc->nvdimm_supported) {
         error_setg(errp, "NVDIMM hotplug not supported for this machine");
-        return;
+        return false;
     }
 
     /*
@@ -59,20 +59,20 @@ void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
      */
     if (!ms->nvdimms_state->is_enabled && nvdimm_opt) {
         error_setg(errp, "nvdimm device found but 'nvdimm=off' was set");
-        return;
+        return false;
     }
 
     if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
                                 &error_abort) == 0) {
         error_setg(errp, "PAPR requires NVDIMM devices to have label-size set");
-        return;
+        return false;
     }
 
     if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
         error_setg(errp, "PAPR requires NVDIMM memory size (excluding label)"
                    " to be a multiple of %" PRIu64 "MB",
                    SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
-        return;
+        return false;
     }
 
     uuidstr = object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP,
@@ -82,8 +82,10 @@ void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
 
     if (qemu_uuid_is_null(&uuid)) {
         error_setg(errp, "NVDIMM device requires the uuid to be set");
-        return;
+        return false;
     }
+
+    return true;
 }
 
 
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index 3eb344e8e9..b834d82f55 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -28,7 +28,7 @@ QEMU_BUILD_BUG_ON(SPAPR_MINIMUM_SCM_BLOCK_SIZE % SPAPR_MEMORY_BLOCK_SIZE);
 int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp);
 void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
-void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
+bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
 void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
-- 
2.26.2


