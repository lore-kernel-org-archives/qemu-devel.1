Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AD0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DDE2226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OziiSDI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DDE2226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpat-0002m3-Lh
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVT-0005DG-P6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:11 -0400
Received: from ozlabs.org ([203.11.71.1]:33371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVQ-0001mj-HU
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wX2sWnz9sVf; Fri,  9 Oct 2020 21:19:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238796;
 bh=GCVvCgAulmR9wxpnL37H/iZHOe2HDKMcMtUSBbCHEZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OziiSDI4hTPMdn3YyOHwlRRNwbeBf7LtxgvPG3/mhVy288fIb+IJ+6fKLu5pPcnhy
 KMvBmQ4E3cHafv2E6jQCj+Scs0bm2HXbGLQKABUlVhk8eQZrI+Aj4hJyeaoo1zVS5X
 81FoVPq9f3P/l8w4koLcBU8jVxb/GvWM9BXYzr18=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 09/20] spapr: Add a return value to spapr_drc_attach()
Date: Fri,  9 Oct 2020 21:19:40 +1100
Message-Id: <20201009101951.1569252-10-david@gibson.dropbear.id.au>
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
Message-Id: <20200914123505.612812-9-groug@kaod.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             | 15 +++------------
 hw/ppc/spapr_drc.c         |  5 +++--
 hw/ppc/spapr_nvdimm.c      |  5 +----
 hw/ppc/spapr_pci.c         |  5 +----
 include/hw/ppc/spapr_drc.h |  2 +-
 5 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0f82e657e3..26b3432fe4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3371,22 +3371,19 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     int i;
     uint64_t addr = addr_start;
     bool hotplugged = spapr_drc_hotplugged(dev);
-    Error *local_err = NULL;
 
     for (i = 0; i < nr_lmbs; i++) {
         drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                               addr / SPAPR_MEMORY_BLOCK_SIZE);
         g_assert(drc);
 
-        spapr_drc_attach(drc, dev, &local_err);
-        if (local_err) {
+        if (!spapr_drc_attach(drc, dev, errp)) {
             while (addr > addr_start) {
                 addr -= SPAPR_MEMORY_BLOCK_SIZE;
                 drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                                       addr / SPAPR_MEMORY_BLOCK_SIZE);
                 spapr_drc_detach(drc);
             }
-            error_propagate(errp, local_err);
             return;
         }
         if (!hotplugged) {
@@ -3767,7 +3764,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUCore *cc = CPU_CORE(dev);
     CPUState *cs;
     SpaprDrc *drc;
-    Error *local_err = NULL;
     CPUArchId *core_slot;
     int index;
     bool hotplugged = spapr_drc_hotplugged(dev);
@@ -3785,9 +3781,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     g_assert(drc || !mc->has_hotpluggable_cpus);
 
     if (drc) {
-        spapr_drc_attach(drc, dev, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!spapr_drc_attach(drc, dev, errp)) {
             return;
         }
 
@@ -3939,7 +3933,6 @@ static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
     SpaprDrc *drc;
     bool hotplugged = spapr_drc_hotplugged(dev);
-    Error *local_err = NULL;
 
     if (!smc->dr_phb_enabled) {
         return;
@@ -3949,9 +3942,7 @@ static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     /* hotplug hooks should check it's enabled before getting this far */
     assert(drc);
 
-    spapr_drc_attach(drc, dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!spapr_drc_attach(drc, dev, errp)) {
         return;
     }
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index fe998d8108..04a6bf134e 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -371,13 +371,13 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
     } while (fdt_depth != 0);
 }
 
-void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
+bool spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
 {
     trace_spapr_drc_attach(spapr_drc_index(drc));
 
     if (drc->dev) {
         error_setg(errp, "an attached device is still awaiting release");
-        return;
+        return false;
     }
     g_assert((drc->state == SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
              || (drc->state == SPAPR_DRC_STATE_PHYSICAL_POWERON));
@@ -388,6 +388,7 @@ void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
                              object_get_typename(OBJECT(drc->dev)),
                              (Object **)(&drc->dev),
                              NULL, 0);
+    return true;
 }
 
 static void spapr_drc_release(SpaprDrc *drc)
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 63872054f3..c06f903e5b 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -91,14 +91,11 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
 {
     SpaprDrc *drc;
     bool hotplugged = spapr_drc_hotplugged(dev);
-    Error *local_err = NULL;
 
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
     g_assert(drc);
 
-    spapr_drc_attach(drc, dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!spapr_drc_attach(drc, dev, errp)) {
         return;
     }
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5db912b48c..3999392b32 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1539,7 +1539,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     PCIDevice *pdev = PCI_DEVICE(plugged_dev);
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(plugged_dev);
     SpaprDrc *drc = drc_from_dev(phb, pdev);
-    Error *local_err = NULL;
     PCIBus *bus = PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
@@ -1578,9 +1577,7 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
         return;
     }
 
-    spapr_drc_attach(drc, DEVICE(pdev), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!spapr_drc_attach(drc, DEVICE(pdev), errp)) {
         return;
     }
 
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index f270860769..165b281496 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -235,7 +235,7 @@ SpaprDrc *spapr_drc_by_index(uint32_t index);
 SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id);
 int spapr_dt_drc(void *fdt, int offset, Object *owner, uint32_t drc_type_mask);
 
-void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
+bool spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
 void spapr_drc_detach(SpaprDrc *drc);
 
 /* Returns true if a hot plug/unplug request is pending */
-- 
2.26.2


