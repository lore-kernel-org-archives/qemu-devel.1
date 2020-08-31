Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C93C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AE020866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AE020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrPB-0004hG-Bk
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9a-0007ID-60
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:50 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9Y-00018J-Bj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:49 -0400
Received: by mail-qv1-f65.google.com with SMTP id j10so3325832qvk.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gYylauk4tPiAZzGE4jC1Jcm9V0EkQZWJ0uSFfEH2UZ4=;
 b=FZGySwc8N3ow1hcli121RaZTVs9Y7f6mwd4kruMs7FGhhVjivHJPZs2MjjT2vGaeyt
 mK1xiQmiiPhsYmrmQAn1vFMyLxs+QNYYVn/Og7c+ds+7fMcIk5mokbaFHdipbgyBkcRI
 A+b29cMRyzFMd+vdX1aWKgp7CJBiNTTNNug5AD/WBDMgyPC4KTuMXjAYg/YysrpgO+TC
 gTVXyrBeNYkjmCY0PU0OO7K6vefJNBMy15VtxfFwJvFpMJJhPSzA/qT8VZulWRCQn2ld
 oVNEyGVlWdGHkVBp3U/dQyo9YFxFd5tXAt3FpCgJW2XP2PCYGl65xXeWHtx+tv1ElNAH
 a37w==
X-Gm-Message-State: AOAM531TLc0DVQvOs0casYIFmDBnG14YKQm0jQx5UqJLrRWUJ+izTvEc
 00f7S/LbtWnzum0o5QMTJmIbcghUhnlpO5cpYlc=
X-Google-Smtp-Source: ABdhPJyhSqpmr6DPwNGqietDiHkyApA5fIdQHGvp84fB1a54fSVLSvB6pORRvp65rVt+HGrvSWUtxJmT1f4HAA9Wtoc=
X-Received: by 2002:ad4:59d0:: with SMTP id el16mr3012799qvb.116.1598908547460; 
 Mon, 31 Aug 2020 14:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200828180243.443016-1-richard.henderson@linaro.org>
 <20200828180243.443016-4-richard.henderson@linaro.org>
In-Reply-To: <20200828180243.443016-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 19:23:23 +0200
Message-ID: <CAAdtpL4yGUaWZe6w3PxCDkhwXy60gw_Fqcz2bw0gws_2Gyhfcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fff14405ae32e786"
Received-SPF: pass client-ip=209.85.219.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qv1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fff14405ae32e786
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 20:04, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> We already support duplication of 128-bit blocks.  This extends
> that support to 256-bit blocks.  This will be needed by SVE2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  tcg/tcg-op-gvec.c | 52 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index fcc25b04e6..7ebd9e8298 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1570,12 +1570,10 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t
> dofs, uint32_t aofs,
>              do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
>              tcg_temp_free_i64(in);
>          }
> -    } else {
> +    } else if (vece =3D=3D 4) {
>          /* 128-bit duplicate.  */
> -        /* ??? Dup to 256-bit vector.  */
>          int i;
>
> -        tcg_debug_assert(vece =3D=3D 4);
>          tcg_debug_assert(oprsz >=3D 16);
>          if (TCG_TARGET_HAS_v128) {
>              TCGv_vec in =3D tcg_temp_new_vec(TCG_TYPE_V128);
> @@ -1601,6 +1599,54 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t
> dofs, uint32_t aofs,
>          if (oprsz < maxsz) {
>              expand_clr(dofs + oprsz, maxsz - oprsz);
>          }
> +    } else if (vece =3D=3D 5) {
> +        /* 256-bit duplicate.  */
> +        int i;
> +
> +        tcg_debug_assert(oprsz >=3D 32);
> +        tcg_debug_assert(oprsz % 32 =3D=3D 0);
> +        if (TCG_TARGET_HAS_v256) {
> +            TCGv_vec in =3D tcg_temp_new_vec(TCG_TYPE_V256);
> +
> +            tcg_gen_ld_vec(in, cpu_env, aofs);
> +            for (i =3D (aofs =3D=3D dofs) * 32; i < oprsz; i +=3D 32) {
> +                tcg_gen_st_vec(in, cpu_env, dofs + i);
> +            }
> +            tcg_temp_free_vec(in);
> +        } else if (TCG_TARGET_HAS_v128) {
> +            TCGv_vec in0 =3D tcg_temp_new_vec(TCG_TYPE_V128);
> +            TCGv_vec in1 =3D tcg_temp_new_vec(TCG_TYPE_V128);
> +
> +            tcg_gen_ld_vec(in0, cpu_env, aofs);
> +            tcg_gen_ld_vec(in1, cpu_env, aofs + 16);
> +            for (i =3D (aofs =3D=3D dofs) * 32; i < oprsz; i +=3D 32) {
> +                tcg_gen_st_vec(in0, cpu_env, dofs + i);
> +                tcg_gen_st_vec(in1, cpu_env, dofs + i + 16);
> +            }
> +            tcg_temp_free_vec(in0);
> +            tcg_temp_free_vec(in1);
> +        } else {
> +            TCGv_i64 in[4];
> +            int j;
> +
> +            for (j =3D 0; j < 4; ++j) {
> +                in[j] =3D tcg_temp_new_i64();
> +                tcg_gen_ld_i64(in[j], cpu_env, aofs + j * 8);
> +            }
> +            for (i =3D (aofs =3D=3D dofs) * 32; i < oprsz; i +=3D 32) {
> +                for (j =3D 0; j < 4; ++j) {
> +                    tcg_gen_st_i64(in[j], cpu_env, dofs + i + j * 8);
> +                }
> +            }
> +            for (j =3D 0; j < 4; ++j) {
> +                tcg_temp_free_i64(in[j]);
> +            }
> +        }
> +        if (oprsz < maxsz) {
> +            expand_clr(dofs + oprsz, maxsz - oprsz);
> +        }
> +    } else {
> +        g_assert_not_reached();
>      }
>  }
>
> --
> 2.25.1
>
>
>

