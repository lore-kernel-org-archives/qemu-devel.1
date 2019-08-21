Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C64C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 05:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9870922DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 05:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi0/xrEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9870922DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Iqz-0006SF-P1
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 01:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0IqJ-00063I-SP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 01:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0IqI-0007xr-4c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 01:07:31 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:41400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0IqG-0007xL-9v
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 01:07:28 -0400
Received: by mail-yw1-xc43.google.com with SMTP id i138so434280ywg.8
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=gnmPeeuzeIj6JuKh6hG+hXD9AZiez9cpBr+furHDk2c=;
 b=Oi0/xrEyXjeO0mAdRAj4tpbDDICc5YcrfTUFAJmruGmvmFBIWkebcMQwJlmlHLv5ot
 UrYnu14BeZTmTlucsogENxJMrcQOfO4ZlMKzZxJWqia253SH0xgw46GDvIsby/P+ftLc
 +bs/RzFFu4gB6Dsj3K4fGmo3NKIZ385hfVl9UIp5Cc9Yp9AoWcG8EjBds1XX2jL3HGgi
 s8yw70Vl/mj5jHmTns6E7pqkd+RhPYNVN13Qj5uos7NbzK/MvpVpum7XdNQuOv3Cod4X
 T0XCAFEkFZJqNjANZi9W7MxaBRhmfsrHMr1Cq4WVUXu75VbfRjURFFrIExCevRZpmWSf
 U57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=gnmPeeuzeIj6JuKh6hG+hXD9AZiez9cpBr+furHDk2c=;
 b=Qh1UQXpW20myIObcKRKJBo9fgjn8F3hXJq7dtKiJtPyuZ3Oan6hL+QEsP2XZw6lBvr
 S3SCSbL0fQhQkabAWqMKyCChygKHRMH+T5Ae8ZYIbiRe0RiC0xUmnUyyNfkDsSCyqzEt
 szJVcErWZ7PT7Woagh4a3ftN9BJT9+ZqvH6SVV57hFhOWIIMGCYF38m1o30xQu2m+HPE
 vDUGXvbsqAnMqDZshYcOgkCi+AV/hIwYMArzqJFvmayfXPvFcuxjyKtxFJFI0fAKBT6a
 AMSN98IneSxErSXysGNZFtIOHEXpjpzxzPFxe3BMI5LALeP7+i2lePToV6oBdkCmhgyY
 PrCw==
X-Gm-Message-State: APjAAAXJrR5AKMbbIgawBn1eW5WyZQT4tqJSI418i8n7cckiAwlDjV4Q
 3UqbAtQFPsyDT/4h9FKPfXBinDod
X-Google-Smtp-Source: APXvYqxyXDMGs7DFZN1Ctdj4gpIMSIKalbBIwz0hNHAnsFEdlYxa+bHw7RRzzA0eACOjZHcfwvE1lg==
X-Received: by 2002:a81:5c87:: with SMTP id
 q129mr21341618ywb.403.1566364047615; 
 Tue, 20 Aug 2019 22:07:27 -0700 (PDT)
Received: from ?IPv6:2601:c0:c67f:e390::3? ([2601:c0:c67f:e390::3])
 by smtp.googlemail.com with ESMTPSA id l5sm1316154ywa.65.2019.08.20.22.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2019 22:07:26 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-16-jan.bobek@gmail.com>
 <CAL1e-=jNu8w-9wgkz5Ug-uZKWreEY=6EqD_cYN_KY_qXfn2TPQ@mail.gmail.com>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <404dea2e-1d22-df1f-b9df-4bb32567a612@gmail.com>
Date: Wed, 21 Aug 2019 01:07:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jNu8w-9wgkz5Ug-uZKWreEY=6EqD_cYN_KY_qXfn2TPQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wcnsQ5j2IkaM8UfxTDc7TXzHPJY9biQUC"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: Re: [Qemu-devel] [RFC PATCH v3 15/46] target/i386: introduce
 function ck_cpuid
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wcnsQ5j2IkaM8UfxTDc7TXzHPJY9biQUC
Content-Type: multipart/mixed; boundary="SlHiXmT1XBFV8uyegyZ93FXkrnuGwVKYb";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Message-ID: <404dea2e-1d22-df1f-b9df-4bb32567a612@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v3 15/46] target/i386: introduce function
 ck_cpuid
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-16-jan.bobek@gmail.com>
 <CAL1e-=jNu8w-9wgkz5Ug-uZKWreEY=6EqD_cYN_KY_qXfn2TPQ@mail.gmail.com>
In-Reply-To: <CAL1e-=jNu8w-9wgkz5Ug-uZKWreEY=6EqD_cYN_KY_qXfn2TPQ@mail.gmail.com>

--SlHiXmT1XBFV8uyegyZ93FXkrnuGwVKYb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/15/19 11:01 AM, Aleksandar Markovic wrote:
>=20
> 15.08.2019. 04.23, "Jan Bobek" <jan.bobek@gmail.com <mailto:jan.bobek@g=
mail.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:
>>
>> Introduce a helper function to take care of instruction CPUID checks.
>>
>> Signed-off-by: Jan Bobek <jan.bobek@gmail.com <mailto:jan.bobek@gmail.=
com>>
>> ---
>=20
> Jan, what is the origin of "CK"? If it is a QEMU internal thing, perhap=
s use "CHECK".
>=20
> The function should be called check_cpuid(), imho. I know, Richard woul=
d like c_ci(), or simpler cc(), better.

It was completely my initiative to name it like that. I'll rename
it to check_cpuid().

-Jan


--SlHiXmT1XBFV8uyegyZ93FXkrnuGwVKYb--

--wcnsQ5j2IkaM8UfxTDc7TXzHPJY9biQUC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1c0Y0ACgkQZeg2ldrj
Ns/RGw//R+OX9HcB1myGqZ915qn6l+c7Uj4LOU8jRI6OVF8jb3rab/xOuw1LCz8p
j4xsgRIF/HkFVkDjvT7VxYXdsdOa/zmUz0XmO8CPTHqhcSbk6bwYXCZGtVpRAbAV
rEYz8XN/K5C7Db7Z8x5PM0hTIX2UgXemVuULTKLTBYJA9qwa1QXU9LsxgTT4XZ6B
B+9VSJ0xazkC4EWKaoakqGXIXqU83RuFaFzoAlSVD+i+J8bvAmO9EIS9r9fqXtqB
HMWCTB12P5tY4mSI19IYbC5+ULxgCL4hcf4SKkjjttCRaDonzDVHgAFDJJtcO0Nx
N2RRj1MTacweD7/Zd4ylYT4Sr49nHSN5OxuTs81CiQSxQk+BSOm5v3jrfXp/+tdE
c68eld8T89ONKCPV2zpSrkio5MX4wclexR1q/4o1/XbZyZK0xxGxKc9168G7EamI
F9dj5Q/i3t1aLOLAegbm5BMkZkluDwdPOSmLLfroDxeazdbNkLBCRUxBNA5PZnNx
O9q47HDMlv33WuP43HNOm0A2IjtuUo7XjEljdSCAGg4d10HqhmeqcBOT7klPDN5L
VhijacEmOKdDRbCNhYenFOENe38+jhWDNY/JSbInFd1AnsUFF1hTSx3BrfPvZ4YM
02sqLlgYDKRy0x1H7Yu2CCCNt4o2Rm+B1v2IGpC78JXT9skPxFQ=
=PBXK
-----END PGP SIGNATURE-----

--wcnsQ5j2IkaM8UfxTDc7TXzHPJY9biQUC--

