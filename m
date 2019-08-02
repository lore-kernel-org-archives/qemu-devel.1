Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F7C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53142087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAAOiUgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53142087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htY0g-0003nK-4s
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1htY01-0003Mu-RH
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1htY00-0002Vw-LW
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:53:37 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1htY00-0002VX-DD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:53:36 -0400
Received: by mail-yb1-xb41.google.com with SMTP id j199so26889328ybg.5
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=4O4mfOO5u/DVIU6ZBXSAfotCAqbdp6TUMol4JeQtnW4=;
 b=jAAOiUgtIDlJOT3M9DEMudn9kovazzyX+F8NeHihYcMHe9krcVJ79uChRQ3uoOBPdV
 YXVCwPrZmPkOGJTkAY56bE38sfwfQqOKCiYEXNC9x4GjekAFejIKa3Xgkv3nw8pAofVX
 AP43F3tKkI/bBDgX4AAOSV7fIr7x6H4qRR3DcYENjZqy4xIm+4UK8UNo6hHVp2xeLzCQ
 3kHWzSc9H/asb5ik0sODOS4MX02bkRx/9J4Fa0Xkuf6m+/Ms85P/b+fdbgm+PuiXecZ0
 Axl/VDw6lQKwZilsST3tjHqCP7wL8+3J9OfllfsUlr9/wOCmPgBG4jQ6w85Q1mPXRP+e
 B9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=4O4mfOO5u/DVIU6ZBXSAfotCAqbdp6TUMol4JeQtnW4=;
 b=ROd3xBE9G/94nExlnFYKKYZY0yncpXI4qvffYmvLI1hzJFb/msJoIclR39kR8Y2DSB
 S6URkJZU11LuSXqJIXY+ZA6si2wi78jrd4o5nbbZ6PrHdaWCRV4bO3+hyyHgSN1HGNZx
 vXtq+bWMIOWxSQS4ZrRaHqv7HRyXMk9N6OzZ/jdGBSu2NHogRMiRidu+B7mlqV57kY3R
 k8YS6IpGYJW3TWDJbdKRKCtxl49XMMMk5bP5ex6EjckUw76KGoUae05qrGC58eJ33/R3
 KhXZyPE8/L/0XOLGOhNMB/85rA1vmo7vWnJzuaUUZOieTkIJua9hMAXlTG0jkWO/9/BX
 3NcA==
X-Gm-Message-State: APjAAAUU3Q+A3ZjyCKLrG/DN8mGz9dYejmb14XOeY0PSeCAk5stX4GOI
 esiPeZ1fjkwl9Rx3xJ9FCWo=
X-Google-Smtp-Source: APXvYqwtKkzsNmpSDOlpklSIG2xCX6nBTyTPRCY+66T4xRqt8faVpdEE+pCAnciCuS/kyDbkM508Ow==
X-Received: by 2002:a25:d80f:: with SMTP id p15mr77018155ybg.145.1564754015225; 
 Fri, 02 Aug 2019 06:53:35 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165]) by smtp.googlemail.com with ESMTPSA id
 r19sm19746284ywa.109.2019.08.02.06.53.34
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 06:53:34 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-9-jan.bobek@gmail.com>
 <6d2c01c9-17a4-163c-349c-537bc54289fb@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <231e111c-e5c8-42a2-f5a6-647a09b6f061@gmail.com>
Date: Fri, 2 Aug 2019 09:53:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6d2c01c9-17a4-163c-349c-537bc54289fb@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Y4J1S8KdzFvQ5PqlZNm5HKLVGjKhxGnED"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: Re: [Qemu-devel] [RFC PATCH v1 08/22] target/i386: reimplement
 (V)PAND, (V)ANDPS, (V)ANDPD
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
--Y4J1S8KdzFvQ5PqlZNm5HKLVGjKhxGnED
Content-Type: multipart/mixed; boundary="cSEhTbOMZq7MDvVju4w2gCtNLwEqKtNfQ";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <231e111c-e5c8-42a2-f5a6-647a09b6f061@gmail.com>
Subject: Re: [RFC PATCH v1 08/22] target/i386: reimplement (V)PAND, (V)ANDPS,
 (V)ANDPD
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-9-jan.bobek@gmail.com>
 <6d2c01c9-17a4-163c-349c-537bc54289fb@linaro.org>
In-Reply-To: <6d2c01c9-17a4-163c-349c-537bc54289fb@linaro.org>

