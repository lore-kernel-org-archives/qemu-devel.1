Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F15EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F02E206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW/nxDeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F02E206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6Z3-0006Zx-9C
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6Na-0004NT-Le
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6NP-0000Ue-1Y
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWd4yB75Wt66mVlUSGrxHhIA1yEu4PJLln4W+/ohXyU=;
 b=BW/nxDeDSABjcCcqoG8z6VAquMo3Dcw5obWRM0raXW8aQNGEm+aZodABKriUTaPk0jxfsj
 Bt9CgGRE93d8CE51LKnAI4qmwILMyM6LqrD9v7yMDVnR6m9JBen1ieUlnb7M8+qkOIFx+o
 WoYJW88NN+N3wT/stM9yT2l/201GtQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-5v7_WUwVOFG1_c2zotQPNg-1; Thu, 15 Oct 2020 12:45:11 -0400
X-MC-Unique: 5v7_WUwVOFG1_c2zotQPNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8F6C107AFC6;
 Thu, 15 Oct 2020 16:45:10 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7269C19C4F;
 Thu, 15 Oct 2020 16:45:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/9] i386/kvm: Remove IRQ routing support checks
Date: Thu, 15 Oct 2020 12:44:57 -0400
Message-Id: <20201015164501.462775-6-ehabkost@redhat.com>
In-Reply-To: <20201015164501.462775-1-ehabkost@redhat.com>
References: <20201015164501.462775-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM_CAP_IRQ_ROUTING is always available on x86, so replace checks
for kvm_has_gsi_routing() and KVM_CAP_IRQ_ROUTING with asserts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200922201922.2153598-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/kvm/apic.c   |  5 ++---
 hw/i386/kvm/ioapic.c | 33 ++++++++++++++++-----------------
 target/i386/kvm.c    |  7 -------
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 4eb2d77b87..dd29906061 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -225,9 +225,8 @@ static void kvm_apic_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->io_memory, OBJECT(s), &kvm_apic_io_ops, s,
                           "kvm-apic-msi", APIC_SPACE_SIZE);
 
-    if (kvm_has_gsi_routing()) {
-        msi_nonbroken = true;
-    }
+    assert(kvm_has_gsi_routing());
+    msi_nonbroken = true;
 }
 
 static void kvm_apic_unrealize(DeviceState *dev)
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index c5528df942..dfc3c98005 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -25,27 +25,26 @@ void kvm_pc_setup_irq_routing(bool pci_enabled)
     KVMState *s = kvm_state;
     int i;
 
-    if (kvm_check_extension(s, KVM_CAP_IRQ_ROUTING)) {
-        for (i = 0; i < 8; ++i) {
-            if (i == 2) {
-                continue;
-            }
-            kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_PIC_MASTER, i);
-        }
-        for (i = 8; i < 16; ++i) {
-            kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_PIC_SLAVE, i - 8);
+    assert(kvm_has_gsi_routing());
+    for (i = 0; i < 8; ++i) {
+        if (i == 2) {
+            continue;
         }
-        if (pci_enabled) {
-            for (i = 0; i < 24; ++i) {
-                if (i == 0) {
-                    kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_IOAPIC, 2);
-                } else if (i != 2) {
-                    kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_IOAPIC, i);
-                }
+        kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_PIC_MASTER, i);
+    }
+    for (i = 8; i < 16; ++i) {
+        kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_PIC_SLAVE, i - 8);
+    }
+    if (pci_enabled) {
+        for (i = 0; i < 24; ++i) {
+            if (i == 0) {
+                kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_IOAPIC, 2);
+            } else if (i != 2) {
+                kvm_irqchip_add_irq_route(s, i, KVM_IRQCHIP_IOAPIC, i);
             }
         }
-        kvm_irqchip_commit_routes(s);
     }
+    kvm_irqchip_commit_routes(s);
 }
 
 typedef struct KVMIOAPICState KVMIOAPICState;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 69c691ad77..588d893a63 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4552,13 +4552,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 
 void kvm_arch_init_irq_routing(KVMState *s)
 {
-    if (!kvm_check_extension(s, KVM_CAP_IRQ_ROUTING)) {
-        /* If kernel can't do irq routing, interrupt source
-         * override 0->2 cannot be set up as required by HPET.
-         * So we have to disable it.
-         */
-        no_hpet = 1;
-    }
     /* We know at this point that we're using the in-kernel
      * irqchip, so we can use irqfds, and on x86 we know
      * we can use msi via irqfd and GSI routing.
-- 
2.28.0


