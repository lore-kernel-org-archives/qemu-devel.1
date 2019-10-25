Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F91CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64062084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIT+iKCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64062084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxRm-0002gG-MT
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNx3p-0000QC-T5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNx3n-0003CI-0h
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:43:13 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iNx3k-00039Q-TB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:43:09 -0400
Received: by mail-ot1-x341.google.com with SMTP id n48so1713494ota.11
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=iblYxiaYgnq0vZgwJd2OyMX1YJ4WrHDDIgxSd+vqQns=;
 b=jIT+iKCP2TyE86XzF5kv6JaQojQRQ0YQ3yL0/0er/PfEplWxyFJDfU/WTAMUMJvCaz
 tyZaS6UW3h86iq/8s6tB7ZV1qczYRE0eMps7dFaC7fhGnXWDzUmSQ1mqo1SEvxZbbuiP
 bPNNDMsCcIxbmfuRYVvDxYFhRiSFWwjbsMOYe0vBEcRcbfFyIOMac6BpEXRjBh3M9KlH
 eF/n7E6hLl3uiy6ksJSPdMHyvU55cZz3oEdJXIGjHhd45QGimF8n0FgEqy++gLm1utob
 92ja9crnJpjutgRid11GLDVckq/kT+vzJhQY5LAjP5Xkwby/xstG40PyjXKajMpqA5+a
 83VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=iblYxiaYgnq0vZgwJd2OyMX1YJ4WrHDDIgxSd+vqQns=;
 b=EihTgO5V18ErQ28qBRL8R5xhstJFjwxoys+CpPnrx5C1tunYPaB9+b838poangTyrg
 izXWZqSKnXbQz7Il+kJgQXgbgbWX8K1qDwbsYYDfpmXNk/kPT4r9qULo3OujJoWk/4KF
 hAUkat59iqxYUbIOkMykZ+XoTzuH7l+h0KiyWMogfHmyDn4RoxDiVRD8Ku6wJdvPzdD7
 A2/UjtNsqUwMoVPIV0jKg3OvETLQtvVFbrKETm5xkCyJCGF+kFmTZ7cu2jrNM2CmeRRu
 YDiWSbAaAAeHbygvHfu7sS0a4TzXzcTVWB6iSN8y0rdfAHotPUAYnFsa48/FZuqlbvFt
 uNrw==
X-Gm-Message-State: APjAAAVYGHQkF22X3YyL7D2HERkBBYU80W7AGfQ43KZ2G9yqleIDwzkg
 vk7cK37kFJtCL1VLHrCLiSQgW0nAU5k5CGRiRSk=
X-Google-Smtp-Source: APXvYqxLtRWse9UX+g2rWnLFGrXBCW77FetAFA0oqoGyuMMvTophWhrRkA91mRYpGFi1b3w+WCiC75usBwD/vlZP4PA=
X-Received: by 2002:a9d:684c:: with SMTP id c12mr2220270oto.341.1572000187197; 
 Fri, 25 Oct 2019 03:43:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 25 Oct 2019 03:43:06
 -0700 (PDT)
In-Reply-To: <1571837825-24438-3-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1571837825-24438-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1571837825-24438-3-git-send-email-Filip.Bozuta@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 25 Oct 2019 12:43:06 +0200
Message-ID: <CAL1e-=gM_FbyF6V_ev=GZX0ogtOJ5MY_fVFTqA7eR=j+WMGUVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/mips: Rearrange vector compare less than
 (signed) instructions
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000beb1070595b9d040"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000beb1070595b9d040
Content-Type: text/plain; charset="UTF-8"

On Wednesday, October 23, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote:

