Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71494CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0462064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXAUw+z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0462064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqIM-0008OQ-Cd
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iMqGz-0007cY-6k
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iMqGv-00075P-Pg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:16:13 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iMqGv-000752-IH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:16:09 -0400
Received: by mail-oi1-x243.google.com with SMTP id k20so13558368oih.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dSon31cgBF4YCrV8T2nvP1OR/dbBJp7RbOTqTNo5q9c=;
 b=oXAUw+z0Bkv6/jN5Nq94WikdiQPGSoAf9SXJcCuDPsTlaKQ5+DRyOxR1DXtM5HHpWB
 tfFKjsdEYRXzpWKU04nTHmU1kLbFhOKKwRy0xAt/KUU4YIWq3Z8pVAg6E1VYF2DA6dy9
 lLpoTN8arQYK8JCeShfRQSMZ4m8VbV+qCKC6dMo/2yZmNKZgarQbn4hNFF+IZSS/Ynyu
 MRhTdkFjfKJ9zysU3qZiPV6Q1Gl5MHd/DIxto+nzHu6Lj1+0CSLVWTZsdSTonrY1liW9
 mYdj206dOuZ+Rk8TdMVSh27JBBiZkdDVc4ES4affq470+NTjSRDumMySyp13HErsVt01
 atgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dSon31cgBF4YCrV8T2nvP1OR/dbBJp7RbOTqTNo5q9c=;
 b=iH5eXe3CjqyWNyqQjWldk1zntNOHs/nFJd3HVxrHPkM9Dllr7V+cvardM+FX8zD2WI
 5+Lq03Uj0gZYj6BbE1jTEKuxIkOSa53sjZ5X94xQkWc9jxIpvehNVz9c8/tlxfCFeOZ+
 QZ1ToZGHYc1jfL/HloW+fndeZcGfO8Lk8zPC+NNnnVQbrxv6A1n7362QFqhzrYi36Snr
 noZfn4zN9LHOGXcUz+tHZ0hFrJj+KwDW0/me6izBqAFEgHKv8UzDbkakMxBmUwpxoTtR
 tXjukQrKkiuFcS3VB3P4TbpbmkGqqyM3+YQiHnjsvaanfof8C/B5XWkIyn6FJXufy5PN
 7dnA==
X-Gm-Message-State: APjAAAV6F9mhEOs50Shs3PbivaRkRI1yOixuYXbLPv+Mbx0UeFNwibOI
 DRoxXl2S+cy1LXPosqq2FRJ43SUW08G+QPR110oiqw==
X-Google-Smtp-Source: APXvYqz2t2lH7yfyPo7RWTK1YcfUIBLLRRTsEKlGDsXsWlsDVOAdPc7MW8aphBOFugYy61u6Cipcyj93WBCJ6i7Eqes=
X-Received: by 2002:aca:4d12:: with SMTP id a18mr1941029oib.79.1571735768390; 
 Tue, 22 Oct 2019 02:16:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 22 Oct 2019 02:16:07
 -0700 (PDT)
In-Reply-To: <1566216496-17375-6-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1566216496-17375-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 22 Oct 2019 11:16:07 +0200
Message-ID: <CAL1e-=hCPYyfSxeiLvXiTj6cECXEvVTTh1ZRqhGkUg7wVWTvmw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 05/37] target/mips: Add support for
 emulation of CRC32 group of instructions
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="00000000000027e06405957c40a6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000027e06405957c40a6
Content-Type: text/plain; charset="UTF-8"

On Monday, August 19, 2019, Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
> Reuse zlib crc32() and Linux crc32c(). Note that, at the time being,
> there is no MIPS CPU that supports CRC32 instructions (they are an
> optional part of MIPS64/32 R6 anf nanoMIPS ISAs).
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  disas/mips.c            |  8 ++++++++
>  target/mips/helper.h    |  2 ++
>  target/mips/op_helper.c | 22 ++++++++++++++++++++++
>  target/mips/translate.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 73 insertions(+)
>
>
This solution is not optimal (see arm equivalent). Also, support for
nanomips crc instructions is not included. In spite of that:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

