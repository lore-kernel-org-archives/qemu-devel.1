Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA8C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 00:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5F82067D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 00:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoCTcTU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5F82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy43n-0007is-Mi
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 20:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy436-0007It-Kk
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 20:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy435-0003pN-Ml
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 20:55:28 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:43477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy435-0003oc-GU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 20:55:27 -0400
Received: by mail-yb1-xb41.google.com with SMTP id o82so347357ybg.10
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=xTZql/8sGzQpRkpuf1OZepJ8VLIqFh6ku970fPt1hcs=;
 b=ZoCTcTU8b9U4ueIQLO+Cbu4IfujIQKgRBvZA7vKHmmL3r0FCwXii7HxA/3OnSMfr8q
 SwZ48Uabln/RGgWcYct++a9aWO83NWFunSq5ezooT74c4il0zoHsNo8BZb/vg3bLva7t
 D8N/uthbjujZtyAuJiZd5Qkf790MgTjsQcyXgzifpZz4jJue6VUQ8Cv81F0Z4MWCVmVR
 AhGcQRLWB4b7rIlcWgidCwsAZKXYUm8X6xSnrFkSZFCOF5ewPysG8TJHus5UCJH3xF6X
 JI+9LWQdu51fYDJUW5UFVdbAWBVE8b7UDvBdDRylmY/oVNybPbo9KlNgS2b/HX++VV1/
 Hzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=xTZql/8sGzQpRkpuf1OZepJ8VLIqFh6ku970fPt1hcs=;
 b=cCoAT5RzPo1vDjbYabcmVFtsWYUC/Tbs9qV6w0SIgsn1AROvMduIP9eJ606tpoxHdd
 NzQxm3tQ/dP5/pyarUUVTtJFAZozSUag4a6EZ4lPE2LwAFCnSKFACIIvBR1NzoelYksC
 lKUfiZNkQp2t26ujUQ/nJHCKXlHPSz3MtESSI43AjmzdJnjx03JUsMjR4hZQAZYa2JER
 B/gsX/pXQCQALy6ox61OToVsJ+ruKn+8W+B5r8ggN3OYjRtPSAyj3IoD1H+hH0Tv4lzW
 QiLfBuNsNxChl0/ZhpynhjjcXRH1M1us5SHI0wltBGwZOmhH6fbfvgZdouTCwZqWwhyS
 Y72Q==
X-Gm-Message-State: APjAAAUWriWWdhOMDXRvY7in8uvIEhFtti3GbkXdtp/3LV/3wVgQeS+a
 TbjQQX3u3iQg+hSAxN9NYYY=
X-Google-Smtp-Source: APXvYqwKd+sOKcJp48WG7EdheVRJgUupw2Aq2k+jKbSoeUNS63YQ1shtMKfDieAlgnRP3MDa3p8x0Q==
X-Received: by 2002:a25:97c4:: with SMTP id j4mr1742415ybo.499.1565830526422; 
 Wed, 14 Aug 2019 17:55:26 -0700 (PDT)
Received: from ?IPv6:2601:c0:c67f:e390:8a9a:e33f:caf8:f018?
 ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.googlemail.com with ESMTPSA id x10sm362023ywl.16.2019.08.14.17.55.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 17:55:25 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-22-jan.bobek@gmail.com>
 <9610c359-21a1-338b-c727-85ee24549886@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c9cc5f3b-b767-75dd-b1d9-56f4e16bafeb@gmail.com>
Date: Wed, 14 Aug 2019 20:55:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9610c359-21a1-338b-c727-85ee24549886@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aFsX4FPHb7fGtIUO09a87fabeSxLqRK55"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: Re: [Qemu-devel] [RFC PATCH v2 21/39] target/i386: introduce insn.h
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aFsX4FPHb7fGtIUO09a87fabeSxLqRK55
Content-Type: multipart/mixed; boundary="bC4ZTDj6yl1SjWcuo4kjEUPtacS5xYyKr";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <c9cc5f3b-b767-75dd-b1d9-56f4e16bafeb@gmail.com>
Subject: Re: [RFC PATCH v2 21/39] target/i386: introduce insn.h
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-22-jan.bobek@gmail.com>
 <9610c359-21a1-338b-c727-85ee24549886@linaro.org>
In-Reply-To: <9610c359-21a1-338b-c727-85ee24549886@linaro.org>

--bC4ZTDj6yl1SjWcuo4kjEUPtacS5xYyKr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/13/19 2:00 AM, Richard Henderson wrote:
> On 8/10/19 5:12 AM, Jan Bobek wrote:
>> This header is intended to eventually list all supported instructions
>> along with some useful details (e.g. mnemonics, opcode, operands etc.)=

>> It shall be used (along with some preprocessor magic) anytime we need
>> to automatically generate code for every instruction.
>>
>> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
>> ---
>>  target/i386/insn.h | 87 +++++++++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 87 insertions(+)
>>  create mode 100644 target/i386/insn.h
>=20
> Things that are included multiple times should be named *.inc.h.  There=
 are
> quite a few that don't follow this in the tree, but we are slowly fixin=
g those.
>=20
> Though even "insn.inc.h" isn't particularly descriptive, and definitely=

> overstates the case.  Maybe sse-opcode.inc.h?  While it's not only sse,=
 it is
> used by gen_sse_ng().

"sse-opcode.inc.h" isn't 100 % as you point out, but looks good enough fo=
r now.

-Jan


--bC4ZTDj6yl1SjWcuo4kjEUPtacS5xYyKr--

--aFsX4FPHb7fGtIUO09a87fabeSxLqRK55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1UrXwACgkQZeg2ldrj
Ns/15BAAgq1VB3v1mqQYRtofm0Ej2eOndTdm4knEMDQKme58GJD6rAGvMi8Y/U9u
vMw+8F0GmmNcNZtE4cHnfHF5DLjQb74bVi3CgebS6BakEXBDPacwlrToGQ2JZCC2
GF9kQCMRDVzv76govGRAH7htWEG7hny83wgJUUV2jklN1RNZKP+G5TdJ1CMp1TL/
1RhoGYgF8gSv8ONxi1XDLFjmoSavh83t1iJFR1WxmHlRO74GYlQn53W4yaOELfPh
ufnF9T05/fzxNBx0/xYjaYYTPqp5WgewwuMTXREZeQhOjmTRIg1g0U867jJKrgZ4
j7hFIerV09bzbYpwmEj2rRZz8GYnxzna93n08dzbybJsYUkv58iVBawdXhFkwbU9
KnxPsBYm1KefEf0+VLKtmbLct+sU1fLF8vPC2Ow15RS83l9L3DzflxBZQjaDkviG
WQLTsOjyFsHHrOxu9tPnTnaBfIjO0HSIQFKpc+6t1dWHLwXAOOKAREUym3MYaCm3
6TKgchUwlG0Q0TV9weLBCBU31ufABp+emCCLm05PPVwFMVE2p+a/LnKtEkRVsDVA
3o25vdfEvFV7W9ThwZAVUVjsLA676mHCDVttAvZ3v1TVfpRdMdJnVMoC20Nm1ICD
l21hIOfq9ncDibD8wKZeEdd1mUS+zOdPHoMgX4L36IlzM3t7wPM=
=ZhKJ
-----END PGP SIGNATURE-----

--aFsX4FPHb7fGtIUO09a87fabeSxLqRK55--

