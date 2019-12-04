Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3ADC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487B8206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN5s3qki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487B8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXRW-0003oJ-BZ
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icX6B-00083G-5U
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icX5z-0006PI-0b
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:01:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icX5u-0006MC-Gh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575475290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNBoqztCstwZYxMByi6xuwbZGax13FXW2xIT8+Xcq8M=;
 b=RN5s3qkiW7y0Uj5B9U3VMMBEDjxFKlk6I/orSVZ9LHegyNMAFTpXuqtuXAuCo5zTzlF1xF
 UQqaa4QebPhuBRy611FkTJt1BjltuKZ1j+5SGxdWT5vKYQUK7zRbCVSVB5XqW5rAvTdoRb
 EGYMEG5yz9CQRo7JZUebW5Vmj8lLZdE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-yy6BvyZ5PN-iLdMTDUUEAQ-1; Wed, 04 Dec 2019 11:01:26 -0500
Received: by mail-wm1-f71.google.com with SMTP id s25so2257689wmj.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 08:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pjhVVHKV653vzyxTWN9M8SByUKfzybjKDmv3ivyWFl4=;
 b=s6h5AETk5mHHt99GT4zHyulzccTOfHCHm13Q1D/Gvn62V0Ev4faUcPt4lR9mRvZWw1
 nULlRNDpKOXsTsKOEspL1hZw6kOftiJujDBZ5j3BUUSv7DBFwKmc4ieqQxqYbr4UVG2E
 +Ft2IP3mq5nykz4RUK8pft9l7HVcnChd2KxB04e49SdY9YAlKAPGA4VD929T8iAQPZWB
 VuFC6Il1hdkWfGqcVWIHKcneqzxscthYcDLakrzYYy4k2pkE3VMJZHIuHHwaE1TqeP8E
 z9+myb13fhCpvMdMT8OusNnmBbul0G4M6ah73gdZrf5q5sArZP4WIRfYPS6vWSVcAMXd
 Aq5w==
X-Gm-Message-State: APjAAAW/iBB2MYsmw+FdDmrFVxd+lN6FPtnd34hziTbYcYoEmfdDnsfM
 Dkzk9C2qL01zEK+CeSFE6+EFNcarW4syuKDd1Pio9/CIj/C4GaHTjQGjiW6AyjaZiub1/3ze3ku
 cvx1o7+HEdP0r3cQ=
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr247898wml.56.1575475284978;
 Wed, 04 Dec 2019 08:01:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzb4UyTbQfuOvfhTggz2jJ981Lkx9EQtn4zy/9Pcsf2mjz7PGjoEQURkcMaPkLcrPwWN1uV8A==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr247860wml.56.1575475284685;
 Wed, 04 Dec 2019 08:01:24 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id j184sm7539314wmb.44.2019.12.04.08.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 08:01:24 -0800 (PST)
Subject: Re: [PATCH v4 16/40] target/arm: Rearrange ARMMMUIdxBit
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f43b552-e450-00f9-6e65-bcd59a6c870b@redhat.com>
Date: Wed, 4 Dec 2019 17:01:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203022937.1474-17-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: yy6BvyZ5PN-iLdMTDUUEAQ-1
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 3:29 AM, Richard Henderson wrote:
> Define via macro expansion, so that renumbering of the base ARMMMUIdx
> symbols is automatically reflexed in the bit definitions.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 39 +++++++++++++++++++++++----------------
>   1 file changed, 23 insertions(+), 16 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5f295c7e60..6ba5126852 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2886,27 +2886,34 @@ typedef enum ARMMMUIdx {
>       ARMMMUIdx_Stage1_E1 =3D 1 | ARM_MMU_IDX_NOTLB,
>   } ARMMMUIdx;
>  =20
> -/* Bit macros for the core-mmu-index values for each index,
> +/*
> + * Bit macros for the core-mmu-index values for each index,
>    * for use when calling tlb_flush_by_mmuidx() and friends.
>    */
> +#define TO_CORE_BIT(NAME) \
> +    ARMMMUIdxBit_##NAME =3D 1 << (ARMMMUIdx_##NAME & ARM_MMU_IDX_COREIDX=
_MASK)
> +
>   typedef enum ARMMMUIdxBit {
> -    ARMMMUIdxBit_EL10_0 =3D 1 << 0,
> -    ARMMMUIdxBit_EL10_1 =3D 1 << 1,
> -    ARMMMUIdxBit_E2 =3D 1 << 2,
> -    ARMMMUIdxBit_SE3 =3D 1 << 3,
> -    ARMMMUIdxBit_SE0 =3D 1 << 4,
> -    ARMMMUIdxBit_SE1 =3D 1 << 5,
> -    ARMMMUIdxBit_Stage2 =3D 1 << 6,
> -    ARMMMUIdxBit_MUser =3D 1 << 0,
> -    ARMMMUIdxBit_MPriv =3D 1 << 1,
> -    ARMMMUIdxBit_MUserNegPri =3D 1 << 2,
> -    ARMMMUIdxBit_MPrivNegPri =3D 1 << 3,
> -    ARMMMUIdxBit_MSUser =3D 1 << 4,
> -    ARMMMUIdxBit_MSPriv =3D 1 << 5,
> -    ARMMMUIdxBit_MSUserNegPri =3D 1 << 6,
> -    ARMMMUIdxBit_MSPrivNegPri =3D 1 << 7,
> +    TO_CORE_BIT(EL10_0),
> +    TO_CORE_BIT(EL10_1),
> +    TO_CORE_BIT(E2),
> +    TO_CORE_BIT(SE0),
> +    TO_CORE_BIT(SE1),
> +    TO_CORE_BIT(SE3),
> +    TO_CORE_BIT(Stage2),
> +
> +    TO_CORE_BIT(MUser),
> +    TO_CORE_BIT(MPriv),
> +    TO_CORE_BIT(MUserNegPri),
> +    TO_CORE_BIT(MPrivNegPri),
> +    TO_CORE_BIT(MSUser),
> +    TO_CORE_BIT(MSPriv),
> +    TO_CORE_BIT(MSUserNegPri),
> +    TO_CORE_BIT(MSPrivNegPri),
>   } ARMMMUIdxBit;
>  =20
> +#undef TO_CORE_BIT
> +
>   #define MMU_USER_IDX 0
>  =20
>   static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


