Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24483C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D2D2189D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rztILigz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D2D2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXa9-00031Q-8B
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50329)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1htXZh-0002ar-Ay
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1htXZf-0005KT-QR
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:26:25 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:42658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1htXZf-0005KH-Ii
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:26:23 -0400
Received: by mail-yb1-xb43.google.com with SMTP id e11so451778ybq.9
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=BjntLDBJ1jPvKY2XbWSOjm40X0sQ/aOM4l3C2P0aWUc=;
 b=rztILigzjye2Sgh6ldm2Pzh7xC7Um48enZOOSH36u8gNtRrvPXqPJRW1IwFWUTH63d
 tRiNqkX361j8MckVQR0k+eBnCGwN81y0JC09n9/9s5XplpvtW40Nsh/tsVvMDu/5Fv5a
 KEa0s1A3WXw3XakYOuTK3NtlVME3zAADMwDPudvFNfaWuTN2HnRp+7IdPWbAtNhJqyRL
 /drJMKMikY12rfXCF3+/Hue0HAlqfjl362qDUdfpPeDLF6u+QJuCuhYxhkodsMQ505Md
 0ZxyUWPE7ZXOwHOr9eYR+9cn+vwCckjmrqUSbtBdJK9xUqJ31n0Kar5700d7PeWQccmf
 o1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=BjntLDBJ1jPvKY2XbWSOjm40X0sQ/aOM4l3C2P0aWUc=;
 b=j9q8SD5S6RDpeamm3SotOSkgeDKRrYYXCBQE06Rz++640vec0dJrcz9jiTQ+OYF9ux
 t0nlERxL4jEjL50A+1pypvapu8iciSFJ0uJ6euKIGxTKfihNouiOu/+1hF0+fs2l40wU
 IDs/HXFTrqbTeokaAImQBoL3yTB+rEmnHYsUQV6m29qJjmS5BfSBwnq+IrzxIuE//UH3
 lh0M4LtUqLkXF/+GpNXX9CU0KYNSCj6PjhHdWX47qA1ZDFdWSIl5ga2Ob17oMZ5nvID2
 Bd8V+IvZvxrrO0l1Hz2DNJdKeAifp7jTuFBgb62Fpl1qfAhP0tGpxHudsnW9aZpsIYxW
 CA2Q==
X-Gm-Message-State: APjAAAW6wfE58poqnb1IWCPH4gbuqELGFPb2hv1DX71Y0zaH+6ddQq1g
 s3Jpz5dt5xQi+qtYXmeloaw=
X-Google-Smtp-Source: APXvYqwZ6hV/LwJNIT6VDl4fv2P7vE9xv8X+t1fON0hBebVtW4nFhprju5CN3XHvhAQqenYC5wuWHw==
X-Received: by 2002:a25:2355:: with SMTP id j82mr67826253ybj.125.1564752382803; 
 Fri, 02 Aug 2019 06:26:22 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id v9sm17112484ywg.73.2019.08.02.06.26.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 06:26:22 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-6-jan.bobek@gmail.com>
 <a31e0c68-c679-1afc-cd18-43da1d002621@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ee081556-23a7-dab7-006a-fbbb7c286243@gmail.com>
Date: Fri, 2 Aug 2019 09:26:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a31e0c68-c679-1afc-cd18-43da1d002621@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zO7d0MDDwEGdYw4OCWzO7C5jlO5DbcvcF"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: Re: [Qemu-devel] [RFC PATCH v1 05/22] target/i386: introduce
 gen_ld_modrm_* helpers
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
--zO7d0MDDwEGdYw4OCWzO7C5jlO5DbcvcF
Content-Type: multipart/mixed; boundary="5v6rGK1IfFiwDbFt30pHq8KE2WMhoU0wC";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <ee081556-23a7-dab7-006a-fbbb7c286243@gmail.com>
Subject: Re: [RFC PATCH v1 05/22] target/i386: introduce gen_ld_modrm_*
 helpers
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-6-jan.bobek@gmail.com>
 <a31e0c68-c679-1afc-cd18-43da1d002621@linaro.org>
