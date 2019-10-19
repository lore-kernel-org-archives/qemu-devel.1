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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF8CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 20:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5311721925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 20:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fivkVe4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5311721925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLv0t-0004jE-Ex
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 16:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLv0A-0004BL-20
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 16:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLv08-0000dF-2V
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 16:07:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLv07-0000cr-Pm
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 16:07:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id s22so7831906otr.6
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=6PNgNc9BqhUXvc5F1JVyaic3PRQ1/fFCTmbPpgIeRCQ=;
 b=fivkVe4nPrVY1ab6enqscODOzCpTgdLKg3KjzB5e5W2tIp80AdYCb5FDnG4MOsAHhr
 hpMbi+VnKxq/cHrhsYPGj3emdvIJvd2zYhKYWtcNoRKMToy/w40nebm1cJEbW5NzYaQ9
 YIvW+i0NCWjeY7zPBhMBz3CRyxuoMrXy82fUMNScxktgsf3LQdDtxjh4emAoxYm6XDiR
 giVMFnASYDZmdigkR9nmIRQfRuao0THwDZ6EO9Xd0ZukEeEFlO2/36qhRp+faP0j9jeQ
 /lfZcwJipzixl67olEIzqt2t6csAJfppib+MR86c2R8NeiAxYmhkRe26jfLyBw/9UVui
 qrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=6PNgNc9BqhUXvc5F1JVyaic3PRQ1/fFCTmbPpgIeRCQ=;
 b=ronq2NNInEk4f/YQ59wSHL6Jl7NPgIAIiNAaXLjblJ4QrnpJHRJuwESwLpvDExKNst
 UOSXSEKfjgwkOh1HcT9+CvkH85hsmtyUiWkSwkenv805ykInwMPcwk1yOuVg/EBWwUH5
 H8yJpGkKf/I3XhVsR0eiK/4DNWgEgIn/yNO3zh/1ms9kS0YhBJCyZVmnk9GESfWByaH8
 1m9Ora/mn4jYoJAkzhj1fvWEBqZ5d4Yt+5qarKbhk+7m+KhLJxLda+1b/QT4vU7TAXEf
 lEu4KqmF8v5sKftfF/q3xSfZHvbjvyTRs+uowMNsfaIb2ZxJgsV+8twJZ473WgkmC8KK
 Qy+Q==
X-Gm-Message-State: APjAAAU0rPWLSQ42gyqw1Zcpukix96c56AJpxTWszdD2RKZgaWnKdaKN
 pxg014HPuJwVxXJ05zAcdLZVZZVXZGcvwyMXAZU=
X-Google-Smtp-Source: APXvYqyO2NM3iBn8nKVWL++d1VFE47hrECHkyDYej2nRJR6JSMV2nfPkWoYt4i3Li2eFkSx8X9pL7EpupLgp1RUqrtg=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr12095151otl.64.1571515618998; 
 Sat, 19 Oct 2019 13:06:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 13:06:58
 -0700 (PDT)
In-Reply-To: <1571311659-15556-4-git-send-email-stefan.brankovic@rt-rk.com>
References: <1571311659-15556-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1571311659-15556-4-git-send-email-stefan.brankovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 22:06:58 +0200
Message-ID: <CAL1e-=g3DZqsjP=Crfe-RFFtpk8SC1GQPpTwQV0=V+1tfs=yXA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] target/ppc: Optimize emulation of vupkhpx and
 vupklpx instructions
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="0000000000003ac7ac059548fe77"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

--0000000000003ac7ac059548fe77
Content-Type: text/plain; charset="UTF-8"

On Thursday, October 17, 2019, Stefan Brankovic <stefan.brankovic@rt-rk.com>
wrote:

