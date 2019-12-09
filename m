Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786DC04E30
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854742077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL9W1/hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854742077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKpR-0005eN-Jy
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKY5-0003di-4Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKY3-0001aC-Ee
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:09 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKY3-0001Z7-6m
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:07 -0500
Received: by mail-wr1-x442.google.com with SMTP id d16so16529010wre.10
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2obtCf3Vea6+0Qq3n8fYhTNc8P7aN6TGdrLYdh2+Zcc=;
 b=UL9W1/hBlvr0O21n2ShBLrfqzvB/KcZiCn/d2ClZ6PyMXUDPID76gtGixDzuG6KmWu
 9vozsF6dMiCoHTVl+Ymb0f33kUoYtDNGT1LQcbSgKovvpviJP/zjscqCQLGFZYvFV4j/
 hGRj25ZTHBAyDOYQ2TZL+tiG+efA4XeQCHeV8kngEDGkq3jtKvtqT4/Yjrn9VvQ1W49D
 +ESlTse551KUMQzHstHb1V1bqOloelpaMnTbBUt++cnTfTiLlJ7L4Q02G9yX8N9WsqU0
 h2nyqsr9IQ6MjQMXlrAuudlWeTio6PCTsg4sHRzVwXD3tGodcvntZIfqMCDJRXBievvJ
 VJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=2obtCf3Vea6+0Qq3n8fYhTNc8P7aN6TGdrLYdh2+Zcc=;
 b=ZX5LGV07EPRx6XECq62BF+rU0OEONKCaF4/360euX/S7zW2zvglq7Ez5UWZU0iFhu+
 DAIBc9tEw2TN4eRj160LY03tBEpeO693CEHYRTd/HhQ2l3bhmFPaj0n915exE9EktYo+
 1a24jSEiUC+4gIX1PgraPPCUKIxpQSMgq21KYQp0QlIlLlnv03XNJEkQhMGj6s3QU+JM
 pTjuhniPdawKNEd5tIPQFxo5HmiclIp6h9Xp6vEPy8372qrlaAZOPRS4kcx0nw3RdYgk
 vnu4gyPPbU8Ri1hdwMBk0zTkcn7LwChpJoUHCO9S9m/uumefgk01UN5AHnsD/68NjZZG
 V2uA==
X-Gm-Message-State: APjAAAVWfcYI75LrwX5/BHONL5VkWW6xsaDu/pva+v6Dr+KjtnnQNM8F
 l8uiMM+UuwC/2O/gL4Ra+Nx1GqK8
X-Google-Smtp-Source: APXvYqwEX7FD0SY2L3zjoQMM7924kawAnuVbvALn1044sRnzwC/Yt66txa/IQsvIprx2x1IgDg4OIw==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr2761553wrm.223.1575903725987; 
 Mon, 09 Dec 2019 07:02:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.02.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:02:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/18] kvm: introduce kvm_kernel_irqchip_* functions
Date: Mon,  9 Dec 2019 16:01:44 +0100
Message-Id: <1575903705-12925-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVMState struct is opaque, so provide accessors for the fields
that will be moved from current_machine to the accelerator.  For now
they just forward to the machine object, but this will change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c  | 23 +++++++++++++++++++----
 hw/ppc/e500.c        |  4 ++--
 hw/ppc/spapr_irq.c   | 10 +++++-----
 include/sysemu/kvm.h |  7 +++++--
 target/arm/kvm.c     |  8 ++++----
 target/i386/kvm.c    |  4 ++--
 target/mips/kvm.c    |  2 +-
 target/ppc/kvm.c     |  2 +-
 target/s390x/kvm.c   |  2 +-
 9 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f0b9294..c0a6351 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1760,7 +1760,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void kvm_irqchip_create(MachineState *machine, KVMState *s)
