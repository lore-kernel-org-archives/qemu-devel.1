Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3000DC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FD3217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGCxVwrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FD3217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8uqn-0005mP-4l
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8upv-00053X-JZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8upu-00016T-JQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:50:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8upu-000161-Fw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583193057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FF3wICewQaa3RiS39JV3wDaDsjE5d8HV95Cf+aKZo7E=;
 b=gGCxVwrSrS6rnNx2fqHf6c8Sz4R270HpM+FCHA+KsjbblVER5MRq3ITA5z9AcP75ILJazF
 hK77FqKQFuASpCAGTtm/iTEochQxf/payYoUFT3bw92tB5Dy1cwdASjvYOS+d3r4vs5jyv
 VvrcovsWC+PiKBO2iffeygb2VWdu0Fs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-e0JQ_F-3MEqiIMah9z2roA-1; Mon, 02 Mar 2020 18:50:56 -0500
X-MC-Unique: e0JQ_F-3MEqiIMah9z2roA-1
Received: by mail-wm1-f70.google.com with SMTP id f207so334087wme.6
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KHLvqzpa6iNoZylNgF3tRer/Y3+oc/9BwRdnj0JoSOw=;
 b=PqU1C23VMfxfdKzRWkCYc4E/dH+K4s0dMHM+p4iPtoanWgezax/hmLq4YmUh2yerVa
 LMGyEkOZNz3uRNBRWP/VUjFmVepsxaj+g6pUuSP9z4X0D8bxRVrCAYShlUb+Ik+LX5j5
 ffQGPQMUFDEdmRO7NVdjg1g31kpv55eUKAs1z0Sm6LVETw0yM4uVdatAIMYimxxWTPif
 BrMiMNK3t0YFw9Xg+8+um2zA3du/Hi9lHE7cmSQlEyDpe2VTuj8mzzFonhZWK8dWiqyj
 ZzWKWLXnpyln63aUIwbfMuyJ2I049eYeN3n2hafg6wX8cxwcKf5ZkNGV5lZc7TU/m4Eu
 EHcg==
X-Gm-Message-State: ANhLgQ1pCMSRjNAfhqE828X5MKMPref8Yq4C66N71JGXdMmkY+MoNDys
 lVrFCH7kRsgku3iKeZ+LKsH69wOilWMJ4mOvTu0H5oac5mg+R/LNisH1jU0XArS/DBTfNRWdG9e
 JzBxjYvPjMYHK/lM=
X-Received: by 2002:a7b:c109:: with SMTP id w9mr749270wmi.14.1583193054815;
 Mon, 02 Mar 2020 15:50:54 -0800 (PST)
X-Google-Smtp-Source: ADFU+vspJinB9C9sNnEwMwpo9oMaLSyS9tXFxJou/Zk5Et4OCatKWJASWxpCYNwz6zKVXHls/8K99w==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr749252wmi.14.1583193054576;
 Mon, 02 Mar 2020 15:50:54 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id k16sm31111203wrd.17.2020.03.02.15.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 15:50:53 -0800 (PST)
Subject: Re: [PATCH v2 3/9] target/arm: Introduce core_to_aa64_mmu_idx
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200302175829.2183-1-richard.henderson@linaro.org>
 <20200302175829.2183-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a4ec9841-0c60-23bd-3f1a-5a21b697c082@redhat.com>
Date: Tue, 3 Mar 2020 00:50:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302175829.2183-4-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 6:58 PM, Richard Henderson wrote:
> If by context we know that we're in AArch64 mode, we need not
> test for M-profile when reconstructing the full ARMMMUIdx.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h     | 6 ++++++
>   target/arm/translate-a64.c | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 9f96a2359f..e633aff36e 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -783,6 +783,12 @@ static inline ARMMMUIdx core_to_arm_mmu_idx(CPUARMSt=
ate *env, int mmu_idx)
>       }
>   }
>  =20
> +static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
> +{
> +    /* AArch64 is always a-profile. */
> +    return mmu_idx | ARM_MMU_IDX_A;

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> +
>   int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
>  =20
>   /*
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 579180af0a..c910a49b4e 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -14300,7 +14300,7 @@ static void aarch64_tr_init_disas_context(DisasCo=
ntextBase *dcbase,
>       dc->condexec_mask =3D 0;
>       dc->condexec_cond =3D 0;
>       core_mmu_idx =3D FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
> -    dc->mmu_idx =3D core_to_arm_mmu_idx(env, core_mmu_idx);
> +    dc->mmu_idx =3D core_to_aa64_mmu_idx(core_mmu_idx);
>       dc->tbii =3D FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
>       dc->tbid =3D FIELD_EX32(tb_flags, TBFLAG_A64, TBID);
>       dc->current_el =3D arm_mmu_idx_to_el(dc->mmu_idx);
>=20