> 'trans_vupkpx' function implements both vupkhpx and vupklpx instructions
> with
> argument 'high' determine which instruction is processed. Instructions are
> implemented in two 'for' loops. Outer 'for' loop repeats unpacking two
> times,
> since both doubleword elements of destination register are formed the same
> way.
> It also stores result of every iteration in temporary register, that is
> later
> transferred to destination register. Inner 'for' loop does unpacking of
> pixels
> and forms resulting doubleword 32 by 32 bits.
>
> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/helper.h                 |  2 -
>  target/ppc/int_helper.c             | 20 --------
>  target/ppc/translate/vmx-impl.inc.c | 91 ++++++++++++++++++++++++++++++
> ++++++-
>  3 files changed, 89 insertions(+), 24 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index b489b38..fd06b56 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -233,8 +233,6 @@ DEF_HELPER_2(vextsh2d, void, avr, avr)
>  DEF_HELPER_2(vextsw2d, void, avr, avr)
>  DEF_HELPER_2(vnegw, void, avr, avr)
>  DEF_HELPER_2(vnegd, void, avr, avr)
> -DEF_HELPER_2(vupkhpx, void, avr, avr)
> -DEF_HELPER_2(vupklpx, void, avr, avr)
>  DEF_HELPER_2(vupkhsb, void, avr, avr)
>  DEF_HELPER_2(vupkhsh, void, avr, avr)
>  DEF_HELPER_2(vupkhsw, void, avr, avr)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index f910c11..9ee667d 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1737,26 +1737,6 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t
> *r, ppc_avr_t *a, ppc_avr_t *b)
>  #define UPKHI 0
>  #define UPKLO 1
>  #endif
> -#define VUPKPX(suffix, hi)                                              \
> -    void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)                \
> -    {                                                                   \
> -        int i;                                                          \
> -        ppc_avr_t result;                                               \
> -                                                                        \
> -        for (i = 0; i < ARRAY_SIZE(r->u32); i++) {                      \
> -            uint16_t e = b->u16[hi ? i : i + 4];                        \
> -            uint8_t a = (e >> 15) ? 0xff : 0;                           \
> -            uint8_t r = (e >> 10) & 0x1f;                               \
> -            uint8_t g = (e >> 5) & 0x1f;                                \
> -            uint8_t b = e & 0x1f;                                       \
> -                                                                        \
> -            result.u32[i] = (a << 24) | (r << 16) | (g << 8) | b;       \
> -        }                                                               \
> -        *r = result;                                                    \
> -    }
> -VUPKPX(lpx, UPKLO)
> -VUPKPX(hpx, UPKHI)
> -#undef VUPKPX
>
>  #define VUPK(suffix, unpacked, packee, hi)                              \
>      void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)                \
> diff --git a/target/ppc/translate/vmx-impl.inc.c
> b/target/ppc/translate/vmx-impl.inc.c
> index 3550ffa..09d80d6 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -1031,6 +1031,95 @@ static void trans_vclzd(DisasContext *ctx)
>      tcg_temp_free_i64(avr);
>  }
>
> +/*
> + * vupkhpx VRT,VRB - Vector Unpack High Pixel
> + * vupklpx VRT,VRB - Vector Unpack Low Pixel
> + *
> + * Unpacks 4 pixels coded in 1-5-5-5 pattern from high/low doubleword
> element
> + * of source register into contigous array of bits in the destination
> register.
> + * Argument 'high' determines if high or low doubleword element of source
> + * register is processed.
> + */
> +static void trans_vupkpx(DisasContext *ctx, int high)
> +{
> +    int VT = rD(ctx->opcode);
> +    int VB = rB(ctx->opcode);
> +    TCGv_i64 tmp = tcg_temp_new_i64();
> +    TCGv_i64 avr = tcg_temp_new_i64();
> +    TCGv_i64 result = tcg_temp_new_i64();
> +    TCGv_i64 result1 = tcg_temp_new_i64();
> +    TCGv_i64 result2 = tcg_temp_new_i64();
> +    int64_t mask1 = 0x1fULL;
> +    int64_t mask2 = 0x1fULL << 8;
> +    int64_t mask3 = 0x1fULL << 16;
> +    int64_t mask4 = 0xffULL << 56;
> +    int i, j;
> +
> +    if (high == 1) {
> +        get_avr64(avr, VB, true);
> +    } else {
> +        get_avr64(avr, VB, false);
> +    }
> +
> +    tcg_gen_movi_i64(result, 0x0ULL);
> +    for (i = 0; i < 2; i++) {
> +        for (j = 0; j < 2; j++) {
> +            tcg_gen_shli_i64(tmp, avr, (j * 16));
> +            tcg_gen_andi_i64(tmp, tmp, mask1 << (j * 32));
> +            tcg_gen_or_i64(result, result, tmp);
> +
> +            tcg_gen_shli_i64(tmp, avr, 3 + (j * 16));
> +            tcg_gen_andi_i64(tmp, tmp, mask2 << (j * 32));
> +            tcg_gen_or_i64(result, result, tmp);
> +
> +            tcg_gen_shli_i64(tmp, avr, 6 + (j * 16));
> +            tcg_gen_andi_i64(tmp, tmp, mask3 << (j * 32));
> +            tcg_gen_or_i64(result, result, tmp);
> +
> +            tcg_gen_shri_i64(tmp, avr, (j * 16));
> +            tcg_gen_ext16s_i64(tmp, tmp);
> +            tcg_gen_andi_i64(tmp, tmp, mask4);
> +            tcg_gen_shri_i64(tmp, tmp, (32 * (1 - j)));
> +            tcg_gen_or_i64(result, result, tmp);
> +        }
> +        if (i == 0) {
> +            tcg_gen_mov_i64(result1, result);
> +            tcg_gen_movi_i64(result, 0x0ULL);
> +            tcg_gen_shri_i64(avr, avr, 32);
> +        }
> +        if (i == 1) {
> +            tcg_gen_mov_i64(result2, result);
> +        }
> +    }
> +
> +    set_avr64(VT, result1, false);
> +    set_avr64(VT, result2, true);
> +
> +    tcg_temp_free_i64(tmp);
> +    tcg_temp_free_i64(avr);
> +    tcg_temp_free_i64(result);
> +    tcg_temp_free_i64(result1);
> +    tcg_temp_free_i64(result2);
> +}
> +
> +static void gen_vupkhpx(DisasContext *ctx)
> +{
> +    if (unlikely(!ctx->altivec_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_VPU);
> +        return;
> +    }
> +    trans_vupkpx(ctx, 1);
> +}
> +
> +static void gen_vupklpx(DisasContext *ctx)
> +{
> +    if (unlikely(!ctx->altivec_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_VPU);
> +        return;
> +    }
> +    trans_vupkpx(ctx, 0);
> +}
> +
>  GEN_VXFORM(vmuloub, 4, 0);
>  GEN_VXFORM(vmulouh, 4, 1);
>  GEN_VXFORM(vmulouw, 4, 2);
> @@ -1348,8 +1437,6 @@ GEN_VXFORM_NOA(vupkhsw, 7, 25);
>  GEN_VXFORM_NOA(vupklsb, 7, 10);
>  GEN_VXFORM_NOA(vupklsh, 7, 11);
>  GEN_VXFORM_NOA(vupklsw, 7, 27);
> -GEN_VXFORM_NOA(vupkhpx, 7, 13);
> -GEN_VXFORM_NOA(vupklpx, 7, 15);


