Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE50C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD9B2073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Psf8l+JA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD9B2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lit-00086F-RY
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1lhn-0007BH-8B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1lhl-0007i1-6I
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:41:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1lhl-0007hl-1H
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581489660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aG52p7Q6sYDmyf5SotvZJPL6ne1P6qiFfJQBvMBtYu4=;
 b=Psf8l+JAmAc0r//57+zRQiCbPfoxZplvUIGM1Lx0KTIoQ0XyL0pF3OaPNtFBmVpmC5RFPF
 JI55w1v/GClQKG5jz/j5VdDRAJ6i9sQyecdtaBXCpe9KpBKaQNnOgXYTIl7r5OlhExqAqS
 K7NlD6Ew0DHWXU4SLQbNAuAh6lBSHMY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-UdK42eohN9OC46bl4e7TQA-1; Wed, 12 Feb 2020 01:40:58 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so399708wrm.17
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 22:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4uts6Q+MoX5UpfO+PW1RSgnoRW4uSVTE9wFkDy3lSKQ=;
 b=Ds/AR0ElhxAtH5Y4VDuzx16SNIYx5CYppn6mq3ikNRahZrSrZbzPKBTPx40R8KrvgU
 I1giqvVKefdojSGjCAuIFWFYgGPZU0LtMp77ZWvXbqzJD1B/mLnvje+jg4A8MZSC0aOr
 RG6Z9pRQvCJp6+zme8JNyKGbR1LFJI3FhJwSf8MtS+4a2Wfir0DsTdY73RWdQV5MhLIq
 tJIiV2R1tErUWv3lsOtP99b3PleGLfC0c0j8RhF5odfTTM7YkLGDdEYMrpMU5KaNq+I1
 gtgX7PI7QgfuCpfcsNfar/RLJkIeBA3BiFleHRFY0yJeh/X3PIXMEnJehKtUZf+HzeFp
 LMhg==
X-Gm-Message-State: APjAAAVEJL5lroZ3gbJ/Ekt9SRybdDpvBpv5ukkQnKtmnX5LBdUMtxok
 JFgpyq73fVjNSUqTHoDo4Hnf4wCZfNKj3/3gMq+dmHyKPzAqtNII6bz3hiaomUVi0kOd7Sltwd0
 dojn7DkSN45pL1Hg=
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr12399472wrv.291.1581489657210; 
 Tue, 11 Feb 2020 22:40:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCYFEgrSWEzjjkhGIzkqMV/Shl+Y0BNx51koLqD1FxD1vEeYfRs49YyHSxv5GzVrphqgjfWA==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr12399446wrv.291.1581489656897; 
 Tue, 11 Feb 2020 22:40:56 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm7005292wmb.28.2020.02.11.22.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 22:40:56 -0800 (PST)
