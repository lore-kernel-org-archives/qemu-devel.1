Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A815CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 19:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8FF21D7C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 19:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxsPMiev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8FF21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLumN-00008V-8P
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 15:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLulM-0007pq-5G
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLulI-0007VL-Bq
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:51:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLulH-0007UL-Ew
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:51:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id i16so7989152oie.4
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ZCQWmg1dXoar+582XpJqTf6pRy3p5ClNqNRVpug13ts=;
 b=IxsPMievR98aMYShncDGOJtMXyDo2w17riLdGRd/A7A5KgfgqiYgEvNuT9yNUhNCmZ
 KcBKbHR6ZJnAyf8QLCuP8o7UCJ9EGB1rfc3SPcoGrcQ+uQ1t5hKohrEZbjC0DrWeyrxz
 EyfRj12/LMxrlx1Ut4wIfhQ1NsgGAEzBCasmbkumgsfQo1ePGxiqreULNCciz1lFZATM
 /HNqnp2KC7MBVuUS21cMiKn75lV22Ii16nDr8LGirdTekOEbEA8nY9FMwyxKW/53XcMy
 Cb2y0GqZaNdEYMRr3oDZxWiZE+PUulpU/O2FmJMoseMahO9lRYxjYRLQRMZgbPOijXXq
 Z+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ZCQWmg1dXoar+582XpJqTf6pRy3p5ClNqNRVpug13ts=;
 b=Lh3lYMMo82zyRbCaqfJ0/73tnZCmrQ5YMThg+ApWyvsaTFPn8gE/77rMDSUCAsqGiC
 txf5h4DOCo+im5+hwVHBw17si/sMV4R/3gZ2rtUA4eY9lgi4AbTq8klPUBwwmCIGjaKv
 iyYjC8F+59FdDa7rRptLipKgie0N2rzkWZD0BYQANuOd/3Kz+uKKOOEgFjpxwEQ/TRI2
 NbEiTwFrl86tlQqYqE0e5XbcFG0NY5j2mz/WOyGAOPoWMzmOv5stalugcKLzS2Z4Qhm2
 Y1t1HbpJjjUmI+jC5YMTzTuNTPr7wE46LOED0QvGmve/zKkDSu/yMo4uDebRZYLOPaQ2
 7c9Q==
X-Gm-Message-State: APjAAAWY4vPc2Z/zPKPJvylJeyiIxl2NT3yFdjoSB+9giC7bl6YMBJgu
 O4EOC67xY6Opk5FxwWlF8mP0ThVI+6A5YP0f4v0=
X-Google-Smtp-Source: APXvYqwa3u7CulSqgDPgTl4Q8/L72nYmTqC9mVf9TuxwZLMdpclVr/T2+5v66eiFswCKmlEW7n5BkPo5h+vGCG8W58M=
X-Received: by 2002:aca:62d5:: with SMTP id
 w204mr13072586oib.136.1571514698419; 
 Sat, 19 Oct 2019 12:51:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 12:51:38
 -0700 (PDT)
In-Reply-To: <1571311659-15556-2-git-send-email-stefan.brankovic@rt-rk.com>
References: <1571311659-15556-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1571311659-15556-2-git-send-email-stefan.brankovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 21:51:38 +0200
Message-ID: <CAL1e-=iMZkReMxz9GrXZ7YJVRfO5u2ibP7ryA4j_kybCL+SYhA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] target/ppc: Optimize emulation of vclzh and vclzb
 instructions
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="0000000000005bd4ba059548c7aa"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005bd4ba059548c7aa
Content-Type: text/plain; charset="UTF-8"

On Thursday, October 17, 2019, Stefan Brankovic <stefan.brankovic@rt-rk.com>
wrote:

