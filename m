Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BDC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF1B218EA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXyWkMv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF1B218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZDm-0001Cx-Ar
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hpZDb-0000oG-3r
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hpZDa-0005Xa-2p
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:23:11 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hpZDZ-0005W1-QH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:23:10 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so34346114otq.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=bdZyN3XZR5nmNBqs0B5QoejUkOygKoPQ+w4Ns6rMo7Y=;
 b=aXyWkMv+MWquZZ/I2yVgI4PxAEdU+TN/x9v8rdG9fmFlbIOM0XEt12P5mrDk8oYEjZ
 T8wdHAn2QDTuGqBcE8ZX3XmNLtZ+mzBSdJ8yWf0R6LsviEhDQnDmMZpTCyAinnNcDQy6
 QqzCCEFlYlI/dNQQVC1R34nFPDiJsG0qS00dkA2AnlK+nKFZfhgyo/aw9ae7WgYseK2K
 B8CMcG+2+d0k0jSQZhuJA/SLi+S7GotpGdCPQm/QjxwOXSbFN87lM87isJEt98HKGs5k
 NY95ejjkIR7ftoeCj83gpjKsTVjbvXEQyGGdLqurbJnXECswYCbV+T4FuTUtKHddphwE
 hRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=bdZyN3XZR5nmNBqs0B5QoejUkOygKoPQ+w4Ns6rMo7Y=;
 b=K+p8NTd7uD1iidJnOryRh3SQBdqwslwFAcoiv7Plj0m55BsjJViVPZTeF1d1QnnVWn
 PNfv/1wUxFmH3HQKjEc6bSfZ+DMEw6Tm+mos1Tfkw55icJ0+7QMBfVGruavCV7oUZPWT
 drOpbPbsHsBmuxLFYDwR+HwkwQl9AVzBzgYHFkAaBXDbf3BFx450Mx1Jz1pIs++102ZK
 hwtyzvLG2RbDhm/qj4U6zteXr3WmFu4bPSvoDM4DJIdZ6zu0zaul+ZhXmT7+EdaQ9AkS
 yeigB+bwCTrQghgVftmpCiU7rSG+YxTszYbT9Jnc96xnwNWgcsDRK02Q1zzZcuUO1k+Q
 AKgA==
X-Gm-Message-State: APjAAAVMlObO+WZ3UnPlzxhtWBjTGcz/lCwA1kBRjw+wS6EPYGA7Dtsg
 VcREKSn+Q/OVx2Vnmx4rLzw=
X-Google-Smtp-Source: APXvYqwmGMRtsG/iF4CSWGxuGfQ2aV1ipdbI4ByDRLpSwOUqGFP7YFp4ajt8CgMK3tlsobtUWs83qQ==
X-Received: by 2002:a9d:470f:: with SMTP id a15mr20682422otf.235.1563805388959; 
 Mon, 22 Jul 2019 07:23:08 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id p2sm13365637otl.59.2019.07.22.07.23.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 07:23:08 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-18-jan.bobek@gmail.com>
 <63c92bca-d1f8-6dd7-35c9-9a8e87ba38b0@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8f66bbc9-7ab9-9f1c-7493-20d0f467dd6b@gmail.com>
Date: Mon, 22 Jul 2019 10:23:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <63c92bca-d1f8-6dd7-35c9-9a8e87ba38b0@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="s3pKoDIUzt0lWA88MLCvwgMQrDqdgs0g9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [RISU PATCH v3 17/18] x86.risu: add AVX
 instructions
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
--s3pKoDIUzt0lWA88MLCvwgMQrDqdgs0g9
Content-Type: multipart/mixed; boundary="FXdRdNEK1kWfn0yTAXt8mnpSDFPQVav81";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <8f66bbc9-7ab9-9f1c-7493-20d0f467dd6b@gmail.com>
Subject: Re: [RISU PATCH v3 17/18] x86.risu: add AVX instructions
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-18-jan.bobek@gmail.com>
 <63c92bca-d1f8-6dd7-35c9-9a8e87ba38b0@linaro.org>
