Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1FAC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B232220D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0/M9i0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B232220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKon0-0003Fl-B6
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 16:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKolM-00023o-4R
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKolK-00083I-Hd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600805981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52XNin5Hd63T3Wdn9qi1J9VaOtpC4qNSf/yGry9fMRE=;
 b=g0/M9i0GY/WSarWje8twyFE8WOypnj23Dx9czpCoNNUft4U4LmBoyEy4Y/ithX1wnAyHJK
 Plns/NGRHcrnpy7WFox6QHg9fQqOpIc0ixS1MB/33elf/X52MX4+6mrdvo/kaXJP+yUcuL
 Us0rmfZJxoREZc9TGHO7Peo2c9GRpng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-lpF4hf4rMqOJmjGEfKsm1g-1; Tue, 22 Sep 2020 16:19:39 -0400
X-MC-Unique: lpF4hf4rMqOJmjGEfKsm1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D481104D3E2;
 Tue, 22 Sep 2020 20:19:38 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEE075DE86;
 Tue, 22 Sep 2020 20:19:37 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] i386/kvm: Remove IRQ routing support checks
Date: Tue, 22 Sep 2020 16:19:21 -0400
Message-Id: <20200922201922.2153598-3-ehabkost@redhat.com>
In-Reply-To: <20200922201922.2153598-1-ehabkost@redhat.com>
References: <20200922201922.2153598-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Sergio Lopez <slp@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM_CAP_IRQ_ROUTING is always available on x86, so replace checks
for kvm_has_gsi_routing() and KVM_CAP_IRQ_ROUTING with asserts.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/kvm/apic.c   |  5 ++---
 hw/i386/kvm/ioapic.c | 33 ++++++++++++++++-----------------
 target/i386/kvm.c    |  7 -------
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 4eb2d77b87b..dd29906061c 100644
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
index c5528df942a..dfc3c980057 100644
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
index d884ff1b071..cf6dc90f7c5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4558,13 +4558,6 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 
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
2.26.2


