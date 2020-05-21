Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941ADC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5867A20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnSb1wnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5867A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnal-000253-Jl
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbna6-00014L-MT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:58:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24001
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbna5-0003Tn-KL
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590076680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qel/3LEqs8TcaOy9QI2A+SHucHIfp6UqRicGUyRMzw=;
 b=OnSb1wnSf85zg6LUIVEC+d87SXgpnWWKK2+aqYl5ilWVRUgP6eTewPNRt5y9Zhn4RLVNkX
 MajHoXk7qwAZitivStcuGdh04/FGiYEzrVtWZcIWi8hiPT+PE0c3QVS+0jHEehkrf66s5o
 udgDY8a3FcFmJX6dOWOnjCRcJ/MNwmQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-FI8LqEYQNaWRHJAq1TYo8Q-1; Thu, 21 May 2020 11:57:55 -0400
X-MC-Unique: FI8LqEYQNaWRHJAq1TYo8Q-1
Received: by mail-wr1-f70.google.com with SMTP id q13so3106569wrn.14
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1qel/3LEqs8TcaOy9QI2A+SHucHIfp6UqRicGUyRMzw=;
 b=b9gNEMLUehEClHR7Na4VGY0SZyhALg41CFA/kW/2G2WsY0CUi5xGFggoIBgC4zGeUL
 xHopftYzixElhzpdluSzowOgP2tlrtrjvGIQnXsan+JcYDz13DYBlvjkX2r12ybhAzNS
 ezozUXCs3t62kTP5nbA8Hy1C4Y+MkoaXnqM0ODypvIyjDSaxLBah5JRrgxP8MPy9fqRd
 lhSNogsb0YVZ8z06Or2TDiYeFsPMEm0SJg7P86B98llXQgvoJVcaHGkkJZBa+f8m/S4r
 LJvYveLqD3ugamwmpeyMBVIrVDldzUKdA29W7SX9cwd68cNZyaJ86qRnbUHmJ+12Yrv8
 anQQ==
X-Gm-Message-State: AOAM531+FFj19Yj5vF0D6pYb2QxLh2zRpdHqGQGiVJgGPQoDeAwiqtzF
 h2YXv5dyfv+Hqss3Q2gNfGTqf2Q13uAQG2arPbwdgDOLp5wLI1k51m66QDntV8+CHGEHEiUYRC9
 5bL6c5lIS1iftkH4=
X-Received: by 2002:a7b:c385:: with SMTP id s5mr10205660wmj.189.1590076674087; 
 Thu, 21 May 2020 08:57:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1NZ772cjIDQ6H+6h9hcRukaT/Z9oEaCsZzB2YcWj/rovT0eRPMChKIpzyV0fg+jE6+B5GZA==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr10205643wmj.189.1590076673767; 
 Thu, 21 May 2020 08:57:53 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id b18sm6800407wrn.82.2020.05.21.08.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:57:53 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] vfio/pci: Fix up breakage against split irqchip
 and INTx
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200318145204.74483-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c55922d-6f66-15c8-94f1-26a539c0b1fc@redhat.com>
Date: Thu, 21 May 2020 17:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318145204.74483-1-peterx@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/03/20 15:51, Peter Xu wrote:
> v4:
> - pick r-b and a-b for Alex without patch 4
> - only kick resamplefd for level triggered irq (as 3.1 change on patch
>   4) [Alex]
> - fix mingw build error with below squashed into patch 4:
> 
> ----------------------------------------
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 2ae96e10be..b9ec570c03 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -241,6 +241,7 @@ void ioapic_eoi_broadcast(int vector)
>                  continue;
>              }
> 
> +#ifdef CONFIG_KVM
>              /*
>               * When IOAPIC is in the userspace while APIC is still in
>               * the kernel (i.e., split irqchip), we have a trick to
> @@ -257,6 +258,7 @@ void ioapic_eoi_broadcast(int vector)
>               * emulated devices that are using/sharing the same IRQ.
>               */
>              kvm_resample_fd_notify(n);
> +#endif
> 
>              if (!(entry & IOAPIC_LVT_REMOTE_IRR)) {
>                  continue;
> ----------------------------------------
> 
> v3:
> - collect r-bs for Eric
> - unconditionally call kvm_resample_fd_notify(), change comment [Alex]
> - remove the split irqchip check in kvm_resample_fd_notify(), then let
>   it return nothing [Alex]
> - test against shared irq to make sure it won't break
> 
> v2:
> - pick tags
> - don't register resamplefd with KVM kernel when the userspace
>   resamplefd path is enabled (should enable fast path on new kernels)
> - fix resamplefd mem leak
> - fix commit message of patch 4 [Eric]
> - let kvm_resample_fd_notify() return a boolean, skip ioapic check if
>   returned true
> - more comments here and there in the code to state the fact that
>   userspace ioapic irr & remote-irr are bypassed [Paolo]
> 
> VFIO INTx is not working with split irqchip.  On new kernels KVM_IRQFD
> will directly fail with resamplefd attached so QEMU will automatically
> fallback to the INTx slow path.  However on old kernels it's still
> broken.
> 
> Only until recently I noticed that this could also break PXE boot for
> assigned NICs [1].  My wild guess is that the PXE ROM will be mostly
> using INTx as well, which means we can't bypass that even if we
> enables MSI for the guest kernel.
> 
> This series tries to first fix this issue function-wise, then speed up
> for the INTx again with resamplefd (mostly following the ideas
> proposed by Paolo one year ago [2]).  My TCP_RR test shows that:
> 
>   - Before this series: this is broken, no number to show
> 
>   - After patch 1 (enable slow path): get 63% perf comparing to full
>     kernel irqchip
> 
>   - After whole series (enable fast path partly, irq injection will be
>     the same as fast path, however userspace needs to intercept for
>     EOI broadcast to resamplefd, though should still be faster than
>     the MMIO trick for intx eoi): get 93% perf comparing to full
>     kernel irqchip, which is a 46% performance boost
> 
> I think we can consider to apply patch 1 even sooner than the rest of
> the series to unbreak intx+split first.
> 
> The whole test matrix for reference:
> 
>   |----------+---------+-------------------+--------------+--------------------|
>   | IRQ type | irqchip | TCP_STREAM (Gbps) | TCP_RR (pps) | note               |
>   |----------+---------+-------------------+--------------+--------------------|
>   | msi      | on      |              9.39 |        17567 |                    |
>   | nomsi    | on      |              9.29 |        14056 |                    |
>   | msi      | split   |              9.36 |        17330 |                    |
>   | nomsi    | split   |                 / |            / | currently broken   |
>   | nomsi    | split   |              8.98 |         8977 | after patch 1      |
>   | nomsi    | split   |              9.21 |        13142 | after whole series |
>   |----------+---------+-------------------+--------------+--------------------|
> 
> Any review comment is welcomed.  Thanks,
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1786404
> [2] https://patchwork.kernel.org/patch/10738541/#22609933
> 
> Peter Xu (5):
>   vfio/pci: Disable INTx fast path if using split irqchip
>   vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for irqfds
>   KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
>   KVM: Kick resamplefd for split kernel irqchip
>   Revert "vfio/pci: Disable INTx fast path if using split irqchip"
> 
>  accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++++++++++++----
>  accel/kvm/trace-events |  1 +
>  hw/intc/ioapic.c       | 19 +++++++++
>  hw/vfio/pci.c          | 37 +++++++---------
>  include/sysemu/kvm.h   |  4 ++
>  5 files changed, 126 insertions(+), 30 deletions(-)
> 

Queued, thanks.

Paolo