In-Reply-To: <63c92bca-d1f8-6dd7-35c9-9a8e87ba38b0@linaro.org>

--FXdRdNEK1kWfn0yTAXt8mnpSDFPQVav81
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/20/19 8:04 PM, Richard Henderson wrote:
> On 7/11/19 3:32 PM, Jan Bobek wrote:
>> +# VEX.LIG.F3.0F.WIG 10 /r: VMOVSS xmm1, xmm2, xmm3
>> +# VEX.LIG.F3.0F.WIG 10 /r: VMOVSS xmm1, m32
>> +# VEX.LIG.F3.0F.WIG 11 /r: VMOVSS xmm1, xmm2, xmm3
>> +# VEX.LIG.F3.0F.WIG 11 /r: VMOVSS m32, xmm1
>> +VMOVSS AVX 0001000 d \
>> +  !constraints { vex($_, m =3D> 0x0F, l =3D> 0, p =3D> 0xF3); modrm($=
_); $_->{vex}{v} =3D 0 unless defined $_->{modrm}{reg2}; 1 } \
>> +  !memory { $d ? store(size =3D> 4) : load(size =3D> 4); }
>=20
> Why the l =3D> 0?  LIG does mean VEX.L ignored, so why not let it get r=
andomized
> as you do for WIG?
>=20
> Not wrong as is... this is the documented value for scalar operands.  B=
ut there
> is a different document markup, LZ, for required (E)VEX.L =3D=3D 0.

I am aware of LIG vs. LZ. Quoting from the MOVSS manual page:

  Software should ensure VMOVSS is encoded with VEX.L=3D0. Encoding
  VMOVSS with VEX.L=3D1 may encounter unpredictable behavior across
  different processor generations.

"Unpredictable behavior" sounded a bit menacing to me, so I opted for
the conservative route. AFAICT all the scalar instructions have this
warning attached; I don't know why they differentiate between LIG and
LZ then, though. Do you think it's irrelevant?

-Jan


--FXdRdNEK1kWfn0yTAXt8mnpSDFPQVav81--

--s3pKoDIUzt0lWA88MLCvwgMQrDqdgs0g9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl01xssACgkQZeg2ldrj
Ns+MyRAAqejJmlWP+uraGFv/cjJAWX2xDnk7eYh5uPrftQ/I1ElHxXhiBoTqAq98
HWgOx3oztaVnmUvPOcW1+79K5d2Vu8bdb+UejeRHgjPp3+RnsSZaWsACDaE7agSF
Y/DoJvJVQInWOVIBFgAFb6Ibsy0f3PyEz1+CLz2K65kPsjZQRFdIs+eddyaxoVXP
ZnKyL+MzpdoT/VcaX42SB7pmQ//GyjtXgHbtaEAROsLTJBbAEkDlhy+5wfu1bxCS
jF+0dXeJcG4V/qbnxjZZFUE55+Yux1it9KYjBzl8qjbPbApKttfAmuKtWOB2i4Vw
Mhtd239tJ6hqC7CImN07t6fKwLxvwu3DTOpVLQBrbk19X8yGx4wfb71sMpibowBV
kHT9nQ8IE1Fd+eVlbHtvqHIo/xPpBY3l41CfKAG/95l4IqaAfd2sK++wDtWjGamE
hRPCV9mG6dSGZT4oNRkLIyV/+88SvDjSKR1tg22bImUgBKAbM5tsOO974H3CjWfN
9C45iSYQD9flqESrYJ4bjR79dcXn+NvxKQ9kWm/Yo4Wktj0WFTnfp9pBxDt2YxLx
BPIjVXWPFK4imyiOOLfzeIUHxnaeay2TBtPJmSSLK9LQmqx1ZD1aVBpBg+/B5nMK
Jx97f7WIPZJRXEVl8Hp6aVkg+BPXGYNKhUei2GEYLSn2xnX0N1Y=
=4eWz
-----END PGP SIGNATURE-----

--s3pKoDIUzt0lWA88MLCvwgMQrDqdgs0g9--