In-Reply-To: <a31e0c68-c679-1afc-cd18-43da1d002621@linaro.org>

--5v6rGK1IfFiwDbFt30pHq8KE2WMhoU0wC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/31/19 3:08 PM, Richard Henderson wrote:
> On 7/31/19 10:56 AM, Jan Bobek wrote:
>> These help with decoding/loading ModR/M vector operands; the operand's=

>> register offset is returned, which is suitable for use with gvec
>> infrastructure.
>>
>> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
>> ---
>>  target/i386/translate.c | 47 ++++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 47 insertions(+)
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 9e22eca2dc..7548677e1f 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -3040,6 +3040,53 @@ static const struct SSEOpHelper_eppi sse_op_tab=
le7[256] =3D {
>>      [0xdf] =3D AESNI_OP(aeskeygenassist),
>>  };
>> =20
>> +static inline void gen_ld_modrm_PqQq(CPUX86State *env, DisasContext *=
s, int modrm,
>> +                                     uint32_t* dofs, uint32_t* aofs)
>=20
> s/uint32_t* /uint32_t */
>=20
> Drop the inlines; let the compiler choose.
>=20
>=20
>> +{
>> +    const int mod =3D (modrm >> 6) & 3;
>> +    const int reg =3D (modrm >> 3) & 7; /* no REX_R */
>> +    *dofs =3D offsetof(CPUX86State, fpregs[reg].mmx);
>> +
>> +    if(mod =3D=3D 3) {
>=20
> s/if(/if (/
>=20
> Both of these errors should be caught by ./scripts/checkpatch.pl.

I have the script set up; I disabled it temporarily (or so I thought)
some time ago when it was preventing me from git stash'ing some
experimental hacks, and never got around to enabling it again.

Anyway, I'll make sure not to forget to run it prior to submission
next time.

>> +        gen_ldo_env_A0(s, *aofs); /* FIXME this needs to load 32 byte=
s for YMM=20
>=20
> Better as "TODO", since this isn't broken and in need of fixing, since =
we do
> not yet support AVX.
>=20
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
> r~
>=20


--5v6rGK1IfFiwDbFt30pHq8KE2WMhoU0wC--

--zO7d0MDDwEGdYw4OCWzO7C5jlO5DbcvcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1EOfwACgkQZeg2ldrj
Ns+3/w//c5P/6r1L4hjk3+IsTsk4GHH+QxpMxJv88x5zdRf3fyy/IJbsiw3W5eRg
ecz4nxf+IR46A0Y8zz2sCpaXsXt1LsRrnwcs+VrzDkpWX2TDxsHntNqq+eDHYqPt
a1VVAg1LQexnuFs+iqHj6BzwE23UvNhWvplwxxUnbCHcILWQA+e7lhFOHDU9lxOJ
fhFL0HYStdkLVnE5N2aA/c5Xzz2ZEkdSbJnPonhqyfRYUTT+HpP+6pXZIvvquZkR
4mZ0TMtNmLUJKFbgmj3n5NCF2z496En1RErMLCQnKfu2LNIIYQxx5NxwXHrsNGvu
fw1DqLyvLpIL/YGhg80mzcwHhHhst1ptJ6yFJhWRVD6hLsu3TVV/YsAgTzQOnRrV
qtY6V/g7104UdQzFjfLEqZszpULYGYgmvm97M4JZ+fCeqiJWbTOt1Ww9BHoYp2vd
ih3tIORzXOJlMBAIWRBK5E6Sp0yYO4OytO2IP8NamXkSTBKQR+rM6gl51TvaiSUv
Mav6cG0XXKHR6Is96poG9/Z380b0CUzHv73am8P9N+uU9HB3drD3PIGHIQ0PJBBM
zcOM/jIi5QNa2U2DCSDi/1fPhPYl2oFu4qtRvsE2x8byVgnp0B6Wu3RQadJhYGm+
ELA/zz+tMU1f/DIPsUpxZo06RjSHcFYIRB7S0SQ2UhSJLxf6H8A=
=4iKI
-----END PGP SIGNATURE-----

--zO7d0MDDwEGdYw4OCWzO7C5jlO5DbcvcF--

