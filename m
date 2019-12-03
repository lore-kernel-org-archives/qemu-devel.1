Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13A7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6CE2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebColzZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6CE2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1Yk-0001iB-Ka
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1XR-0000kK-Ma
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1XN-0006fi-31
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:19:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1XL-0006eW-Ob
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575353990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIggsHV7RwzfRpHde3nsZOyP42nBpUZTWDoAvsx3sFU=;
 b=ebColzZeyGHO6Ovs/VD3bQpQFLE4OlUQpseY7AD4QmqlFbfWFIhZe8Te7skJLoDGT69bRO
 xPJJzz2UwDwUeFAzGB9rXvx5yRlVTQIWpL5KV9rpRLo8A3sr1nt1O0L9Elw//KNiJtZKhc
 k+2W4Er1JCmNy5vBG5zn0DUkbN5Ul7g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-lF1CucpqNYehom-5C91Z2A-1; Tue, 03 Dec 2019 01:19:49 -0500
Received: by mail-wr1-f72.google.com with SMTP id 90so1226072wrq.6
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cQ6SeHgzlGCjdsiT8Qv10jhbeiLaVPvQtaufLIrxZ5A=;
 b=ERnzIbVhRqpXwfnuMSwmeyZ8hAZoptyXzniGSaBlWrU34TGG8qi2G2XW2wAStV5O0t
 EImKKlCUpsYAmpBfhM5ar6iWZ9MTmSDh6GfwaYsU/iuzlrsHvz6Tu5asSA6oqFHefHo8
 VpECc+NqLZxptvZahTUvZZwd391iMkm+EKJyjMDSEf1CFzRnqHc55AM/nddmmD5sU5Xj
 plKwsGUvo4kjMmcjCyLON2aWMO5thXNMqA0Y9xqgfC7ehbSnNlJfRvYtXI/F9KkdqqPm
 lLsfUHkjT8jZXmVDlyhqOKh/i0BV0cGDU2preR8RjP+IKH1qgH82DSCB5IalO1PW6jRI
 J2Vg==
X-Gm-Message-State: APjAAAVDkSSXn26pzwnCbI8k8E3JbpWA1bcrZ+zFCOkuFiiMIXzNoeR0
 T7rEOsQeErE+il3a4ctk+OpxjD0p9VhQRnp+8HLf1L7+1YztxTVUMGKGMxeLj1uJC/JEUm/cvZi
 1bMcPh3reJqC/J+k=
X-Received: by 2002:a1c:6207:: with SMTP id w7mr25888570wmb.16.1575353987770; 
 Mon, 02 Dec 2019 22:19:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxunwusEg1LgtmAipcMpNQ2d1XNghTg9Z5lGsj2d+FHSaTSCAzrVy7SiHD3HzU6AQYSMnuK2w==
X-Received: by 2002:a1c:6207:: with SMTP id w7mr25888551wmb.16.1575353987459; 
 Mon, 02 Dec 2019 22:19:47 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id e18sm2114137wrr.95.2019.12.02.22.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:19:46 -0800 (PST)
Subject: Re: [PATCH v2 3/4] target/arm: Prepare generic timer for per-platform
 CNTFRQ
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20191203041440.6275-1-andrew@aj.id.au>
 <20191203041440.6275-4-andrew@aj.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fc320f0d-b2e2-c603-e5db-170f24df1149@redhat.com>
