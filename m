Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EB2C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 15:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437672085B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 15:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ziy1ZYdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437672085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwq6X-0001ZE-DH
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49571)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwq5r-00019w-5s
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 11:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwq5o-0007rP-I4
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 11:49:15 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwq5o-0007po-8D
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 11:49:12 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m9so248374ybm.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2019 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=L3FU84SmQYTlmrvK8z9du4uMf3O1nljoRGpeSjwuAxg=;
 b=Ziy1ZYdG/k6HCJ+QiJNBmw5NqUvEXfMWltvXDF73+9aGptreQKRrrn1ILe44h19RUo
 VIJuZMdGu/csw1jXBgzso4N/4bJ7OECHhC6tXS7U6I+HjOvjB96Z6K1EkZYl+eXLRXl1
 ujy39ZnJLzA/npla0H3TonSVei1h9OmP+2pbvzFEjhYExXq1jIb4u68lwPcoOlZuDL1H
 PAKQ28MJy2xDLB+Yx/O1EzBokP8c/Y3x4VSEny72ClpADdMUcJkUYB0AryrJBTvd74hC
 +guXpL2382ziBL8eh4NdAb6f1Xcde6lueEu8+qKBFaSPCj/FPlSDY1FFbj5dm/HrHiLE
 DtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=L3FU84SmQYTlmrvK8z9du4uMf3O1nljoRGpeSjwuAxg=;
 b=OrHBkcwQax9aubyVk59u7ZF8Wf43ilScQ8rqc4G6Rg7Dx39AhU2FnZ2HP64w/zlu85
 aAm6OKqMX7br0mihlDM1h70EH3BcNLjuWoNd5nq1V37GkXJhh51yZFBaTmvGOD8/P9m/
 vL6fZn0MLeBrSHzdgnrXO0YoePnYnK7A0IYW3vi5p7TOZnHUjq0I+EoyhsU56AiycMTf
 5JLoaCDYNoLQgAdnx+KA6bJwCgEoMdn3zg66srhweOL4cnZHlkjHt1SqZn8sWUGLxKnm
 q42b2tns1WxfASZrgW3mMzC7tVG+vHpqPE9pQPWA0tzr+mov7/0f9uJK2EvTDTlSusPA
 zfGw==
X-Gm-Message-State: APjAAAUSAzGejumfpL6DG8xWBtMD7FL2ZKiBOpWDkKjqkv5P1jkt5kT8
 FF8HjqWPsJN+sI6x/IuwjY8=
X-Google-Smtp-Source: APXvYqxphB+9souMLGXfHZXVAkoGplEtKUqEjs85ZJEs5Bxv8VMDIT3Lh4T89Esd7KmGOOU4TAVM1g==
X-Received: by 2002:a25:bfc2:: with SMTP id q2mr13437248ybm.274.1565538551217; 
 Sun, 11 Aug 2019 08:49:11 -0700 (PDT)
Received: from ?IPv6:2601:c0:c67f:e390:8a9a:e33f:caf8:f018?
 ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.googlemail.com with ESMTPSA id q81sm3513933ywc.24.2019.08.11.08.49.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 11 Aug 2019 08:49:10 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <7d6ac8e9-00a0-fda2-74ba-327b39460cce@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b46dc069-8213-9e56-37a5-fa8986cf5c7b@gmail.com>
Date: Sun, 11 Aug 2019 11:49:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7d6ac8e9-00a0-fda2-74ba-327b39460cce@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7rrvMBEZtxTq42walCG1culItVFShPkL2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/39] rewrite MMX/SSE instruction
 translation
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
--7rrvMBEZtxTq42walCG1culItVFShPkL2
Content-Type: multipart/mixed; boundary="2TC2gN93dMMRoHYfL4lsZosfpUCwnOSTl";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <b46dc069-8213-9e56-37a5-fa8986cf5c7b@gmail.com>
Subject: Re: [RFC PATCH v2 00/39] rewrite MMX/SSE instruction translation
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <7d6ac8e9-00a0-fda2-74ba-327b39460cce@linaro.org>
In-Reply-To: <7d6ac8e9-00a0-fda2-74ba-327b39460cce@linaro.org>

--2TC2gN93dMMRoHYfL4lsZosfpUCwnOSTl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/10/19 7:35 PM, Richard Henderson wrote:
> On 8/9/19 9:12 PM, Jan Bobek wrote:
>> This is a v2 of the patch series posted in [1]. Patches 1-9 are just
>> cleanups; patches 10-39 are something actually interesting. Compared
>> to v1, I started using preprocessor more extensively to generate
>> repetitive boilerplate code; opinions/alternatives are welcome and
>> appreciated.
>=20
> This is tricky.  I'm not keen on code entirely expanded via macros beca=
use it
> becomes extremely difficult to debug.  All statements get recorded at t=
he same
> line of the location of the expansion, which makes the gdb "step" comma=
nd
> finish the entire function because there is no next line.
>=20
> Once upon a time I wrote some code that's extremely macro crazy:
>=20
> https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob_plain;f=3Dsoft-fp/op=
-common.h;hb=3DHEAD
>=20
> It has been extremely difficult to maintain over the years.

