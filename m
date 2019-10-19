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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DFECA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 19:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1F4222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 19:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsbnmSJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1F4222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLucK-0005Uh-R9
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 15:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLubK-000549-T5
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLubI-0000Zd-Od
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:41:22 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLubI-0000ZF-G6
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:41:20 -0400
Received: by mail-ot1-x342.google.com with SMTP id c10so7794964otd.9
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=JoXbuRtJMuh9bzaaCAfaXGIC5I4Cr8tB63KIZkkOi8c=;
 b=SsbnmSJvzPqOOCNt5V6k6LUIhQr15aF+f56Hgbm1QMpUX75nBpRX8wFH8RWhFHReZl
 rYfZhA1x3MnhjKykyHS2H3A7UTAGJSSb1XTbip5CBrygK3bmk0NFpQMFRIEsK4GXkpFB
 5Ak4dY1p1IPmerxUcSjkiH+gs9R26NCxb7DtqoHKTc9nrsjONNPkkSAgw0YDIePN3Sd9
 ND5R/noKqhXak2fbP/Xk0ANAod/cMd6v7b6Y1/FiNIHbRB8ojqajfG/m0+pXYcQqxK4l
 N6cbTRMKwIVKUgOsZQzhNleeiWNUwpJbgCk8bj+lqyRkBu0h8Md+w26Bi42thUOjc4WS
 LTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=JoXbuRtJMuh9bzaaCAfaXGIC5I4Cr8tB63KIZkkOi8c=;
 b=Tu3gV5RnqlaosZ9Q95ZY19e+C7xfjfUNmgWmMqXSzMn4mhMTtkG/NozNpGWw+40M4u
 6JMPHa0BgEUfkmXS731q0c4G5qN07e8sGBgBlSDFD8gisOK1Az0d6IpjcLRcOIHyzjy+
 FN3tmPu8ebrwvC7UhQJfTSx6gWXy8HNoc06KzrHRGeP2VM8EQIfdP17RlVUtVuEqWRsI
 s3tLx+tkiK0/hrt3ALauOq+xOn3utGSFYvoE7WT4MXdJXQBjGkSMNfllo/azT1flH+p1
 lK30T7kwPL77wHz7xLlKIK1kjIN+U+I1ta7RGAFjWQqOCOwd3gD8GzRi73tC9WxEvEL2
 KT1w==
X-Gm-Message-State: APjAAAV/9zrxYYKW3zagHJ+5MtiilpYSYl3KO/Cxb606zAdlwBMioIiL
 tGqotgk6CcWkt49nQiS6IyFDC817nXfchDGU5tQ=
X-Google-Smtp-Source: APXvYqyUjTsG0W9S4wQnOrKdYZWClT0ePp9FKj6UQ50jYsplY5aORDjVbDhTPsjoY9/jIhTFTtalWln8crJOeAZ/gpc=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr12515237oth.306.1571513741680; 
 Sat, 19 Oct 2019 12:35:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 12:35:41
 -0700 (PDT)
In-Reply-To: <1571311659-15556-3-git-send-email-stefan.brankovic@rt-rk.com>
References: <1571311659-15556-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1571311659-15556-3-git-send-email-stefan.brankovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 21:35:41 +0200
Message-ID: <CAL1e-=iZAxe3em_HOjhSVNSs_p8tP9X05Y4peteSai1yQFeVqA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] target/ppc: Optimize emulation of vpkpx instruction
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="0000000000005522530595488eba"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

--0000000000005522530595488eba
Content-Type: text/plain; charset="UTF-8"

On Thursday, October 17, 2019, Stefan Brankovic <stefan.brankovic@rt-rk.com>
wrote:

> Optimize altivec instruction vpkpx (Vector Pack Pixel).
> Rearranges 8 pixels coded in 6-5-5 pattern (4 from each source register)
> into contigous array of bits in the destination register.
>
> In each iteration of outer loop, the instruction is to be done with
> the 6-5-5 pack for 2 pixels of each doubleword element of each
> source register. The first thing to be done in outer loop is
> choosing which doubleword element of which register is to be used
> in current iteration and it is to be placed in avr variable. The
> next step is to perform 6-5-5 pack of pixels on avr variable in inner
> for loop(2 iterations, 1 for each pixel) and save result in tmp variable.
> In the end of outer for loop, the result is merged in variable called
> result and saved in appropriate doubleword element of vD if the whole
> doubleword is finished(every second iteration). The outer loop has 4
> iterations.
>
>
Check spelling.