Date: Tue, 3 Dec 2019 07:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203041440.6275-4-andrew@aj.id.au>
Content-Language: en-US
X-MC-Unique: lF1CucpqNYehom-5C91Z2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> The ASPEED AST2600 clocks the generic timer at the rate of HPLL. On
> recent firmwares this is at 1125MHz, which is considerably quicker than
> the assumed 62.5MHz of the current generic timer implementation. The
> delta between the value as read from CNTFRQ and the true rate of the
> underlying QEMUTimer leads to sticky behaviour in AST2600 guests.
>=20
> Add a feature-gated property exposing CNTFRQ for ARM CPUs providing the
> generic timer. This allows platforms to configure CNTFRQ (and the
> associated QEMUTimer) to the appropriate frequency prior to starting the
> guest.
>=20
> As the platform can now determine the rate of CNTFRQ we're exposed to
> limitations of QEMUTimer that didn't previously materialise: In the
> course of emulation we need to arbitrarily and accurately convert
> between guest ticks and time, but we're constrained by QEMUTimer's use
> of an integer scaling factor. The effect is QEMUTimer cannot exactly
> capture the period of frequencies that do not cleanly divide
> NANOSECONDS_PER_SECOND for scaling ticks to time. As such, provide an
> equally inaccurate scaling factor for scaling time to ticks so at least
> a self-consistent inverse relationship holds.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c    | 43 +++++++++++++++++++++++++++++++++----------
>   target/arm/cpu.h    | 18 ++++++++++++++++++
>   target/arm/helper.c |  9 ++++++++-
>   3 files changed, 59 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5698a74061bb..f186019a77fd 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -974,10 +974,12 @@ static void arm_cpu_initfn(Object *obj)
>       if (tcg_enabled()) {
>           cpu->psci_version =3D 2; /* TCG implements PSCI 0.2 */
>       }
> -
> -    cpu->gt_cntfrq =3D NANOSECONDS_PER_SECOND / GTIMER_SCALE;
>   }
>  =20
> +static Property arm_cpu_gt_cntfrq_property =3D
> +            DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq,
> +                               NANOSECONDS_PER_SECOND / GTIMER_SCALE);
> +
>   static Property arm_cpu_reset_cbar_property =3D
>               DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
>  =20
> @@ -1174,6 +1176,11 @@ void arm_cpu_post_init(Object *obj)
>  =20
>       qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
>                                &error_abort);
> +
> +    if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
> +        qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_propert=
y,
> +                                 &error_abort);
> +    }
>   }
>  =20
>   static void arm_cpu_finalizefn(Object *obj)
> @@ -1253,14 +1260,30 @@ static void arm_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>           }
>       }
>  =20
> -    cpu->gt_timer[GTIMER_PHYS] =3D timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_=
SCALE,
> -                                           arm_gt_ptimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_VIRT] =3D timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_=
SCALE,
> -                                           arm_gt_vtimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_HYP] =3D timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_S=
CALE,
> -                                          arm_gt_htimer_cb, cpu);
> -    cpu->gt_timer[GTIMER_SEC] =3D timer_new(QEMU_CLOCK_VIRTUAL, GTIMER_S=
CALE,
> -                                          arm_gt_stimer_cb, cpu);
> +
> +    {
> +        uint64_t scale;

Apparently you have to use this odd indent due to the '#ifndef=20
CONFIG_USER_ONLY'. Well, acceptable.

> +
> +        if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
> +            if (!cpu->gt_cntfrq) {
> +                error_setg(errp, "Invalid CNTFRQ: %"PRId64"Hz",
> +                           cpu->gt_cntfrq);
> +                return;
> +            }
> +            scale =3D gt_cntfrq_period_ns(cpu);
> +        } else {
> +            scale =3D GTIMER_SCALE;
> +        }
> +
> +        cpu->gt_timer[GTIMER_PHYS] =3D timer_new(QEMU_CLOCK_VIRTUAL, sca=
le,
> +                                               arm_gt_ptimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_VIRT] =3D timer_new(QEMU_CLOCK_VIRTUAL, sca=
le,
> +                                               arm_gt_vtimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_HYP] =3D timer_new(QEMU_CLOCK_VIRTUAL, scal=
e,
> +                                              arm_gt_htimer_cb, cpu);
> +        cpu->gt_timer[GTIMER_SEC] =3D timer_new(QEMU_CLOCK_VIRTUAL, scal=
e,
> +                                              arm_gt_stimer_cb, cpu);
> +    }
>   #endif
>  =20
>       cpu_exec_realizefn(cs, &local_err);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 666c03871fdf..0bcd13dcac81 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -939,6 +939,24 @@ struct ARMCPU {
>  =20
>   static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
>   {
> +    /*
> +     * The exact approach to calculating guest ticks is:
> +     *
> +     *     muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), cpu->gt_cntfr=
q,
> +     *              NANOSECONDS_PER_SECOND);
> +     *
> +     * We don't do that. Rather we intentionally use integer division
> +     * truncation below and in the caller for the conversion of host mon=
otonic
> +     * time to guest ticks to provide the exact inverse for the semantic=
s of
> +     * the QEMUTimer scale factor. QEMUTimer's scale facter is an intege=
r, so
> +     * it loses precision when representing frequencies where
> +     * `(NANOSECONDS_PER_SECOND % cpu->gt_cntfrq) > 0` holds. Failing to
> +     * provide an exact inverse leads to scheduling timers with negative
> +     * periods, which in turn leads to sticky behaviour in the guest.
> +     *
> +     * Finally, CNTFRQ is effectively capped at 1GHz to ensure our scale=
 factor
> +     * cannot become zero.
> +     */

This comment belong to the previous patch. I'd rather see this function=20
+ big comment in target/arm/cpu.c.

With comment moved (and if possible function uninlined):
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECOND? *=
/
>       const unsigned int ns_per_s =3D 1000 * 1000 * 1000;
>       return ns_per_s > cpu->gt_cntfrq ? ns_per_s / cpu->gt_cntfrq : 1;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2622a9a8d02f..da960d17040b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2683,6 +2683,13 @@ void arm_gt_stimer_cb(void *opaque)
>       gt_recalc_timer(cpu, GTIMER_SEC);
>   }
>  =20
> +static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *op=
aque)
> +{
> +    ARMCPU *cpu =3D env_archcpu(env);
> +
> +    cpu->env.cp15.c14_cntfrq =3D cpu->gt_cntfrq;
> +}
> +
>   static const ARMCPRegInfo generic_timer_cp_reginfo[] =3D {
>       /* Note that CNTFRQ is purely reads-as-written for the benefit
>        * of software; writing it doesn't actually change the timer freque=
ncy.
> @@ -2697,7 +2704,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[=
] =3D {
>         .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 0,
>         .access =3D PL1_RW | PL0_R, .accessfn =3D gt_cntfrq_access,
>         .fieldoffset =3D offsetof(CPUARMState, cp15.c14_cntfrq),
> -      .resetvalue =3D (1000 * 1000 * 1000) / GTIMER_SCALE,
> +      .resetfn =3D arm_gt_cntfrq_reset,
>       },
>       /* overall control: mostly access permissions */
>       { .name =3D "CNTKCTL", .state =3D ARM_CP_STATE_BOTH,
>=20


