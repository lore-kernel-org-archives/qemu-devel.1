Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD797C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBEE2081B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyWbx2Gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBEE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTOA-0000Mu-PY
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icSP8-0000yw-Lu
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icSOr-0008AP-C1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:01:00 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icSOl-0007Ch-C8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:00:47 -0500
Received: by mail-wm1-x344.google.com with SMTP id f129so7404736wmf.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 03:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=waw9J7GA7l5JXf7mJQ/uJAeTyes/s6aSxCWQty3y/Co=;
 b=hyWbx2GxG7W8CRfNP20kXPHD1GiQhhzZ7LJdMqlyIkcOhOBcU70P6AzQxx9oV+fAzf
 MMfnlaf++7+Q7TJZGw3ckjKBsiRzIeu5Vk25Xg7eNl+ZYuoaOPCFLYjLYFLQO1ABA4K5
 NgYcefkhOspzH2XunmQcRThJY1aXMeRau9+BHZO5IsUCBgHuMhkrVxWxmgbfUUliXVXR
 E49/sAVUlASzclC1lhMumG1ur+E6z28WQlsX9JZ0OadQOCw6z6+iLtTommJ1L68CUl+0
 Sp97Jm30oFBGmJUMYtMGkK9KCMkKwB4oOmPlCgjWIbVM5kKFIste39klB1OUNwR4jFSc
 XQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=waw9J7GA7l5JXf7mJQ/uJAeTyes/s6aSxCWQty3y/Co=;
 b=gYCCrRF85qi9h4cnpjE+KzvUEojMdWm90jLEmng8uwmZ6h0SSFxMBAtPznQxsyWNtU
 AqUGUSFAsxqhxkcNw8bEqb0opPyu1sGTHXp1TOTJ6abZHvch2u2NxYhuPv6H1Tl0uGcd
 DjHw5DOJ0AjbfBaOyMDmD4TCTrojTiCJfO0ah5Qy9cZGh8OfHbpu1I134eSyE3vfjg9M
 xuRwsKlGvq0Q1hvg9C+nljb2YJt77JSuWeqZb3BpTnqze6Zi9A+MsZI/Cwd5bdQAJ6IE
 I+B+swfrx2kX6MUppqcMGjPWh0uvbg1uDLxfvY00NxsVBQJF5jmBtLduvqO2Z7iHbDaw
 2RVg==
X-Gm-Message-State: APjAAAWz/Wr5Ma4jtlIXws8+kQ10eMhbieQtXfzERZGchIRIOv9SpW62
 +1Z5DGBnFpcSpyLzHspDTQoRDQ==
X-Google-Smtp-Source: APXvYqxRKVbyBRKD1k5Ul3RRUuSfHvI8mtwpiw2AVKPgiW1mr/eo/BjYxN3YprmPQa7tGoWjch8l2Q==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr38299102wmk.77.1575457235904; 
 Wed, 04 Dec 2019 03:00:35 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a186sm6264460wmd.41.2019.12.04.03.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 03:00:34 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0910C1FF87;
 Wed,  4 Dec 2019 11:00:34 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-11-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 10/40] target/arm: Rename ARMMMUIdx_S1NSE* to
 ARMMMUIdx_Stage1_E*
In-reply-to: <20191203022937.1474-11-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 11:00:34 +0000
Message-ID: <87a7889wz1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This is part of a reorganization to the set of mmu_idx.
> The EL1&0 regime is the only one that uses 2-stage translation.
> Spelling out Stage avoids confusion with Secure.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
<snip>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 97677f8482..a34accec20 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2992,7 +2992,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint=
64_t value,
>          bool take_exc =3D false;
>=20=20
>          if (fi.s1ptw && current_el =3D=3D 1 && !arm_is_secure(env)
> -            && (mmu_idx =3D=3D ARMMMUIdx_S1NSE1 || mmu_idx =3D=3D ARMMMU=
Idx_S1NSE0)) {
> +            && (mmu_idx =3D=3D ARMMMUIdx_Stage1_E1
> +                || mmu_idx =3D=3D ARMMMUIdx_Stage1_E0)) {

Personal nit: I think ||\nfoo =3D=3D scans more nicely as it lines up but
maybe that's just me.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

