Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CDCC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 08:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5DE2073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPVQKTeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5DE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieEge-0002YO-WB
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 03:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieEfh-0001c8-0u
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieEff-0006uq-9b
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:45:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50094
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieEff-0006um-5J
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575881134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoYFY4rhMOvAA6zJE2Fk4UkoKAxwgDgrfc97LOA8K8Y=;
 b=dPVQKTeGnGxWwzoT0CVkRhz9RnV6U6e8DtUHXkTpi0XPymwFAiyqYm1TLkDp7diFxGfsCt
 Ag6ar3ZortrUBZU3fUN6CO47OGrujwjAZWjvMdQNJgyPSVhX0winfSyVZCOpynKoPw68aV
 21MjD0VZbvUc+1e090c3Sahop6kOUz0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-oDcwARW1NReF2QOO-wOFAw-1; Mon, 09 Dec 2019 03:45:31 -0500
Received: by mail-wm1-f69.google.com with SMTP id o135so2804559wme.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 00:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eoYFY4rhMOvAA6zJE2Fk4UkoKAxwgDgrfc97LOA8K8Y=;
 b=DpFk64wKWbesNzubuMO+LkNpLP5XfbcoipfEDg5bpF0qusmjRCEPAohDwmJI0czZxq
 z6y/qjtdcuggUkFBMNIQ+ULaLnvn6jTxlq3owicAMNe88rAOrJM7T667RviHFvbjNdGN
 Vn+p+XB4q28E1zc5RfVlZIXalVZiV/61bFybKUMGOswllnnIPgOlprCexNchkdEDVrpK
 IlglSeFI36aPUglkCC1llyX2rK5K01b1e8Ihk7lfRIosBfkSb4S6c6R8QlX+l/3c81TT
 2G05HzMpLwwa/TLdlRNnoyo/fttzlfzy21TYj6sUOrM1DNoHs3R/+P37dp7yU9q7HAX1
 JIZA==
X-Gm-Message-State: APjAAAXmGQhCM3YQcbra+zFmPV99hnvtkdoamYpbJKPIqu31nh4UrhmO
 Ahw12VKImQJeHt3pgE0Kjp+4nOJBCZp77+F2JBQuRYYtetALerDx8rhgsTzlc00wqRV80M/XNLI
 ssMGqhDyQOn6H9kA=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr23058426wmc.174.1575881130466; 
 Mon, 09 Dec 2019 00:45:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHPRl9+ZA0GFhUuMh/FXM/KDILMtoHyZukISsFpfocYzX6RgQGCIuLNW5fOzJRKXLhiKSdBg==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr23058398wmc.174.1575881130182; 
 Mon, 09 Dec 2019 00:45:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id c2sm26623597wrp.46.2019.12.09.00.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 00:45:29 -0800 (PST)
