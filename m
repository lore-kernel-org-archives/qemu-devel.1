Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D23AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0395320829
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPPj3Jbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0395320829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3oc-00056X-5W
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f3-0001F1-1g
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f0-0003VJ-2t
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhc/akqt2k271QDx2pIHOAywXZ1NLyCzy7+9Te+SzQE=;
 b=UPPj3Jbh9oj0Hz6oa8oAneZzqdVZ7GUZr/hCuvyT8r+pLEhfgDJzGIz4yv2j7lCLZx4GDY
 93otIbCPKm09TJPU9ghuZAkcr7QXde19iMoa/000j0Jm34dzfkqk83bCMGWLx/qlAzM+fu
 OH8pIQtqMim0EL3uSo96G5GvABCDmjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-__CubLirOKWS3HbEdkq1Yw-1; Tue, 19 May 2020 10:55:59 -0400
X-MC-Unique: __CubLirOKWS3HbEdkq1Yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C9D4107ACF3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A6FE5799C;
 Tue, 19 May 2020 14:55:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F50711358DE; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/55] qom: Tidy up a few object_initialize_child() calls
Date: Tue, 19 May 2020 16:55:29 +0200
Message-Id: <20200519145551.22836-34-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The callers of object_initialize_child() commonly  pass either
&child, sizeof(child), or pchild, sizeof(*pchild).  Tidy up the few
that don't, mostly to keep the next commit simpler.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/aspeed.c                 | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c | 3 +--
 hw/pci-host/pnv_phb4.c          | 2 +-
 hw/riscv/riscv_hart.c           | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index adbfbbd6b4..eaf50da8df 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -267,7 +267,7 @@ static void aspeed_machine_init(MachineState *machine)
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
2.21.1


