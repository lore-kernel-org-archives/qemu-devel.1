Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C81C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC15A2072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="TQXHKbh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC15A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=etsukata.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieF2y-0002IO-Ua
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <devel@etsukata.com>) id 1ieDV0-0001AC-AC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <devel@etsukata.com>) id 1ieDUy-0003nb-Mq
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:30:30 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <devel@etsukata.com>) id 1ieDUy-0003mN-9A
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:30:28 -0500
Received: by mail-pl1-x642.google.com with SMTP id x17so164254pln.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 23:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=etsukata-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ytPK+hH06lqGjyswEy6eX9rtlUfTVQLT89l523gdpMs=;
 b=TQXHKbh/UREXMkgVaVPmqJupbseTmERK85MSDdLPis5u1tVUExHIF2zXEQ/a3R7uQ7
 IPwFTVpkEKj9e2i7wuejXnNviflA1eEBi2XSijSCJWlUZqr0N0qS4AiLae2W5JKZGke6
 yEY+P7bfGFI0rkklI1oaiX+BH37TCypVO2MUIY0VN5bxvayX/7eItAEw1NtOKFiV5vuB
 BcjIw/fftHvBa+JpOPXVmCr+A99xGhk+DLnSd6EYBv/p3Mz4dCnXhGjcn1AIPquwtA7+
 YXUnwb5nWCYHsraEPdT1miHxDXgCe0/3cNCob32aTC+P57mY7Q17STKGBu/UInM6fLM2
 Byxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ytPK+hH06lqGjyswEy6eX9rtlUfTVQLT89l523gdpMs=;
 b=c+X/P2jPjdWpsQARhrb+CZZvDXQHgf5Vk1HGzrS9nRN1g7LtoxddDzlSF2XSK/YgAj
 1+k6TNDKK3Rh0KB1jMNzSg6NjsBjYzIsA51+4xv43ajyaCHu2HtOp2OYYTBcMrhGNlFv
 aLxzpsWLBYOlUVzIbrBwwwqXJLY7BCvcbjdEKcouFfUijS9a4+qD/V4KdppCB00eHtb+
 7iL27q899ZpRFIZMVvqlv0tCWkalY/Bm1cddfBLe5jEvyt5i2iqIK6B37KG8pzmgU5hZ
 ohY7F9Qvq49Hz4QXIeWI3GG6euCh6ngqk6YxpLPMZVmJJQkvgL452gHBrm1S3kVAtX5P
 LnIQ==
X-Gm-Message-State: APjAAAWuXnbE2xW9GugjXqriRO+hwQSFWL2Csu8Fhc5ymiJZ9l8t+oFH
 q0UW+V91nLUjc0dCerkVzUZ8BA==
X-Google-Smtp-Source: APXvYqzqCU1qinCtg2re+a0Na3/RreE9wGd00R/ycD/EeVqpcds+bFJlRj6O+FZYejrD+pKoLWVleA==
X-Received: by 2002:a17:902:968b:: with SMTP id
 n11mr23780213plp.120.1575876626379; 
 Sun, 08 Dec 2019 23:30:26 -0800 (PST)
Received: from localhost.localdomain
 (p5309002-ipngn11902marunouchi.tokyo.ocn.ne.jp. [114.166.47.2])
 by smtp.gmail.com with ESMTPSA id q22sm26104660pfg.170.2019.12.08.23.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2019 23:30:25 -0800 (PST)
From: Eiichi Tsukata <devel@etsukata.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: [PATCH] target/i386: remove unused pci-assign codes
Date: Mon,  9 Dec 2019 16:29:32 +0900
Message-Id: <20191209072932.313056-1-devel@etsukata.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
X-Mailman-Approved-At: Mon, 09 Dec 2019 04:08:43 -0500
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
Cc: Eiichi Tsukata <devel@etsukata.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Legacy PCI device assignment has been already removed in commit ab37bfc7d641
("pci-assign: Remove"), but some codes remain unused.

CC: qemu-trivial@nongnu.org
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 target/i386/kvm.c      | 140 -----------------------------------------
 target/i386/kvm_i386.h |  20 ------
 2 files changed, 160 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index bf1655645b..efd39843c4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4505,146 +4505,6 @@ int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
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
index 06fe06bdb3..7d0242f5fb 100644
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
2.23.0


