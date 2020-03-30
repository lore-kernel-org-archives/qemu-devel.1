Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A0C2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B222072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/ojmwYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B222072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxCU-0004Ck-Al
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jIxBa-0003GB-Cj
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jIxBZ-0008KO-5w
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:22:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jIxBZ-0008JW-1z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585585368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pBqpeKzq2ywabEjb9lKo2BkzSGZFe49tkKDRe5IeJQ=;
 b=Z/ojmwYoOzOpAYgAG7KrtL6UbazvyueziUZKOePVDF6v8zWh1LniCUvw4+MIZmwwJvTPpE
 xSULS5DToEnXUIrpwyHWP9QYG4nniHtm3Z9xEfZQ9XmK3FeJsGh+FE7UZVjRdtglvehq9c
 KA2psP+K+ma+WjYBmXywxuoF5EepwHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-kWrqcXo9Mk-D94nT7_jtCQ-1; Mon, 30 Mar 2020 12:22:46 -0400
X-MC-Unique: kWrqcXo9Mk-D94nT7_jtCQ-1
Received: by mail-wm1-f71.google.com with SMTP id w8so2162560wmk.5
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 09:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sW1FXFB42oMy9eotetjDDuXszctfAe/UkJB6bFgGQ2c=;
 b=I0s1P30ehZmpx4E3Sou/h2VNqa5oNwsRfGCSMbNYV0+J2AKqeWOsLJ87lNJAVgsTcb
 4nYtP7EMQ3c0HHkrHh4umSjBzteqZ5LML/10Dt5YOIlVfSiIoNQhHfYmmfBzIXRlB/2D
 34nQC4na94klQHPBH6O9CJhrSOtlezGML/Y5jct+LPUU+3dEkL3/FvoYXpAp2jQlF6+B
 nTZV1yx78LDuDfnWRjt1pHfVRFR4TnRSTS2UQ9jB+zx+GZVAtPZ2ht0BswRdD3DbyS1y
 zNji6zseEDGg9UNXaaZLdilKN+1f49Wc/6peignSZErWzf+7Z9JH0Z1JrFVTIcVrcSy/
 vIng==
X-Gm-Message-State: ANhLgQ18HIrwnIvbIdKXCY2jZivbN2Ha7LJu4tTLdz8kHkjHoVuM7cUf
 0fYJajyPP6Fz+Cry7S9YPQPY+frntaOTDQydnLCpVLISpc9uK+7m768ErW54cT2ejxywzF/Nfh1
 MVyac6PaZQDiserA=
X-Received: by 2002:a1c:e109:: with SMTP id y9mr111140wmg.62.1585585365387;
 Mon, 30 Mar 2020 09:22:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuRlR5gmgMtdu6AM+uf/Sk5XYAnk0HghX29GWFh2dxqFH4RRO1YOyYZzPM8Bac2dRnNfMykvQ==
X-Received: by 2002:a1c:e109:: with SMTP id y9mr111123wmg.62.1585585365060;
 Mon, 30 Mar 2020 09:22:45 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n11sm87191wmi.10.2020.03.30.09.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 09:22:44 -0700 (PDT)
Subject: Re: [PATCH for-5.0, v1] target/mips: Fix loongson multimedia
 condition instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
 <39c28108-5d85-d611-c2ea-abbbf913b981@redhat.com>
 <1B369970-E78B-4A05-A80E-D7AB527E3A4E@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bbf10da2-76ee-a4c6-275d-fa1c8fc59e1e@redhat.com>
Date: Mon, 30 Mar 2020 18:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1B369970-E78B-4A05-A80E-D7AB527E3A4E@flygoat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Huacai Chen <chenhc@lemote.com>, aleksandar.qemu.devel@gmail.com,
 richard.henderson@linaro.org, aleksandar.rikalo@rt-rk.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 6:18 PM, Jiaxun Yang wrote:
>=20
>=20
> =E4=BA=8E 2020=E5=B9=B43=E6=9C=8830=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
11:39:44, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =E5=86=99=E5=88=
=B0:
>> Hi Jiaxun Yang,
>>
>> On 3/24/20 1:22 PM, Jiaxun Yang wrote:
>>> Loongson multimedia condition instructions were previously
>> implemented as
>>> write 0 to rd due to lack of documentation. So I just confirmed with
>> Loongson
>>> about their encoding and implemented them correctly.
>>
>> If you have a binary using loongson multimedia instructions, can you
>> add
>> a test? So this code won't bitrot.
>=20
> I know ffmpeg uses it.
> But I think that's too fat.

Looks perfect to me!

It'll be simpler if you use a pre-build binary from a known distribution.

>=20
>>
>> I'm in particular interested by a test covering the MAC2008
>> instructions. You can look at examples in the tests/tcg/mips/
>> directory,
>> Aleksandar added a lot of tests there.
>=20
> I'm going to try that.
>=20
> Thanks.
>=20
>>
>> Thanks,
>>
>> Phil.
>>
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Acked-by: Huacai Chen <chenhc@lemote.com>
>>> ---
>>> v1: Use deposit opreations according to Richard's suggestion.
>>> ---
>>>    target/mips/translate.c | 35 +++++++++++++++++++++++++++++++----
>>>    1 file changed, 31 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>>> index d745bd2803..25b595a17d 100644
>>> --- a/target/mips/translate.c
>>> +++ b/target/mips/translate.c
>>> @@ -5529,6 +5529,7 @@ static void
>> gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>>>    {
>>>        uint32_t opc, shift_max;
>>>        TCGv_i64 t0, t1;
>>> +    TCGCond cond;
>>>   =20
>>>        opc =3D MASK_LMI(ctx->opcode);
>>>        switch (opc) {
>>> @@ -5862,14 +5863,39 @@ static void
>> gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>>>   =20
>>>        case OPC_SEQU_CP2:
>>>        case OPC_SEQ_CP2:
>>> +        cond =3D TCG_COND_EQ;
>>> +        goto do_cc_cond;
>>> +        break;
>>>        case OPC_SLTU_CP2:
>>> +        cond =3D TCG_COND_LTU;
>>> +        goto do_cc_cond;
>>> +        break;
>>>        case OPC_SLT_CP2:
>>> +        cond =3D TCG_COND_LT;
>>> +        goto do_cc_cond;
>>> +        break;
>>>        case OPC_SLEU_CP2:
>>> +        cond =3D TCG_COND_LEU;
>>> +        goto do_cc_cond;
>>> +        break;
>>>        case OPC_SLE_CP2:
>>> -        /*
>>> -         * ??? Document is unclear: Set FCC[CC].  Does that mean the
>>> -         * FD field is the CC field?
>>> -         */
>>> +        cond =3D TCG_COND_LE;
>>> +    do_cc_cond:
>>> +        {
>>> +            int cc =3D (ctx->opcode >> 8) & 0x7;
>>> +            TCGv_i64 t64 =3D tcg_temp_new_i64();
>>> +            TCGv_i32 t32 =3D tcg_temp_new_i32();
>>> +
>>> +            tcg_gen_setcond_i64(cond, t64, t0, t1);
>>> +            tcg_gen_extrl_i64_i32(t32, t64);
>>> +            tcg_gen_deposit_i32(fpu_fcr31, fpu_fcr31, t32,
>>> +                                get_fp_bit(cc), 1);
>>> +
>>> +            tcg_temp_free_i32(t32);
>>> +            tcg_temp_free_i64(t64);
>>> +        }
>>> +        goto no_rd;
>>> +        break;
>>>        default:
>>>            MIPS_INVAL("loongson_cp2");
>>>            generate_exception_end(ctx, EXCP_RI);
>>> @@ -5878,6 +5904,7 @@ static void
>> gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>>>   =20
>>>        gen_store_fpr64(ctx, t0, rd);
>>>   =20
>>> +no_rd:
>>>        tcg_temp_free_i64(t0);
>>>        tcg_temp_free_i64(t1);
>>>    }
>>>
>=20


