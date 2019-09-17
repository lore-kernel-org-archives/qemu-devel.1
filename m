Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A244EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699D020665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MP+k8QyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699D020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGKF-0005me-4K
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAG7v-0003UJ-FO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAG7s-0000pd-VW
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:14:51 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37523)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAG7r-0000mw-IZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:14:48 -0400
Received: by mail-oi1-x242.google.com with SMTP id i16so3376789oie.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bD8Jponzt0b3FgzXqAefCuszN0PhhypHANGCJyzaDtg=;
 b=MP+k8QyHueUJci+16hy/aJWr4toHiJ7LJkOa9vX+/zD/FPUxJlGEufHjONlj2MqfiA
 IDLQP+Eb7VEl0O2tMYdED0/CUtixr0Yrg8x70E1pW/Zz3LJ/X0fLnAy+JviJh/opfW66
 dK1Ut54Uo3ZNnMKMiyVufolvN/C+/SchrKWxP1BsZcICLhKae2oTReUNlD5EMYUAvbe2
 UKVadPoR5MlkRpG7y1n5UhbTljrEFeJVwcD4mCPhCOOwmFSS479va/NDX+UQESUw4C7X
 6KG11rwkBhUy95wdsm+xpYEo8T53zwKqKVhE3BuCh+CCjTPntLBej4Wyh1GvJQVJ9DvQ
 LCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bD8Jponzt0b3FgzXqAefCuszN0PhhypHANGCJyzaDtg=;
 b=CUvIuBMZj0Dqx4rxTfnUGbNrxJKYq7QsrstdO8ncxq2yMsIRoGmY4U/LMG6cofoo3h
 QMPFFFfy3iVxy+3rr9N6sGPj16JIv7uJIUWRi7gdHpn6b9hIy/OKS+GJujNiq7VUbnkj
 kcDK3lKzL+CagyZHpbWWhIQOvIfNi28TZ79ErJIN1x0bYmVDTWvvmtJtLOjqruxB8pko
 ldVvLvjjB5TLQpKucdY2z99dZbRDmwygWletdS6kgk/6Mmeth0N3+KuFovPsYFqp3ZVL
 6mzxAa/ukonDNkdzVz3MTs2StPKmU9EAzAS0gtSkvW+1up74zNMBVlxi/slFx8Y3oedC
 EvOA==
X-Gm-Message-State: APjAAAU7JIdDqKq0z5Druygmmxz2CxKsImRGvPlDD29HDkQ3yqI4BQlE
 ALuKxfPxNgdARs+fqUUcZMaKIT3Q/koXznvYLZa5tg==
X-Google-Smtp-Source: APXvYqwGaKyju4JNgJLMu2OTI/FrlhzRZWreQVNnvX7z2ms+h2k+BVcyMg4jJBTJAe5MbDSzUYDOdtwavFM1reGNgho=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr4252451oib.146.1568736885919; 
 Tue, 17 Sep 2019 09:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190912065631.12473-1-andrew@aj.id.au>
In-Reply-To: <20190912065631.12473-1-andrew@aj.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 17:14:34 +0100
Message-ID: <CAFEAcA_h80VQVC0jE7v8kmsuXU=16+KXSKQ-qhuRNTct7X6X7g@mail.gmail.com>
To: Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v5] target-arm: Make the counter tick
 relative to cntfrq
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 07:56, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Allow machines to configure CNTFRQ via a property if the ARM core
> supports the generic timer. This is necessary on e.g. the ASPEED AST2600
> SoC where the generic timer clock is run at 800MHz or above. The default
> value for CNTFRQ remains at 62.50MHz (based on GTIMER_SCALE).
>
> CNTFRQ is a read-as-written co-processor register; the property sets the
> register's initial value which is used during realize() to configure the
> QEMUTimers that back the generic timers. Beyond that the firmware can to
> do whatever it sees fit with the CNTFRQ register though changes to the
> value will not be reflected in the timers' rate.
>
> I've tested this using an out-of-tree AST2600 SoC model (Cortex-A7) with
> the SDK u-boot that sets CNTFRQ as appropriate, and by starting/running
> machines with assorted ARM CPUs (palmetto-bmc with the ARM926EJ-S,
> romulus-bmc with the ARM1176 and raspi2 with the Cortex-A53).
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> v5: Remove unrelated submodule updates that snuck into v4
>
> v4: https://patchwork.ozlabs.org/patch/1161340/
> Fix configuration for cores without a generic timer
>
> v3: https://patchwork.ozlabs.org/patch/1160634/
> Peter - I think this addresses most of your feedback. I still reach into
> the QEMUTimer to fetch out scale when adjusting the nexttick
> calculation, but we no longer need to update the scale member and force
> a recalculation of the period.
>
> v2: https://patchwork.ozlabs.org/patch/1144389/
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  target/arm/cpu.c    | 43 +++++++++++++++++++++++++++++++++++--------
>  target/arm/cpu.h    |  3 +++
>  target/arm/helper.c | 30 ++++++++++++++++++++++++++----
>  3 files changed, 64 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2399c144718d..8b63a27761bb 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -40,6 +40,8 @@
>  #include "disas/capstone.h"
>  #include "fpu/softfloat.h"
>
> +#include <inttypes.h>
> +