--cSEhTbOMZq7MDvVju4w2gCtNLwEqKtNfQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/31/19 3:35 PM, Richard Henderson wrote:
> On 7/31/19 10:56 AM, Jan Bobek wrote:
>> +#define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s=
), (modrm), MO_64, tcg_gen_gvec_and, 0112)
>> +#define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s=
), (modrm), MO_64, tcg_gen_gvec_and, 0112)
>> +#define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s=
), (modrm), MO_64, tcg_gen_gvec_and, 0123)
>> +#define gen_vpand_ymm(env, s, modrm) gen_gvec_ld_modrm_vymm((env), (s=
), (modrm), MO_64, tcg_gen_gvec_and, 0123)
>> +#define gen_andps_xmm  gen_pand_xmm
>> +#define gen_vandps_xmm gen_vpand_xmm
>> +#define gen_vandps_ymm gen_vpand_ymm
>> +#define gen_andpd_xmm  gen_pand_xmm
>> +#define gen_vandpd_xmm gen_vpand_xmm
>> +#define gen_vandpd_ymm gen_vpand_ymm
>=20
>=20
> Why all of these extra defines?
>=20
>> +    enum {
>> +        M_0F    =3D 0x01 << 8,
>> +        M_0F38  =3D 0x02 << 8,
>> +        M_0F3A  =3D 0x04 << 8,
>> +        P_66    =3D 0x08 << 8,
>> +        P_F3    =3D 0x10 << 8,
>> +        P_F2    =3D 0x20 << 8,
>> +        VEX_128 =3D 0x40 << 8,
>> +        VEX_256 =3D 0x80 << 8,
>> +    };
>> +
>> +    switch(b | M_0F
>> +           | (s->prefix & PREFIX_DATA ? P_66 : 0)
>> +           | (s->prefix & PREFIX_REPZ ? P_F3 : 0)
>> +           | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
>> +           | (s->prefix & PREFIX_VEX ? (s->vex_l ? VEX_256 : VEX_128)=
 : 0)) {
>=20
> I think you can move this above almost everything in this function, so =
that all
> of the legacy bits follow this switch.
>=20
>> +    case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm); re=
turn;
>=20
> You'll want to put these on the next lines -- checkpatch.pl again.
>=20
>> +    case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm); r=
eturn;
>> +    case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm); =
return;
>> +    case 0xdb | M_0F | P_66 | VEX_256: gen_vpand_ymm(env, s, modrm); =
return;
>> +    case 0x54 | M_0F:                  gen_andps_xmm(env, s, modrm); =
return;
>> +    case 0x54 | M_0F | VEX_128:        gen_vandps_xmm(env, s, modrm);=
 return;
>> +    case 0x54 | M_0F | VEX_256:        gen_vandps_ymm(env, s, modrm);=
 return;
>> +    case 0x54 | M_0F | P_66:           gen_andpd_xmm(env, s, modrm); =
return;
>> +    case 0x54 | M_0F | P_66 | VEX_128: gen_vandpd_xmm(env, s, modrm);=
 return;
>> +    case 0x54 | M_0F | P_66 | VEX_256: gen_vandpd_ymm(env, s, modrm);=
 return;
>> +    default: break;
>> +    }
>=20
> Perhaps group cases together?
>=20
>     case 0xdb | M_0F | P_66:  /* PAND */
>     case 0x54 | M_0F:         /* ANDPS */
>     case 0x54 | M_0F | P_66:  /* ANDPD */
>        gen_gvec_ld_modrm_xmm(env, s, modrm, MO_64, tcg_gen_gvec_and, 01=
12);
>        return;

As Aleksandar pointed out in his email, the general intuition was to
have self-documenting code. Seeing

case 0x54 | M_0F | VEX_256: gen_vandps_ymm(env, s, modrm); return;

clearly states that this particular case is a VANDPS, and if one wants
to see what we do with it, they can go look gen_vandps_ymm up.

That being said, I have to the conclusion in the meantime that keeping
all the extra macros is just too much code and not worth it, so I'll
do it like you suggest above.

> How are you planning to handle CPUID checks?  I know the currently hand=
ling is
> quite spotty, but with a reorg we might as well fix that too.

Good question. CPUID checks are not handled in this patch at all, I
will need to come up with a workable approach.

-Jan


--cSEhTbOMZq7MDvVju4w2gCtNLwEqKtNfQ--

--Y4J1S8KdzFvQ5PqlZNm5HKLVGjKhxGnED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1EQF0ACgkQZeg2ldrj
Ns/SMw/+OxjCEYXVNYeASNcyJJpFtaVXgef+nkKMThwlhp3FTWliPh3vkuSYNud9
WZJyzKPe+Ab+waZmqn12UdN2iI84PRprAcmKR6lNRVxzilmKgyKsz+Y2//njppXG
Px4h7sycBKcBvSmabrdwLJH5l6XppDd4CcaZFBJ9F0sV0qxIkLzRJeOsCP/YIBuj
XgWXOjnJI169RfPKwoZEbmQiEPSoc7Jiov7cONOY+yPcLSRD5YUlpI9IzuehTvRD
m0HYpSs3tVtsvqeS/X9oSGAGGJC1dybV4Ul1nS2zaqlKVfjUMMFuQ5lvbu2KG/Jw
os3wZ6JREm1MH+hVSQBGRJk3qwAtwUi2j5mCYewGNlEgNqJuImBOh8CFJHmxXqiC
cFtCW1mhwD1GmtbpgI9ciskOVXEXUXyyoCafzD0nOwdJqErUQffh1SxWesnB8Vj9
Fk/eotksopFlU4nHx/47cjkVT5Xpc5Pki7p5hLCOU5TtMN/+wD5sC0mtO7vJFYGU
bs+riaJoCh0imzMDsAy/4QSVzfzB/b25qT1n60Cd9bdDybh7aG185klrrmulOx1g
JPYy+W+4rFDikvXH3vS/SxhK4P6+g9dc6HkU304HJAUm9UdhjEsTyZfuxxARYW2S
2BC+YB2iVAgUXLmAVgp9ABgz33fMPOa8J+x9gWud5DUQURg+k20=
=89L/
-----END PGP SIGNATURE-----

--Y4J1S8KdzFvQ5PqlZNm5HKLVGjKhxGnED--