Subject: Re: [PATCH] target/i386: remove unused pci-assign codes
To: Eiichi Tsukata <devel@etsukata.com>, mtosatti@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20191209072932.313056-1-devel@etsukata.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <652d62de-bf30-7fd8-c203-0393b3720593@redhat.com>
Date: Mon, 9 Dec 2019 09:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191209072932.313056-1-devel@etsukata.com>
Content-Language: en-US
X-MC-Unique: oDcwARW1NReF2QOO-wOFAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 08:29, Eiichi Tsukata wrote:
> Legacy PCI device assignment has been already removed in commit ab37bfc7d641
> ("pci-assign: Remove"), but some codes remain unused.
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
> ---
>  target/i386/kvm.c      | 140 -----------------------------------------
>  target/i386/kvm_i386.h |  20 ------
>  2 files changed, 160 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index bf1655645b..efd39843c4 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -4505,146 +4505,6 @@ int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
>      }
>  }
>  
> -/* Classic KVM device assignment interface. Will remain x86 only. */
> -int kvm_device_pci_assign(KVMState *s, PCIHostDeviceAddress *dev_addr,
> -                          uint32_t flags, uint32_t *dev_id)
> -{
> -    struct kvm_assigned_pci_dev dev_data = {
> -        .segnr = dev_addr->domain,
> -        .busnr = dev_addr->bus,
> -        .devfn = PCI_DEVFN(dev_addr->slot, dev_addr->function),
> -        .flags = flags,
> -    };
> -    int ret;
> -
> -    dev_data.assigned_dev_id =
> -        (dev_addr->domain << 16) | (dev_addr->bus << 8) | dev_data.devfn;
> -
> -    ret = kvm_vm_ioctl(s, KVM_ASSIGN_PCI_DEVICE, &dev_data);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    *dev_id = dev_data.assigned_dev_id;
> -
> -    return 0;
> -}
> -
> -int kvm_device_pci_deassign(KVMState *s, uint32_t dev_id)
> -{
> -    struct kvm_assigned_pci_dev dev_data = {
> -        .assigned_dev_id = dev_id,
> -    };
> -
> -    return kvm_vm_ioctl(s, KVM_DEASSIGN_PCI_DEVICE, &dev_data);
> -}
> -
> -static int kvm_assign_irq_internal(KVMState *s, uint32_t dev_id,
> -                                   uint32_t irq_type, uint32_t guest_irq)
> -{
> -    struct kvm_assigned_irq assigned_irq = {
> -        .assigned_dev_id = dev_id,
> -        .guest_irq = guest_irq,
> -        .flags = irq_type,
> -    };
> -
> -    if (kvm_check_extension(s, KVM_CAP_ASSIGN_DEV_IRQ)) {
> -        return kvm_vm_ioctl(s, KVM_ASSIGN_DEV_IRQ, &assigned_irq);
> -    } else {
> -        return kvm_vm_ioctl(s, KVM_ASSIGN_IRQ, &assigned_irq);
> -    }
> -}
> -
> -int kvm_device_intx_assign(KVMState *s, uint32_t dev_id, bool use_host_msi,
> -                           uint32_t guest_irq)
> -{
> -    uint32_t irq_type = KVM_DEV_IRQ_GUEST_INTX |
> -        (use_host_msi ? KVM_DEV_IRQ_HOST_MSI : KVM_DEV_IRQ_HOST_INTX);
> -
> -    return kvm_assign_irq_internal(s, dev_id, irq_type, guest_irq);
> -}
> -
> -int kvm_device_intx_set_mask(KVMState *s, uint32_t dev_id, bool masked)
> -{
> -    struct kvm_assigned_pci_dev dev_data = {
> -        .assigned_dev_id = dev_id,
> -        .flags = masked ? KVM_DEV_ASSIGN_MASK_INTX : 0,
> -    };
> -
> -    return kvm_vm_ioctl(s, KVM_ASSIGN_SET_INTX_MASK, &dev_data);
> -}
> -
> -static int kvm_deassign_irq_internal(KVMState *s, uint32_t dev_id,
> -                                     uint32_t type)
> -{
> -    struct kvm_assigned_irq assigned_irq = {
> -        .assigned_dev_id = dev_id,
> -        .flags = type,
> -    };
> -
> -    return kvm_vm_ioctl(s, KVM_DEASSIGN_DEV_IRQ, &assigned_irq);
> -}
> -
> -int kvm_device_intx_deassign(KVMState *s, uint32_t dev_id, bool use_host_msi)
> -{
> -    return kvm_deassign_irq_internal(s, dev_id, KVM_DEV_IRQ_GUEST_INTX |
> -        (use_host_msi ? KVM_DEV_IRQ_HOST_MSI : KVM_DEV_IRQ_HOST_INTX));
> -}
> -
> -int kvm_device_msi_assign(KVMState *s, uint32_t dev_id, int virq)
> -{
> -    return kvm_assign_irq_internal(s, dev_id, KVM_DEV_IRQ_HOST_MSI |
> -                                              KVM_DEV_IRQ_GUEST_MSI, virq);
> -}
> -
> -int kvm_device_msi_deassign(KVMState *s, uint32_t dev_id)
> -{
> -    return kvm_deassign_irq_internal(s, dev_id, KVM_DEV_IRQ_GUEST_MSI |
> -                                                KVM_DEV_IRQ_HOST_MSI);
> -}
> -
> -bool kvm_device_msix_supported(KVMState *s)
> -{
> -    /* The kernel lacks a corresponding KVM_CAP, so we probe by calling
> -     * KVM_ASSIGN_SET_MSIX_NR with an invalid parameter. */
> -    return kvm_vm_ioctl(s, KVM_ASSIGN_SET_MSIX_NR, NULL) == -EFAULT;
> -}
> -
> -int kvm_device_msix_init_vectors(KVMState *s, uint32_t dev_id,
> -                                 uint32_t nr_vectors)
> -{
> -    struct kvm_assigned_msix_nr msix_nr = {
> -        .assigned_dev_id = dev_id,
> -        .entry_nr = nr_vectors,
> -    };
> -
> -    return kvm_vm_ioctl(s, KVM_ASSIGN_SET_MSIX_NR, &msix_nr);
> -}
> -
> -int kvm_device_msix_set_vector(KVMState *s, uint32_t dev_id, uint32_t vector,
> -                               int virq)
> -{
> -    struct kvm_assigned_msix_entry msix_entry = {
> -        .assigned_dev_id = dev_id,
> -        .gsi = virq,
> -        .entry = vector,
> -    };
> -
> -    return kvm_vm_ioctl(s, KVM_ASSIGN_SET_MSIX_ENTRY, &msix_entry);
> -}
> -
> -int kvm_device_msix_assign(KVMState *s, uint32_t dev_id)
> -{
> -    return kvm_assign_irq_internal(s, dev_id, KVM_DEV_IRQ_HOST_MSIX |
> -                                              KVM_DEV_IRQ_GUEST_MSIX, 0);
> -}
> -
> -int kvm_device_msix_deassign(KVMState *s, uint32_t dev_id)
> -{
> -    return kvm_deassign_irq_internal(s, dev_id, KVM_DEV_IRQ_GUEST_MSIX |
> -                                                KVM_DEV_IRQ_HOST_MSIX);
> -}
> -
>  int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                               uint64_t address, uint32_t data, PCIDevice *dev)
>  {
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index 06fe06bdb3..7d0242f5fb 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -40,26 +40,6 @@ void kvm_synchronize_all_tsc(void);
>  void kvm_arch_reset_vcpu(X86CPU *cs);
>  void kvm_arch_do_init_vcpu(X86CPU *cs);
>  
> -int kvm_device_pci_assign(KVMState *s, PCIHostDeviceAddress *dev_addr,
> -                          uint32_t flags, uint32_t *dev_id);
> -int kvm_device_pci_deassign(KVMState *s, uint32_t dev_id);
> -
> -int kvm_device_intx_assign(KVMState *s, uint32_t dev_id,
> -                           bool use_host_msi, uint32_t guest_irq);
> -int kvm_device_intx_set_mask(KVMState *s, uint32_t dev_id, bool masked);
> -int kvm_device_intx_deassign(KVMState *s, uint32_t dev_id, bool use_host_msi);
> -
> -int kvm_device_msi_assign(KVMState *s, uint32_t dev_id, int virq);
> -int kvm_device_msi_deassign(KVMState *s, uint32_t dev_id);
> -
> -bool kvm_device_msix_supported(KVMState *s);
> -int kvm_device_msix_init_vectors(KVMState *s, uint32_t dev_id,
> -                                 uint32_t nr_vectors);
> -int kvm_device_msix_set_vector(KVMState *s, uint32_t dev_id, uint32_t vector,
> -                               int virq);
> -int kvm_device_msix_assign(KVMState *s, uint32_t dev_id);
> -int kvm_device_msix_deassign(KVMState *s, uint32_t dev_id);
> -
>  void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
>  
>  bool kvm_enable_x2apic(void);
> 

Queued, thanks.


