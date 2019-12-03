Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AAB206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfWgu9ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AAB206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1e1-0004QI-PQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1ce-0003d5-Be
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1cc-0007rD-Tt
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:25:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1cX-0007pV-Ll
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575354312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlprGPoARXFNCgDZ0l4YYUwxwjEj67w3tbNvXdHrMes=;
 b=DfWgu9ZHap8BnfGgxeNETLsEMQzACh54lbneTOCEWgTM1x711rl6eUYeefecDZvZWOSDss
 41Yd6vFxBImoKBCdvrphMYh07Ps7FPUkoGkPz601SK16lsU+VSBFzeweYfddAo7C68PW9+
 mqyLIpRNZDRCiM4VaEW3gglU8lUyyT4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-VQdAVKpdP5-oIKtdqlwQmQ-1; Tue, 03 Dec 2019 01:25:11 -0500
Received: by mail-wr1-f69.google.com with SMTP id r2so1232714wrp.7
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sueqhZ7HVKgO1GslfDSIetGRVmuR15UnDFqHn/5BSjY=;
 b=FzGguKcGPfrEnx3EJ3TNO5YalGtGQudU+u3YsP2TshSN+OXyewPb/35Vrjq9GJ4K6e
 eyLax0jJjlMYYV9YyAwJf6O2ngS4vWZmYLp4FtMiYx3kj6VaM3vnMKuA+iGM2997mfdW
 8TUjc/nrqnFWpF0josrje8NTCAAZl4OTQCVkW0niDVFryOd3fSiqEvCOajJhf9/HD5Yw
 MQH9Wi+Eu1CZ9lcB0Fll0+TcmF+UnMY9Sud3edvbiqDeCL0K1+hLYBum/f+s6m5t9Gtq
 EwfFIyv3Z7y+L9KBJDDE5NdjgaLAnC6UcNk4KsdbgpfKVll9jmNVOQirmmQ0yp9RjAQY
 dMUg==
X-Gm-Message-State: APjAAAV/vP7a+17uOSr7ZNdzJLsNs3SzY8NxnPDMaJtT9bt3byrlFlzN
 AWP/qgy3TqWone31QpMgFiYgv+LrH48vGhBEKVBhqQWrTzsTfVujd3p7ms7eB9R0LfrBKry8ouC
 6N3rl/ETtsvGkZu4=
X-Received: by 2002:adf:a141:: with SMTP id r1mr3174361wrr.285.1575354310349; 
 Mon, 02 Dec 2019 22:25:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKkzns138zI5U7NahVVOaDmQWXcKN3Qh0f42FJWH/h2BN7lXCDPysI/mrlBFHBSUgPLkLqBA==
X-Received: by 2002:adf:a141:: with SMTP id r1mr3174344wrr.285.1575354310084; 
 Mon, 02 Dec 2019 22:25:10 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id z3sm2171060wrs.94.2019.12.02.22.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:25:09 -0800 (PST)
Subject: Re: [PATCH v4 06/40] target/arm: Split out vae1_tlbmask,
 vmalle1_tlbmask
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <82c07397-e462-9408-67eb-09ba089b5f39@redhat.com>
Date: Tue, 3 Dec 2019 07:25:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203022937.1474-7-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: VQdAVKpdP5-oIKtdqlwQmQ-1
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 3:29 AM, Richard Henderson wrote:
> No functional change, but unify code sequences.
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Easier to review in 2 patches: vae1_tlbmask first, then vmalle1_tlbmask.