There is inconsistency here compared to your previous patches. There should
be lines:

GEN_VXFORM_TRANS(vupkhpx, 7, 13);
GEN_VXFORM_TRANS(vupklpx, 7, 15);

and there should be two new functions trans_vupkhpx() and trans_vupklpx()
drfined as thin wrappers around trans_vupkpx(). gen_vupkhpx() and
gen_vupklpx() should be deleted.


>  GEN_VXFORM_NOA_ENV(vrefp, 5, 4);
>  GEN_VXFORM_NOA_ENV(vrsqrtefp, 5, 5);
>  GEN_VXFORM_NOA_ENV(vexptefp, 5, 6);
> --
> 2.7.4
>
>
>

--0000000000003ac7ac059548fe77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, October 17, 2019, Stefan Brankovic &lt;<a href=3D"mail=
to:stefan.brankovic@rt-rk.com">stefan.brankovic@rt-rk.com</a>&gt; wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">&#39;trans_vupkpx&#39; function implements =
both vupkhpx and vupklpx instructions with<br>
argument &#39;high&#39; determine which instruction is processed. Instructi=
ons are<br>
implemented in two &#39;for&#39; loops. Outer &#39;for&#39; loop repeats un=
packing two times,<br>
since both doubleword elements of destination register are formed the same =
way.<br>
It also stores result of every iteration in temporary register, that is lat=
er<br>
transferred to destination register. Inner &#39;for&#39; loop does unpackin=
g of pixels<br>
and forms resulting doubleword 32 by 32 bits.<br>
<br>
Signed-off-by: Stefan Brankovic &lt;<a href=3D"mailto:stefan.brankovic@rt-r=
k.com">stefan.brankovic@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0target/ppc/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 -<br>
=C2=A0target/ppc/int_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 20 --------<br>
=C2=A0target/ppc/translate/vmx-impl.<wbr>inc.c | 91 +++++++++++++++++++++++=
+++++++<wbr>++++++-<br>
=C2=A03 files changed, 89 insertions(+), 24 deletions(-)<br>
<br>
diff --git a/target/ppc/helper.h b/target/ppc/helper.h<br>
index b489b38..fd06b56 100644<br>
--- a/target/ppc/helper.h<br>
+++ b/target/ppc/helper.h<br>
@@ -233,8 +233,6 @@ DEF_HELPER_2(vextsh2d, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vextsw2d, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vnegw, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vnegd, void, avr, avr)<br>
-DEF_HELPER_2(vupkhpx, void, avr, avr)<br>
-DEF_HELPER_2(vupklpx, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vupkhsb, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vupkhsh, void, avr, avr)<br>
=C2=A0DEF_HELPER_2(vupkhsw, void, avr, avr)<br>
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c<br>
index f910c11..9ee667d 100644<br>
--- a/target/ppc/int_helper.c<br>
+++ b/target/ppc/int_helper.c<br>
@@ -1737,26 +1737,6 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r,=
 ppc_avr_t *a, ppc_avr_t *b)<br>
