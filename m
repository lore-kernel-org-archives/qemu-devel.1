Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A68EC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 20:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C802189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 20:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKi5yQej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C802189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Qwx-0003VR-8W
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 16:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3Qw7-0002u0-5c
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 16:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3Qw5-0004Pv-KD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 16:22:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3Qw5-0004Ok-Bu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 16:22:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so3391145wrt.13
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7E2qqxDS1Kj6oqoJx2iuHbvzzl6fdLD72WEam0+phcg=;
 b=RKi5yQej6+Cqifbw1AxuO7cPFaWFvdAfC/sfTWHrO6NJnJUEN9OWmqCBxS3uKHVgVn
 6edKtkDx892ka0IdfHVi1wlHi3Qp1OaTo67GawHsjnAGW2KjMl/nu2zKeqR7KcmUqZRS
 OntyCLbweEt2BMk8nduy38xny9+BHU1nKDdqWdmh2O18ZYao6tKUW0HpydjEjFJbHr97
 KfwtXdQCfXIw741hBmqvN0S3+Htl3Cko4rDd9jxjH28q2rAy1qc1JbQrsJrRIclXAYHh
 v7jQG9r5AhDQs1ZSMasA1vHF7OEPwjb/qvuwXLnHn9ZTIe4s2XENYNA1JLVW36KXY3vY
 OB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7E2qqxDS1Kj6oqoJx2iuHbvzzl6fdLD72WEam0+phcg=;
 b=dLZaHUvrwqbKq79AFdQqVd1IxMuR0AVAA8b4L06Jjo/oZfVnUp0oOpbhAI8AEtMaTZ
 +hZR6tZC1rjvFpTs41Q1+8i9sYXApg8MWJXSIu+sW4JNz2H3/tAJtN16mle/s6qvpRnf
 G6ft9ZNcuWEEEMSFJNU1EbJGVXpusVYPi6KE1JcDeTmzYyAAXdyNs7um1cXEDC9M6NbE
 z6QtIT8fSHwpn2tqhANeCdi90z67oQtzwte6vAGZvNexBAzvXOVdD3SY8D4kdHdFiy8z
 JcY90KDhmD+nsa7tYxJCVxkaVNGbBtG6NBZwFVVQClkJjufaHE6DA6nCtedkl6JWmKRn
 5nqg==
X-Gm-Message-State: APjAAAVHr0qhie7HHqxKssFq6KMH4bEIDCPrMrl2cQZY+BMyWEVSPUsq
 08CPpM88wjdHGsNosHlVmhQ6dg==
X-Google-Smtp-Source: APXvYqxhA/6JrexasZVeDRQp9vZIQlvsNL8wsc6JfB6EKITVvPkBihQ/gcfDa5zIyTSc3EvdPtt5MQ==
X-Received: by 2002:a5d:434a:: with SMTP id u10mr14800126wrr.245.1567110143623; 
 Thu, 29 Aug 2019 13:22:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u6sm4887491wrr.26.2019.08.29.13.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 13:22:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3F56D1FF87;
 Thu, 29 Aug 2019 21:22:22 +0100 (BST)
References: <20190827121931.26836-1-peter.maydell@linaro.org>
 <CAL1e-=j_uoOcyxqv7CZv3V6FWaarBnS1wEnU4k1cAoc1_b5mMg@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <CAL1e-=j_uoOcyxqv7CZv3V6FWaarBnS1wEnU4k1cAoc1_b5mMg@mail.gmail.com>
Date: Thu, 29 Aug 2019 21:22:22 +0100
Message-ID: <87v9uf4t8h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] target/arm: Free TCG temps in
 trans_VMOV_64_sp()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> 27.08.2019. 14.20, "Peter Maydell" <peter.maydell@linaro.org> =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> The function neon_store_reg32() doesn't free the TCG temp that it
>> is passed, so the caller must do that. We got this right in most
>> places but forgot to free the TCG temps in trans_VMOV_64_sp().
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>
> Hello, Peter,
>
> I am just curious if you found this by manual code inspection, or perhaps
> using a tool?

I'm guessing that if you run code that exercises this while built with
--enable-tcg-debug then TCG's sanity checking complains about unfreed
temps.

>
> Yours,
> Aleksandar
>
>>  target/arm/translate-vfp.inc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/target/arm/translate-vfp.inc.c
> b/target/arm/translate-vfp.inc.c
>> index 3e8ea80493b..9ae980bef63 100644
>> --- a/target/arm/translate-vfp.inc.c
>> +++ b/target/arm/translate-vfp.inc.c
>> @@ -880,8 +880,10 @@ static bool trans_VMOV_64_sp(DisasContext *s,
> arg_VMOV_64_sp *a)
>>          /* gpreg to fpreg */
>>          tmp =3D load_reg(s, a->rt);
>>          neon_store_reg32(tmp, a->vm);
>> +        tcg_temp_free_i32(tmp);
>>          tmp =3D load_reg(s, a->rt2);
>>          neon_store_reg32(tmp, a->vm + 1);
>> +        tcg_temp_free_i32(tmp);
>>      }
>>
>>      return true;
>> --
>> 2.20.1
>>
>>


--
Alex Benn=C3=A9e

