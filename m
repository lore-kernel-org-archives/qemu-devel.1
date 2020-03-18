Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D23C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6132076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqL98opt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6132076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWFl-0002x9-V5
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEWEp-00027E-Ay
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEWEo-00034X-6k
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEWEo-000323-22
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584528469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20Pma11u+V3QJ12jl7Iqp+bmqwni4dt/3uPHazTMKo8=;
 b=aqL98optVhRQR1h3g4qnKzcU8QFITi4jDVsGJ/FRzJOrTb3geNWNsaVRxZ5EMT88fMx59z
 ACM45rXaUccQ4m9fBQ7Xn3l723oB4BZNrsJjhn3Bs7JLgKKboh4ssvXjVq4MGDr8huKGIh
 TchIcPwTQ7UNgd/bZtN6h0ffaVeXRmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-l1VhSE9sOumCqVxR9cXOUQ-1; Wed, 18 Mar 2020 06:47:48 -0400
X-MC-Unique: l1VhSE9sOumCqVxR9cXOUQ-1
Received: by mail-wm1-f72.google.com with SMTP id a23so868229wmm.8
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 03:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=20Pma11u+V3QJ12jl7Iqp+bmqwni4dt/3uPHazTMKo8=;
 b=H0midZcO4OKL8r9D0GT71VTVk8DyzDt8UAOzZIzudOtM+hEyWN5IbJYmaoQNXAGsEe
 68LKMZp47Sm09mZNwzKSuwqrd/TF8WSthsNLowfafiZI8IrG+4T3+SWyiIZS68Lo4+HF
 07lHM7mzql6JpC4TFjTDjc+RnwnZXw4CUYxEpHapsxf5lsR1t5xE+dj6C6b+bR5df9vL
 NYZrAreytOLUt9GR62SpMx4BDQgxjcRmw9JHtW6fLTrHPPDBa7BKs9QoFQOKiczsdfcG
 ALFWJglY5RP4CVrrMVp6/Qh0E6XaZZvCyUqtP6r2Zbam6uTTt+mrw2pdOPV1WuygaIt5
 McXQ==
X-Gm-Message-State: ANhLgQ3GZewRYWxmP9xwqbajVOMaRpbqo8h4xXhtEv+9N+2Lky4RdG1u
 KsfCgvyAHsUWYgZ0sENU2vMkZVySvxL5iQorDVJYCFe4SuStiP2ACbLcoShBUmfPxAOvQyPeyYK
 B9qoSA4XQ2NxX/2E=
X-Received: by 2002:a1c:3585:: with SMTP id c127mr4574225wma.124.1584528466991; 
 Wed, 18 Mar 2020 03:47:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuAtZOmBxaL+oCC9HAvrwkuL2dQBy3C1WKZmpeb/R7KpwuLMA+nd6TV9Ou+ZyizLHgON8YK3w==
X-Received: by 2002:a1c:3585:: with SMTP id c127mr4574198wma.124.1584528466730; 
 Wed, 18 Mar 2020 03:47:46 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id p10sm8545688wru.4.2020.03.18.03.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 03:47:46 -0700 (PDT)
Subject: Re: [PATCH] kvm: support to get/set dirty log initial-all-set
 capability
To: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20200304025554.2159-1-jianjay.zhou@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18e7b781-8a52-d78a-a653-898445a5ee53@redhat.com>
Date: Wed, 18 Mar 2020 11:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304025554.2159-1-jianjay.zhou@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: liu.jinsong@huawei.com, weidong.huang@huawei.com, mst@redhat.com,
 wangxinxin.wang@huawei.com, cohuck@redhat.com, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/03/20 03:55, Jay Zhou wrote:
> Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced in the
> kernel, tweak the userspace side to detect and enable this
> capability.
> 
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>  accel/kvm/kvm-all.c       | 21 ++++++++++++++-------
>  linux-headers/linux/kvm.h |  3 +++
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 439a4efe52..45ab25be63 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -100,7 +100,7 @@ struct KVMState
>      bool kernel_irqchip_required;
>      OnOffAuto kernel_irqchip_split;
>      bool sync_mmu;
> -    bool manual_dirty_log_protect;
> +    uint64_t manual_dirty_log_protect;
>      /* The man page (and posix) say ioctl numbers are signed int, but
>       * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
>       * unsigned, and treating them as signed here can break things */
> @@ -1882,6 +1882,7 @@ static int kvm_init(MachineState *ms)
>      int ret;
>      int type = 0;
>      const char *kvm_type;
> +    uint64_t dirty_log_manual_caps;
>  
>      s = KVM_STATE(ms->accelerator);
>  
> @@ -2007,14 +2008,20 @@ static int kvm_init(MachineState *ms)
>      s->coalesced_pio = s->coalesced_mmio &&
>                         kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
>  
> -    s->manual_dirty_log_protect =
> +    dirty_log_manual_caps =
>          kvm_check_extension(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> -    if (s->manual_dirty_log_protect) {
> -        ret = kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0, 1);
> +    dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
> +                              KVM_DIRTY_LOG_INITIALLY_SET);
> +    s->manual_dirty_log_protect = dirty_log_manual_caps;
> +    if (dirty_log_manual_caps) {
> +        ret = kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0,
> +                                   dirty_log_manual_caps);
>          if (ret) {
> -            warn_report("Trying to enable KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 "
> -                        "but failed.  Falling back to the legacy mode. ");
> -            s->manual_dirty_log_protect = false;
> +            warn_report("Trying to enable capability %"PRIu64" of "
> +                        "KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 but failed. "
> +                        "Falling back to the legacy mode. ",
> +                        dirty_log_manual_caps);
> +            s->manual_dirty_log_protect = 0;
>          }
>      }
>  
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 265099100e..3cb71c2b19 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1628,4 +1628,7 @@ struct kvm_hyperv_eventfd {
>  #define KVM_HYPERV_CONN_ID_MASK		0x00ffffff
>  #define KVM_HYPERV_EVENTFD_DEASSIGN	(1 << 0)
>  
> +#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
> +#define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
> +
>  #endif /* __LINUX_KVM_H */
> 

Queued, thanks.

Paolo


