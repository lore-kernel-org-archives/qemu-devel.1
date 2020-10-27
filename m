Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C7AC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50706207BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A/Slerx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50706207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQ5U-00073t-8j
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnf-0002HX-Ql; Tue, 27 Oct 2020 10:18:12 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47381 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnd-0007cM-7r; Tue, 27 Oct 2020 10:18:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLr35DBz9sj2; Wed, 28 Oct 2020 01:17:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808276;
 bh=WtBoWbnat7omboOd9VfCOxAcVAER/a/qECF3paGFwVw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A/Slerx7+mGLmb9MrRc0mq3IM8fBaOE0+nzvXzzyKHK7KJL9IE5GJw76PX1FJi3Ep
 EIJSKqJsB9lasIFx5+nELnKgS1wfYVNaLi5jc1uB+ojdMgtkhFHGVLs3YtI55zSMlK
 6c161rTudOyhvWMlRkMyldG6jY7FYLdh3Y2I9wgY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 14/18] spapr: Simplify error handling in spapr_memory_plug()
Date: Wed, 28 Oct 2020 01:17:31 +1100
Message-Id: <20201027141735.728821-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

As recommended in "qapi/error.h", add a bool return value to
spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
of local_err in spapr_memory_plug().

This allows to get rid of the error propagation overhead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160309734178.2739814.3488437759887793902.stgit@bahia.lan>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                | 22 ++++++++++------------
 hw/ppc/spapr_nvdimm.c         |  5 +++--
 include/hw/ppc/spapr_nvdimm.h |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a5aef7a6ff..0cc19b5863 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3382,7 +3382,7 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
     return 0;
 }
 
-static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
+static bool spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                            bool dedicated_hp_event_source, Error **errp)
 {
     SpaprDrc *drc;
@@ -3403,7 +3403,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
                 spapr_drc_detach(drc);
             }
-            return;
+            return false;
         }
         if (!hotplugged) {
             spapr_drc_reset(drc);
@@ -3425,12 +3425,12 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                                            nr_lmbs);
         }
     }
+    return true;
 }
 
 static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
-    Error *local_err = NULL;
     SpaprMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     uint64_t size, addr;
@@ -3444,26 +3444,24 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (!is_nvdimm) {
         addr = object_property_get_uint(OBJECT(dimm),
                                         PC_DIMM_ADDR_PROP, &error_abort);
-        spapr_add_lmbs(dev, addr, size,
-                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                       &local_err);
+        if (!spapr_add_lmbs(dev, addr, size,
+                            spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT), errp)) {
+            goto out_unplug;
+        }
     } else {
         slot = object_property_get_int(OBJECT(dimm),
                                        PC_DIMM_SLOT_PROP, &error_abort);
         /* We should have valid slot number at this point */
         g_assert(slot >= 0);
-        spapr_add_nvdimm(dev, slot, &local_err);
-    }
-
-    if (local_err) {
-        goto out_unplug;
+        if (!spapr_add_nvdimm(dev, slot, errp)) {
+            goto out_unplug;
+        }
     }
 
     return;
 
 out_unplug:
     pc_dimm_unplug(dimm, MACHINE(ms));
-    error_propagate(errp, local_err);
 }
 
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 9e3d94071f..a833a63b5e 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -89,7 +89,7 @@ bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
 }
 
 
-void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
+bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
 {
     SpaprDrc *drc;
     bool hotplugged = spapr_drc_hotplugged(dev);
@@ -98,12 +98,13 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
     g_assert(drc);
 
     if (!spapr_drc_attach(drc, dev, errp)) {
-        return;
+        return false;
     }
 
     if (hotplugged) {
         spapr_hotplug_req_add_by_index(drc);
     }
+    return true;
 }
 
 static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index 490b19a009..344582d2f5 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -30,6 +30,6 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
 void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
 bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp);
-void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
+bool spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
 
 #endif
-- 
2.26.2


