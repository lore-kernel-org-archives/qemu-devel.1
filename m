Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F355C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042512068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFQ/zryS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042512068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1PQ-0005mZ-66
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1Nk-0004mG-MK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1Nh-00053s-Hh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:09:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40789
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1Nh-0004z1-C8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575353391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CgCdBNIjws7notuP2bcv87jEX3tF15nyKZxcylDcoM=;
 b=YFQ/zrySAt0fgjIymtv6tlM1f+FBAbyU1FhFshoEnaxNrrr31C3V25yIxx0N+9oxN5g+qO
 niU829PkVPFOHO6DzGN3SORxtYyvdKsVKkEh7vKzhNyF0k0aVtAHnHILH2yDb/ksSUJJec
 1fyr5ad810wY3AV/7/STpodJKSna7Uc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-PjQCemLiNvmMziaCOe-0Ew-1; Tue, 03 Dec 2019 01:09:50 -0500
Received: by mail-wr1-f70.google.com with SMTP id b2so1217469wrj.9
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3CgCdBNIjws7notuP2bcv87jEX3tF15nyKZxcylDcoM=;
 b=Zt/yrEZ/bFg93YIoy+9mPwKtPIY/ODUWsRZ3sLFqJICoiKpnwMtlnxi9S9CDcoZqkx
 KmyRZ9UUQP2mFTFQH0G7OnBsNHEHv+XnpcqsLz8HRqNBAjfpvpC86FK0us8sSomURnSA
 6BLOdoHUoU3qvSGSqDgF0Bv1gonQNosj6258cFuRnFknfXlnXrrGQ7tFCix3flCP0Wzn
 rJQM0IBeOpVbJ45HLIQbKXyp8phHiLu3zTsN7d9yA/QIFEn/3JIoZBjfDZMIAMc2fIeI
 n25ehAzQsoqhuCINYveAnI7Uj1EJbFyxi8XK5y2uIIxeV6m/nePMn2v7Mu4wBN7c2KOk
 snMw==
X-Gm-Message-State: APjAAAUdN5z/A6yCICyUk3/FNNPV4aDVbJQ6xwxstBY21+cRVU8VBj0c
 xwGMx4WmzXkX9QyXmhRc2qGa5y2id6ZLn10saYYqB2QtoNShppFGDKtZjCdiSRPw2dVLYK6z7j3
 uHiaEq052j0Bv2Fw=
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr3046689wrn.75.1575353389745;
 Mon, 02 Dec 2019 22:09:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLg6SHSqjCa/n2eklIcf/6sM1Q3pGXYQ4XZht81Be9rgGuJMndJMA3R7AxQ00EtgFXSQ4Eiw==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr3046648wrn.75.1575353389275;
 Mon, 02 Dec 2019 22:09:49 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id o7sm1796086wmc.41.2019.12.02.22.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:09:48 -0800 (PST)
Subject: Re: [PATCH v2 2/4] target/arm: Abstract the generic timer frequency
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20191203041440.6275-1-andrew@aj.id.au>
 <20191203041440.6275-3-andrew@aj.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <283c152b-b1c7-551e-bec0-c087b14de996@redhat.com>
Date: Tue, 3 Dec 2019 07:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203041440.6275-3-andrew@aj.id.au>
Content-Language: en-US
X-MC-Unique: PjQCemLiNvmMziaCOe-0Ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: joel@jms.id.au, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 5:14 AM, Andrew Jeffery wrote:
> Prepare for SoCs such as the ASPEED AST2600 whose firmware configures
> CNTFRQ to values significantly larger than the static 62.5MHz value
> currently derived from GTIMER_SCALE. As the OS potentially derives its
> timer periods from the CNTFRQ value the lack of support for running
> QEMUTimers at the appropriate rate leads to sticky behaviour in the
> guest.
> 
> Substitute the GTIMER_SCALE constant with use of a helper to derive the
> period from gt_cntfrq stored in struct ARMCPU. Initially set gt_cntfrq
> to the frequency associated with GTIMER_SCALE so current behaviour is
> maintained.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c    |  2 ++
>   target/arm/cpu.h    | 10 ++++++++++
>   target/arm/helper.c | 10 +++++++---
>   3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7a4ac9339bf9..5698a74061bb 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
>       if (tcg_enabled()) {
>           cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
>       }
> +
> +    cpu->gt_cntfrq = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
>   }
>   
>   static Property arm_cpu_reset_cbar_property =
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 83a809d4bac4..666c03871fdf 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -932,8 +932,18 @@ struct ARMCPU {
>        */
>       DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
>       DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
> +
> +    /* Generic timer counter frequency, in Hz */
> +    uint64_t gt_cntfrq;

You can also explicit the unit by calling it 'gt_cntfrq_hz'.

>   };
>   
> +static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
> +{
> +    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECOND? */

Why inline this call? I doubt there is a significant performance gain.

> +    const unsigned int ns_per_s = 1000 * 1000 * 1000;
> +    return ns_per_s > cpu->gt_cntfrq ? ns_per_s / cpu->gt_cntfrq : 1;
> +}
> +
>   void arm_cpu_post_init(Object *obj);
>   
>   uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 65c4441a3896..2622a9a8d02f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2409,7 +2409,9 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
>   
>   static uint64_t gt_get_countervalue(CPUARMState *env)
>   {
> -    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
> +    ARMCPU *cpu = env_archcpu(env);
> +
> +    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
>   }
>   
>   static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
> @@ -2445,7 +2447,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
>            * set the timer for as far in the future as possible. When the
>            * timer expires we will reset the timer for any remaining period.
>            */
> -        if (nexttick > INT64_MAX / GTIMER_SCALE) {
> +        if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
>               timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
>           } else {
>               timer_mod(cpu->gt_timer[timeridx], nexttick);
> @@ -2874,11 +2876,13 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>   
>   static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
>   {
> +    ARMCPU *cpu = env_archcpu(env);
> +
>       /* Currently we have no support for QEMUTimer in linux-user so we
>        * can't call gt_get_countervalue(env), instead we directly
>        * call the lower level functions.
>        */
> -    return cpu_get_clock() / GTIMER_SCALE;
> +    return cpu_get_clock() / gt_cntfrq_period_ns(cpu);
>   }
>   
>   static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
> 