If you need to respin, the 2 patches are welcome. Regardless:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/helper.c | 118 ++++++++++++++------------------------------
>   1 file changed, 37 insertions(+), 81 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 731507a82f..0b0130d814 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3890,70 +3890,61 @@ static CPAccessResult aa64_cacheop_access(CPUARMS=
tate *env,
>    * Page D4-1736 (DDI0487A.b)
>    */
>  =20
> +static int vae1_tlbmask(CPUARMState *env)
> +{
> +    if (arm_is_secure_below_el3(env)) {
> +        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
> +    } else {
> +        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
> +    }
> +}
> +
>   static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegI=
nfo *ri,
>                                         uint64_t value)
>   {
>       CPUState *cs =3D env_cpu(env);
> -    bool sec =3D arm_is_secure_below_el3(env);
> +    int mask =3D vae1_tlbmask(env);
>  =20
> -    if (sec) {
> -        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            ARMMMUIdxBit_S1SE1 |
> -                                            ARMMMUIdxBit_S1SE0);
> -    } else {
> -        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            ARMMMUIdxBit_S12NSE1 |
> -                                            ARMMMUIdxBit_S12NSE0);
> -    }
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
>   }
>  =20
>   static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInf=
o *ri,
>                                       uint64_t value)
>   {
>       CPUState *cs =3D env_cpu(env);
> +    int mask =3D vae1_tlbmask(env);
>  =20
>       if (tlb_force_broadcast(env)) {
>           tlbi_aa64_vmalle1is_write(env, NULL, value);
>           return;
>       }
>  =20
> +    tlb_flush_by_mmuidx(cs, mask);
> +}
> +
> +static int vmalle1_tlbmask(CPUARMState *env)
> +{
> +    /*
> +     * Note that the 'ALL' scope must invalidate both stage 1 and
> +     * stage 2 translations, whereas most other scopes only invalidate
> +     * stage 1 translations.
> +     */
>       if (arm_is_secure_below_el3(env)) {
> -        tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_S1SE1 |
> -                            ARMMMUIdxBit_S1SE0);
> +        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
> +    } else if (arm_feature(env, ARM_FEATURE_EL2)) {
> +        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0 | ARMMMUIdxBi=
t_S2NS;
>       } else {
> -        tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_S12NSE1 |
> -                            ARMMMUIdxBit_S12NSE0);
> +        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
>       }
>   }
>  =20
>   static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
>                                     uint64_t value)
>   {
> -    /* Note that the 'ALL' scope must invalidate both stage 1 and
> -     * stage 2 translations, whereas most other scopes only invalidate
> -     * stage 1 translations.
> -     */
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
> +    int mask =3D vmalle1_tlbmask(env);
>  =20
> -    if (arm_is_secure_below_el3(env)) {
> -        tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_S1SE1 |
> -                            ARMMMUIdxBit_S1SE0);
> -    } else {
> -        if (arm_feature(env, ARM_FEATURE_EL2)) {
> -            tlb_flush_by_mmuidx(cs,
> -                                ARMMMUIdxBit_S12NSE1 |
> -                                ARMMMUIdxBit_S12NSE0 |
> -                                ARMMMUIdxBit_S2NS);
> -        } else {
> -            tlb_flush_by_mmuidx(cs,
> -                                ARMMMUIdxBit_S12NSE1 |
> -                                ARMMMUIdxBit_S12NSE0);
> -        }
> -    }
> +    tlb_flush_by_mmuidx(cs, mask);
>   }
>  =20
>   static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo =
*ri,
> @@ -3977,28 +3968,10 @@ static void tlbi_aa64_alle3_write(CPUARMState *en=
v, const ARMCPRegInfo *ri,
>   static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInf=
o *ri,
>                                       uint64_t value)
>   {
> -    /* Note that the 'ALL' scope must invalidate both stage 1 and
> -     * stage 2 translations, whereas most other scopes only invalidate
> -     * stage 1 translations.
> -     */
>       CPUState *cs =3D env_cpu(env);
> -    bool sec =3D arm_is_secure_below_el3(env);
> -    bool has_el2 =3D arm_feature(env, ARM_FEATURE_EL2);
> +    int mask =3D vmalle1_tlbmask(env);
>  =20
> -    if (sec) {
> -        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            ARMMMUIdxBit_S1SE1 |
> -                                            ARMMMUIdxBit_S1SE0);
> -    } else if (has_el2) {
> -        tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                            ARMMMUIdxBit_S12NSE1 |
> -                                            ARMMMUIdxBit_S12NSE0 |
> -                                            ARMMMUIdxBit_S2NS);
> -    } else {
> -          tlb_flush_by_mmuidx_all_cpus_synced(cs,
> -                                              ARMMMUIdxBit_S12NSE1 |
> -                                              ARMMMUIdxBit_S12NSE0);
> -    }
> +    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
>   }
>  =20
>   static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInf=
o *ri,
> @@ -4048,20 +4021,11 @@ static void tlbi_aa64_vae3_write(CPUARMState *env=
, const ARMCPRegInfo *ri,
>   static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
>                                      uint64_t value)
>   {
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> -    bool sec =3D arm_is_secure_below_el3(env);
> +    CPUState *cs =3D env_cpu(env);
> +    int mask =3D vae1_tlbmask(env);
>       uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>  =20
> -    if (sec) {
> -        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                                 ARMMMUIdxBit_S1SE1 |
> -                                                 ARMMMUIdxBit_S1SE0);
> -    } else {
> -        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
> -                                                 ARMMMUIdxBit_S12NSE1 |
> -                                                 ARMMMUIdxBit_S12NSE0);
> -    }
> +    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
>   }
>  =20
>   static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *=
ri,
> @@ -4072,8 +4036,8 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, =
const ARMCPRegInfo *ri,
>        * since we don't support flush-for-specific-ASID-only or
>        * flush-last-level-only.
>        */
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
> +    int mask =3D vae1_tlbmask(env);
>       uint64_t pageaddr =3D sextract64(value << 12, 0, 56);
>  =20
>       if (tlb_force_broadcast(env)) {
> @@ -4081,15 +4045,7 @@ static void tlbi_aa64_vae1_write(CPUARMState *env,=
 const ARMCPRegInfo *ri,
>           return;
>       }
>  =20
> -    if (arm_is_secure_below_el3(env)) {
> -        tlb_flush_page_by_mmuidx(cs, pageaddr,
> -                                 ARMMMUIdxBit_S1SE1 |
> -                                 ARMMMUIdxBit_S1SE0);
> -    } else {
> -        tlb_flush_page_by_mmuidx(cs, pageaddr,
> -                                 ARMMMUIdxBit_S12NSE1 |
> -                                 ARMMMUIdxBit_S12NSE0);
> -    }
> +    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
>   }
>  =20
>   static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo=
 *ri,
>=20


