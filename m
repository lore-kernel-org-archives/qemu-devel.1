Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49398C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11281206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hy/N/G+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11281206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWke-0003Tr-8T
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icWgb-0000rm-2T
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icWgZ-0001Tj-1R
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:35:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39758
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icWgX-0001RT-10
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575473724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sn0mupfCbLW1dBw87ske4jrh2XisnOnC1IY29ApK+I=;
 b=Hy/N/G+1WqxN9JEpUCvAPiUDv/COo2cfPlvennApPqku86Nn2bSiA+iVc7wCX0vBZlaQuE
 VnQHm7byq3NLjMo3Q+VLeKxKeVawBVON8NvROR1g7unyFOBDxebgcfs+Io9Tcg35kuRuk+
 6A0LUQhgmq/bW4CEoORAE3jtYX8zPoo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-vuYYMlfVMyaLJ9olqW2dQg-1; Wed, 04 Dec 2019 10:35:20 -0500
Received: by mail-wm1-f72.google.com with SMTP id v8so2329127wml.4
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pGAib3JNOPzm4Xo6ZlbNdGWm5IgftMzvUVWYOKSthcI=;
 b=RzmfiMv4rPrYtdxvcgIJIEq6xtREJhxTYRLJ4BtSNSbcLnci3QEKrcH+horFSUhhcC
 yzyi6oyk9o7P4tJIPO9nBbFxPmKZc/oEfwRy+IYIgtei6+ehXi5AHQI7cNpyceKjeAjM
 9+a821wNd4jDI8UzExZ06dAKyuCczOntDaQXUMTUZzWcnadDHwMTf+EEf87Z2ulfuO8c
 /7hVbcqtZmpcxKIMPhzZAdZ+Hv4cYN7Ifo729OW6WUwFimSs5pc7xWyjnLM9qj9DQmGh
 VyySiLtVcQpxRmJzV885aWOuWgTuRIxeoGl9S1oeEx0GFQG070f+NyPy4xWbBq/C+2eb
 KzwQ==
X-Gm-Message-State: APjAAAVsAMgblKSdSO+rF/I2dR3aCU00Wom+kU3D7TLNKj7TuEDe5O1o
 ZGkDjhjLYOSJfWvPD2KZUib6kS6dJuE3uZPow5JaAnefAJaWW4fCbY5CbBTqZNMr70ReSUyRZH2
 uaDgd8QoSgKXmWMk=
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr94147wme.124.1575473719585; 
 Wed, 04 Dec 2019 07:35:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzu+kmrYFFY6um6y75gVhB/1nW13K1pEQUC2QQSLxHd+5kowxQr56vyjurJyxNkMkYgZoZRxA==
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr94120wme.124.1575473719398; 
 Wed, 04 Dec 2019 07:35:19 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id z6sm7083328wmz.12.2019.12.04.07.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 07:35:18 -0800 (PST)
Subject: Re: [PATCH 02/11] target/arm: Add arm_mmu_idx_is_stage1
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f24817e-54dc-dbca-e3f9-09ed185d025f@redhat.com>
Date: Wed, 4 Dec 2019 16:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203225333.17055-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: vuYYMlfVMyaLJ9olqW2dQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 11:53 PM, Richard Henderson wrote:
> Use a common predicate for querying stage1-ness.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   target/arm/internals.h | 11 +++++++++++
>   target/arm/helper.c    |  8 +++-----
>   2 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 49dac2a677..850f204f14 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1034,6 +1034,17 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMS=
tate *env)
>   ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
>   #endif
>  =20
> +static inline bool arm_mmu_idx_is_stage1(ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_Stage1_E0:
> +    case ARMMMUIdx_Stage1_E1:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>   /*
>    * Parameters of a given virtual address, as extracted from the
>    * translation control register (TCR) for a given regime.
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f3785d5ad6..fdb86ea427 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3212,8 +3212,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint=
64_t value,
>           bool take_exc =3D false;
>  =20
>           if (fi.s1ptw && current_el =3D=3D 1 && !arm_is_secure(env)
> -            && (mmu_idx =3D=3D ARMMMUIdx_Stage1_E1
> -                || mmu_idx =3D=3D ARMMMUIdx_Stage1_E0)) {
> +            && arm_mmu_idx_is_stage1(mmu_idx)) {
>               /*
>                * Synchronous stage 2 fault on an access made as part of t=
he
>                * translation table walk for AT S1E0* or AT S1E1* insn
> @@ -9159,8 +9158,7 @@ static inline bool regime_translation_disabled(CPUA=
RMState *env,
>           }
>       }
>  =20
> -    if ((env->cp15.hcr_el2 & HCR_DC) &&
> -        (mmu_idx =3D=3D ARMMMUIdx_Stage1_E0 || mmu_idx =3D=3D ARMMMUIdx_=
Stage1_E1)) {
> +    if ((env->cp15.hcr_el2 & HCR_DC) && arm_mmu_idx_is_stage1(mmu_idx)) =
{
>           /* HCR.DC means SCTLR_EL1.M behaves as 0 */
>           return true;
>       }
> @@ -9469,7 +9467,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, AR=
MMMUIdx mmu_idx,
>                                  hwaddr addr, MemTxAttrs txattrs,
>                                  ARMMMUFaultInfo *fi)
>   {
> -    if ((mmu_idx =3D=3D ARMMMUIdx_Stage1_E0 || mmu_idx =3D=3D ARMMMUIdx_=
Stage1_E1) &&
> +    if (arm_mmu_idx_is_stage1(mmu_idx) &&
>           !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
>           target_ulong s2size;
>           hwaddr s2pa;
>=20