--000000000000fff14405ae32e786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 20:04, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</=
a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">We alrea=
dy support duplication of 128-bit blocks.=C2=A0 This extends<br>
that support to 256-bit blocks.=C2=A0 This will be needed by SVE2.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Reviewe=
d-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.=
org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-s=
erif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:sans=
-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
---<br>
=C2=A0tcg/tcg-op-gvec.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--=
-<br>
=C2=A01 file changed, 49 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c<br>
index fcc25b04e6..7ebd9e8298 100644<br>
--- a/tcg/tcg-op-gvec.c<br>
+++ b/tcg/tcg-op-gvec.c<br>
@@ -1570,12 +1570,10 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t d=
ofs, uint32_t aofs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_dup(vece, dofs, oprsz, m=
axsz, NULL, in, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(in);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 } else if (vece =3D=3D 4) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 128-bit duplicate.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? Dup to 256-bit vector.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_debug_assert(vece =3D=3D 4);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_debug_assert(oprsz &gt;=3D 16);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TCG_TARGET_HAS_v128) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_vec in =3D tcg_temp_ne=
w_vec(TCG_TYPE_V128);<br>
@@ -1601,6 +1599,54 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t do=
fs, uint32_t aofs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (oprsz &lt; maxsz) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expand_clr(dofs + oprsz, ma=
xsz - oprsz);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 } else if (vece =3D=3D 5) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 256-bit duplicate.=C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_debug_assert(oprsz &gt;=3D 32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_debug_assert(oprsz % 32 =3D=3D 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (TCG_TARGET_HAS_v256) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_vec in =3D tcg_temp_new_vec=
(TCG_TYPE_V256);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ld_vec(in, cpu_env, aofs=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D (aofs =3D=3D dofs) * =
32; i &lt; oprsz; i +=3D 32) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_st_vec(in,=
 cpu_env, dofs + i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_vec(in);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (TCG_TARGET_HAS_v128) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_vec in0 =3D tcg_temp_new_ve=
c(TCG_TYPE_V128);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_vec in1 =3D tcg_temp_new_ve=
c(TCG_TYPE_V128);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ld_vec(in0, cpu_env, aof=
s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ld_vec(in1, cpu_env, aof=
s + 16);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D (aofs =3D=3D dofs) * =
32; i &lt; oprsz; i +=3D 32) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_st_vec(in0=
, cpu_env, dofs + i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_st_vec(in1=
, cpu_env, dofs + i + 16);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_vec(in0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_vec(in1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_i64 in[4];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int j;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; 4; ++j) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in[j] =3D tcg_temp=
_new_i64();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ld_i64(in[=
j], cpu_env, aofs + j * 8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D (aofs =3D=3D dofs) * =
32; i &lt; oprsz; i +=3D 32) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &l=
t; 4; ++j) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_=
gen_st_i64(in[j], cpu_env, dofs + i + j * 8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; 4; ++j) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i64(=
in[j]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (oprsz &lt; maxsz) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expand_clr(dofs + oprsz, maxsz -=
 oprsz);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000fff14405ae32e786--

