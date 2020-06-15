Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B74DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E904820707
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBg5l1Hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E904820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwdR-0004tZ-5o
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkw23-00075E-9m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:48:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21688
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkw1z-0001su-OH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592254114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42aldGQJLbIDZz8lGn47amolxeFmaQnn4yES0rU3IqU=;
 b=GBg5l1Hk33L7tUdcPoBkkouUSVszjvL08vqtcxu8lT1iOuxK0zxkFo1ycn6kSowOQ8PhbO
 IO12dR+CJDJL9PtjS7r8g2vmr0Fq6o5WwlTu7PuMWPVwYhn7YGTpBKzR4TvFKu8gcLHjdv
 p94V+dScNMuFlPivsu5m7H92BJY5qgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45--KTsiJrWNCG76rVLSzgHnw-1; Mon, 15 Jun 2020 16:48:31 -0400
X-MC-Unique: -KTsiJrWNCG76rVLSzgHnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DA6803328;
 Mon, 15 Jun 2020 20:48:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3A7D90337;
 Mon, 15 Jun 2020 20:48:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0478D1132C15; Mon, 15 Jun 2020 22:40:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 61/84] qom: Tidy up a few object_initialize_child() calls
Date: Mon, 15 Jun 2020 22:39:45 +0200
Message-Id: <20200615204008.3069956-62-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The callers of object_initialize_child() commonly  pass either
&child, sizeof(child), or pchild, sizeof(*pchild).  Tidy up the few
that don't, mostly to keep the next commit simpler.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200610053247.1583243-36-armbru@redhat.com>
---
 hw/arm/aspeed.c                 | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c | 3 +--
 hw/pci-host/pnv_phb4.c          | 2 +-
 hw/riscv/riscv_hart.c           | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 2b96244cf5..ee50476ccb 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -268,7 +268,7 @@ static void aspeed_machine_init(MachineState *machine)
     memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
 
     object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
-                            (sizeof(bmc->soc)), amc->soc_name, &error_abort,
+                            sizeof(bmc->soc), amc->soc_name, &error_abort,
                             NULL);
 
     sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 028f31894d..aa90b9d1be 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -174,8 +174,7 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
                                 pmu_ram);
 
     /* Create the PMU device */
-    object_initialize_child(OBJECT(machine), "pmu", pmu,
-                            sizeof(XlnxZynqMPPMUSoCState),
+    object_initialize_child(OBJECT(machine), "pmu", pmu, sizeof(*pmu),
                             TYPE_XLNX_ZYNQMP_PMU_SOC, &error_abort, NULL);
     object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
 
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index e30ae9ad5b..aba710fd1f 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1155,7 +1155,7 @@ static void pnv_phb4_instance_init(Object *obj)
     QLIST_INIT(&phb->dma_spaces);
 
     /* XIVE interrupt source object */
-    object_initialize_child(obj, "source", &phb->xsrc, sizeof(XiveSource),
+    object_initialize_child(obj, "source", &phb->xsrc, sizeof(phb->xsrc),
                             TYPE_XIVE_SOURCE, &error_abort, NULL);
 
     /* Root Port */
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 276a9baca0..61e88e2e37 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -46,7 +46,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
     Error *err = NULL;
 
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
-                            sizeof(RISCVCPU), cpu_type,
+                            sizeof(s->harts[idx]), cpu_type,
                             &error_abort, NULL);
     s->harts[idx].env.mhartid = s->hartid_base + idx;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
-- 
2.26.2


