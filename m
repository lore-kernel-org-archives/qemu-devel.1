Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E7C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F644222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efW/GEOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F644222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUu0N-0004eE-9K
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtno-00060c-02
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnm-0006NY-Ck
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:23 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtnm-0006Mt-5f
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:22 -0500
Received: by mail-wm1-x344.google.com with SMTP id 8so2283473wmo.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KGzEFsoR5Ne9dc3BBeXqX8dzJn/ffqjieOFhjVDRthY=;
 b=efW/GEOnrwhahfd4461bZXJaLHNXb1y0YfZIqa5msGDz/8eL2+9YAIpzbTFC6tLHY0
 m6YQz3Jilil08mLM2e7/CvwIGNts8lh3qLGM1paA4DRmBMnSy7Lfq0Pnzzyd10R17TCP
 sqqywo5miSUhyeuQE1aT18EjgVL2OHVIe3Sf16hfyxdAVPyYPDi6MhaaxrX17mlVYHbH
 qIhPsV8TfVrTsGeSQylYF8FYLDUFDou/JR166XfmPkqg5TLWMacWC8oFwRaasmOnJWVf
 hpwHGKl7w6gWqV5mfedVPEBVsY5YQ0abG77NMD7a9EvBJR0hxnsSM70QSaTtTy0pTO68
 5FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=KGzEFsoR5Ne9dc3BBeXqX8dzJn/ffqjieOFhjVDRthY=;
 b=Q1MVpkr2sUEgw0pKfOvGLnsjLGzfri8EXA7EBD00j2A6gFpjaS22K1d5A+t6nFeg3J
 bZs+UFZ8SaPcW4oZI2+e88YA+y2f6WJa7chBo+nFJhTK+dTTLRnKFOaaxE6uF4rRSYkP
 ZG4vPDa1lm9PIRKDtjbV3CUjNjUv2U+LoTSg2liJq78wvBd/8Zc6jbZ+nrtpbwTDE1/u
 AnXShauAMk8p1/uAh46wOsEPL9NOWRUcSU4jyTpUM6u54vZf6d+yirJuErIc/zKuKFXe
 hJkdFjEK/9Znv+WYPQjorgYmXjHS8aZRNg3gSQaiztlIZ+kR0QebhxBCakFoOHZQr4xb
 iLWA==
X-Gm-Message-State: APjAAAXleNXx6d8l9dEmsWHw0mnp/PAytEHEDloVmlxwKvYnqxjAqWaB
 qXL2CQMjYsCdwFhAPkKHxUq2w2Al
X-Google-Smtp-Source: APXvYqyxflYY4ybjQHjeU+g3F3TG7P/JNRlSy903Rwk495iaL0nmgQs4bTQlhlstvwWE2tYqSYw1oA==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr3288827wmb.175.1573655960320; 
 Wed, 13 Nov 2019 06:39:20 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] kvm: introduce kvm_kernel_irqchip_* functions
Date: Wed, 13 Nov 2019 15:39:04 +0100
Message-Id: <1573655945-14912-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: thuth@redhat.com, armbru@redhat.com
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
index c016319..a1c3b78 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1742,7 +1742,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void kvm_irqchip_create(MachineState *machine, KVMState *s)
+static void kvm_irqchip_create(KVMState *s)
 {
     int ret;
 
@@ -1760,9 +1760,9 @@ static void kvm_irqchip_create(MachineState *machine, KVMState *s)
 
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
@@ -2034,7 +2034,7 @@ static int kvm_init(MachineState *ms)
     }
 
     if (machine_kernel_irqchip_allowed(ms)) {
-        kvm_irqchip_create(ms, s);
+        kvm_irqchip_create(s);
     }
 
     if (kvm_eventfds_allowed) {
@@ -2951,6 +2951,21 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
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
index b941608..8b66eb9 100644
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
@@ -276,12 +276,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
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
index 9d14328..46a9f18 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -514,10 +514,13 @@ void kvm_pc_gsi_handler(void *opaque, int n, int level);
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
@@ -525,7 +528,7 @@ void kvm_init_irq_routing(KVMState *s);
  *            0: irq chip was not created
  *          > 0: irq chip was created
  */
-int kvm_arch_irqchip_create(MachineState *ms, KVMState *s);
+int kvm_arch_irqchip_create(KVMState *s);
 
 /**
  * kvm_set_one_reg - set a register value in KVM via KVM_SET_ONE_REG ioctl
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b473c63..d10383c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -726,11 +726,11 @@ void kvm_arch_init_irq_routing(KVMState *s)
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
index 7dc05c6..72bb215 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4473,10 +4473,10 @@ void kvm_arch_init_irq_routing(KVMState *s)
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
index 7d2e896..02face1 100644
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



