Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F38C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AB320C56
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0HFOo25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AB320C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBw2-0008Iz-7m
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJBuc-0007Wl-BZ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJBua-0007Eq-NG
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600418311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKtY+pRlucL0q3uuq9pIy/9rTnLjOr3sHbFXDHxPOF4=;
 b=D0HFOo25jNrueuTg4tnOFFurw7fuDoiFtHVc5JrBPFXR0k2bhFMtSxMFBsfTa1757xo8k4
 Pn645eOhSwqrtjPqEnzMbhI6GD68azge62m0r3sbikzVUzRjNH9PIfq5H1ys5mPhEaCyvs
 0V/WaCLJpZgQXbXIebJOdFB9BtvZuhc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-3Z1kRkLyNc2U6r_pE0Auew-1; Fri, 18 Sep 2020 04:38:30 -0400
X-MC-Unique: 3Z1kRkLyNc2U6r_pE0Auew-1
Received: by mail-wm1-f70.google.com with SMTP id y18so1219575wma.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jKtY+pRlucL0q3uuq9pIy/9rTnLjOr3sHbFXDHxPOF4=;
 b=aJTCgboVOXAqMf88hZa2o27jR6YIq+6tjPa7aSDZc4sWuHkjLvuqbX2ehJPEHBv1dU
 Dfamlm/xnF4Re5mqgMZp80hXkq+/mQK9zzUZraaBfyxxXs9f0qVJOc3ekdA7giEQ2BR6
 wdP9iVS//3abZMEsRAyo4wrbyMSYFXXMCWv8cfOQ2HcvMScfd6Iga87dE7Z8EMKV2qFe
 XhaBMdje3GzLHApK/nmc858+ARczFsK5Dg7JQQap1zUvSacBfbxc5SsCYcyhbGMvyxcM
 gMEOexwttxInoqiq87WzClZEQGLBHUkJJeaJkAerdgzx5VzBXqJ/Mc7D4CWvkDFghoZb
 Y5Xw==
X-Gm-Message-State: AOAM533y7acZHjiOoS84lw3cL7OvijUkfqErtQL77RodT3EeK0gRo+Bp
 PihrvZKGq0Hbp6BTjPMT2IJUKrLonRBW/+eq0jIjNGc3wjmmliq6lOCk4MOWsCnNfvnJlm8aXj3
 1bVzrKShHZ0OefP4=
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr35898419wrp.161.1600418308553; 
 Fri, 18 Sep 2020 01:38:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBgZJv4k7YOw5Vd1InQhxbs2WD5xa8tnX5DRzcCPcvO8Y+XtOL4o79V9Za/orVPGiUJmAiMw==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr35898401wrp.161.1600418308320; 
 Fri, 18 Sep 2020 01:38:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:69b4:4715:609f:385f?
 ([2001:b07:6468:f312:69b4:4715:609f:385f])
 by smtp.gmail.com with ESMTPSA id s80sm3702185wme.41.2020.09.18.01.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:38:27 -0700 (PDT)
Subject: Re: [PATCH] target/i386: always create kvmclock device
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200917111306.819263-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8783874f-8d6d-b1b6-20c3-9910c267779b@redhat.com>
Date: Fri, 18 Sep 2020 10:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917111306.819263-1-vkuznets@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Antoine Damhet <antoine.damhet@blade-group.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/20 13:13, Vitaly Kuznetsov wrote:
> QEMU's kvmclock device is only created when KVM PV feature bits for
> kvmclock (KVM_FEATURE_CLOCKSOURCE/KVM_FEATURE_CLOCKSOURCE2) are
> exposed to the guest. With 'kvm=off' cpu flag the device is not
> created and we don't call KVM_GET_CLOCK/KVM_SET_CLOCK upon migration.
> It was reported that without these call at least Hyper-V TSC page
> clocksouce (which can be enabled independently) gets broken after
> migration.
> 
> Switch to creating kvmclock QEMU device unconditionally, it seems
> to always make sense to call KVM_GET_CLOCK/KVM_SET_CLOCK on migration.
> Use KVM_CAP_ADJUST_CLOCK check instead of CPUID feature bits.
> 
> Reported-by: Antoine Damhet <antoine.damhet@blade-group.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  hw/i386/kvm/clock.c    | 6 +-----
>  target/i386/kvm.c      | 5 +++++
>  target/i386/kvm_i386.h | 1 +
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 64283358f91d..526c9ea5172b 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -330,11 +330,7 @@ static const TypeInfo kvmclock_info = {
>  /* Note: Must be called after VCPU initialization. */
>  void kvmclock_create(void)
>  {
> -    X86CPU *cpu = X86_CPU(first_cpu);
> -
> -    if (kvm_enabled() &&
> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
> +    if (kvm_enabled() && kvm_has_adjust_clock()) {
>          sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
>      }
>  }
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 4a8b3a41c1bc..20b31b65307b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -143,6 +143,11 @@ bool kvm_has_adjust_clock_stable(void)
>      return (ret == KVM_CLOCK_TSC_STABLE);
>  }
>  
> +bool kvm_has_adjust_clock(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
> +}
> +
>  bool kvm_has_exception_payload(void)
>  {
>      return has_exception_payload;
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index 064b8798a26c..0fce4e51d2d6 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -34,6 +34,7 @@
>  
>  bool kvm_allows_irq0_override(void);
>  bool kvm_has_smm(void);
> +bool kvm_has_adjust_clock(void);
>  bool kvm_has_adjust_clock_stable(void);
>  bool kvm_has_exception_payload(void);
>  void kvm_synchronize_all_tsc(void);
> 

Queued, thanks.

Paolo


