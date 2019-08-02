Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A52C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E87F20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCzYMSR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E87F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htYEB-00017I-Ek
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 10:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1htYD8-0008Kf-Ma
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1htYD7-0000v9-BX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:07:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1htYD7-0000uv-1p
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:07:09 -0400
Received: by mail-oi1-x242.google.com with SMTP id c15so1497891oic.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=nsSVi1wv3hclIKNH1ND8Et1vX9IsG2GUg2mfioJCpoA=;
 b=BCzYMSR8q1aP5rUWQ1P5YstJYYn2zrvSQpZeJ5TmfgaG5SheR7kpeoeuM/KjwVCqq6
 lJZyhV6i/BypQapavjLEXXUZ4ivg0tZeOqhHcru8u7KyqhXuH/zaJiji2QuaD42gmZf9
 9ZphHTPj+l/uU4kUbDgND2W28zqhD9fRcWUMbUHWPx4Q70kr6ytBXQFxHm8ntokl/8or
 sB9TV1m1OJKsqlvlknRnEYJksf+dt+544WY6+5SSKnqpW1hnCT29rkdzvfju80MSbb3b
 JjTSuMJCA26wrc8g0NX6zC7W9kBj+pipJEyW/NB4U9pvYaIpm2le6llSF/a75/oYo+bG
 4dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=nsSVi1wv3hclIKNH1ND8Et1vX9IsG2GUg2mfioJCpoA=;
 b=Sjq2k9ptjbKW45bvwdsR6qLP16qwQxQzP3henKY8B/FWBWOWzFzTMKohGB8ksMjxab
 19oTxIJ4jNjJ7kt39CopIefUBI0r/Ck6V4FYhkC1WfarWyy23OsLOSqXvb5xVhGaLxwm
 RN04z/1jB7+Npje+2DPPjbSu0tpv9FeouUeWuh0bl/2FB8oBGf3eUMsjkw6lvLgh7dSm
 Gk3X+mDh33pTgxH/2kqt1DkYDGrWCBQA7tH4jMPSTiFLUrTcLimrNDzJi8zAxzmOWd2G
 FMNahI5pKmBWamm7FQKRG4HrLkxs2CktIDTMOV1k7P8bdwtxDArJfH6PAi4Dq5j45jWL
 ldww==
X-Gm-Message-State: APjAAAUNkjn7CysBXINXT+Ajju+y/WEPvqdaxm8/WuNRanprEgKJjJHU
 2EBwOp8l2sYFkhsi5M+8i7nsESet
X-Google-Smtp-Source: APXvYqx+mqG7QtCK2pBrxV6nW79D8IHgE1gkRIoOtViiEQzfY/GFv6AWadQotkmv+F3txB/WmbxV5g==
X-Received: by 2002:aca:7507:: with SMTP id q7mr2880274oic.87.1564754828339;
 Fri, 02 Aug 2019 07:07:08 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id e24sm25119232otp.14.2019.08.02.07.07.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 07:07:07 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-23-jan.bobek@gmail.com>
 <1691a32a-e0a2-931b-2d17-4dae8dde7c7e@linaro.org>
 <CAL1e-=h2eHpH2KAtT+orB9gbqnaqTVYf+W_eVfmNrj+jxVsnnA@mail.gmail.com>
 <bf8155f6-4f03-dcb6-5159-5f10dd0211a0@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <37f9dbf7-e519-9550-a193-a05013a43d92@gmail.com>
Date: Fri, 2 Aug 2019 10:07:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bf8155f6-4f03-dcb6-5159-5f10dd0211a0@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3MaML0dSYkZnfEEUdbrgXAvpQ4l93St4p"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [RFC PATCH v1 22/22] target/i386: reimplement
 (V)P(EQ, CMP)(B, W, D)
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3MaML0dSYkZnfEEUdbrgXAvpQ4l93St4p
Content-Type: multipart/mixed; boundary="tDNpi28W1kTzH7xWRhaYj78QOY8KDqxbw";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <37f9dbf7-e519-9550-a193-a05013a43d92@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 22/22] target/i386: reimplement
 (V)P(EQ, CMP)(B, W, D)
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-23-jan.bobek@gmail.com>
 <1691a32a-e0a2-931b-2d17-4dae8dde7c7e@linaro.org>
 <CAL1e-=h2eHpH2KAtT+orB9gbqnaqTVYf+W_eVfmNrj+jxVsnnA@mail.gmail.com>
 <bf8155f6-4f03-dcb6-5159-5f10dd0211a0@linaro.org>