You shouldn't need this -- it's one of the headers provided
by osdep.h and available everywhere.

>  static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>  {
>      ARMCPU *cpu = ARM_CPU(cs);
> @@ -976,6 +978,10 @@ static void arm_cpu_initfn(Object *obj)
>      }
>  }
>
> +static Property arm_cpu_gt_cntfrq_property =
> +            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq,
> +                               (1000 * 1000 * 1000) / GTIMER_SCALE);

I think it would be helpful to have a comment saynig what units
this property is in.

> +
>  static Property arm_cpu_reset_cbar_property =
>              DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
>
> @@ -1172,6 +1178,11 @@ void arm_cpu_post_init(Object *obj)
>
>      qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
>                               &error_abort);
> +
> +    if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
> +        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property,
> +                                 &error_abort);
> +    }
>  }
>
>  static void arm_cpu_finalizefn(Object *obj)
> @@ -1238,14 +1249,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>
> -    cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
> -                                           arm_gt_ptimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
> -                                           arm_gt_vtimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_HYP] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
> -                                          arm_gt_htimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_SCALE,
> -                                          arm_gt_stimer_cb, cpu);
> +
> +    {
> +        uint64_t scale;
> +
> +        if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
> +            if (!cpu->gt_cntfrq) {
> +                error_setg(errp, "Invalid CNTFRQ: %"PRId64"Hz",
> +                           cpu->gt_cntfrq);
> +                return;
> +            }
> +            scale = MAX(1, NANOSECONDS_PER_SECOND / cpu->gt_cntfrq);
> +        } else {
> +            scale = GTIMER_SCALE;
> +        }
> +
> +        cpu->gt_timer[GTIMER_PHYS] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
> +                                               arm_gt_ptimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_VIRT] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
> +                                               arm_gt_vtimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_HYP] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
> +                                              arm_gt_htimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_SEC] = timer_new(QEMU_CLOCK_VIRTUAL, scale,
> +                                              arm_gt_stimer_cb, cpu);
> +    }
>  #endif
>
>      cpu_exec_realizefn(cs, &local_err);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 297ad5e47ad8..8bd576f834ba 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -915,6 +915,9 @@ struct ARMCPU {
>
>      /* Used to set the maximum vector length the cpu will support.  */
>      uint32_t sve_max_vq;
> +
> +    /* Used to configure the generic timer input clock */

This comment would be more useful if it said what the field
did (eg "frequency in Hz of the generic timer" or whatever it is).

> +    uint64_t gt_cntfrq;
>  };
>
>  void arm_cpu_post_init(Object *obj);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 507026c9154b..09975704d47f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2409,7 +2409,21 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
>
>  static uint64_t gt_get_countervalue(CPUARMState *env)
>  {
> -    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
> +    uint64_t effective;
> +
> +    /*
> +     * Deal with quantized clock scaling by calculating the effective frequency
> +     * in terms of the timer scale.
> +     */
> +    if (env->cp15.c14_cntfrq <= NANOSECONDS_PER_SECOND) {
> +        uint32_t scale = NANOSECONDS_PER_SECOND / env->cp15.c14_cntfrq;
> +        effective = NANOSECONDS_PER_SECOND / scale;
> +    } else {
> +        effective = NANOSECONDS_PER_SECOND;
> +    }

What is this doing, and why didn't we need to do it before?

> +
> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), effective,
> +                    NANOSECONDS_PER_SECOND);
>  }
>
>  static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
> @@ -2445,8 +2459,8 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
>           * set the timer for as far in the future as possible. When the
>           * timer expires we will reset the timer for any remaining period.
>           */
> -        if (nexttick > INT64_MAX / GTIMER_SCALE) {
> -            nexttick = INT64_MAX / GTIMER_SCALE;
> +        if (nexttick > INT64_MAX / cpu->gt_timer[timeridx]->scale) {
> +            nexttick = INT64_MAX / cpu->gt_timer[timeridx]->scale;
>          }
>          timer_mod(cpu->gt_timer[timeridx], nexttick);
>          trace_arm_gt_recalc(timeridx, irqstate, nexttick);
> @@ -2680,6 +2694,14 @@ void arm_gt_stimer_cb(void *opaque)
>      gt_recalc_timer(cpu, GTIMER_SEC);
>  }
>
> +static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +
> +    cpu->env.cp15.c14_cntfrq =
> +        cpu->gt_cntfrq ?: (1000 * 1000 * 1000) / GTIMER_SCALE;

Can't we just make the cpu->gt_cntfrq be set to the right thing
rather than having to cope with it being 0 here ?

> +}
> +
>  static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>      /* Note that CNTFRQ is purely reads-as-written for the benefit
>       * of software; writing it doesn't actually change the timer frequency.
> @@ -2694,7 +2716,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
>        .access = PL1_RW | PL0_R, .accessfn = gt_cntfrq_access,
>        .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
> -      .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
> +      .resetfn = arm_gt_cntfrq_reset,
>      },
>      /* overall control: mostly access permissions */
>      { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
> --
> 2.20.1
>

thanks
-- PMM