Thank you, that's exactly the feedback I'm looking for! I've played
with the preprocessor in the past just to try out what's possible, but
I've never maintained code that uses it as extensively as this
series. It didn't occur to me that there would be a problem with
stepping it in gdb, for example, but now it seems obvious.

> We have just recently gotten rid of some of the macros in the softmmu c=
ode
>=20
> https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D105441
>=20
> replacing most of them with inline functions.

I'll have to look at it and see how exactly it's done; perhaps I'll
find something that's applicable to my case, too.

> A lot of what you have needs very little adjustment to address the debu=
gging
> problem.  E.g.
>=20
>> +#define INSNOP_INIT(opT, init_stmt)                                \
>> +    static int insnop_init(opT)(CPUX86State *env, DisasContext *s, \
>> +                                int modrm, insnop_t(opT) *op)      \
>> +    {                                                              \
>> +        init_stmt;                                                 \
>> +    }
> ....
>> +INSNOP(
>> +    M, TCGv,
>> +    do {
>> +        if (decode_modrm_mod(env, s, modrm) =3D=3D 3) {
>> +            INSNOP_INIT_FAIL;
>> +        } else {
>> +            INSNOP_INIT_OK(s->A0);
>> +        }
>> +    } while (0),
>> +    do {
>> +        assert(*op =3D=3D s->A0);
>> +        gen_lea_modrm(env, s, modrm);
>> +    } while (0),
>> +    INSNOP_FINALIZE_NOOP)
>=20
> Rearrange this as
>=20
> #define INSNOP_INIT(OPT) \
>     static bool insnop_##OPT##_init(CPUX86State *env, DisasContext *s, =
\
>                                     int modrm, insnop_##OPT##_t *op)
>=20
> #define INSNOP_PREPARE(OPT) \
>     static void insnop_##OPT##_prepare(CPUX86State *env, DisasContext *=
s, \
>                                        int modrm, insnop_##OPT##_t *op)=

>=20
> INSNOP_INIT(M)
> {
>     if (decode_modrm_mod(env, s, modrm) =3D=3D 3) {
>         INSNOP_INIT_FAIL;
>     } else {
>         INSNOP_INIT_OK(s->A0);
>     }
> }
>=20
> INSNOP_PREPARE(M)
> {
>     assert(*op =3D=3D s->A0);
>     gen_lea_modrm(env, s, modrm);
> }
>=20
> etc and suddenly the entire expansion does not occur on a single line.

That makes complete sense, thank you! I'll keep the debugging issue in
mind.

> Further specific commentary to follow.

Looking forward to it!

-Jan


--2TC2gN93dMMRoHYfL4lsZosfpUCwnOSTl--

--7rrvMBEZtxTq42walCG1culItVFShPkL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1QOPQACgkQZeg2ldrj
Ns+5xQ//S84ZhWGWYR0Ir9YN9wa9PBq2NEc464q1P2XY7ut+w/roaASM/vasU+cT
ei9jFkJ2SUXN6PIr9f1HUiT55Y8z4xlPoHnLxchRiQdy55gT2M/MXoUjYr9J6sgt
eTO0kymYPHNG1MLdE3GTvS2MyGp084suisJP2RDyFzw3/0OzU8nC39Muiip8E0ih
ezCGuwTIOcyLTo26SY7Vi4jsB94R8qmYLK0CHAP5mvZ9tN3okGtI6U2Y3MLGh88B
Xke3hpqAXA08wvjL8sS9G2FCPXV5zU4bmtDyJ2u1EAirUlP5z2l8AgABrElUfEvi
hFpHBBGxZu/ZtrbvLKzQV8f44TUI+YtoqGcT7Tj+/YuCup5dM+BuGQTiVKQizL7t
XHoclg2c13vEx3Y12OTXOQQVPxzPMf16YlZQxDqNLfe+SmLTCdXdcaFWUheXKNor
qMDtbTmgqJckMHyuw0mv4k4VKGOw7JcDJ0zk9TXh5snkBE02M/2EH6hcSeQn5R+x
EmAK2glxl/hLqLtDaXxPJ718wanTzIE0pO1SFhh2e35EjFhDf3aLJxNHLBv0ixsB
bZ9U+avH0RqEWYFIHddhLtKQnnDllrx/l2yjKpTurG6fdKDaVNdXzJQ0AIid8yHo
lkGOLi4wWkp7bR+c39aDIuJRZS6pkkrW33df6i1ha4WZGEF/iSI=
=nnha
-----END PGP SIGNATURE-----

--7rrvMBEZtxTq42walCG1culItVFShPkL2--

