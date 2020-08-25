Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03679C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACE02075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGyW188Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACE02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAelZ-00074O-0k
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWM-0008GU-Q0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWL-0006Aq-69
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhMJUERqNSnqfvGsPobtD/QQgBku6FXq/dEaxcR0J2w=;
 b=PGyW188QCPDgp8o4QMRn6oqWiW3U9R1U1lCZBwycydV9S1hCJFy8b+OkRrCNOZsUZ9I362
 SThLIBrxqGDiryUhbx9Vom4fB8LbsHeIC/SqyR7IjO1CUN9aEqD98QhCBdAIGfdO26Tfma
 o23BDq8XgZWXmxBlvljzoLz0Iu1ipzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-CnuiP0DNNPqcMB1jg3tmyQ-1; Tue, 25 Aug 2020 15:22:07 -0400
X-MC-Unique: CnuiP0DNNPqcMB1jg3tmyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A80E0801AB5;
 Tue, 25 Aug 2020 19:22:06 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00C3C1002D47;
 Tue, 25 Aug 2020 19:22:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 27/74] spapr: Move typedef SpaprMachineState to spapr.h
Date: Tue, 25 Aug 2020 15:20:23 -0400
Message-Id: <20200825192110.3528606-28-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:39:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

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
index 0ffbe0be02..a1c8540ab4 100644
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