> Remove unnecessary argument and provide separate function for each
> instruction.
>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  target/mips/msa_helper.c | 80 ++++++++++++++++++++++++++++++
> ------------------
>  1 file changed, 50 insertions(+), 30 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index b5027e7..35bbf26 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1389,6 +1389,11 @@ static inline int64_t msa_clt_s_df(uint32_t df,
> int64_t arg1, int64_t arg2)
>      return arg1 < arg2 ? -1 : 0;
>  }
>
> +static inline int8_t msa_clt_s_b(int8_t arg1, int8_t arg2)
> +{
> +    return arg1 < arg2 ? -1 : 0;
> +}
> +
>  void helper_msa_clt_s_b(CPUMIPSState *env,
>                          uint32_t wd, uint32_t ws, uint32_t wt)
>  {
> @@ -1396,22 +1401,27 @@ void helper_msa_clt_s_b(CPUMIPSState *env,
>      wr_t *pws = &(env->active_fpu.fpr[ws].wr);
>      wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
>
> -    pwd->b[0]  = msa_clt_s_df(DF_BYTE, pws->b[0],  pwt->b[0]);
> -    pwd->b[1]  = msa_clt_s_df(DF_BYTE, pws->b[1],  pwt->b[1]);
> -    pwd->b[2]  = msa_clt_s_df(DF_BYTE, pws->b[2],  pwt->b[2]);
> -    pwd->b[3]  = msa_clt_s_df(DF_BYTE, pws->b[3],  pwt->b[3]);
> -    pwd->b[4]  = msa_clt_s_df(DF_BYTE, pws->b[4],  pwt->b[4]);
> -    pwd->b[5]  = msa_clt_s_df(DF_BYTE, pws->b[5],  pwt->b[5]);
> -    pwd->b[6]  = msa_clt_s_df(DF_BYTE, pws->b[6],  pwt->b[6]);
> -    pwd->b[7]  = msa_clt_s_df(DF_BYTE, pws->b[7],  pwt->b[7]);
> -    pwd->b[8]  = msa_clt_s_df(DF_BYTE, pws->b[8],  pwt->b[8]);
> -    pwd->b[9]  = msa_clt_s_df(DF_BYTE, pws->b[9],  pwt->b[9]);
> -    pwd->b[10] = msa_clt_s_df(DF_BYTE, pws->b[10], pwt->b[10]);
> -    pwd->b[11] = msa_clt_s_df(DF_BYTE, pws->b[11], pwt->b[11]);
> -    pwd->b[12] = msa_clt_s_df(DF_BYTE, pws->b[12], pwt->b[12]);
> -    pwd->b[13] = msa_clt_s_df(DF_BYTE, pws->b[13], pwt->b[13]);
> -    pwd->b[14] = msa_clt_s_df(DF_BYTE, pws->b[14], pwt->b[14]);
> -    pwd->b[15] = msa_clt_s_df(DF_BYTE, pws->b[15], pwt->b[15]);
> +    pwd->b[0]  = msa_clt_s_b(pws->b[0],  pwt->b[0]);
> +    pwd->b[1]  = msa_clt_s_b(pws->b[1],  pwt->b[1]);
> +    pwd->b[2]  = msa_clt_s_b(pws->b[2],  pwt->b[2]);
> +    pwd->b[3]  = msa_clt_s_b(pws->b[3],  pwt->b[3]);
> +    pwd->b[4]  = msa_clt_s_b(pws->b[4],  pwt->b[4]);
> +    pwd->b[5]  = msa_clt_s_b(pws->b[5],  pwt->b[5]);
> +    pwd->b[6]  = msa_clt_s_b(pws->b[6],  pwt->b[6]);
> +    pwd->b[7]  = msa_clt_s_b(pws->b[7],  pwt->b[7]);
> +    pwd->b[8]  = msa_clt_s_b(pws->b[8],  pwt->b[8]);
> +    pwd->b[9]  = msa_clt_s_b(pws->b[9],  pwt->b[9]);
> +    pwd->b[10] = msa_clt_s_b(pws->b[10], pwt->b[10]);
> +    pwd->b[11] = msa_clt_s_b(pws->b[11], pwt->b[11]);
> +    pwd->b[12] = msa_clt_s_b(pws->b[12], pwt->b[12]);
> +    pwd->b[13] = msa_clt_s_b(pws->b[13], pwt->b[13]);
> +    pwd->b[14] = msa_clt_s_b(pws->b[14], pwt->b[14]);
> +    pwd->b[15] = msa_clt_s_b(pws->b[15], pwt->b[15]);
> +}
> +
> +static inline int16_t msa_clt_s_h(int16_t arg1, int16_t arg2)
> +{
> +    return arg1 < arg2 ? -1 : 0;
>  }
>
>  void helper_msa_clt_s_h(CPUMIPSState *env,
> @@ -1421,14 +1431,19 @@ void helper_msa_clt_s_h(CPUMIPSState *env,
>      wr_t *pws = &(env->active_fpu.fpr[ws].wr);
>      wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
>
> -    pwd->h[0]  = msa_clt_s_df(DF_HALF, pws->h[0],  pwt->h[0]);
> -    pwd->h[1]  = msa_clt_s_df(DF_HALF, pws->h[1],  pwt->h[1]);
> -    pwd->h[2]  = msa_clt_s_df(DF_HALF, pws->h[2],  pwt->h[2]);
> -    pwd->h[3]  = msa_clt_s_df(DF_HALF, pws->h[3],  pwt->h[3]);
> -    pwd->h[4]  = msa_clt_s_df(DF_HALF, pws->h[4],  pwt->h[4]);
> -    pwd->h[5]  = msa_clt_s_df(DF_HALF, pws->h[5],  pwt->h[5]);
> -    pwd->h[6]  = msa_clt_s_df(DF_HALF, pws->h[6],  pwt->h[6]);
> -    pwd->h[7]  = msa_clt_s_df(DF_HALF, pws->h[7],  pwt->h[7]);
> +    pwd->h[0]  = msa_clt_s_h(pws->h[0],  pwt->h[0]);
> +    pwd->h[1]  = msa_clt_s_h(pws->h[1],  pwt->h[1]);
> +    pwd->h[2]  = msa_clt_s_h(pws->h[2],  pwt->h[2]);
> +    pwd->h[3]  = msa_clt_s_h(pws->h[3],  pwt->h[3]);
> +    pwd->h[4]  = msa_clt_s_h(pws->h[4],  pwt->h[4]);
> +    pwd->h[5]  = msa_clt_s_h(pws->h[5],  pwt->h[5]);
> +    pwd->h[6]  = msa_clt_s_h(pws->h[6],  pwt->h[6]);
> +    pwd->h[7]  = msa_clt_s_h(pws->h[7],  pwt->h[7]);
> +}
> +
> +static inline int32_t msa_clt_s_w(int32_t arg1, int32_t arg2)
> +{
> +    return arg1 < arg2 ? -1 : 0;
>  }
>
>  void helper_msa_clt_s_w(CPUMIPSState *env,
> @@ -1438,10 +1453,15 @@ void helper_msa_clt_s_w(CPUMIPSState *env,
>      wr_t *pws = &(env->active_fpu.fpr[ws].wr);
>      wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
>
> -    pwd->w[0]  = msa_clt_s_df(DF_WORD, pws->w[0],  pwt->w[0]);
> -    pwd->w[1]  = msa_clt_s_df(DF_WORD, pws->w[1],  pwt->w[1]);
> -    pwd->w[2]  = msa_clt_s_df(DF_WORD, pws->w[2],  pwt->w[2]);
> -    pwd->w[3]  = msa_clt_s_df(DF_WORD, pws->w[3],  pwt->w[3]);
> +    pwd->w[0]  = msa_clt_s_w(pws->w[0],  pwt->w[0]);
> +    pwd->w[1]  = msa_clt_s_w(pws->w[1],  pwt->w[1]);
> +    pwd->w[2]  = msa_clt_s_w(pws->w[2],  pwt->w[2]);
> +    pwd->w[3]  = msa_clt_s_w(pws->w[3],  pwt->w[3]);
> +}
> +
> +static inline int64_t msa_clt_s_d(int64_t arg1, int64_t arg2)
> +{
> +    return arg1 < arg2 ? -1 : 0;
>  }
>
>  void helper_msa_clt_s_d(CPUMIPSState *env,
> @@ -1451,8 +1471,8 @@ void helper_msa_clt_s_d(CPUMIPSState *env,
>      wr_t *pws = &(env->active_fpu.fpr[ws].wr);
>      wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
>
> -    pwd->d[0]  = msa_clt_s_df(DF_DOUBLE, pws->d[0],  pwt->d[0]);
> -    pwd->d[1]  = msa_clt_s_df(DF_DOUBLE, pws->d[1],  pwt->d[1]);
> +    pwd->d[0]  = msa_clt_s_d(pws->d[0],  pwt->d[0]);
> +    pwd->d[1]  = msa_clt_s_d(pws->d[1],  pwt->d[1]);
>  }
>
>  static inline int64_t msa_clt_u_df(uint32_t df, int64_t arg1, int64_t
> arg2)
> --
> 2.7.4
>
>
>

--000000000000beb1070595b9d040
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, October 23, 2019, Filip Bozuta &lt;<a href=3D"mailto:=
Filip.Bozuta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Remove unnecessary argument and provide separate funct=
ion for each<br>
instruction.<br>
<br>
Signed-off-by: Filip Bozuta &lt;<a href=3D"mailto:Filip.Bozuta@rt-rk.com">F=
ilip.Bozuta@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0target/mips/msa_helper.c | 80 ++++++++++++++++++++++++++++++<wbr>----=
--------------<br>
=C2=A01 file changed, 50 insertions(+), 30 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c<br>
index b5027e7..35bbf26 100644<br>
--- a/target/mips/msa_helper.c<br>
+++ b/target/mips/msa_helper.c<br>
@@ -1389,6 +1389,11 @@ static inline int64_t msa_clt_s_df(uint32_t df, int6=
4_t arg1, int64_t arg2)<br>
=C2=A0 =C2=A0 =C2=A0return arg1 &lt; arg2 ? -1 : 0;<br>
=C2=A0}<br>
<br>
+static inline int8_t msa_clt_s_b(int8_t arg1, int8_t arg2)<br>
+{<br>
+=C2=A0 =C2=A0 return arg1 &lt; arg2 ? -1 : 0;<br>
+}<br>
+<br>
=C2=A0void helper_msa_clt_s_b(<wbr>CPUMIPSState *env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint32_t wd, uint32_t ws, uint32_t wt)<br>
=C2=A0{<br>
@@ -1396,22 +1401,27 @@ void helper_msa_clt_s_b(<wbr>CPUMIPSState *env,<br>
=C2=A0 =C2=A0 =C2=A0wr_t *pws =3D &amp;(env-&gt;active_fpu.fpr[ws].wr);<br>
=C2=A0 =C2=A0 =C2=A0wr_t *pwt =3D &amp;(env-&gt;active_fpu.fpr[wt].wr);<br>
<br>
-=C2=A0 =C2=A0 pwd-&gt;b[0]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[0],=
=C2=A0 pwt-&gt;b[0]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[1]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[1],=
=C2=A0 pwt-&gt;b[1]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[2]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[2],=
=C2=A0 pwt-&gt;b[2]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[3]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[3],=
=C2=A0 pwt-&gt;b[3]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[4]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[4],=
=C2=A0 pwt-&gt;b[4]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[5]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[5],=
=C2=A0 pwt-&gt;b[5]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[6]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[6],=
=C2=A0 pwt-&gt;b[6]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[7]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[7],=
=C2=A0 pwt-&gt;b[7]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[8]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[8],=
=C2=A0 pwt-&gt;b[8]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[9]=C2=A0 =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[9],=
=C2=A0 pwt-&gt;b[9]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[10] =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[10], pwt-&=
gt;b[10]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[11] =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[11], pwt-&=
gt;b[11]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[12] =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[12], pwt-&=
gt;b[12]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[13] =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[13], pwt-&=
gt;b[13]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[14] =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[14], pwt-&=
gt;b[14]);<br>
-=C2=A0 =C2=A0 pwd-&gt;b[15] =3D msa_clt_s_df(DF_BYTE, pws-&gt;b[15], pwt-&=
gt;b[15]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[0]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[0],=C2=A0 pwt-&=
gt;b[0]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[1]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[1],=C2=A0 pwt-&=
gt;b[1]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[2]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[2],=C2=A0 pwt-&=
gt;b[2]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[3]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[3],=C2=A0 pwt-&=
gt;b[3]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[4]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[4],=C2=A0 pwt-&=
gt;b[4]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[5]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[5],=C2=A0 pwt-&=
gt;b[5]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[6]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[6],=C2=A0 pwt-&=
gt;b[6]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[7]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[7],=C2=A0 pwt-&=
gt;b[7]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[8]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[8],=C2=A0 pwt-&=
gt;b[8]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[9]=C2=A0 =3D msa_clt_s_b(pws-&gt;b[9],=C2=A0 pwt-&=
gt;b[9]);<br>
+=C2=A0 =C2=A0 pwd-&gt;b[10] =3D msa_clt_s_b(pws-&gt;b[10], pwt-&gt;b[10]);=
<br>
+=C2=A0 =C2=A0 pwd-&gt;b[11] =3D msa_clt_s_b(pws-&gt;b[11], pwt-&gt;b[11]);=
<br>
+=C2=A0 =C2=A0 pwd-&gt;b[12] =3D msa_clt_s_b(pws-&gt;b[12], pwt-&gt;b[12]);=
<br>
+=C2=A0 =C2=A0 pwd-&gt;b[13] =3D msa_clt_s_b(pws-&gt;b[13], pwt-&gt;b[13]);=
<br>
+=C2=A0 =C2=A0 pwd-&gt;b[14] =3D msa_clt_s_b(pws-&gt;b[14], pwt-&gt;b[14]);=
<br>
+=C2=A0 =C2=A0 pwd-&gt;b[15] =3D msa_clt_s_b(pws-&gt;b[15], pwt-&gt;b[15]);=
<br>
+}<br>
+<br>
+static inline int16_t msa_clt_s_h(int16_t arg1, int16_t arg2)<br>
+{<br>
+=C2=A0 =C2=A0 return arg1 &lt; arg2 ? -1 : 0;<br>
=C2=A0}<br>
<br>
=C2=A0void helper_msa_clt_s_h(<wbr>CPUMIPSState *env,<br>
@@ -1421,14 +1431,19 @@ void helper_msa_clt_s_h(<wbr>CPUMIPSState *env,<br>
=C2=A0 =C2=A0 =C2=A0wr_t *pws =3D &amp;(env-&gt;active_fpu.fpr[ws].wr);<br>
=C2=A0 =C2=A0 =C2=A0wr_t *pwt =3D &amp;(env-&gt;active_fpu.fpr[wt].wr);<br>
<br>
-=C2=A0 =C2=A0 pwd-&gt;h[0]=C2=A0 =3D msa_clt_s_df(DF_HALF, pws-&gt;h[0],=
=C2=A0 pwt-&gt;h[0]);<br>
-=C2=A0 =C2=A0 pwd-&gt;h[1]=C2=A0 =3D msa_clt_s_df(DF_HALF, pws-&gt;h[1],=
=C2=A0 pwt-&gt;h[1]);<br>
-=C2=A0 =C2=A0 pwd-&gt;h[2]=C2=A0 =3D msa_clt_s_df(DF_HALF, pws-&gt;h[2],=
=C2=A0 pwt-&gt;h[2]);<br>
-=C2=A0 =C2=A0 pwd-&gt;h[3]=C2=A0 =3D msa_clt_s_df(DF_HALF, pws-&gt;h[3],=
=C2=A0 pwt-&gt;h[3]);<br>
-=C2=A0 =C2=A0 pwd-&gt;h[4]=C2=A0 =3D msa_clt_s_df(DF_HALF, pws-&gt;h[4],=
=C2=A0 pwt-&gt;h[4]);<br>
-=C2=A0 =C2=A0 pwd-&gt;h[5]=C2=A0 =3D msa_clt_s_df(DF_HALF, pws-&gt;h[5],=
=C2=A0 pwt-&gt;h[5]);<br>
-=C2=A0 =C2=A0 pwd-&gt;h[6]=C2=A0 =3D msa_clt_s_df(DF_HALF, pws-&gt;h[6],=
=C2=A0 pwt-&gt;h[6]);<br>
-=C2=A0 =C2=A0 pwd-&gt;h[7]=C2=A0 =3D msa_clt_s_df(DF_HALF, pws-&gt;h[7],=
=C2=A0 pwt-&gt;h[7]);<br>
+=C2=A0 =C2=A0 pwd-&gt;h[0]=C2=A0 =3D msa_clt_s_h(pws-&gt;h[0],=C2=A0 pwt-&=
gt;h[0]);<br>
+=C2=A0 =C2=A0 pwd-&gt;h[1]=C2=A0 =3D msa_clt_s_h(pws-&gt;h[1],=C2=A0 pwt-&=
gt;h[1]);<br>
+=C2=A0 =C2=A0 pwd-&gt;h[2]=C2=A0 =3D msa_clt_s_h(pws-&gt;h[2],=C2=A0 pwt-&=
gt;h[2]);<br>
+=C2=A0 =C2=A0 pwd-&gt;h[3]=C2=A0 =3D msa_clt_s_h(pws-&gt;h[3],=C2=A0 pwt-&=
gt;h[3]);<br>
+=C2=A0 =C2=A0 pwd-&gt;h[4]=C2=A0 =3D msa_clt_s_h(pws-&gt;h[4],=C2=A0 pwt-&=
gt;h[4]);<br>
+=C2=A0 =C2=A0 pwd-&gt;h[5]=C2=A0 =3D msa_clt_s_h(pws-&gt;h[5],=C2=A0 pwt-&=
gt;h[5]);<br>
+=C2=A0 =C2=A0 pwd-&gt;h[6]=C2=A0 =3D msa_clt_s_h(pws-&gt;h[6],=C2=A0 pwt-&=
gt;h[6]);<br>
+=C2=A0 =C2=A0 pwd-&gt;h[7]=C2=A0 =3D msa_clt_s_h(pws-&gt;h[7],=C2=A0 pwt-&=
gt;h[7]);<br>
+}<br>
+<br>
+static inline int32_t msa_clt_s_w(int32_t arg1, int32_t arg2)<br>
+{<br>
+=C2=A0 =C2=A0 return arg1 &lt; arg2 ? -1 : 0;<br>
=C2=A0}<br>
<br>
=C2=A0void helper_msa_clt_s_w(<wbr>CPUMIPSState *env,<br>
@@ -1438,10 +1453,15 @@ void helper_msa_clt_s_w(<wbr>CPUMIPSState *env,<br>
=C2=A0 =C2=A0 =C2=A0wr_t *pws =3D &amp;(env-&gt;active_fpu.fpr[ws].wr);<br>
=C2=A0 =C2=A0 =C2=A0wr_t *pwt =3D &amp;(env-&gt;active_fpu.fpr[wt].wr);<br>
<br>
-=C2=A0 =C2=A0 pwd-&gt;w[0]=C2=A0 =3D msa_clt_s_df(DF_WORD, pws-&gt;w[0],=
=C2=A0 pwt-&gt;w[0]);<br>
-=C2=A0 =C2=A0 pwd-&gt;w[1]=C2=A0 =3D msa_clt_s_df(DF_WORD, pws-&gt;w[1],=
=C2=A0 pwt-&gt;w[1]);<br>
-=C2=A0 =C2=A0 pwd-&gt;w[2]=C2=A0 =3D msa_clt_s_df(DF_WORD, pws-&gt;w[2],=
=C2=A0 pwt-&gt;w[2]);<br>
-=C2=A0 =C2=A0 pwd-&gt;w[3]=C2=A0 =3D msa_clt_s_df(DF_WORD, pws-&gt;w[3],=
=C2=A0 pwt-&gt;w[3]);<br>
+=C2=A0 =C2=A0 pwd-&gt;w[0]=C2=A0 =3D msa_clt_s_w(pws-&gt;w[0],=C2=A0 pwt-&=
gt;w[0]);<br>
+=C2=A0 =C2=A0 pwd-&gt;w[1]=C2=A0 =3D msa_clt_s_w(pws-&gt;w[1],=C2=A0 pwt-&=
gt;w[1]);<br>
+=C2=A0 =C2=A0 pwd-&gt;w[2]=C2=A0 =3D msa_clt_s_w(pws-&gt;w[2],=C2=A0 pwt-&=
gt;w[2]);<br>
+=C2=A0 =C2=A0 pwd-&gt;w[3]=C2=A0 =3D msa_clt_s_w(pws-&gt;w[3],=C2=A0 pwt-&=
gt;w[3]);<br>
+}<br>
+<br>
+static inline int64_t msa_clt_s_d(int64_t arg1, int64_t arg2)<br>
+{<br>
+=C2=A0 =C2=A0 return arg1 &lt; arg2 ? -1 : 0;<br>
=C2=A0}<br>
<br>
=C2=A0void helper_msa_clt_s_d(<wbr>CPUMIPSState *env,<br>
@@ -1451,8 +1471,8 @@ void helper_msa_clt_s_d(<wbr>CPUMIPSState *env,<br>
=C2=A0 =C2=A0 =C2=A0wr_t *pws =3D &amp;(env-&gt;active_fpu.fpr[ws].wr);<br>
=C2=A0 =C2=A0 =C2=A0wr_t *pwt =3D &amp;(env-&gt;active_fpu.fpr[wt].wr);<br>
<br>
-=C2=A0 =C2=A0 pwd-&gt;d[0]=C2=A0 =3D msa_clt_s_df(DF_DOUBLE, pws-&gt;d[0],=
=C2=A0 pwt-&gt;d[0]);<br>
-=C2=A0 =C2=A0 pwd-&gt;d[1]=C2=A0 =3D msa_clt_s_df(DF_DOUBLE, pws-&gt;d[1],=
=C2=A0 pwt-&gt;d[1]);<br>
+=C2=A0 =C2=A0 pwd-&gt;d[0]=C2=A0 =3D msa_clt_s_d(pws-&gt;d[0],=C2=A0 pwt-&=
gt;d[0]);<br>
+=C2=A0 =C2=A0 pwd-&gt;d[1]=C2=A0 =3D msa_clt_s_d(pws-&gt;d[1],=C2=A0 pwt-&=
gt;d[1]);<br>
=C2=A0}<br>
<br>
=C2=A0static inline int64_t msa_clt_u_df(uint32_t df, int64_t arg1, int64_t=
 arg2)<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--000000000000beb1070595b9d040--

