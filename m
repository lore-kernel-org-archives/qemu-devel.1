Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8000620720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1w4anF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8000620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIVX-0000oU-NX
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIF1-00082R-9J
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:08:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIEz-0007Zb-B9
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgmaAxo6fmWtsoTPhFRh0NpaPV7AtIZ6Fvm8jXBM5aE=;
 b=d1w4anF302j8PFudjOx1kpZbYj32ZqAU7dIRFmF9fjC3bDaaEeM2mBaZ95szt//WnxFDpf
 tQQpqF2iFxXHp0vi3ihmu6lN3Xo6PxJCbx1SBpQ3KYc/Hr4PpwEZRXazfoEpARqmlAkKtb
 NKZbXxH8Ex1OC0tkKhAPCZkEfQy89g0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-QrS2mFtnMMqX4rqCenV5OA-1; Wed, 08 Jul 2020 12:07:38 -0400
X-MC-Unique: QrS2mFtnMMqX4rqCenV5OA-1
Received: by mail-wr1-f69.google.com with SMTP id j5so52456786wro.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CgmaAxo6fmWtsoTPhFRh0NpaPV7AtIZ6Fvm8jXBM5aE=;
 b=lJLLM+cVWx/YVMeEklBRmBpA7tDs9v656B7jYv/u4jIwnFw+mUwMuD7E5qQb5AftMI
 HBQ66Mg137aqg29XpWm2Vigj6Tvt8GtUUaz7zCk6FMepDxpcFKNtG/yY4cX5XZVh2+Te
 DH4I1PzQqg5UaKIl/Yhi2xnUI8+iNC1GMI9TXX69zpYWYBtKMiA9aL+Ev/cvGuHfUcmf
 5I+niXo2ChkDjsc8SD0MEGyVTjg3HOM3XRn2etroMBCEML1xWbzg/FEHkJENl3+z5Q61
 lqQ+pcVFU5sEHVUwk+i/zIiz06tR/KCpE8tyQk5h8e2o0SFAWbnwBGHg4NUHUsmEVyFG
 l7LQ==
X-Gm-Message-State: AOAM532o1srklj6kbwCtV23P7axUawhtAHbTmzw7EsK581hVBWv8Dxhe
 nu3WHG0i9PwUhhjwkYAW0aEQUa+evsoN3PHkabOoPsYj0nYgFmdE7VDNcshyOCG6QU3g85ynMv0
 O8V4gBk989v/edYU=
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr9678478wme.46.1594224457009; 
 Wed, 08 Jul 2020 09:07:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN00OIt/eSWJi65ZC9R4Zx61OKf1LAE0m9BTBlNqTFPd+JNpu3WhZy5c2u2o4k0+vIVAB0Mw==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr9678455wme.46.1594224456760; 
 Wed, 08 Jul 2020 09:07:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id j15sm592488wrx.69.2020.07.08.09.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:07:35 -0700 (PDT)
Subject: Re: [PATCH v2] apic: Report current_count via 'info lapic'
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
References: <e00e2896-ca5b-a929-de7a-8e5762f0c1c2@siemens.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d40f3b59-e32e-30be-ff6c-ecc86ca302f0@redhat.com>
Date: Wed, 8 Jul 2020 18:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e00e2896-ca5b-a929-de7a-8e5762f0c1c2@siemens.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/20 07:43, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This is helpful when debugging stuck guest timers.
> 
> As we need apic_get_current_count for that, and it is really not
> emulation specific, move it to apic_common.c and export it. Fix its
> style at this chance as well.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> 
> Changes in v2:
>  - fix style of apic_get_current_count
> 
>  hw/intc/apic.c                  | 18 ------------------
>  hw/intc/apic_common.c           | 19 +++++++++++++++++++
>  include/hw/i386/apic_internal.h |  1 +
>  target/i386/helper.c            |  5 +++--
>  4 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index bd40467965..f2207d0ace 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -615,24 +615,6 @@ int apic_accept_pic_intr(DeviceState *dev)
>      return 0;
>  }
>  
> -static uint32_t apic_get_current_count(APICCommonState *s)
> -{
> -    int64_t d;
> -    uint32_t val;
> -    d = (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_load_time) >>
> -        s->count_shift;
> -    if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
> -        /* periodic */
> -        val = s->initial_count - (d % ((uint64_t)s->initial_count + 1));
> -    } else {
> -        if (d >= s->initial_count)
> -            val = 0;
> -        else
> -            val = s->initial_count - d;
> -    }
> -    return val;
> -}
> -
>  static void apic_timer_update(APICCommonState *s, int64_t current_time)
>  {
>      if (apic_next_timer(s, current_time)) {
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 9ec0f2deb2..fb432e83f2 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -189,6 +189,25 @@ bool apic_next_timer(APICCommonState *s, int64_t current_time)
>      return true;
>  }
>  
> +uint32_t apic_get_current_count(APICCommonState *s)
> +{
> +    int64_t d;
> +    uint32_t val;
> +    d = (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_load_time) >>
> +        s->count_shift;
> +    if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
> +        /* periodic */
> +        val = s->initial_count - (d % ((uint64_t)s->initial_count + 1));
> +    } else {
> +        if (d >= s->initial_count) {
> +            val = 0;
> +        } else {
> +            val = s->initial_count - d;
> +        }
> +    }
> +    return val;
> +}
> +
>  void apic_init_reset(DeviceState *dev)
>  {
>      APICCommonState *s;
> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
> index b04bdd947f..2597000e03 100644
> --- a/include/hw/i386/apic_internal.h
> +++ b/include/hw/i386/apic_internal.h
> @@ -211,6 +211,7 @@ void vapic_report_tpr_access(DeviceState *dev, CPUState *cpu, target_ulong ip,
>                               TPRAccess access);
>  
>  int apic_get_ppr(APICCommonState *s);
> +uint32_t apic_get_current_count(APICCommonState *s);
>  
>  static inline void apic_set_bit(uint32_t *tab, int index)
>  {
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index c3a6e4fabe..e3c3726c29 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -370,10 +370,11 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
>      dump_apic_lvt("LVTTHMR", lvt[APIC_LVT_THERMAL], false);
>      dump_apic_lvt("LVTT", lvt[APIC_LVT_TIMER], true);
>  
> -    qemu_printf("Timer\t DCR=0x%x (divide by %u) initial_count = %u\n",
> +    qemu_printf("Timer\t DCR=0x%x (divide by %u) initial_count = %u"
> +                " current_count = %u\n",
>                  s->divide_conf & APIC_DCR_MASK,
>                  divider_conf(s->divide_conf),
> -                s->initial_count);
> +                s->initial_count, apic_get_current_count(s));
>  
>      qemu_printf("SPIV\t 0x%08x APIC %s, focus=%s, spurious vec %u\n",
>                  s->spurious_vec,
> 

Queued, thanks.

Paolo