=C2=A0#define UPKHI 0<br>
=C2=A0#define UPKLO 1<br>
=C2=A0#endif<br>
-#define VUPKPX(suffix, hi)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc_avr_t result;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(r-&gt;u32); i+=
+) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t e =3D b-&gt;u16[hi ? i =
: i + 4];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t a =3D (e &gt;&gt; 15) ? =
0xff : 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t r =3D (e &gt;&gt; 10) &a=
mp; 0x1f;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t g =3D (e &gt;&gt; 5) &am=
p; 0x1f;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t b =3D e &amp; 0x1f;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result.u32[i] =3D (a &lt;&lt; 24=
) | (r &lt;&lt; 16) | (g &lt;&lt; 8) | b;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *r =3D result;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
-=C2=A0 =C2=A0 }<br>
-VUPKPX(lpx, UPKLO)<br>
-VUPKPX(hpx, UPKHI)<br>
-#undef VUPKPX<br>
<br>
=C2=A0#define VUPK(suffix, unpacked, packee, hi)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
=C2=A0 =C2=A0 =C2=A0void helper_vupk##suffix(ppc_avr_t *r, ppc_avr_t *b)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
diff --git a/target/ppc/translate/vmx-<wbr>impl.inc.c b/target/ppc/translat=
e/vmx-<wbr>impl.inc.c<br>
index 3550ffa..09d80d6 100644<br>
--- a/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
+++ b/target/ppc/translate/vmx-<wbr>impl.inc.c<br>
@@ -1031,6 +1031,95 @@ static void trans_vclzd(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(avr);<br>
=C2=A0}<br>
<br>
+/*<br>
+ * vupkhpx VRT,VRB - Vector Unpack High Pixel<br>
+ * vupklpx VRT,VRB - Vector Unpack Low Pixel<br>
+ *<br>
+ * Unpacks 4 pixels coded in 1-5-5-5 pattern from high/low doubleword elem=
ent<br>
+ * of source register into contigous array of bits in the destination regi=
ster.<br>
+ * Argument &#39;high&#39; determines if high or low doubleword element of=
 source<br>
+ * register is processed.<br>
+ */<br>
+static void trans_vupkpx(DisasContext *ctx, int high)<br>
+{<br>
+=C2=A0 =C2=A0 int VT =3D rD(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 int VB =3D rB(ctx-&gt;opcode);<br>
+=C2=A0 =C2=A0 TCGv_i64 tmp =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 avr =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result1 =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 TCGv_i64 result2 =3D tcg_temp_new_i64();<br>
+=C2=A0 =C2=A0 int64_t mask1 =3D 0x1fULL;<br>
+=C2=A0 =C2=A0 int64_t mask2 =3D 0x1fULL &lt;&lt; 8;<br>
+=C2=A0 =C2=A0 int64_t mask3 =3D 0x1fULL &lt;&lt; 16;<br>
+=C2=A0 =C2=A0 int64_t mask4 =3D 0xffULL &lt;&lt; 56;<br>
+=C2=A0 =C2=A0 int i, j;<br>
+<br>
+=C2=A0 =C2=A0 if (high =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, true);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_avr64(avr, VB, false);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_movi_i64(result, 0x0ULL);<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 2; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; 2; j++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, avr, (j * =
16));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, tmp, mask1=
 &lt;&lt; (j * 32));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, result, t=