> Optimize Altivec instruction vclzh (Vector Count Leading Zeros Halfword).
> This instruction counts the number of leading zeros of each halfword
> element
> in source register and places result in the appropriate halfword element of
> destination register.
>
> In each iteration of outer for loop count operation is performed on one
> doubleword element of source register vB. In the first iteration, higher
> doubleword element of vB is placed in variable avr, and then counting
> for every halfword element is performed by  using tcg_gen_clzi_i64.
> Since it counts leading zeros on 64 bit lenght, ith byte element has to
> be moved to the highest 16 bits of tmp, or-ed with mask(in order to get all
> ones in lowest 48 bits), then perform tcg_gen_clzi_i64 and move it's result
> in appropriate halfword element of result. This is done in inner for loop.
> After the operation is finished, the result is saved in the appropriate
> doubleword element of destination register vD. The same sequence of orders
> is to be applied again for the  lower doubleword element of vB.
>
> Optimize Altivec instruction vclzb (Vector Count Leading Zeros Byte).
> This instruction counts the number of leading zeros of each byte element
> in source register and places result in the appropriate byte element of
> destination register.
>
> In each iteration of the outer for loop, counting operation is done on one
> doubleword element of source register vB. In the first iteration, the
> higher doubleword element of vB is placed in variable avr, and then
> counting
> for every byte element is performed using tcg_gen_clzi_i64. Since it counts
> leading zeros on 64 bit lenght, ith byte element has to be moved to the
> highest
> 8 bits of variable  tmp, ored with mask(in order to get all ones in the
> lowest
> 56 bits), then perform tcg_gen_clzi_i64 and move it's result in the
> appropriate
> byte element of result. This is done in inner for loop. After the
> operation is
> finished, the result is saved in the  appropriate doubleword element of
> destination
> register vD. The same sequence of orders is to be applied again for the
> lower
> doubleword element of vB.
>
>
The same hints as for the commit message of patch 2/3.