+static void kvm_irqchip_create(KVMState *s)
 {
     int ret;
 
@@ -1778,9 +1778,9 @@ static void kvm_irqchip_create(MachineState *machine, KVMState *s)
 
     /* First probe and see if there's a arch-specific hook to create the
      * in-kernel irqchip for us */
-    ret = kvm_arch_irqchip_create(machine, s);
+    ret = kvm_arch_irqchip_create(s);
     if (ret == 0) {
-        if (machine_kernel_irqchip_split(machine)) {
+        if (kvm_kernel_irqchip_split()) {
             perror("Split IRQ chip mode not supported.");
             exit(1);
         } else {
@@ -2052,7 +2052,7 @@ static int kvm_init(MachineState *ms)
     }
 
     if (machine_kernel_irqchip_allowed(ms)) {
-        kvm_irqchip_create(ms, s);
+        kvm_irqchip_create(s);
     }
 
     if (kvm_eventfds_allowed) {
@@ -2969,6 +2969,21 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
     s->kvm_shadow_mem = value;
 }
 
+bool kvm_kernel_irqchip_allowed(void)
+{
+    return machine_kernel_irqchip_allowed(current_machine);
+}
+
+bool kvm_kernel_irqchip_required(void)
+{
+    return machine_kernel_irqchip_required(current_machine);
+}
+
+bool kvm_kernel_irqchip_split(void)
+{
+    return machine_kernel_irqchip_split(current_machine);
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s = KVM_STATE(obj);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 91cd4c2..928efaa 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -801,10 +801,10 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
     if (kvm_enabled()) {
         Error *err = NULL;
 
-        if (machine_kernel_irqchip_allowed(machine)) {
+        if (kvm_kernel_irqchip_allowed()) {
             dev = ppce500_init_mpic_kvm(pmc, irqs, &err);
         }
-        if (machine_kernel_irqchip_required(machine) && !dev) {
+        if (kvm_kernel_irqchip_required() && !dev) {
             error_reportf_err(err,
                               "kernel_irqchip requested but unavailable: ");
             exit(1);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d6bb7fd..c3f8870 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -77,9 +77,9 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
     MachineState *machine = MACHINE(qdev_get_machine());
     Error *local_err = NULL;
 
-    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+    if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
         if (fn(intc, &local_err) < 0) {
-            if (machine_kernel_irqchip_required(machine)) {
+            if (kvm_kernel_irqchip_required()) {
                 error_prepend(&local_err,
                               "kernel_irqchip requested but unavailable: ");
                 error_propagate(errp, local_err);
@@ -184,7 +184,7 @@ static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
      */
     if (kvm_enabled() &&
         spapr->irq == &spapr_irq_dual &&
-        machine_kernel_irqchip_required(machine) &&
+        kvm_kernel_irqchip_required() &&
         xics_kvm_has_broken_disconnect(spapr)) {
         error_setg(errp, "KVM is too old to support ic-mode=dual,kernel-irqchip=on");
         return -1;
@@ -290,12 +290,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     MachineState *machine = MACHINE(spapr);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
-    if (machine_kernel_irqchip_split(machine)) {
+    if (kvm_enabled() && kvm_kernel_irqchip_split()) {
         error_setg(errp, "kernel_irqchip split mode not supported on pseries");
         return;
     }
 
-    if (!kvm_enabled() && machine_kernel_irqchip_required(machine)) {
+    if (!kvm_enabled() && kvm_kernel_irqchip_required()) {
         error_setg(errp,
                    "kernel_irqchip requested but only available with KVM");
         return;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9fe233b..aaf2a50 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -519,10 +519,13 @@ void kvm_pc_gsi_handler(void *opaque, int n, int level);
 void kvm_pc_setup_irq_routing(bool pci_enabled);
 void kvm_init_irq_routing(KVMState *s);
 
+bool kvm_kernel_irqchip_allowed(void);
+bool kvm_kernel_irqchip_required(void);
+bool kvm_kernel_irqchip_split(void);
+
 /**
  * kvm_arch_irqchip_create:
  * @KVMState: The KVMState pointer
- * @MachineState: The MachineState pointer
  *
  * Allow architectures to create an in-kernel irq chip themselves.
  *
@@ -530,7 +533,7 @@ void kvm_init_irq_routing(KVMState *s);
  *            0: irq chip was not created
  *          > 0: irq chip was created
  */
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s);
+int kvm_arch_irqchip_create(KVMState *s);
 
 /**
  * kvm_set_one_reg - set a register value in KVM via KVM_SET_ONE_REG ioctl
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5b82cef..b87b59a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -741,11 +741,11 @@ void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
-     if (machine_kernel_irqchip_split(ms)) {
-         perror("-machine kernel_irqchip=split is not supported on ARM.");
-         exit(1);
+    if (kvm_kernel_irqchip_split()) {
+        perror("-machine kernel_irqchip=split is not supported on ARM.");
+        exit(1);
     }
 
     /* If we can create the VGIC using the newer device control API, we
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 62ce681..ef63f3a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4494,10 +4494,10 @@ void kvm_arch_init_irq_routing(KVMState *s)
     }
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
     int ret;
-    if (machine_kernel_irqchip_split(ms)) {
+    if (kvm_kernel_irqchip_split()) {
         ret = kvm_vm_enable_cap(s, KVM_CAP_SPLIT_IRQCHIP, 0, 24);
         if (ret) {
             error_report("Could not enable split irqchip mode: %s",
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 578bc14..de3e26e 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -57,7 +57,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
     return 0;
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index c77f984..461dc6d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -152,7 +152,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
     return 0;
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0c9d14b..f3a742b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -374,7 +374,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
+int kvm_arch_irqchip_create(KVMState *s)
 {
     return 0;
 }
-- 
1.8.3.1