mp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, avr, 3 + (=
j * 16));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, tmp, mask2=
 &lt;&lt; (j * 32));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, result, t=
mp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shli_i64(tmp, avr, 6 + (=
j * 16));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, tmp, mask3=
 &lt;&lt; (j * 32));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, result, t=
mp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(tmp, avr, (j * =
16));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ext16s_i64(tmp, tmp);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andi_i64(tmp, tmp, mask4=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(tmp, tmp, (32 *=
 (1 - j)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(result, result, t=
mp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result1, result)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i64(result, 0x0ULL)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_shri_i64(avr, avr, 32);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(result2, result)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 set_avr64(VT, result1, false);<br>
+=C2=A0 =C2=A0 set_avr64(VT, result2, true);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(tmp);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(avr);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i64(result2);<br>
+}<br>
+<br>
+static void gen_vupkhpx(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 if (unlikely(!ctx-&gt;altivec_<wbr>enabled)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exception(ctx, POWERPC_EXCP_VPU);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 trans_vupkpx(ctx, 1);<br>
+}<br>
+<br>
+static void gen_vupklpx(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 if (unlikely(!ctx-&gt;altivec_<wbr>enabled)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exception(ctx, POWERPC_EXCP_VPU);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 trans_vupkpx(ctx, 0);<br>
+}<br>
+<br>
=C2=A0GEN_VXFORM(vmuloub, 4, 0);<br>
=C2=A0GEN_VXFORM(vmulouh, 4, 1);<br>
=C2=A0GEN_VXFORM(vmulouw, 4, 2);<br>
@@ -1348,8 +1437,6 @@ GEN_VXFORM_NOA(vupkhsw, 7, 25);<br>
=C2=A0GEN_VXFORM_NOA(vupklsb, 7, 10);<br>
=C2=A0GEN_VXFORM_NOA(vupklsh, 7, 11);<br>
=C2=A0GEN_VXFORM_NOA(vupklsw, 7, 27);<br>
-GEN_VXFORM_NOA(vupkhpx, 7, 13);<br>
-GEN_VXFORM_NOA(vupklpx, 7, 15);</blockquote><div><br></div><div>There is i=
nconsistency here compared to your previous patches. There should be lines:=
</div><div><br></div><div><span style=3D"color:rgb(34,34,34);font-size:14px=
;line-height:22.1200008392334px">GEN_VXFORM_TRANS(vupkhpx, 7, 13);</span><b=
r></div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:=
22.1200008392334px">GEN_VXFORM_TRANS(vupklpx, 7, 15);</span></div><div><br>=
</div><div>and there should be two new functions trans_vupkhpx() and trans_=
vupklpx() drfined as thin wrappers around trans_vupkpx(). gen_vupkhpx() and=
 gen_vupklpx() should be deleted.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
=C2=A0GEN_VXFORM_NOA_ENV(vrefp, 5, 4);<br>
=C2=A0GEN_VXFORM_NOA_ENV(vrsqrtefp, 5, 5);<br>
=C2=A0GEN_VXFORM_NOA_ENV(vexptefp, 5, 6);<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--0000000000003ac7ac059548fe77--