Additionally, the first and the third paragraph should be merged into a
single one at the beggining of the commit message


Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/helper.h                 |   2 -
>  target/ppc/int_helper.c             |   9 ---
>  target/ppc/translate/vmx-impl.inc.c | 136 ++++++++++++++++++++++++++++++
> +++++-
>  3 files changed, 134 insertions(+), 13 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index f843814..281e54f 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -308,8 +308,6 @@ DEF_HELPER_4(vcfsx, void, env, avr, avr, i32)
>  DEF_HELPER_4(vctuxs, void, env, avr, avr, i32)
>  DEF_HELPER_4(vctsxs, void, env, avr, avr, i32)
>
> -DEF_HELPER_2(vclzb, void, avr, avr)
> -DEF_HELPER_2(vclzh, void, avr, avr)
>  DEF_HELPER_2(vctzb, void, avr, avr)
>  DEF_HELPER_2(vctzh, void, avr, avr)
>  DEF_HELPER_2(vctzw, void, avr, avr)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 6d238b9..cd00f5e 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1817,15 +1817,6 @@ VUPK(lsw, s64, s32, UPKLO)
>          }                                                               \
>      }
>
> -#define clzb(v) ((v) ? clz32((uint32_t)(v) << 24) : 8)
> -#define clzh(v) ((v) ? clz32((uint32_t)(v) << 16) : 16)
> -
> -VGENERIC_DO(clzb, u8)
> -VGENERIC_DO(clzh, u16)
> -
> -#undef clzb
> -#undef clzh
> -
>  #define ctzb(v) ((v) ? ctz32(v) : 8)
>  #define ctzh(v) ((v) ? ctz32(v) : 16)
>  #define ctzw(v) ctz32((v))
> diff --git a/target/ppc/translate/vmx-impl.inc.c
> b/target/ppc/translate/vmx-impl.inc.c
> index 2472a52..a428ef3 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -751,6 +751,138 @@ static void trans_vgbbd(DisasContext *ctx)
>  }
>
>  /*
> + * vclzb VRT,VRB - Vector Count Leading Zeros Byte
> + *
> + * Counting the number of leading zero bits of each byte element in source
> + * register and placing result in appropriate byte element of destination
> + * register.
> + */
> +static void trans_vclzb(DisasContext *ctx)
> +{
> +    int VT = rD(ctx->opcode);
> +    int VB = rB(ctx->opcode);
> +    TCGv_i64 avr = tcg_temp_new_i64();
> +    TCGv_i64 result = tcg_temp_new_i64();
> +    TCGv_i64 result1 = tcg_temp_new_i64();
> +    TCGv_i64 result2 = tcg_temp_new_i64();
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +    TCGv_i64 mask = tcg_const_i64(0xffffffffffffffULL);
> +    int i, j;
> +
> +    for (i = 0; i < 2; i++) {
> +        if (i == 0) {
> +            /* Get high doubleword of vB in 'avr'. */
> +            get_avr64(avr, VB, true);
> +        } else {
> +            /* Get low doubleword of vB in 'avr'. */
> +            get_avr64(avr, VB, false);
> +        }
> +        /*
> +         * Perform count for every byte element using 'tcg_gen_clzi_i64'.
> +         * Since it counts leading zeros on 64 bit lenght, we have to move
> +         * ith byte element to highest 8 bits of 'tmp', or it with
> mask(so we
> +         * get all ones in lowest 56 bits), then perform
> 'tcg_gen_clzi_i64' and
> +         * move it's result in appropriate byte element of result.
> +         */
> +        tcg_gen_shli_i64(tmp, avr, 56);


before this line, insert a blank line and the comment: /* count leading
zeroes for bits 0..8 */


> +        tcg_gen_or_i64(tmp, tmp, mask);
> +        tcg_gen_clzi_i64(result, tmp, 64);
> +        for (j = 1; j < 7; j++) {
> +            tcg_gen_shli_i64(tmp, avr, (7 - j) * 8);


before this line, insert comment: /* count leading zeroes for bits
8*j..8*j+7  */


> +            tcg_gen_or_i64(tmp, tmp, mask);
> +            tcg_gen_clzi_i64(tmp, tmp, 64);
> +            tcg_gen_deposit_i64(result, result, tmp, j * 8, 8);
> +        }
> +        tcg_gen_or_i64(tmp, avr, mask);


before this line, insert comment: /* count leading zeroes for bits 56..63
 */


> +        tcg_gen_clzi_i64(tmp, tmp, 64);
> +        tcg_gen_deposit_i64(result, result, tmp, 56, 8);

+        if (i == 0) {
> +            /* Place result in high doubleword element of vD. */
> +            tcg_gen_mov_i64(result1, result);
> +        } else {
> +            /* Place result in low doubleword element of vD. */
> +            tcg_gen_mov_i64(result2, result);
> +        }
> +    }
> +
> +    set_avr64(VT, result1, true);
> +    set_avr64(VT, result2, false);
> +
> +    tcg_temp_free_i64(avr);
> +    tcg_temp_free_i64(result);
> +    tcg_temp_free_i64(result1);
> +    tcg_temp_free_i64(result2);
> +    tcg_temp_free_i64(tmp);
> +    tcg_temp_free_i64(mask);
> +}
> +
> +/*
> + * vclzh VRT,VRB - Vector Count Leading Zeros Halfword


Similar hints as in the case of the previous function.


> + *
> + * Counting the number of leading zero bits of each halfword element in
> source
> + * register and placing result in appropriate halfword element of
> destination
> + * register.
> + */
> +static void trans_vclzh(DisasContext *ctx)
> +{
> +    int VT = rD(ctx->opcode);
> +    int VB = rB(ctx->opcode);
> +    TCGv_i64 avr = tcg_temp_new_i64();
> +    TCGv_i64 result = tcg_temp_new_i64();
> +    TCGv_i64 result1 = tcg_temp_new_i64();
> +    TCGv_i64 result2 = tcg_temp_new_i64();
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +    TCGv_i64 mask = tcg_const_i64(0xffffffffffffULL);
> +    int i, j;
> +
> +    for (i = 0; i < 2; i++) {
> +        if (i == 0) {
> +            /* Get high doubleword element of vB in 'avr'. */
> +            get_avr64(avr, VB, true);
> +        } else {
> +            /* Get low doubleword element of vB in 'avr'. */
> +            get_avr64(avr, VB, false);
> +        }
> +        /*
> +         * Perform count for every halfword element using
> 'tcg_gen_clzi_i64'.
> +         * Since it counts leading zeros on 64 bit lenght, we have to move
> +         * ith byte element to highest 16 bits of 'tmp', or it with
> mask(so we
> +         * get all ones in lowest 48 bits), then perform
> 'tcg_gen_clzi_i64' and
> +         * move it's result in appropriate halfword element of result.
> +         */
> +        tcg_gen_shli_i64(tmp, avr, 48);
> +        tcg_gen_or_i64(tmp, tmp, mask);
> +        tcg_gen_clzi_i64(result, tmp, 64);
> +        for (j = 1; j < 3; j++) {
> +            tcg_gen_shli_i64(tmp, avr, (3 - j) * 16);
> +            tcg_gen_or_i64(tmp, tmp, mask);
> +            tcg_gen_clzi_i64(tmp, tmp, 64);
> +            tcg_gen_deposit_i64(result, result, tmp, j * 16, 16);
> +        }
> +        tcg_gen_or_i64(tmp, avr, mask);
> +        tcg_gen_clzi_i64(tmp, tmp, 64);
> +        tcg_gen_deposit_i64(result, result, tmp, 48, 16);
> +        if (i == 0) {
> +            /* Place result in high doubleword element of vD. */
> +            tcg_gen_mov_i64(result1, result);
> +        } else {
> +            /* Place result in low doubleword element of vD. */
> +            tcg_gen_mov_i64(result2, result);
> +        }
> +    }
> +
> +    set_avr64(VT, result1, true);
> +    set_avr64(VT, result2, false);
> +
> +    tcg_temp_free_i64(avr);
> +    tcg_temp_free_i64(result);
> +    tcg_temp_free_i64(result1);
> +    tcg_temp_free_i64(result2);
> +    tcg_temp_free_i64(tmp);
> +    tcg_temp_free_i64(mask);
> +}
> +
> +/*
>   * vclzw VRT,VRB - Vector Count Leading Zeros Word
>   *
>   * Counting the number of leading zero bits of each word element in source
> @@ -1315,8 +1447,8 @@ GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20)
>  GEN_VAFORM_PAIRED(vsel, vperm, 21)
>  GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23)
>
> -GEN_VXFORM_NOA(vclzb, 1, 28)
> -GEN_VXFORM_NOA(vclzh, 1, 29)
> +GEN_VXFORM_TRANS(vclzb, 1, 28)
> +GEN_VXFORM_TRANS(vclzh, 1, 29)
>  GEN_VXFORM_TRANS(vclzw, 1, 30)
>  GEN_VXFORM_TRANS(vclzd, 1, 31)
>  GEN_VXFORM_NOA_2(vnegw, 1, 24, 6)
> --
> 2.7.4
>
>
>

--0000000000005bd4ba059548c7aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, October 17, 2019, Stefan Brankovic &lt;<a href=3D"mail=
to:stefan.brankovic@rt-rk.com">stefan.brankovic@rt-rk.com</a>&gt; wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Optimize Altivec instruction vclzh (Vector =
Count Leading Zeros Halfword).<br>
This instruction counts the number of leading zeros of each halfword elemen=
t<br>
in source register and places result in the appropriate halfword element of=
<br>
destination register.<br>
<br>
In each iteration of outer for loop count operation is performed on one<br>
doubleword element of source register vB. In the first iteration, higher<br=
>
doubleword element of vB is placed in variable avr, and then counting<br>
for every halfword element is performed by=C2=A0 using tcg_gen_clzi_i64.<br=
>
Since it counts leading zeros on 64 bit lenght, ith byte element has to<br>
be moved to the highest 16 bits of tmp, or-ed with mask(in order to get all=
<br>
ones in lowest 48 bits), then perform tcg_gen_clzi_i64 and move it&#39;s re=
sult<br>
in appropriate halfword element of result. This is done in inner for loop.<=
br>
After the operation is finished, the result is saved in the appropriate<br>
doubleword element of destination register vD. The same sequence of orders<=
br>
is to be applied again for the=C2=A0 lower doubleword element of vB.<br>
<br>
Optimize Altivec instruction vclzb (Vector Count Leading Zeros Byte).<br>
This instruction counts the number of leading zeros of each byte element<br=
>
in source register and places result in the appropriate byte element of<br>
destination register.<br>
<br>
In each iteration of the outer for loop, counting operation is done on one<=
br>
doubleword element of source register vB. In the first iteration, the<br>
higher doubleword element of vB is placed in variable avr, and then countin=
g<br>
for every byte element is performed using tcg_gen_clzi_i64. Since it counts=
<br>
leading zeros on 64 bit lenght, ith byte element has to be moved to the hig=
hest<br>
8 bits of variable=C2=A0 tmp, ored with mask(in order to get all ones in th=
e lowest<br>
56 bits), then perform tcg_gen_clzi_i64 and move it&#39;s result in the app=
ropriate<br>
byte element of result. This is done in inner for loop. After the operation=
 is<br>
finished, the result is saved in the=C2=A0 appropriate doubleword element o=
f destination<br>
register vD. The same sequence of orders is to be applied again for the low=
er<br>
doubleword element of vB.<br>
<br></blockquote><div><br></div><div>The same hints as for the commit messa=
ge of patch 2/3.</div><div><br></div><div>Additionally, the first and the t=
hird paragraph should be merged into a single one at the beggining of the c=
ommit message=C2=A0</div><div><br></div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
Signed-off-by: Stefan Brankovic &lt;<a href=3D"mailto:stefan.brankovic@rt-r=
k.com">stefan.brankovic@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0target/ppc/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 -<br>
=C2=A0target/ppc/int_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A09 ---<br>
=C2=A0target/ppc/translate/vmx-impl.<wbr>inc.c | 136 ++++++++++++++++++++++=
++++++++<wbr>+++++-<br>
=C2=A03 files changed, 134 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/target/ppc/helper.h b/target/ppc/helper.h<br>
index f843814..281e54f 100644<br>
--- a/target/ppc/helper.h<br>
+++ b/target/ppc/helper.h<br>
@@ -308,8 +308,6 @@ DEF_HELPER_4(vcfsx, void, env, avr, avr, i32)<br>
=C2=A0DEF_HELPER_4(vctuxs, void, env, avr, avr, i32)<br>
=C2=A0DEF_HELPER_4(vctsxs, void, env, avr, avr, i32)<br>
<br>
-DEF_HELPER_2(vclzb, void, avr, avr)<br>
-DEF_HELPER_2(vclzh, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vctzb, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vctzh, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vctzw, void, avr, avr)<br>
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c<br>
index 6d238b9..cd00f5e 100644<br>
--- a/target/ppc/int_helper.c<br>
+++ b/target/ppc/int_helper.c<br>
@@ -1817,15 +1817,6 @@ VUPK(lsw, s64, s32, UPKLO)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-#define clzb(v) ((v) ? clz32((uint32_t)(v) &lt;&lt; 24) : 8)<br>
-#define clzh(v) ((v) ? clz32((uint32_t)(v) &lt;&lt; 16) : 16)<br>
-<br>
-VGENERIC_DO(clzb, u8)<br>
-VGENERIC_DO(clzh, u16)<br>
-<br>
-#undef clzb<br>
-#undef clzh<br>
-<br>
=C2=A0#define ctzb(v) ((v) ? ctz32(v) : 8)<br>
=C2=A0#define ctzh(v) ((v) ? ctz32(v) : 16)<br>
=C2=A0#define ctzw(v) ctz32((v))<br>
diff --git a/target/ppc/translate/vmx-<wbr>impl.inc.c b/target/ppc/translat=
e/vmx-<wbr>impl.inc.c<br>
index 2472a52..a428ef3 100644<br>
--- a/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
+++ b/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
@@ -751,6 +751,138 @@ static void trans_vgbbd(DisasContext *ctx)<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
+ * vclzb VRT,VRB - Vector Count Leading Zeros Byte<br>
+ *<br>
+ * Counting the number of leading zero bits of each byte element in source=
<br>
+ * register and placing result in appropriate byte element of destination<=
br>
+ * register.<br>
+ */<br>
+static void trans_vclzb(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 int VT =3D rD(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 int VB =3D rB(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 TCGv_i64 avr =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result1 =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result2 =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 tmp =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 mask =3D tcg_const_i64(<wbr>0xffffffffffffffULL);<b=
r>
+=C2=A0 =C2=A0 int i, j;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 2; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get high doubleword of vB in =
&#39;avr&#39;. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get low doubleword of vB in &=
#39;avr&#39;. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Perform count for every byte element u=
sing &#39;tcg_gen_clzi_i64&#39;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Since it counts leading zeros on 64 bi=
t lenght, we have to move<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ith byte element to highest 8 bits of =
&#39;tmp&#39;, or it with mask(so we<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* get all ones in lowest 56 bits), then =
perform &#39;tcg_gen_clzi_i64&#39; and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* move it&#39;s result in appropriate by=
te element of result.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, avr, 56);</blockquote><d=
iv><br></div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-he=
ight:22.1200008392334px">before this line, insert a blank line and the comm=
ent: /* count leading zeroes for bits 0..8 */</span></div><div>=C2=A0=C2=A0=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, tmp, mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_clzi_i64(result, tmp, 64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 1; j &lt; 7; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, avr, (7 - =
j) * 8);</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34)=
;font-size:14px;line-height:22.1200008392334px">before this line, insert co=
mment: /* count leading zeroes for bits 8*j..8*j+7 =C2=A0*/</span></div><di=
v>=C2=A0=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, tmp, mask);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_clzi_i64(tmp, tmp, 64);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(result, resu=
lt, tmp, j * 8, 8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, avr, mask);</blockquote><d=
iv><br></div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-he=
ight:22.1200008392334px">before this line, insert comment: /* count leading=
 zeroes for bits 56..63 =C2=A0*/</span></div><div>=C2=A0<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_clzi_i64(tmp, tmp, 64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(result, result, tmp, 56, 8=
);</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Place result in high doublewo=
rd element of vD. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result1, result)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Place result in low doublewor=
d element of vD. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result2, result)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 set_avr64(VT, result1, true);<br>
+=C2=A0 =C2=A0 set_avr64(VT, result2, false);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(avr);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result2);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(tmp);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(mask);<br>
+}<br>
+<br>
+/*<br>
+ * vclzh VRT,VRB - Vector Count Leading Zeros Halfword</blockquote><div><b=
r></div><div>Similar hints as in the case of the previous function.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
+ *<br>
+ * Counting the number of leading zero bits of each halfword element in so=
urce<br>
+ * register and placing result in appropriate halfword element of destinat=
ion<br>
+ * register.<br>
+ */<br>
+static void trans_vclzh(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 int VT =3D rD(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 int VB =3D rB(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 TCGv_i64 avr =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result1 =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result2 =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 tmp =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 mask =3D tcg_const_i64(<wbr>0xffffffffffffULL);<br>
+=C2=A0 =C2=A0 int i, j;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 2; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get high doubleword element o=
f vB in &#39;avr&#39;. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get low doubleword element of=
 vB in &#39;avr&#39;. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Perform count for every halfword eleme=
nt using &#39;tcg_gen_clzi_i64&#39;.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Since it counts leading zeros on 64 bi=
t lenght, we have to move<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ith byte element to highest 16 bits of=
 &#39;tmp&#39;, or it with mask(so we<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* get all ones in lowest 48 bits), then =
perform &#39;tcg_gen_clzi_i64&#39; and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* move it&#39;s result in appropriate ha=
lfword element of result.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, avr, 48);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, tmp, mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_clzi_i64(result, tmp, 64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 1; j &lt; 3; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, avr, (3 - =
j) * 16);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, tmp, mask);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_clzi_i64(tmp, tmp, 64);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(result, resu=
lt, tmp, j * 16, 16);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, avr, mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_clzi_i64(tmp, tmp, 64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_i64(result, result, tmp, 48, 1=
6);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Place result in high doublewo=
rd element of vD. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result1, result)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Place result in low doublewor=
d element of vD. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result2, result)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 set_avr64(VT, result1, true);<br>
+=C2=A0 =C2=A0 set_avr64(VT, result2, false);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(avr);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result2);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(tmp);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(mask);<br>
+}<br>
+<br>
+/*<br>
=C2=A0 * vclzw VRT,VRB - Vector Count Leading Zeros Word<br>
=C2=A0 *<br>
=C2=A0 * Counting the number of leading zero bits of each word element in s=
ource<br>
@@ -1315,8 +1447,8 @@ GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20)<br>
=C2=A0GEN_VAFORM_PAIRED(vsel, vperm, 21)<br>
=C2=A0GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23)<br>
<br>
-GEN_VXFORM_NOA(vclzb, 1, 28)<br>
-GEN_VXFORM_NOA(vclzh, 1, 29)<br>
+GEN_VXFORM_TRANS(vclzb, 1, 28)<br>
+GEN_VXFORM_TRANS(vclzh, 1, 29)<br>
=C2=A0GEN_VXFORM_TRANS(vclzw, 1, 30)<br>
=C2=A0GEN_VXFORM_TRANS(vclzd, 1, 31)<br>
=C2=A0GEN_VXFORM_NOA_2(vnegw, 1, 24, 6)<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--0000000000005bd4ba059548c7aa--

