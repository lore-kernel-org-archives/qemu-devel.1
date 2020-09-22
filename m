Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47741C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A4023A61
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X56zTAEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A4023A61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKl7p-0002Qz-Kn
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKkN5-0001Mj-HU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKkN3-0000Qz-4y
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600789100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuaYKSij4WH1NXByncA5AVSp9syAJ776Fggbd8itbrg=;
 b=X56zTAExOcHUwI7YeaU2WkBkRpAXXakwLoZ7ulzx8cVQ2BRvbQKMSVR2K5sH9nJynncsd9
 hkJJJIOYsjRy9E4dYSfhsDC8QT2xa0hkxQNk1b4KbQdOABsiN2/arIfJNzrS+wVswwJ0IG
 kQvlfoetK4Fl/tpBnfsCUMdpk7rZA7s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-9n-GSsUaNy2T9BnG8_pLKg-1; Tue, 22 Sep 2020 11:38:18 -0400
X-MC-Unique: 9n-GSsUaNy2T9BnG8_pLKg-1
Received: by mail-wr1-f70.google.com with SMTP id 33so7614490wre.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 08:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=WuaYKSij4WH1NXByncA5AVSp9syAJ776Fggbd8itbrg=;
 b=kY1kghgq8AWMaQarc2MpEf2CxCe+JFTA4pYPI8gZGqgsYPlVcfJtklhlbg5jT3vLXo
 cL5VKWGoIPjocFkmyywEUzFlGxAFxLCkfGWDSBVf9AJ18h66VLaMLvGtEe9HUfIyYv7S
 UlBidJrmKK/tZfW2MSp5k5fLhTmrsJod8GcfZJVhkYR+hdN8JUTTlgzWm9AMvmv4YA8s
 GgyFEgfwl5FRqXBXDYEb1cPwB0NB3500jrRqMWSQ+b47UaQ2Meei23HNCbhH/FCrbGNX
 tKjHeAKf52fav2pqsCbqBPk+bhypSY22zEj97Qq0eHhV5plgUjOoJLqwn+lNcYy414lU
 dUsQ==
X-Gm-Message-State: AOAM533Z3/GW/tJqxJ4cp+9Oro0N9N3S/ZAA8CLoYJdjPy66CLVI++M5
 GJYQxoB0g8PC70y7+k6g6XmVg1/mPrb7DbvzTmLWOmB+Rkj/EAszUrdqcx/foE9zWZsBFoitY+7
 TZxmHs9xl0dL5/48=
X-Received: by 2002:a1c:e484:: with SMTP id b126mr1623681wmh.44.1600789094362; 
 Tue, 22 Sep 2020 08:38:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynXdfXyBnd242un5XVis7GmOEU7D12gowjspwcx7XthRwbz+t15wEohJR5o+CX20vzIO9+HQ==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr1623655wmh.44.1600789094116; 
 Tue, 22 Sep 2020 08:38:14 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id z15sm27228395wrv.94.2020.09.22.08.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 08:38:13 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386: Don't try to set MSR_KVM_ASYNC_PF_EN if
 kernel-irqchip=off
In-Reply-To: <20200922151455.1763896-1-ehabkost@redhat.com>
References: <20200922151455.1763896-1-ehabkost@redhat.com>
Date: Tue, 22 Sep 2020 17:38:12 +0200
Message-ID: <87v9g5es9n.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
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
Cc: Laurent Vivier <lvivier@redhat.com>, 1896263@bugs.launchpad.net,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> This addresses the following crash when running Linux v5.8
> with kernel-irqchip=off:
>
>   qemu-system-x86_64: error: failed to set MSR 0x4b564d02 to 0x0
>   qemu-system-x86_64: ../target/i386/kvm.c:2714: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
>
> There is a kernel-side fix for the issue too (kernel commit
> d831de177217 "KVM: x86: always allow writing '0' to
> MSR_KVM_ASYNC_PF_EN"), but it's nice to simply not trigger
> the bug if running an older kernel.
>
> Fixes: https://bugs.launchpad.net/bugs/1896263
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/kvm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 9efb07e7c83..1492f41349f 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2818,7 +2818,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>          kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
>          kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
>          kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
> +        /*
> +         * Some kernel versions (v5.8) won't let MSR_KVM_ASYNC_PF_EN to be set
> +         * at all if kernel-irqchip=off, so don't try to set it in that case.
> +         */
> +        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF) &&
> +            kvm_irqchip_in_kernel()) {
>              kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
>          }
>          if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {

I'm not sure kvm_irqchip_in_kernel() was required before we switched to
interrupt-based APF (as we were always injecting #PF) but with
kernel-5.8+ this should work. We'll need to merge this with

https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg02963.html
(queued by Paolo) and
https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg06196.html
which fixes a bug in it.

as kvm_irqchip_in_kernel() should go around both KVM_FEATURE_ASYNC_PF
and KVM_FEATURE_ASYNC_PF_INT I believe.

-- 
Vitaly


