Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEFAC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AF4218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ/uJLWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AF4218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYtk-0005lI-Su
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3x-0007Ql-Eb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3v-0003ik-FE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:21 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3v-0003ej-4Z; Wed, 18 Dec 2019 07:04:19 -0500
Received: by mail-wr1-x42a.google.com with SMTP id y17so2013266wrh.5;
 Wed, 18 Dec 2019 04:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xoiVKpP9hu9WCjJ4oCdzKyi18D0F4vTbBwktrThFJeE=;
 b=YJ/uJLWBZxg8la5DghZ0zMXGKR5HMj1GVEIdeEtmw33/h0A01X1zSkGPSJhiAo/QnC
 iYpPkAZRjlMuW2tsAAhfwgKl86G+qkz30RLZz3x1mbZiwcvxsvc0YZS6PeIXkwqYYo8X
 v+D1whVCvQkpiYVTKzhvOlXlJRHKEv/aGJ35OLOC3Ezi2f3qY16HUZFhCELSGVqcyVHa
 txTmgBaR7UhCy5eltJGFF+4gh254h+IxpQO1xZRWqXbCsxZf5HBswWjrgRBxUFJI7ciF
 xxCi8q/tzsiYewZ/5IoOtqbXVXZd6XtSR1X/QAWde2t6XVFAaXFgXHFHl4i11CeXjRQT
 V7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=xoiVKpP9hu9WCjJ4oCdzKyi18D0F4vTbBwktrThFJeE=;
 b=JJKf7Ul9x3dDIudosdgIn+UnSN+Y8nsxwDeLwTb9Uu0egEpQB66YtNqO9HEMQsJPHq
 ksmm/0ZcK9q8hpHJiAfZfxBKtqMgz239WnraPncm8hSEhtVGX0zmHMTiDbqu0OJljgPN
 2F7KWC8DDPu4ljJOAbN6CoPx1JHksqeB3aPT1kKUg3QoDetuOOT2SevvDyDvjYgwphDC
 9aQtv4qnTJdwZ2tBOaBbash0qHiq5AmZdHqftj1fdLNziJnJrZzSJyS6UrQMsLjmDSjO
 u6FVs7gHWzmK724XQmTv9u4RU86Ai/ZKjaCElo1KSFkjceudT0AmX1o+kNZv048Fzsb1
 H2Bg==
X-Gm-Message-State: APjAAAUS5dwll4wueu4r05dDfDUITYEYGRA8U23WLhdSDbwLx5q2pHsN
 sABUeLYV5NBbgOypP9YEMMlKi+6k
X-Google-Smtp-Source: APXvYqyp14ZH+erO5k4m5jU7LCGriOlnOIxoJRZ9U9/WBknXiG8DLtoyeYIL01UWssLyDgh6SJ9uqA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr2449904wro.334.1576670657870; 
 Wed, 18 Dec 2019 04:04:17 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 75/87] target/i386: remove unused pci-assign codes
Date: Wed, 18 Dec 2019 13:02:41 +0100
Message-Id: <1576670573-48048-76-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: qemu-trivial@nongnu.org, Eiichi Tsukata <devel@etsukata.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eiichi Tsukata <devel@etsukata.com>

Legacy PCI device assignment has been already removed in commit ab37bfc7d641
("pci-assign: Remove"), but some codes remain unused.

CC: qemu-trivial@nongnu.org
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Message-Id: <20191209072932.313056-1-devel@etsukata.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c      | 140 -------------------------------------------------
 target/i386/kvm_i386.h |  20 -------
 2 files changed, 160 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55e6265..0b51190 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4512,146 +4512,6 @@ int kvm_arch_irqchip_create(KVMState *s)
     }
 }
 