Use single quotation marks around variavle names and other code elements.

avr variable-> variable 'avr' (and several similar instances)


> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/helper.h                 |  1 -
>  target/ppc/int_helper.c             | 21 --------
>  target/ppc/translate/vmx-impl.inc.c | 99 ++++++++++++++++++++++++++++++
> ++++++-
>  3 files changed, 98 insertions(+), 23 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 281e54f..b489b38 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -258,7 +258,6 @@ DEF_HELPER_4(vpkudus, void, env, avr, avr, avr)
>  DEF_HELPER_4(vpkuhum, void, env, avr, avr, avr)
>  DEF_HELPER_4(vpkuwum, void, env, avr, avr, avr)
>  DEF_HELPER_4(vpkudum, void, env, avr, avr, avr)
> -DEF_HELPER_3(vpkpx, void, avr, avr, avr)
>  DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index cd00f5e..f910c11 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1262,27 +1262,6 @@ void helper_vpmsumd(ppc_avr_t *r, ppc_avr_t *a,
> ppc_avr_t *b)
>  #else
>  #define PKBIG 0
>  #endif
> -void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
> -{
> -    int i, j;
> -    ppc_avr_t result;
> -#if defined(HOST_WORDS_BIGENDIAN)
> -    const ppc_avr_t *x[2] = { a, b };
> -#else
> -    const ppc_avr_t *x[2] = { b, a };
> -#endif
> -
> -    VECTOR_FOR_INORDER_I(i, u64) {
> -        VECTOR_FOR_INORDER_I(j, u32) {
> -            uint32_t e = x[i]->u32[j];
> -
> -            result.u16[4 * i + j] = (((e >> 9) & 0xfc00) |
> -                                     ((e >> 6) & 0x3e0) |
> -                                     ((e >> 3) & 0x1f));
> -        }
> -    }
> -    *r = result;
> -}
>
>  #define VPK(suffix, from, to, cvt, dosat)                               \
>      void helper_vpk##suffix(CPUPPCState *env, ppc_avr_t *r,             \
> diff --git a/target/ppc/translate/vmx-impl.inc.c
> b/target/ppc/translate/vmx-impl.inc.c
> index a428ef3..3550ffa 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -579,6 +579,103 @@ static void trans_lvsr(DisasContext *ctx)
>  }
>
>  /*
> + * vpkpx VRT,VRA,VRB - Vector Pack Pixel
> + *
> + * Rearranges 8 pixels coded in 6-5-5 pattern (4 from each source
> register)
> + * into contigous array of bits in the destination register.
> + */
> +static void trans_vpkpx(DisasContext *ctx)
> +{
> +    int VT = rD(ctx->opcode);
> +    int VA = rA(ctx->opcode);
> +    int VB = rB(ctx->opcode);
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +    TCGv_i64 shifted = tcg_temp_new_i64();
> +    TCGv_i64 avr = tcg_temp_new_i64();
> +    TCGv_i64 result = tcg_temp_new_i64();
> +    TCGv_i64 result1 = tcg_temp_new_i64();
> +    TCGv_i64 result2 = tcg_temp_new_i64();


'result2' is not needed, 'result' can be used in the final half instead all
the way up to the coping to the destination.


> +    int64_t mask1 = 0x1fULL;
> +    int64_t mask2 = 0x1fULL << 5;
> +    int64_t mask3 = 0x3fULL << 10;
> +    int i, j;
> +    /*
> +     * In each iteration do the 6-5-5 pack for 2 pixels of each doubleword
> +     * element of each source register.
> +     */
> +    for (i = 0; i < 4; i++) {
> +        switch (i) {
> +        case 0:
> +            /*
> +             * Get high doubleword of vA to perform 6-5-5 pack of pixels
> +             * 1 and 2.
> +             */
> +            get_avr64(avr, VA, true);
> +            tcg_gen_movi_i64(result, 0x0ULL);
> +            break;
> +        case 1:
> +            /*
> +             * Get low doubleword of vA to perform 6-5-5 pack of pixels
> +             * 3 and 4.
> +             */
> +            get_avr64(avr, VA, false);
> +            break;
> +        case 2:
> +            /*
> +             * Get high doubleword of vB to perform 6-5-5 pack of pixels
> +             * 5 and 6.
> +             */
> +            get_avr64(avr, VB, true);
> +            tcg_gen_movi_i64(result, 0x0ULL);
> +            break;
> +        case 3:
> +            /*
> +             * Get low doubleword of vB to perform 6-5-5 pack of pixels
> +             * 7 and 8.
> +             */
> +            get_avr64(avr, VB, false);
> +            break;
> +        }
> +        /* Perform the packing for 2 pixels(each iteration for 1). */
> +        tcg_gen_movi_i64(tmp, 0x0ULL);
> +        for (j = 0; j < 2; j++) {
> +            tcg_gen_shri_i64(shifted, avr, (j * 16 + 3));
> +            tcg_gen_andi_i64(shifted, shifted, mask1 << (j * 16));
> +            tcg_gen_or_i64(tmp, tmp, shifted);
> +
> +            tcg_gen_shri_i64(shifted, avr, (j * 16 + 6));
> +            tcg_gen_andi_i64(shifted, shifted, mask2 << (j * 16));
> +            tcg_gen_or_i64(tmp, tmp, shifted);
> +
> +            tcg_gen_shri_i64(shifted, avr, (j * 16 + 9));
> +            tcg_gen_andi_i64(shifted, shifted, mask3 << (j * 16));
> +            tcg_gen_or_i64(tmp, tmp, shifted);
> +        }
> +        if ((i == 0) || (i == 2)) {
> +            tcg_gen_shli_i64(tmp, tmp, 32);
> +        }
> +        tcg_gen_or_i64(result, result, tmp);
> +        if (i == 1) {
> +            /* Place packed pixels 1:4 to high doubleword of vD. */
> +            tcg_gen_mov_i64(result1, result);
> +        }
> +        if (i == 3) {
> +            /* Place packed pixels 5:8 to low doubleword of vD. */
> +            tcg_gen_mov_i64(result2, result);
> +        }


If 'result2' is removed, the last tcg movement is not needed...


> +    }
> +    set_avr64(VT, result1, true);
> +    set_avr64(VT, result2, false);


... and here 'result' should be instead of  'result2'.

A.


    +

> +    tcg_temp_free_i64(tmp);
> +    tcg_temp_free_i64(shifted);
> +    tcg_temp_free_i64(avr);
> +    tcg_temp_free_i64(result);
> +    tcg_temp_free_i64(result1);
> +    tcg_temp_free_i64(result2);
> +}
> +
> +/*
>   * vsl VRT,VRA,VRB - Vector Shift Left
>   *
>   * Shifting left 128 bit value of vA by value specified in bits 125-127
> of vB.
> @@ -1063,7 +1160,7 @@ GEN_VXFORM_ENV(vpksdus, 7, 21);
>  GEN_VXFORM_ENV(vpkshss, 7, 6);
>  GEN_VXFORM_ENV(vpkswss, 7, 7);
>  GEN_VXFORM_ENV(vpksdss, 7, 23);
> -GEN_VXFORM(vpkpx, 7, 12);
> +GEN_VXFORM_TRANS(vpkpx, 7, 12);
>  GEN_VXFORM_ENV(vsum4ubs, 4, 24);
>  GEN_VXFORM_ENV(vsum4sbs, 4, 28);
>  GEN_VXFORM_ENV(vsum4shs, 4, 25);
> --
> 2.7.4
>
>
>

--0000000000005522530595488eba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, October 17, 2019, Stefan Brankovic &lt;<a href=3D"mail=
to:stefan.brankovic@rt-rk.com">stefan.brankovic@rt-rk.com</a>&gt; wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Optimize altivec instruction vpkpx (Vector =
Pack Pixel).<br>
Rearranges 8 pixels coded in 6-5-5 pattern (4 from each source register)<br=
>
into contigous array of bits in the destination register.<br>
<br>
In each iteration of outer loop, the instruction is to be done with<br>
the 6-5-5 pack for 2 pixels of each doubleword element of each<br>
source register. The first thing to be done in outer loop is<br>
choosing which doubleword element of which register is to be used<br>
in current iteration and it is to be placed in avr variable. The<br>
next step is to perform 6-5-5 pack of pixels on avr variable in inner<br>
for loop(2 iterations, 1 for each pixel) and save result in tmp variable.<b=
r>
In the end of outer for loop, the result is merged in variable called<br>
result and saved in appropriate doubleword element of vD if the whole<br>
doubleword is finished(every second iteration). The outer loop has 4<br>
iterations.<br>
<br></blockquote><div><br></div><div>Check spelling.</div><div><br></div><d=
iv>Use single quotation marks around variavle names and other code elements=
.</div><div><br></div><div>avr variable-&gt; variable &#39;avr&#39; (and se=
veral similar instances)</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
Signed-off-by: Stefan Brankovic &lt;<a href=3D"mailto:stefan.brankovic@rt-r=
k.com">stefan.brankovic@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0target/ppc/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0target/ppc/int_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 21 --------<br>
=C2=A0target/ppc/translate/vmx-impl.<wbr>inc.c | 99 +++++++++++++++++++++++=
+++++++<wbr>++++++-<br>
=C2=A03 files changed, 98 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/target/ppc/helper.h b/target/ppc/helper.h<br>
index 281e54f..b489b38 100644<br>
--- a/target/ppc/helper.h<br>
+++ b/target/ppc/helper.h<br>
@@ -258,7 +258,6 @@ DEF_HELPER_4(vpkudus, void, env, avr, avr, avr)<br>
=C2=A0DEF_HELPER_4(vpkuhum, void, env, avr, avr, avr)<br>
=C2=A0DEF_HELPER_4(vpkuwum, void, env, avr, avr, avr)<br>
=C2=A0DEF_HELPER_4(vpkudum, void, env, avr, avr, avr)<br>
-DEF_HELPER_3(vpkpx, void, avr, avr, avr)<br>
=C2=A0DEF_HELPER_5(vmhaddshs, void, env, avr, avr, avr, avr)<br>
=C2=A0DEF_HELPER_5(vmhraddshs, void, env, avr, avr, avr, avr)<br>
=C2=A0DEF_HELPER_5(vmsumuhm, void, env, avr, avr, avr, avr)<br>
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c<br>
index cd00f5e..f910c11 100644<br>
--- a/target/ppc/int_helper.c<br>
+++ b/target/ppc/int_helper.c<br>
@@ -1262,27 +1262,6 @@ void helper_vpmsumd(ppc_avr_t *r, ppc_avr_t *a, ppc_=
avr_t *b)<br>
=C2=A0#else<br>
=C2=A0#define PKBIG 0<br>
=C2=A0#endif<br>
-void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)<br>
-{<br>
-=C2=A0 =C2=A0 int i, j;<br>
-=C2=A0 =C2=A0 ppc_avr_t result;<br>
-#if defined(HOST_WORDS_BIGENDIAN)<br>
-=C2=A0 =C2=A0 const ppc_avr_t *x[2] =3D { a, b };<br>
-#else<br>
-=C2=A0 =C2=A0 const ppc_avr_t *x[2] =3D { b, a };<br>
-#endif<br>
-<br>
-=C2=A0 =C2=A0 VECTOR_FOR_INORDER_I(i, u64) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VECTOR_FOR_INORDER_I(j, u32) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t e =3D x[i]-&gt;u32[j];<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result.u16[4 * i + j] =3D (((e &=
gt;&gt; 9) &amp; 0xfc00) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((e &gt;&gt; 6) =
&amp; 0x3e0) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((e &gt;&gt; 3) =
&amp; 0x1f));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 *r =3D result;<br>
-}<br>
<br>
=C2=A0#define VPK(suffix, from, to, cvt, dosat)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0void helper_vpk##suffix(CPUPPCState *env, ppc_avr_t *r,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
diff --git a/target/ppc/translate/vmx-<wbr>impl.inc.c b/target/ppc/translat=
e/vmx-<wbr>impl.inc.c<br>
index a428ef3..3550ffa 100644<br>
--- a/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
+++ b/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
@@ -579,6 +579,103 @@ static void trans_lvsr(DisasContext *ctx)<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
+ * vpkpx VRT,VRA,VRB - Vector Pack Pixel<br>
+ *<br>
+ * Rearranges 8 pixels coded in 6-5-5 pattern (4 from each source register=
)<br>
+ * into contigous array of bits in the destination register.<br>
+ */<br>
+static void trans_vpkpx(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 int VT =3D rD(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 int VA =3D rA(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 int VB =3D rB(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 TCGv_i64 tmp =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 shifted =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 avr =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result1 =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result2 =3D tcg_temp_new_i64();</blockquote><div><b=
r></div><div>&#39;result2&#39; is not needed, &#39;result&#39; can be used =
in the final half instead all the way up to the coping to the destination.<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 int64_t mask1 =3D 0x1fULL;<br>
+=C2=A0 =C2=A0 int64_t mask2 =3D 0x1fULL &lt;&lt; 5;<br>
+=C2=A0 =C2=A0 int64_t mask3 =3D 0x3fULL &lt;&lt; 10;<br>
+=C2=A0 =C2=A0 int i, j;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* In each iteration do the 6-5-5 pack for 2 pixels of =
each doubleword<br>
+=C2=A0 =C2=A0 =C2=A0* element of each source register.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 4; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Get high doubleword of v=
A to perform 6-5-5 pack of pixels<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 1 and 2.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VA, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i64(result, 0x0ULL)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Get low doubleword of vA=
 to perform 6-5-5 pack of pixels<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 3 and 4.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VA, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Get high doubleword of v=
B to perform 6-5-5 pack of pixels<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 5 and 6.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i64(result, 0x0ULL)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Get low doubleword of vB=
 to perform 6-5-5 pack of pixels<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 7 and 8.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Perform the packing for 2 pixels(each itera=
tion for 1). */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i64(tmp, 0x0ULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; 2; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(shifted, avr, (=
j * 16 + 3));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(shifted, shifte=
d, mask1 &lt;&lt; (j * 16));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, tmp, shifted=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(shifted, avr, (=
j * 16 + 6));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(shifted, shifte=
d, mask2 &lt;&lt; (j * 16));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, tmp, shifted=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(shifted, avr, (=
j * 16 + 9));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(shifted, shifte=
d, mask3 &lt;&lt; (j * 16));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(tmp, tmp, shifted=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((i =3D=3D 0) || (i =3D=3D 2)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, tmp, 32);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, result, tmp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Place packed pixels 1:4 to hi=
gh doubleword of vD. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result1, result)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 3) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Place packed pixels 5:8 to lo=
w doubleword of vD. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result2, result)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</blockquote><div><br></div><div>If &#39;resu=
lt2&#39; is removed, the last tcg movement is not needed...</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 set_avr64(VT, result1, true);<br>
+=C2=A0 =C2=A0 set_avr64(VT, result2, false);</blockquote><div><br></div><d=
iv>... and here &#39;result&#39; should be instead of=C2=A0=C2=A0&#39;resul=
t2&#39;.</div><div><br></div><div>A.</div><div><br></div><div><br></div><di=
v>=C2=A0 =C2=A0 +</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 tcg_temp_free_i64(tmp);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(shifted);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(avr);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result2);<br>
+}<br>
+<br>
+/*<br>
=C2=A0 * vsl VRT,VRA,VRB - Vector Shift Left<br>
=C2=A0 *<br>
=C2=A0 * Shifting left 128 bit value of vA by value specified in bits 125-1=
27 of vB.<br>
@@ -1063,7 +1160,7 @@ GEN_VXFORM_ENV(vpksdus, 7, 21);<br>
=C2=A0GEN_VXFORM_ENV(vpkshss, 7, 6);<br>
=C2=A0GEN_VXFORM_ENV(vpkswss, 7, 7);<br>
=C2=A0GEN_VXFORM_ENV(vpksdss, 7, 23);<br>
-GEN_VXFORM(vpkpx, 7, 12);<br>
+GEN_VXFORM_TRANS(vpkpx, 7, 12);<br>
=C2=A0GEN_VXFORM_ENV(vsum4ubs, 4, 24);<br>
=C2=A0GEN_VXFORM_ENV(vsum4sbs, 4, 28);<br>
=C2=A0GEN_VXFORM_ENV(vsum4shs, 4, 25);<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--0000000000005522530595488eba--

