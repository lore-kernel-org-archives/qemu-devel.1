Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25034C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76679207BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DUN1RR9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76679207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQ8s-0003lI-Cf
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnO-0001nN-PQ; Tue, 27 Oct 2020 10:17:54 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40709 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnM-0007Yt-Pt; Tue, 27 Oct 2020 10:17:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLc1PWFz9sfR; Wed, 28 Oct 2020 01:17:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808264;
 bh=Yzt18OlWRJS5R+7mSUR1fLBLDl520kInoQYoWI8XNE8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DUN1RR9RDaiEWZdp6+7u7Nsk+EH3R/epl2+PkDgWNpDKm8RdNPBHYBFu3P+p5vZTW
 lLPYkgs3zi9QotltmB4Pr+LBvAPu/xxt7AszZ+TS5RcwZILzpfD0FCxe+per25qQgQ
 xfE0mv3cIzo2pq9fCFQNoPxoxfbb9QswprS04YiU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/18] spapr: Move spapr_create_nvdimm_dr_connectors() to core
 machine code
Date: Wed, 28 Oct 2020 01:17:21 +1100
Message-Id: <20201027141735.728821-5-david@gibson.dropbear.id.au>
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

The spapr_create_nvdimm_dr_connectors() function doesn't need to access
any internal details of the sPAPR NVDIMM implementation. Also, pretty
much like for the LMBs, only spapr_machine_init() is responsible for the
creation of DR connectors for NVDIMMs.

Make this clear by making this function static in hw/ppc/spapr.c.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160249772183.757627.7396780936543977766.stgit@bahia.lan>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                | 10 ++++++++++
 hw/ppc/spapr_nvdimm.c         | 11 -----------
 include/hw/ppc/spapr_nvdimm.h |  1 -
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 63315f2d0f..ee716a12af 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2641,6 +2641,16 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
     return rma_size;
 }
 
+static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
+{
+    MachineState *machine = MACHINE(spapr);
+    int i;
+
+    for (i = 0; i < machine->ram_slots; i++) {
+        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
+    }
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void spapr_machine_init(MachineState *machine)
 {
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index b3a489e9fe..9e3d94071f 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -106,17 +106,6 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
     }
 }
 
-void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
-{
-    MachineState *machine = MACHINE(spapr);
-    int i;
-
-    for (i = 0; i < machine->ram_slots; i++) {
-        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
-    }
-}
-
-
 static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
                            int parent_offset, NVDIMMDevice *nvdimm)
 {
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index b834d82f55..490b19a009 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -31,6 +31,5 @@ void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
 bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
-void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
 
 #endif
-- 
2.26.2