All outstanding issues will be handled post-4.2.


diff --git a/disas/mips.c b/disas/mips.c
> index c3a3059..b9a5204 100644
> --- a/disas/mips.c
> +++ b/disas/mips.c
> @@ -1411,6 +1411,14 @@ const struct mips_opcode mips_builtin_opcodes[] =
>  {"evp",        "t",     0x41600004, 0xffe0ffff, TRAP|WR_t,            0,
> I32R6},
>  {"ginvi",      "v",     0x7c00003d, 0xfc1ffcff, TRAP | INSN_TLB,      0,
> I32R6},
>  {"ginvt",      "v",     0x7c0000bd, 0xfc1ffcff, TRAP | INSN_TLB,      0,
> I32R6},
> +{"crc32b",     "t,v,t", 0x7c00000f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,
> I32R6},
> +{"crc32h",     "t,v,t", 0x7c00004f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,
> I32R6},
> +{"crc32w",     "t,v,t", 0x7c00008f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,
> I32R6},
> +{"crc32d",     "t,v,t", 0x7c0000cf, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,
> I64R6},
> +{"crc32cb",    "t,v,t", 0x7c00010f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,
> I32R6},
> +{"crc32ch",    "t,v,t", 0x7c00014f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,
> I32R6},
> +{"crc32cw",    "t,v,t", 0x7c00018f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,
> I32R6},
> +{"crc32cd",    "t,v,t", 0x7c0001cf, 0xfc00ff3f, WR_d | RD_s | RD_t,   0,
> I64R6},
>
>  /* MSA */
>  {"sll.b",   "+d,+e,+f", 0x7800000d, 0xffe0003f, WR_VD|RD_VS|RD_VT,  0,
> MSA},
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index c7d35bd..0e61043 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -40,6 +40,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
>  #endif
>
> +DEF_HELPER_3(crc32, tl, tl, tl, i32)
> +DEF_HELPER_3(crc32c, tl, tl, tl, i32)
>  DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
>
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 3104904..5874029 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -25,6 +25,8 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "sysemu/kvm.h"
> +#include "qemu/crc32c.h"
> +#include <zlib.h>
>
>  /***********************************************************
> ******************/
>  /* Exceptions processing helpers */
> @@ -343,6 +345,26 @@ target_ulong helper_rotx(target_ulong rs, uint32_t
> shift, uint32_t shiftx,
>      return (int64_t)(int32_t)(uint32_t)tmp5;
>  }
>
> +/* these crc32 functions are based on target/arm/helper-a64.c */
> +target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
> +{
> +    uint8_t buf[8];
> +    target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) -
> 1);
> +
> +    m &= mask;
> +    stq_le_p(buf, m);
> +    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
> +}
> +
> +target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)
> +{
> +    uint8_t buf[8];
> +    target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) -
> 1);
> +    m &= mask;
> +    stq_le_p(buf, m);
> +    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>
>  static inline hwaddr do_translate_address(CPUMIPSState *env,
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3f73be0..3f9f113 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -452,6 +452,7 @@ enum {
>      OPC_LWE            = 0x2F | OPC_SPECIAL3,
>
>      /* R6 */
> +    OPC_CRC32          = 0x0F | OPC_SPECIAL3,
>      R6_OPC_PREF        = 0x35 | OPC_SPECIAL3,
>      R6_OPC_CACHE       = 0x25 | OPC_SPECIAL3,
>      R6_OPC_LL          = 0x36 | OPC_SPECIAL3,
> @@ -2550,6 +2551,7 @@ typedef struct DisasContext {
>      bool saar;
>      bool mi;
>      int gi;
> +    bool crcp;
>  } DisasContext;
>
>  #define DISAS_STOP       DISAS_TARGET_0
> @@ -27041,6 +27043,33 @@ static void decode_opc_special2_legacy(CPUMIPSState
> *env, DisasContext *ctx)
>      }
>  }
>
> +static void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
> +                      int crc32c)
> +{
> +    TCGv t0;
> +    TCGv t1;
> +    TCGv_i32 tsz = tcg_const_i32(1 << sz);
> +    if (rd == 0) {
> +        /* Treat as NOP. */
> +        return;
> +    }
> +    t0 = tcg_temp_new();
> +    t1 = tcg_temp_new();
> +
> +    gen_load_gpr(t0, rt);
> +    gen_load_gpr(t1, rs);
> +
> +    if (crc32c) {
> +        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);
> +    } else {
> +        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);
> +    }
> +
> +    tcg_temp_free(t0);
> +    tcg_temp_free(t1);
> +    tcg_temp_free_i32(tsz);
> +}
> +
>  static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
>  {
>      int rs, rt, rd, sa;
> @@ -27055,6 +27084,17 @@ static void decode_opc_special3_r6(CPUMIPSState
> *env, DisasContext *ctx)
>
>      op1 = MASK_SPECIAL3(ctx->opcode);
>      switch (op1) {
> +    case OPC_CRC32:
> +        if (unlikely(!ctx->crcp) ||
> +            unlikely((extract32(ctx->opcode, 6, 2) == 3) &&
> +                     (!(ctx->hflags & MIPS_HFLAG_64))) ||
> +            unlikely((extract32(ctx->opcode, 8, 3) >= 2))) {
> +            generate_exception_end(ctx, EXCP_RI);
> +        }
> +        gen_crc32(ctx, rt, rs, rt,
> +                  extract32(ctx->opcode, 6, 2),
> +                  extract32(ctx->opcode, 8, 3));
> +        break;
>      case R6_OPC_PREF:
>          if (rt >= 24) {
>              /* hint codes 24-31 are reserved and signal RI */
> @@ -30049,6 +30089,7 @@ static void mips_tr_init_disas_context(DisasContextBase
> *dcbase, CPUState *cs)
>      ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
>      ctx->mi = (env->CP0_Config5 >> CP0C5_MI) & 1;
>      ctx->gi = (env->CP0_Config5 >> CP0C5_GI) & 3;
> +    ctx->crcp = (env->CP0_Config5 >> CP0C5_CRCP) & 1;
>      restore_cpu_state(env, ctx);
>  #ifdef CONFIG_USER_ONLY
>          ctx->mem_idx = MIPS_HFLAG_UM;
> --
> 2.7.4
>
>
>

--00000000000027e06405957c40a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, August 19, 2019, Aleksandar Markovic &lt;<a href=3D"mail=
to:aleksandar.markovic@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">From: Yongbok Kim &lt;<a href=3D"mail=
to:yongbok.kim@mips.com">yongbok.kim@mips.com</a>&gt;<br>
<br>
Add emulation of MIPS&#39; CRC32 (Cyclic Redundancy Check) instructions.<br=
>
Reuse zlib crc32() and Linux crc32c(). Note that, at the time being,<br>
there is no MIPS CPU that supports CRC32 instructions (they are an<br>
optional part of MIPS64/32 R6 anf nanoMIPS ISAs).<br>
<br>
Signed-off-by: Yongbok Kim &lt;<a href=3D"mailto:yongbok.kim@mips.com">yong=
bok.kim@mips.com</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp=
.com">amarkovic@wavecomp.com</a>&gt;<br>
---<br>
=C2=A0disas/mips.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +++++=
+++<br>
=C2=A0target/mips/helper.h=C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/mips/op_helper.c | 22 ++++++++++++++++++++++<br>
=C2=A0target/mips/translate.c | 41 ++++++++++++++++++++++++++++++<wbr>+++++=
++++++<br>
=C2=A04 files changed, 73 insertions(+)<br>
<br></blockquote><div><br></div><div>This solution is not optimal (see arm =
equivalent). Also, support for nanomips crc instructions is not included. I=
n spite of that:</div><div><br></div><div><span style=3D"color:rgb(34,34,34=
);font-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Ma=
rkovic &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-s=
ize:14px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span st=
yle=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&=
gt;</span><br></div><div><br></div><div>All outstanding issues will be hand=
led post-4.2.</div><div><br></div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
diff --git a/disas/mips.c b/disas/mips.c<br>
index c3a3059..b9a5204 100644<br>
--- a/disas/mips.c<br>
+++ b/disas/mips.c<br>
@@ -1411,6 +1411,14 @@ const struct mips_opcode mips_builtin_opcodes[] =3D<=
br>
=C2=A0{&quot;evp&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;t&quot;,=C2=A0 =C2=
=A0 =C2=A00x41600004, 0xffe0ffff, TRAP|WR_t,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0, I32R6},<br>
=C2=A0{&quot;ginvi&quot;,=C2=A0 =C2=A0 =C2=A0 &quot;v&quot;,=C2=A0 =C2=A0 =
=C2=A00x7c00003d, 0xfc1ffcff, TRAP | INSN_TLB,=C2=A0 =C2=A0 =C2=A0 0, I32R6=
},<br>
=C2=A0{&quot;ginvt&quot;,=C2=A0 =C2=A0 =C2=A0 &quot;v&quot;,=C2=A0 =C2=A0 =
=C2=A00x7c0000bd, 0xfc1ffcff, TRAP | INSN_TLB,=C2=A0 =C2=A0 =C2=A0 0, I32R6=
},<br>
+{&quot;crc32b&quot;,=C2=A0 =C2=A0 =C2=A0&quot;t,v,t&quot;, 0x7c00000f, 0xf=
c00ff3f, WR_d | RD_s | RD_t,=C2=A0 =C2=A00, I32R6},<br>
+{&quot;crc32h&quot;,=C2=A0 =C2=A0 =C2=A0&quot;t,v,t&quot;, 0x7c00004f, 0xf=
c00ff3f, WR_d | RD_s | RD_t,=C2=A0 =C2=A00, I32R6},<br>
+{&quot;crc32w&quot;,=C2=A0 =C2=A0 =C2=A0&quot;t,v,t&quot;, 0x7c00008f, 0xf=
c00ff3f, WR_d | RD_s | RD_t,=C2=A0 =C2=A00, I32R6},<br>
+{&quot;crc32d&quot;,=C2=A0 =C2=A0 =C2=A0&quot;t,v,t&quot;, 0x7c0000cf, 0xf=
c00ff3f, WR_d | RD_s | RD_t,=C2=A0 =C2=A00, I64R6},<br>
+{&quot;crc32cb&quot;,=C2=A0 =C2=A0 &quot;t,v,t&quot;, 0x7c00010f, 0xfc00ff=
3f, WR_d | RD_s | RD_t,=C2=A0 =C2=A00, I32R6},<br>
+{&quot;crc32ch&quot;,=C2=A0 =C2=A0 &quot;t,v,t&quot;, 0x7c00014f, 0xfc00ff=
3f, WR_d | RD_s | RD_t,=C2=A0 =C2=A00, I32R6},<br>
+{&quot;crc32cw&quot;,=C2=A0 =C2=A0 &quot;t,v,t&quot;, 0x7c00018f, 0xfc00ff=
3f, WR_d | RD_s | RD_t,=C2=A0 =C2=A00, I32R6},<br>
+{&quot;crc32cd&quot;,=C2=A0 =C2=A0 &quot;t,v,t&quot;, 0x7c0001cf, 0xfc00ff=
3f, WR_d | RD_s | RD_t,=C2=A0 =C2=A00, I64R6},<br>
<br>
=C2=A0/* MSA */<br>
=C2=A0{&quot;sll.b&quot;,=C2=A0 =C2=A0&quot;+d,+e,+f&quot;, 0x7800000d, 0xf=
fe0003f, WR_VD|RD_VS|RD_VT,=C2=A0 0, MSA},<br>
diff --git a/target/mips/helper.h b/target/mips/helper.h<br>
index c7d35bd..0e61043 100644<br>
--- a/target/mips/helper.h<br>
+++ b/target/mips/helper.h<br>
@@ -40,6 +40,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)<b=
r>
=C2=A0DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)<br>
=C2=A0#endif<br>
<br>
+DEF_HELPER_3(crc32, tl, tl, tl, i32)<br>
+DEF_HELPER_3(crc32c, tl, tl, tl, i32)<br>
=C2=A0DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)<b=
r>
<br>
=C2=A0#ifndef CONFIG_USER_ONLY<br>
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c<br>
index 3104904..5874029 100644<br>
--- a/target/mips/op_helper.c<br>
+++ b/target/mips/op_helper.c<br>
@@ -25,6 +25,8 @@<br>
=C2=A0#include &quot;exec/exec-all.h&quot;<br>
=C2=A0#include &quot;exec/cpu_ldst.h&quot;<br>
=C2=A0#include &quot;sysemu/kvm.h&quot;<br>
+#include &quot;qemu/crc32c.h&quot;<br>
+#include &lt;zlib.h&gt;<br>
<br>
=C2=A0/*****************************<wbr>******************************<wbr=
>******************/<br>
=C2=A0/* Exceptions processing helpers */<br>
@@ -343,6 +345,26 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shi=
ft, uint32_t shiftx,<br>
=C2=A0 =C2=A0 =C2=A0return (int64_t)(int32_t)(uint32_t)<wbr>tmp5;<br>
=C2=A0}<br>
<br>
+/* these crc32 functions are based on target/arm/helper-a64.c */<br>
+target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)<b=
r>
+{<br>
+=C2=A0 =C2=A0 uint8_t buf[8];<br>
+=C2=A0 =C2=A0 target_ulong mask =3D ((sz * 8) =3D=3D 64) ? -1ULL : ((1ULL =
&lt;&lt; (sz * 8)) - 1);<br>
+<br>
+=C2=A0 =C2=A0 m &amp;=3D mask;<br>
+=C2=A0 =C2=A0 stq_le_p(buf, m);<br>
+=C2=A0 =C2=A0 return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xfffff=
fff);<br>
+}<br>
+<br>
+target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)<=
br>
+{<br>
+=C2=A0 =C2=A0 uint8_t buf[8];<br>
+=C2=A0 =C2=A0 target_ulong mask =3D ((sz * 8) =3D=3D 64) ? -1ULL : ((1ULL =
&lt;&lt; (sz * 8)) - 1);<br>
+=C2=A0 =C2=A0 m &amp;=3D mask;<br>
+=C2=A0 =C2=A0 stq_le_p(buf, m);<br>
+=C2=A0 =C2=A0 return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);<br>
+}<br>
+<br>
=C2=A0#ifndef CONFIG_USER_ONLY<br>
<br>
=C2=A0static inline hwaddr do_translate_address(<wbr>CPUMIPSState *env,<br>
diff --git a/target/mips/translate.c b/target/mips/translate.c<br>
index 3f73be0..3f9f113 100644<br>
--- a/target/mips/translate.c<br>
+++ b/target/mips/translate.c<br>
@@ -452,6 +452,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0OPC_LWE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x=
2F | OPC_SPECIAL3,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* R6 */<br>
+=C2=A0 =C2=A0 OPC_CRC32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0F | OPC_S=
PECIAL3,<br>
=C2=A0 =C2=A0 =C2=A0R6_OPC_PREF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x35 | OPC_S=
PECIAL3,<br>
=C2=A0 =C2=A0 =C2=A0R6_OPC_CACHE=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x25 | OPC_S=
PECIAL3,<br>
=C2=A0 =C2=A0 =C2=A0R6_OPC_LL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x36 | =
OPC_SPECIAL3,<br>
@@ -2550,6 +2551,7 @@ typedef struct DisasContext {<br>
=C2=A0 =C2=A0 =C2=A0bool saar;<br>
=C2=A0 =C2=A0 =C2=A0bool mi;<br>
=C2=A0 =C2=A0 =C2=A0int gi;<br>
+=C2=A0 =C2=A0 bool crcp;<br>
=C2=A0} DisasContext;<br>
<br>
=C2=A0#define DISAS_STOP=C2=A0 =C2=A0 =C2=A0 =C2=A0DISAS_TARGET_0<br>
@@ -27041,6 +27043,33 @@ static void decode_opc_special2_legacy(<wbr>CPUMIP=
SState *env, DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int crc32c)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv t0;<br>
+=C2=A0 =C2=A0 TCGv t1;<br>
+=C2=A0 =C2=A0 TCGv_i32 tsz =3D tcg_const_i32(1 &lt;&lt; sz);<br>
+=C2=A0 =C2=A0 if (rd =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Treat as NOP. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 t0 =3D tcg_temp_new();<br>
+=C2=A0 =C2=A0 t1 =3D tcg_temp_new();<br>
+<br>
+=C2=A0 =C2=A0 gen_load_gpr(t0, rt);<br>
+=C2=A0 =C2=A0 gen_load_gpr(t1, rs);<br>
+<br>
+=C2=A0 =C2=A0 if (crc32c) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);<b=
r>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);<br=
>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(tsz);<br>
+}<br>
+<br>
=C2=A0static void decode_opc_special3_r6(<wbr>CPUMIPSState *env, DisasConte=
xt *ctx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int rs, rt, rd, sa;<br>
@@ -27055,6 +27084,17 @@ static void decode_opc_special3_r6(<wbr>CPUMIPSSta=
te *env, DisasContext *ctx)<br>
<br>
=C2=A0 =C2=A0 =C2=A0op1 =3D MASK_SPECIAL3(ctx-&gt;opcode);<br>
=C2=A0 =C2=A0 =C2=A0switch (op1) {<br>
+=C2=A0 =C2=A0 case OPC_CRC32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(!ctx-&gt;crcp) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlikely((extract32(ctx-&gt;<wbr=
>opcode, 6, 2) =3D=3D 3) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(!(ctx-&gt;hflags &amp; MIPS_HFLAG_64))) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlikely((extract32(ctx-&gt;<wbr=
>opcode, 8, 3) &gt;=3D 2))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 generate_exception_end(ctx, EXCP=
_RI);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_crc32(ctx, rt, rs, rt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extract32(c=
tx-&gt;opcode, 6, 2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extract32(c=
tx-&gt;opcode, 8, 3));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0case R6_OPC_PREF:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rt &gt;=3D 24) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* hint codes 24-31 are res=
erved and signal RI */<br>
@@ -30049,6 +30089,7 @@ static void mips_tr_init_disas_context(<wbr>DisasCo=
ntextBase *dcbase, CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;abs2008 =3D (env-&gt;active_fpu.fcr31 &gt;&gt; =
FCR31_ABS2008) &amp; 1;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;mi =3D (env-&gt;CP0_Config5 &gt;&gt; CP0C5_MI) =
&amp; 1;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;gi =3D (env-&gt;CP0_Config5 &gt;&gt; CP0C5_GI) =
&amp; 3;<br>
+=C2=A0 =C2=A0 ctx-&gt;crcp =3D (env-&gt;CP0_Config5 &gt;&gt; CP0C5_CRCP) &=
amp; 1;<br>
=C2=A0 =C2=A0 =C2=A0restore_cpu_state(env, ctx);<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;mem_idx =3D MIPS_HFLAG_UM;<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--00000000000027e06405957c40a6--

