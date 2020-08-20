Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8113EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CB0207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJcdNlr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CB0207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YKo-00047L-HB
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDC-0006Tv-L1
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:13:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32611
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YD9-0002Om-U4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXX+IB01OMSQ//OqiXhm4bBwWV9ZDrkS6OdwmIVEaFM=;
 b=aJcdNlr4bFK4/ClNdfE3FSkwFStUbCfy/WC8pV9MaYj7tjVFlWe/wsFUTVSUNfSHtJenaT
 4iN8echJAFP1rt1hCFjP7ZqkFS2NlaaOCoCIWrQRQFBORjlfgEX7oXdSiGvnZ5oF3pyRsI
 M7tFo7tyJmVOn7PTwIrt3vnV31mjaEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-OdvfXX4PMZezi1BfrwoVBg-1; Wed, 19 Aug 2020 20:13:41 -0400
X-MC-Unique: OdvfXX4PMZezi1BfrwoVBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C7011007465;
 Thu, 20 Aug 2020 00:13:40 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA525D9D5;
 Thu, 20 Aug 2020 00:13:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/58] spapr: Move typedef SpaprMachineState to spapr.h
Date: Wed, 19 Aug 2020 20:12:05 -0400
Message-Id: <20200820001236.1284548-28-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the typedef from spapr_irq.h to spapr.h, and use "struct
SpaprMachineState" in the spapr_*.h headers (to avoid circular
header dependencies).

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2: new patch in series v2

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
---
 include/hw/ppc/spapr.h      |  1 +
 include/hw/ppc/spapr_irq.h  | 36 ++++++++++++++++++------------------
 include/hw/ppc/spapr_xive.h |  3 ++-
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3134d339e8..a1e230ad39 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -41,6 +41,7 @@ typedef struct SpaprDimmState SpaprDimmState;
 typedef struct SpaprMachineClass SpaprMachineClass;
 
 #define TYPE_SPAPR_MACHINE      "spapr-machine"
+typedef struct SpaprMachineState SpaprMachineState;
 #define SPAPR_MACHINE(obj) \
     OBJECT_CHECK(SpaprMachineState, (obj), TYPE_SPAPR_MACHINE)
 #define SPAPR_MACHINE_GET_CLASS(obj) \
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ca8cb44213..b161ccebc2 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -28,7 +28,7 @@
 
 #define SPAPR_NR_XIRQS       0x1000
 
-typedef struct SpaprMachineState SpaprMachineState;
+struct SpaprMachineState;
 
 typedef struct SpaprInterruptController SpaprInterruptController;
 
@@ -67,20 +67,20 @@ typedef struct SpaprInterruptControllerClass {
     int (*post_load)(SpaprInterruptController *intc, int version_id);
 } SpaprInterruptControllerClass;
 
-void spapr_irq_update_active_intc(SpaprMachineState *spapr);
+void spapr_irq_update_active_intc(struct SpaprMachineState *spapr);
 
-int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
+int spapr_irq_cpu_intc_create(struct SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
-void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu);
-void spapr_irq_cpu_intc_destroy(SpaprMachineState *spapr, PowerPCCPU *cpu);
-void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
-void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
+void spapr_irq_cpu_intc_reset(struct SpaprMachineState *spapr, PowerPCCPU *cpu);
+void spapr_irq_cpu_intc_destroy(struct SpaprMachineState *spapr, PowerPCCPU *cpu);
+void spapr_irq_print_info(struct SpaprMachineState *spapr, Monitor *mon);
+void spapr_irq_dt(struct SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
 
-uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr);
-int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
+uint32_t spapr_irq_nr_msis(struct SpaprMachineState *spapr);
+int spapr_irq_msi_alloc(struct SpaprMachineState *spapr, uint32_t num, bool align,
                         Error **errp);
-void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
+void spapr_irq_msi_free(struct SpaprMachineState *spapr, int irq, uint32_t num);
 
 typedef struct SpaprIrq {
     bool        xics;
@@ -92,13 +92,13 @@ extern SpaprIrq spapr_irq_xics_legacy;
 extern SpaprIrq spapr_irq_xive;
 extern SpaprIrq spapr_irq_dual;
 
-void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
-int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
-void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
-qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
-int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
-void spapr_irq_reset(SpaprMachineState *spapr, Error **errp);
-int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **errp);
+void spapr_irq_init(struct SpaprMachineState *spapr, Error **errp);
+int spapr_irq_claim(struct SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
+void spapr_irq_free(struct SpaprMachineState *spapr, int irq, int num);
+qemu_irq spapr_qirq(struct SpaprMachineState *spapr, int irq);
+int spapr_irq_post_load(struct SpaprMachineState *spapr, int version_id);
+void spapr_irq_reset(struct SpaprMachineState *spapr, Error **errp);
+int spapr_irq_get_phandle(struct SpaprMachineState *spapr, void *fdt, Error **errp);
 
 typedef int (*SpaprInterruptControllerInitKvm)(SpaprInterruptController *,
                                                uint32_t, Error **);
@@ -111,7 +111,7 @@ int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
 /*
  * XICS legacy routines
  */
-int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp);
+int spapr_irq_find(struct SpaprMachineState *spapr, int num, bool align, Error **errp);
 #define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false, errp)
 
 #endif
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 93d09d68de..85f124506d 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -66,7 +66,8 @@ typedef struct SpaprXiveClass {
 
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
 
-void spapr_xive_hcall_init(SpaprMachineState *spapr);
+struct SpaprMachineState;
+void spapr_xive_hcall_init(struct SpaprMachineState *spapr);
 void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
 void spapr_xive_map_mmio(SpaprXive *xive);
 
-- 
2.26.2