In-Reply-To: <bf8155f6-4f03-dcb6-5159-5f10dd0211a0@linaro.org>

--tDNpi28W1kTzH7xWRhaYj78QOY8KDqxbw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/31/19 5:31 PM, Richard Henderson wrote:
> On 7/31/19 1:09 PM, Aleksandar Markovic wrote:
>>
>>
>> On Wed, Jul 31, 2019 at 9:51 PM Richard Henderson <richard.henderson@l=
inaro.org
>> <mailto:richard.henderson@linaro.org>> wrote:
>>
>>     On 7/31/19 10:57 AM, Jan Bobek wrote:
>>     > +static inline void gen_gvec_cmpeq(unsigned vece, uint32_t dofs,=

>>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t aofs, ui=
nt32_t bofs,
>>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t oprsz, u=
int32_t maxsz)
>>     > +{
>>     > +=C2=A0 =C2=A0 tcg_gen_gvec_cmp(TCG_COND_EQ, vece, dofs, aofs, b=
ofs, oprsz, maxsz);
>>     > +}
>>     ...
>>     > +static inline void gen_gvec_cmpgt(unsigned vece, uint32_t dofs,=

>>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t aofs, ui=
nt32_t bofs,
>>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t oprsz, u=
int32_t maxsz)
>>     > +{
>>     > +=C2=A0 =C2=A0 tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, b=
ofs, oprsz, maxsz);
>>     > +}
>>
>>     Drop the inlines.
>>
>>
>> Why? The compiler will decide at the end of the day, but at least "inl=
ine" here
>> says that the code author thinks that inlining is desirable, logical, =
and expected
>> in these cases, which is in turn a valuable information for the code r=
eader.
>=20
> In this case it is in fact a lie that will only confuse the reader, as =
it did
> you.  Functions whose address are passed as a callback, as these are, a=
re
> always forced out of line.
>=20
> But beyond that, clang diagnoses unused static inline within *.c while =
gcc does
> not (I'm not sure I agree with clang, but it is what it is).  By leavin=
g off
> the inline, but compilers will diagnose when code rearrangement leaves =
a
> function unused.

Dang, I completely forgot about the function-address vs. inlining rule. I=
 thought
of these as macros, really; they are only functions because I needed to p=
ass
them to the gen_gvec_ld_modrm_* helpers.

I'll drop the inline, compilers ignore it anyway.

-Jan


--tDNpi28W1kTzH7xWRhaYj78QOY8KDqxbw--

--3MaML0dSYkZnfEEUdbrgXAvpQ4l93St4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1EQ4oACgkQZeg2ldrj
Ns9wVQ/7BIuM7/4ThaHC/WpbHjjO00a/JGho5xhwD7xBGz7GEUs/M9K6BlDhUxTB
rKc0pwq7LrokTyNAcL5iGy30NoypSlB9CAdY1UFTBcwiHu31MFpwaK7Hlx6XTLEh
EfQDVuV6cgP484FHcDsOI34t4huk2x+HTuZo4peIInRTuv+xbLq1pi0hSDotIf7c
9KipejyMqe6XhvEfhOaeRWqytX4IkZldwoZkTyy8d/sf+3A1eyERUldAzJLEVAfb
5tK1JemHo5QgRAbuPUi1MgVn4BkLeWMPUYMFR3IRzC9MtiHAhDaiD4xbIhEUJGDJ
LjT+W7bwqv92pbQTospdDTtF81HZbnKQwbMIsnKj++xXNP3TsGNVPB0ELvlB4ltR
Ya5gHIxjf00OTytOMLiVyh8zGSFn4dDyYFOwnbaNg4xDGxsuRScnoXUUZvn3Bj2K
KeeqGuoDiTPMZQfHPbpE58KMP5/dHt5tTYw04YxO36Qn5XF7gc/cuVPTBZFu2gKM
GwqGl3+VOKaGYtdq8iojtvOaKJXGaAwkTmCqZbeuYWDp/IBU3ahIF4b1FGP20iHu
9LaZlSO/qWZrA8ldwwEDWewrg2eHzpdeNnHAolWprnzeIv0iKJ9FVnAGVwQi+8Du
fBBBupY0d8BfL7WrG2LSVifEhRo4qKKXpW5WhCYjy0JRMlvXpAc=
=HXkF
-----END PGP SIGNATURE-----

--3MaML0dSYkZnfEEUdbrgXAvpQ4l93St4p--