-/* Classic KVM device assignment interface. Will remain x86 only. */
-int kvm_device_pci_assign(KVMState *s, PCIHostDeviceAddress *dev_addr,
-                          uint32_t flags, uint32_t *dev_id)
-{
-    struct kvm_assigned_pci_dev dev_data = {
-        .segnr = dev_addr->domain,
-        .busnr = dev_addr->bus,
-        .devfn = PCI_DEVFN(dev_addr->slot, dev_addr->function),
-        .flags = flags,
-    };
-    int ret;
-
-    dev_data.assigned_dev_id =
-        (dev_addr->domain << 16) | (dev_addr->bus << 8) | dev_data.devfn;
-
-    ret = kvm_vm_ioctl(s, KVM_ASSIGN_PCI_DEVICE, &dev_data);
-    if (ret < 0) {
-        return ret;
-    }
-
-    *dev_id = dev_data.assigned_dev_id;
-
-    return 0;
-}
-
-int kvm_device_pci_deassign(KVMState *s, uint32_t dev_id)
-{
-    struct kvm_assigned_pci_dev dev_data = {
-        .assigned_dev_id = dev_id,
-    };
-
-    return kvm_vm_ioctl(s, KVM_DEASSIGN_PCI_DEVICE, &dev_data);
-}
-
-static int kvm_assign_irq_internal(KVMState *s, uint32_t dev_id,
-                                   uint32_t irq_type, uint32_t guest_irq)
-{
-    struct kvm_assigned_irq assigned_irq = {
-        .assigned_dev_id = dev_id,
-        .guest_irq = guest_irq,
-        .flags = irq_type,
-    };
-
-    if (kvm_check_extension(s, KVM_CAP_ASSIGN_DEV_IRQ)) {
-        return kvm_vm_ioctl(s, KVM_ASSIGN_DEV_IRQ, &assigned_irq);
-    } else {
-        return kvm_vm_ioctl(s, KVM_ASSIGN_IRQ, &assigned_irq);
-    }
-}
-
-int kvm_device_intx_assign(KVMState *s, uint32_t dev_id, bool use_host_msi,
-                           uint32_t guest_irq)
-{
-    uint32_t irq_type = KVM_DEV_IRQ_GUEST_INTX |
-        (use_host_msi ? KVM_DEV_IRQ_HOST_MSI : KVM_DEV_IRQ_HOST_INTX);
-
-    return kvm_assign_irq_internal(s, dev_id, irq_type, guest_irq);
-}
-
-int kvm_device_intx_set_mask(KVMState *s, uint32_t dev_id, bool masked)
-{
-    struct kvm_assigned_pci_dev dev_data = {
-        .assigned_dev_id = dev_id,
-        .flags = masked ? KVM_DEV_ASSIGN_MASK_INTX : 0,
-    };
-
-    return kvm_vm_ioctl(s, KVM_ASSIGN_SET_INTX_MASK, &dev_data);
-}
-
-static int kvm_deassign_irq_internal(KVMState *s, uint32_t dev_id,
-                                     uint32_t type)
-{
-    struct kvm_assigned_irq assigned_irq = {
-        .assigned_dev_id = dev_id,
-        .flags = type,
-    };
-
-    return kvm_vm_ioctl(s, KVM_DEASSIGN_DEV_IRQ, &assigned_irq);
-}
-
-int kvm_device_intx_deassign(KVMState *s, uint32_t dev_id, bool use_host_msi)
-{
-    return kvm_deassign_irq_internal(s, dev_id, KVM_DEV_IRQ_GUEST_INTX |
-        (use_host_msi ? KVM_DEV_IRQ_HOST_MSI : KVM_DEV_IRQ_HOST_INTX));
-}
-
-int kvm_device_msi_assign(KVMState *s, uint32_t dev_id, int virq)
-{
-    return kvm_assign_irq_internal(s, dev_id, KVM_DEV_IRQ_HOST_MSI |
-                                              KVM_DEV_IRQ_GUEST_MSI, virq);
-}
-
-int kvm_device_msi_deassign(KVMState *s, uint32_t dev_id)
-{
-    return kvm_deassign_irq_internal(s, dev_id, KVM_DEV_IRQ_GUEST_MSI |
-                                                KVM_DEV_IRQ_HOST_MSI);
-}
-
-bool kvm_device_msix_supported(KVMState *s)
-{
-    /* The kernel lacks a corresponding KVM_CAP, so we probe by calling
-     * KVM_ASSIGN_SET_MSIX_NR with an invalid parameter. */
-    return kvm_vm_ioctl(s, KVM_ASSIGN_SET_MSIX_NR, NULL) == -EFAULT;
-}
-
-int kvm_device_msix_init_vectors(KVMState *s, uint32_t dev_id,
-                                 uint32_t nr_vectors)
-{
-    struct kvm_assigned_msix_nr msix_nr = {
-        .assigned_dev_id = dev_id,
-        .entry_nr = nr_vectors,
-    };
-
-    return kvm_vm_ioctl(s, KVM_ASSIGN_SET_MSIX_NR, &msix_nr);
-}
-
-int kvm_device_msix_set_vector(KVMState *s, uint32_t dev_id, uint32_t vector,
-                               int virq)
-{
-    struct kvm_assigned_msix_entry msix_entry = {
-        .assigned_dev_id = dev_id,
-        .gsi = virq,
-        .entry = vector,
-    };
-
-    return kvm_vm_ioctl(s, KVM_ASSIGN_SET_MSIX_ENTRY, &msix_entry);
-}
-
-int kvm_device_msix_assign(KVMState *s, uint32_t dev_id)
-{
-    return kvm_assign_irq_internal(s, dev_id, KVM_DEV_IRQ_HOST_MSIX |
-                                              KVM_DEV_IRQ_GUEST_MSIX, 0);
-}
-
-int kvm_device_msix_deassign(KVMState *s, uint32_t dev_id)
-{
-    return kvm_deassign_irq_internal(s, dev_id, KVM_DEV_IRQ_GUEST_MSIX |
-                                                KVM_DEV_IRQ_HOST_MSIX);
-}
-
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 06fe06b..7d0242f 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -40,26 +40,6 @@ void kvm_synchronize_all_tsc(void);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
 
-int kvm_device_pci_assign(KVMState *s, PCIHostDeviceAddress *dev_addr,
-                          uint32_t flags, uint32_t *dev_id);
-int kvm_device_pci_deassign(KVMState *s, uint32_t dev_id);
-
-int kvm_device_intx_assign(KVMState *s, uint32_t dev_id,
-                           bool use_host_msi, uint32_t guest_irq);
-int kvm_device_intx_set_mask(KVMState *s, uint32_t dev_id, bool masked);
-int kvm_device_intx_deassign(KVMState *s, uint32_t dev_id, bool use_host_msi);
-
-int kvm_device_msi_assign(KVMState *s, uint32_t dev_id, int virq);
-int kvm_device_msi_deassign(KVMState *s, uint32_t dev_id);
-
-bool kvm_device_msix_supported(KVMState *s);
-int kvm_device_msix_init_vectors(KVMState *s, uint32_t dev_id,
-                                 uint32_t nr_vectors);
-int kvm_device_msix_set_vector(KVMState *s, uint32_t dev_id, uint32_t vector,
-                               int virq);
-int kvm_device_msix_assign(KVMState *s, uint32_t dev_id);
-int kvm_device_msix_deassign(KVMState *s, uint32_t dev_id);
-
 void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
 
 bool kvm_enable_x2apic(void);
-- 
1.8.3.1