Subject: Re: [PATCH 04/13] target/arm: Factor out PMU register definitions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f9e4aa0e-4368-611a-c31b-2ddc6b2a89b2@redhat.com>
Date: Wed, 12 Feb 2020 07:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-5-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: UdK42eohN9OC46bl4e7TQA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 6:37 PM, Peter Maydell wrote:
> Pull the code that defines the various PMU registers out
> into its own function, matching the pattern we have
> already for the debug registers.
>=20
> Apart from one style fix to a multi-line comment, this
> is purely movement of code with no changes to it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 158 +++++++++++++++++++++++---------------------
>   1 file changed, 82 insertions(+), 76 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index bf083c369fc..0011a22f42d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5822,6 +5822,87 @@ static void define_debug_regs(ARMCPU *cpu)
>       }
>   }
>  =20
> +static void define_pmu_regs(ARMCPU *cpu)
> +{
> +    /*
> +     * v7 performance monitor control register: same implementor
> +     * field as main ID register, and we implement four counters in
> +     * addition to the cycle count register.
> +     */
> +    unsigned int i, pmcrn =3D 4;
> +    ARMCPRegInfo pmcr =3D {
> +        .name =3D "PMCR", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =3D=
 0, .opc2 =3D 0,
> +        .access =3D PL0_RW,
> +        .type =3D ARM_CP_IO | ARM_CP_ALIAS,
> +        .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmcr),
> +        .accessfn =3D pmreg_access, .writefn =3D pmcr_write,
> +        .raw_writefn =3D raw_write,
> +    };
> +    ARMCPRegInfo pmcr64 =3D {
> +        .name =3D "PMCR_EL0", .state =3D ARM_CP_STATE_AA64,
> +        .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2 =3D 0,
> +        .access =3D PL0_RW, .accessfn =3D pmreg_access,
> +        .type =3D ARM_CP_IO,
> +        .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmcr),
> +        .resetvalue =3D (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHIFT=
),
> +        .writefn =3D pmcr_write, .raw_writefn =3D raw_write,
> +    };
> +    define_one_arm_cp_reg(cpu, &pmcr);
> +    define_one_arm_cp_reg(cpu, &pmcr64);
> +    for (i =3D 0; i < pmcrn; i++) {
> +        char *pmevcntr_name =3D g_strdup_printf("PMEVCNTR%d", i);
> +        char *pmevcntr_el0_name =3D g_strdup_printf("PMEVCNTR%d_EL0", i)=
;
> +        char *pmevtyper_name =3D g_strdup_printf("PMEVTYPER%d", i);
> +        char *pmevtyper_el0_name =3D g_strdup_printf("PMEVTYPER%d_EL0", =
i);
> +        ARMCPRegInfo pmev_regs[] =3D {
> +            { .name =3D pmevcntr_name, .cp =3D 15, .crn =3D 14,
> +              .crm =3D 8 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D i & 7,
> +              .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALIAS,
> +              .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_writefn=
,
> +              .accessfn =3D pmreg_access },
> +            { .name =3D pmevcntr_el0_name, .state =3D ARM_CP_STATE_AA64,
> +              .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 8 | (3 & (=
i >> 3)),
> +              .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D pmreg_a=
ccess,
> +              .type =3D ARM_CP_IO,
> +              .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_writefn=
,
> +              .raw_readfn =3D pmevcntr_rawread,
> +              .raw_writefn =3D pmevcntr_rawwrite },
> +            { .name =3D pmevtyper_name, .cp =3D 15, .crn =3D 14,
> +              .crm =3D 12 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D i & 7=
,
> +              .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALIAS,
> +              .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper_write=
fn,
> +              .accessfn =3D pmreg_access },
> +            { .name =3D pmevtyper_el0_name, .state =3D ARM_CP_STATE_AA64=
,
> +              .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 12 | (3 & =
(i >> 3)),
> +              .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D pmreg_a=
ccess,
> +              .type =3D ARM_CP_IO,
> +              .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper_write=
fn,
> +              .raw_writefn =3D pmevtyper_rawwrite },
> +            REGINFO_SENTINEL
> +        };
> +        define_arm_cp_regs(cpu, pmev_regs);
> +        g_free(pmevcntr_name);
> +        g_free(pmevcntr_el0_name);
> +        g_free(pmevtyper_name);
> +        g_free(pmevtyper_el0_name);
> +    }
> +    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >=3D 4 &&
> +            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) !=3D 0xf) {
> +        ARMCPRegInfo v81_pmu_regs[] =3D {
> +            { .name =3D "PMCEID2", .state =3D ARM_CP_STATE_AA32,
> +              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =
=3D 4,
> +              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> +              .resetvalue =3D extract64(cpu->pmceid0, 32, 32) },
> +            { .name =3D "PMCEID3", .state =3D ARM_CP_STATE_AA32,
> +              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =
=3D 5,
> +              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> +              .resetvalue =3D extract64(cpu->pmceid1, 32, 32) },
> +            REGINFO_SENTINEL
> +        };
> +        define_arm_cp_regs(cpu, v81_pmu_regs);
> +    }
> +}
> +
>   /* We don't know until after realize whether there's a GICv3
>    * attached, and that is what registers the gicv3 sysregs.
>    * So we have to fill in the GIC fields in ID_PFR/ID_PFR1_EL1/ID_AA64PF=
R0_EL1
> @@ -6244,67 +6325,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>           define_arm_cp_regs(cpu, pmovsset_cp_reginfo);
>       }
>       if (arm_feature(env, ARM_FEATURE_V7)) {
> -        /* v7 performance monitor control register: same implementor
> -         * field as main ID register, and we implement four counters in
> -         * addition to the cycle count register.
> -         */
> -        unsigned int i, pmcrn =3D 4;
> -        ARMCPRegInfo pmcr =3D {
> -            .name =3D "PMCR", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1=
 =3D 0, .opc2 =3D 0,
> -            .access =3D PL0_RW,
> -            .type =3D ARM_CP_IO | ARM_CP_ALIAS,
> -            .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmcr),
> -            .accessfn =3D pmreg_access, .writefn =3D pmcr_write,
> -            .raw_writefn =3D raw_write,
> -        };
> -        ARMCPRegInfo pmcr64 =3D {
> -            .name =3D "PMCR_EL0", .state =3D ARM_CP_STATE_AA64,
> -            .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2 =3D=
 0,
> -            .access =3D PL0_RW, .accessfn =3D pmreg_access,
> -            .type =3D ARM_CP_IO,
> -            .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmcr),
> -            .resetvalue =3D (cpu->midr & 0xff000000) | (pmcrn << PMCRN_S=
HIFT),
> -            .writefn =3D pmcr_write, .raw_writefn =3D raw_write,
> -        };
> -        define_one_arm_cp_reg(cpu, &pmcr);
> -        define_one_arm_cp_reg(cpu, &pmcr64);
> -        for (i =3D 0; i < pmcrn; i++) {
> -            char *pmevcntr_name =3D g_strdup_printf("PMEVCNTR%d", i);
> -            char *pmevcntr_el0_name =3D g_strdup_printf("PMEVCNTR%d_EL0"=
, i);
> -            char *pmevtyper_name =3D g_strdup_printf("PMEVTYPER%d", i);
> -            char *pmevtyper_el0_name =3D g_strdup_printf("PMEVTYPER%d_EL=
0", i);
> -            ARMCPRegInfo pmev_regs[] =3D {
> -                { .name =3D pmevcntr_name, .cp =3D 15, .crn =3D 14,
> -                  .crm =3D 8 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D i =
& 7,
> -                  .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALIAS=
,
> -                  .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_wri=
tefn,
> -                  .accessfn =3D pmreg_access },
> -                { .name =3D pmevcntr_el0_name, .state =3D ARM_CP_STATE_A=
A64,
> -                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 8 | (3=
 & (i >> 3)),
> -                  .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D pmr=
eg_access,
> -                  .type =3D ARM_CP_IO,
> -                  .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_wri=
tefn,
> -                  .raw_readfn =3D pmevcntr_rawread,
> -                  .raw_writefn =3D pmevcntr_rawwrite },
> -                { .name =3D pmevtyper_name, .cp =3D 15, .crn =3D 14,
> -                  .crm =3D 12 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D i=
 & 7,
> -                  .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALIAS=
,
> -                  .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper_w=
ritefn,
> -                  .accessfn =3D pmreg_access },
> -                { .name =3D pmevtyper_el0_name, .state =3D ARM_CP_STATE_=
AA64,
> -                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 12 | (=
3 & (i >> 3)),
> -                  .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D pmr=
eg_access,
> -                  .type =3D ARM_CP_IO,
> -                  .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper_w=
ritefn,
> -                  .raw_writefn =3D pmevtyper_rawwrite },
> -                REGINFO_SENTINEL
> -            };
> -            define_arm_cp_regs(cpu, pmev_regs);
> -            g_free(pmevcntr_name);
> -            g_free(pmevcntr_el0_name);
> -            g_free(pmevtyper_name);
> -            g_free(pmevtyper_el0_name);

TIL git-diff --color-moved

Maybe move PERFMON block first, then extract define_pmu_regs()?

In any case,
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> -        }
>           ARMCPRegInfo clidr =3D {
>               .name =3D "CLIDR", .state =3D ARM_CP_STATE_BOTH,
>               .opc0 =3D 3, .crn =3D 0, .crm =3D 0, .opc1 =3D 1, .opc2 =3D=
 1,
> @@ -6315,24 +6335,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>           define_one_arm_cp_reg(cpu, &clidr);
>           define_arm_cp_regs(cpu, v7_cp_reginfo);
>           define_debug_regs(cpu);
> +        define_pmu_regs(cpu);
>       } else {
>           define_arm_cp_regs(cpu, not_v7_cp_reginfo);
>       }
> -    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >=3D 4 &&
> -            FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) !=3D 0xf) {
> -        ARMCPRegInfo v81_pmu_regs[] =3D {
> -            { .name =3D "PMCEID2", .state =3D ARM_CP_STATE_AA32,
> -              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =
=3D 4,
> -              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> -              .resetvalue =3D extract64(cpu->pmceid0, 32, 32) },
> -            { .name =3D "PMCEID3", .state =3D ARM_CP_STATE_AA32,
> -              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =
=3D 5,
> -              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D A=
RM_CP_CONST,
> -              .resetvalue =3D extract64(cpu->pmceid1, 32, 32) },
> -            REGINFO_SENTINEL
> -        };
> -        define_arm_cp_regs(cpu, v81_pmu_regs);
> -    }
>       if (arm_feature(env, ARM_FEATURE_V8)) {
>           /* AArch64 ID registers, which all have impdef reset values.
>            * Note that within the ID register ranges the unused slots
>=20


