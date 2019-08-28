Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF08C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDF120856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7jfRII5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDF120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2txp-0001eB-21
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2twj-0000hw-2x
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2twg-0001rX-KL
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:08:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2twg-0001qk-85
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:08:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id o184so1189433wme.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3PogXB//ade5QhM5AgZ6H0CTUqMbytroT0ZrRFG02x4=;
 b=E7jfRII56BVDR9c/Ax9XHHPJG6GkbHlCtkFEdwuLmehW9QNYOzQwZuN7Ns3ECQgDj+
 lYmjarCqxcnBp+K+F0bNDY4S6at6hSxXH3SOI787B+EaJqIhckP6zBT98CBXxgWDuHRy
 gkBGAVSf4M8ByKks6x0BppTsvhJqVjKIEfufr8cNvFbs6Dst6lM0hzdg79dlZwkwyLrS
 bY5g6U8glg9NB8XP+dnztrSPW+USSHs/l64xA69r1XxOt7IhFbTKOxnpcr61/SVErvFD
 MPWJ11421eUyXyByNNrv+iuPfkvbiZ9PmB6bDn7rnHQtXKaHsh66LYezAanRL6Pdjs6A
 YkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3PogXB//ade5QhM5AgZ6H0CTUqMbytroT0ZrRFG02x4=;
 b=qYwCf1ggYSpSLplta41QTcFd/mlIrqsJn/xEsSEETFwey5h6AQa4K8vDonoSBBu3jm
 toEY4mbiPdEhqno7rRBUXLRe5HNK/8Kei9jUusMzI+6mkenCmFPptMN64M9yQCQToqjQ
 mYu+7AxXuXO3+PYVrW9WWtIUBoQp2IOhl7ANE0or38OCWNYbYn5oJGZLCilsIeh2ZCVA
 g/290JcJzaOYJeU1Ektl2rAl6ZXDPGmm3ECzwj8KHN7VCjjxc+JpQqSL5hgAYO0A9pmi
 9LXfEA3r5/AyaGHw3/Xx5nq8pJcoybxj4uFnXxE2/gb8Pbg5xwtrst8vl3E0M5GTJkRJ
 VZRQ==
X-Gm-Message-State: APjAAAVIphMd4iFRxy8qNy/+HbRX7me1jmy1qAlemxyVCohST/fTbQ2e
 fJPZTJ96X/3SszCJkIX3FpK/Zg==
X-Google-Smtp-Source: APXvYqzQoUU4qISOPaKr4fN7RTLVcp/2goCUBoRDg+GztCrz8jgoOQpT51bCqgNC8pKK/8QmvheHnA==
X-Received: by 2002:a05:600c:214c:: with SMTP id
 v12mr3554158wml.28.1566983328902; 
 Wed, 28 Aug 2019 02:08:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r5sm1253319wmh.35.2019.08.28.02.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:08:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 89B521FF87;
 Wed, 28 Aug 2019 10:08:47 +0100 (BST)
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: liuzhiwei <zhiwei_liu@c-sky.com>
In-reply-to: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
Date: Wed, 28 Aug 2019 10:08:47 +0100
Message-ID: <87k1ax64io.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu, Alistair.Francis@wdc.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


liuzhiwei <zhiwei_liu@c-sky.com> writes:

> Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
> Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com>
> ---
>  fpu/softfloat.c                         |   119 +
>  include/fpu/softfloat.h                 |     4 +

Changes to softfloat should be in a separate patch, but see bellow.

>  linux-user/riscv/cpu_loop.c             |     8 +-
>  target/riscv/Makefile.objs              |     2 +-
>  target/riscv/cpu.h                      |    30 +
>  target/riscv/cpu_bits.h                 |    15 +
>  target/riscv/cpu_helper.c               |     7 +
>  target/riscv/csr.c                      |    65 +-
>  target/riscv/helper.h                   |   354 +
>  target/riscv/insn32.decode              |   374 +-
>  target/riscv/insn_trans/trans_rvv.inc.c |   484 +
>  target/riscv/translate.c                |     1 +
>  target/riscv/vector_helper.c            | 26563 ++++++++++++++++++++++++=
++++++

This is likely too big to be reviewed. Is it possible to split the patch
up into more discrete chunks, for example support pieces and then maybe
a class at a time?

>  13 files changed, 28017 insertions(+), 9 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>  create mode 100644 target/riscv/vector_helper.c
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 2ba36ec..da155ea 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -433,6 +433,16 @@ static inline int extractFloat16Exp(float16 a)
>  }
>
>  /*----------------------------------------------------------------------=
------
> +| Returns the sign bit of the half-precision floating-point value `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +static inline flag extractFloat16Sign(float16 a)
> +{
> +    return float16_val(a) >> 0xf;
> +}
> +

We are trying to avoid this sort of bit fiddling for new code when we
already have generic decompose functions that can extract all the parts
into a common format.

> +
> +/*----------------------------------------------------------------------=
------
>  | Returns the fraction bits of the single-precision floating-point value=
 `a'.
>  *-----------------------------------------------------------------------=
-----*/
>
> @@ -4790,6 +4800,35 @@ int float32_eq(float32 a, float32 b, float_status =
*status)
>  }
>
>  /*----------------------------------------------------------------------=
------
> +| Returns 1 if the half-precision floating-point value `a' is less than
> +| or equal to the corresponding value `b', and 0 otherwise.  The invalid
> +| exception is raised if either operand is a NaN.  The comparison is per=
formed
> +| according to the IEC/IEEE Standard for Binary Floating-Point Arithmeti=
c.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +int float16_le(float16 a, float16 b, float_status *status)
> +{
> +    flag aSign, bSign;
> +    uint16_t av, bv;
> +    a =3D float16_squash_input_denormal(a, status);
> +    b =3D float16_squash_input_denormal(b, status);
> +
> +    if (    ( ( extractFloat16Exp( a ) =3D=3D 0x1F ) && extractFloat16Fr=
ac( a ) )
> +         || ( ( extractFloat16Exp( b ) =3D=3D 0x1F ) && extractFloat16Fr=
ac( b ) )
> +       ) {
> +        float_raise(float_flag_invalid, status);
> +        return 0;
> +    }
> +    aSign =3D extractFloat16Sign( a );
> +    bSign =3D extractFloat16Sign( b );
> +    av =3D float16_val(a);
> +    bv =3D float16_val(b);
> +    if ( aSign !=3D bSign ) return aSign || ( (uint16_t) ( ( av | bv )<<=
1 ) =3D=3D 0 );
> +    return ( av =3D=3D bv ) || ( aSign ^ ( av < bv ) );
> +
> +}

What does this provide that:

  float16_compare(a, b, status) =3D=3D float_relation_less;

doesn't?

> +
> +/*----------------------------------------------------------------------=
------
>  | Returns 1 if the single-precision floating-point value `a' is less than
>  | or equal to the corresponding value `b', and 0 otherwise.  The invalid
>  | exception is raised if either operand is a NaN.  The comparison is per=
formed
> @@ -4825,6 +4864,35 @@ int float32_le(float32 a, float32 b, float_status =
*status)
>  | to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
>  *-----------------------------------------------------------------------=
-----*/
>
> +int float16_lt(float16 a, float16 b, float_status *status)
> +{
> +    flag aSign, bSign;
> +    uint16_t av, bv;
> +    a =3D float16_squash_input_denormal(a, status);
> +    b =3D float16_squash_input_denormal(b, status);
> +
> +    if (    ( ( extractFloat16Exp( a ) =3D=3D 0x1F ) && extractFloat16Fr=
ac( a ) )
> +         || ( ( extractFloat16Exp( b ) =3D=3D 0x1F ) && extractFloat16Fr=
ac( b ) )
> +       ) {
> +        float_raise(float_flag_invalid, status);
> +        return 0;
> +    }
> +    aSign =3D extractFloat16Sign( a );
> +    bSign =3D extractFloat16Sign( b );
> +    av =3D float16_val(a);
> +    bv =3D float16_val(b);
> +    if ( aSign !=3D bSign ) return aSign && ( (uint16_t) ( ( av | bv )<<=
1 ) !=3D 0 );
> +    return ( av !=3D bv ) && ( aSign ^ ( av < bv ) );
> +
> +}
> +
> +/*----------------------------------------------------------------------=
------
> +| Returns 1 if the single-precision floating-point value `a' is less than
> +| the corresponding value `b', and 0 otherwise.  The invalid exception is
> +| raised if either operand is a NaN.  The comparison is performed accord=
ing
> +| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> +*-----------------------------------------------------------------------=
-----*/
> +
>  int float32_lt(float32 a, float32 b, float_status *status)
>  {
>      flag aSign, bSign;
> @@ -4869,6 +4937,32 @@ int float32_unordered(float32 a, float32 b, float_=
status *status)
>  }
>
>  /*----------------------------------------------------------------------=
------
> +| Returns 1 if the half-precision floating-point value `a' is equal to
> +| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause=
 an
> +| exception.  The comparison is performed according to the IEC/IEEE Stan=
dard
> +| for Binary Floating-Point Arithmetic.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +int float16_eq_quiet(float16 a, float16 b, float_status *status)
> +{
> +    a =3D float16_squash_input_denormal(a, status);
> +    b =3D float16_squash_input_denormal(b, status);
> +
> +    if (    ( ( extractFloat16Exp( a ) =3D=3D 0x1F ) && extractFloat16Fr=
ac( a ) )
> +         || ( ( extractFloat16Exp( b ) =3D=3D 0x1F ) && extractFloat16Fr=
ac( b ) )
> +       ) {
> +        if (float16_is_signaling_nan(a, status)
> +         || float16_is_signaling_nan(b, status)) {
> +            float_raise(float_flag_invalid, status);
> +        }
> +        return 0;
> +    }
> +    return ( float16_val(a) =3D=3D float16_val(b) ) ||
> +            ( (uint16_t) ( ( float16_val(a) | float16_val(b) )<<1 ) =3D=
=3D 0 );
> +}
> +

See also float_16_compare_quiet

> +
> +/*----------------------------------------------------------------------=
------
>  | Returns 1 if the single-precision floating-point value `a' is equal to
>  | the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause=
 an
>  | exception.  The comparison is performed according to the IEC/IEEE Stan=
dard
> @@ -4958,6 +5052,31 @@ int float32_lt_quiet(float32 a, float32 b, float_s=
tatus *status)
>  }
>
>  /*----------------------------------------------------------------------=
------
> +| Returns 1 if the half-precision floating-point values `a' and `b' cann=
ot
> +| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  =
The
> +| comparison is performed according to the IEC/IEEE Standard for Binary
> +| Floating-Point Arithmetic.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +int float16_unordered_quiet(float16 a, float16 b, float_status *status)
> +{
> +    a =3D float16_squash_input_denormal(a, status);
> +    b =3D float16_squash_input_denormal(b, status);
> +
> +    if (    ( ( extractFloat16Exp( a ) =3D=3D 0x1F ) && extractFloat16Fr=
ac( a ) )
> +         || ( ( extractFloat16Exp( b ) =3D=3D 0x1F ) && extractFloat16Fr=
ac( b ) )
> +       ) {
> +        if (float16_is_signaling_nan(a, status)
> +         || float16_is_signaling_nan(b, status)) {
> +            float_raise(float_flag_invalid, status);
> +        }
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +
> +/*----------------------------------------------------------------------=
------
>  | Returns 1 if the single-precision floating-point values `a' and `b' ca=
nnot
>  | be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  =
The
>  | comparison is performed according to the IEC/IEEE Standard for Binary
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 3ff3fa5..3b0754c 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -293,6 +293,10 @@ float16 float16_maxnummag(float16, float16, float_st=
atus *status);
>  float16 float16_sqrt(float16, float_status *status);
>  int float16_compare(float16, float16, float_status *status);
>  int float16_compare_quiet(float16, float16, float_status *status);
> +int float16_unordered_quiet(float16, float16, float_status *status);
> +int float16_le(float16, float16, float_status *status);
> +int float16_lt(float16, float16, float_status *status);
> +int float16_eq_quiet(float16, float16, float_status *status);
>
>  int float16_is_quiet_nan(float16, float_status *status);
>  int float16_is_signaling_nan(float16, float_status *status);
> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index 12aa3c0..b01548a 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -40,7 +40,13 @@ void cpu_loop(CPURISCVState *env)
>          signum =3D 0;
>          sigcode =3D 0;
>          sigaddr =3D 0;
> -
> +        if (env->foflag) {
> +            if (env->vfp.vl !=3D 0) {
> +                env->foflag =3D false;
> +                env->pc +=3D 4;
> +                continue;
> +            }
> +        }

What is this trying to do?

>          switch (trapnr) {
>          case EXCP_INTERRUPT:
>              /* just indicate that signals should be handled asap */
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index b1c79bc..d577cef 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o=
 gdbstub.o pmp.o
> +obj-y +=3D translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o=
 vector_helper.o gdbstub.o pmp.o
>
>  DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307..5a93aa2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -67,6 +67,7 @@
>  #define RVC RV('C')
>  #define RVS RV('S')
>  #define RVU RV('U')
> +#define RVV RV('V')
>
>  /* S extension denotes that Supervisor mode exists, however it is possib=
le
>     to have a core that support S mode but does not have an MMU and there
> @@ -93,9 +94,38 @@ typedef struct CPURISCVState CPURISCVState;
>
>  #include "pmp.h"
>
> +#define VLEN 128
> +#define VUNIT(x) (VLEN / x)
> +

If you want to do vectors I suggest you look at the TCGvec types for
passing pointers to vector registers to helpers. In this case you will
want to ensure your vector registers are properly aligned.

>  struct CPURISCVState {
>      target_ulong gpr[32];
>      uint64_t fpr[32]; /* assume both F and D extensions */
> +
> +    /* vector coprocessor state.  */
> +    struct {
> +        union VECTOR {
> +            float64  f64[VUNIT(64)];
> +            float32  f32[VUNIT(32)];
> +            float16  f16[VUNIT(16)];
> +            target_ulong ul[VUNIT(sizeof(target_ulong))];
> +            uint64_t u64[VUNIT(64)];
> +            int64_t  s64[VUNIT(64)];
> +            uint32_t u32[VUNIT(32)];
> +            int32_t  s32[VUNIT(32)];
> +            uint16_t u16[VUNIT(16)];
> +            int16_t  s16[VUNIT(16)];
> +            uint8_t  u8[VUNIT(8)];
> +            int8_t   s8[VUNIT(8)];
> +        } vreg[32];
> +        target_ulong vxrm;
> +        target_ulong vxsat;
> +        target_ulong vl;
> +        target_ulong vstart;
> +        target_ulong vtype;
> +        float_status fp_status;
> +    } vfp;
> +
> +    bool         foflag;

Again I have no idea what foflag is here.

>      target_ulong pc;
>      target_ulong load_res;
>      target_ulong load_val;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 11f971a..9eb43ec 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -29,6 +29,14 @@
>  #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
>  #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR=
_NXA)
>
> +/* Vector Fixed-Point round model */
> +#define FSR_VXRM_SHIFT      9
> +#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
> +
> +/* Vector Fixed-Point saturation flag */
> +#define FSR_VXSAT_SHIFT     8
> +#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
> +
>  /* Control and Status Registers */
>
>  /* User Trap Setup */
> @@ -48,6 +56,13 @@
>  #define CSR_FRM             0x002
>  #define CSR_FCSR            0x003
>
> +/* User Vector CSRs */
> +#define CSR_VSTART          0x008
> +#define CSR_VXSAT           0x009
> +#define CSR_VXRM            0x00a
> +#define CSR_VL              0xc20
> +#define CSR_VTYPE           0xc21
> +
>  /* User Timers and Counters */
>  #define CSR_CYCLE           0xc00
>  #define CSR_TIME            0xc01
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e32b612..405caf6 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -521,6 +521,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          [PRV_H] =3D RISCV_EXCP_H_ECALL,
>          [PRV_M] =3D RISCV_EXCP_M_ECALL
>      };
> +    if (env->foflag) {
> +        if (env->vfp.vl !=3D 0) {
> +            env->foflag =3D false;
> +            env->pc +=3D 4;
> +            return;
> +        }
> +    }
>
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e0d4586..a6131ff 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -87,12 +87,12 @@ static int ctr(CPURISCVState *env, int csrno)
>      return 0;
>  }
>
> -#if !defined(CONFIG_USER_ONLY)
>  static int any(CPURISCVState *env, int csrno)
>  {
>      return 0;
>  }
>
> +#if !defined(CONFIG_USER_ONLY)
>  static int smode(CPURISCVState *env, int csrno)
>  {
>      return -!riscv_has_ext(env, RVS);
> @@ -158,8 +158,10 @@ static int read_fcsr(CPURISCVState *env, int csrno, =
target_ulong *val)
>          return -1;
>      }
>  #endif
> -    *val =3D (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
> -        | (env->frm << FSR_RD_SHIFT);
> +    *val =3D (env->vfp.vxrm << FSR_VXRM_SHIFT)
> +            | (env->vfp.vxsat << FSR_VXSAT_SHIFT)
> +            | (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
> +            | (env->frm << FSR_RD_SHIFT);
>      return 0;
>  }
>
> @@ -172,10 +174,60 @@ static int write_fcsr(CPURISCVState *env, int csrno=
, target_ulong val)
>      env->mstatus |=3D MSTATUS_FS;
>  #endif
>      env->frm =3D (val & FSR_RD) >> FSR_RD_SHIFT;
> +    env->vfp.vxrm =3D (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
> +    env->vfp.vxsat =3D (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
>      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>      return 0;
>  }
>
> +static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->vfp.vtype;
> +    return 0;
> +}
> +
> +static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->vfp.vl;
> +    return 0;
> +}
> +
> +static int read_vxrm(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->vfp.vxrm;
> +    return 0;
> +}
> +
> +static int read_vxsat(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->vfp.vxsat;
> +    return 0;
> +}
> +
> +static int read_vstart(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->vfp.vstart;
> +    return 0;
> +}
> +
> +static int write_vxrm(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vfp.vxrm =3D val;
> +    return 0;
> +}
> +
> +static int write_vxsat(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vfp.vxsat =3D val;
> +    return 0;
> +}
> +
> +static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    env->vfp.vstart =3D val;
> +    return 0;
> +}

A fixed return value makes me think these should be void functions.

> +
>  /* User Timers and Counters */
>  static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> @@ -873,7 +925,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
=3D {
>      [CSR_FFLAGS] =3D              { fs,   read_fflags,      write_fflags=
      },
>      [CSR_FRM] =3D                 { fs,   read_frm,         write_frm   =
      },
>      [CSR_FCSR] =3D                { fs,   read_fcsr,        write_fcsr  =
      },
> -
> +    /* Vector CSRs */
> +    [CSR_VSTART] =3D              { any,   read_vstart,     write_vstart=
      },
> +    [CSR_VXSAT] =3D               { any,   read_vxsat,      write_vxsat =
      },
> +    [CSR_VXRM] =3D                { any,   read_vxrm,       write_vxrm  =
      },
> +    [CSR_VL] =3D                  { any,   read_vl                      =
      },
> +    [CSR_VTYPE] =3D               { any,   read_vtype                   =
      },
>      /* User Timers and Counters */
>      [CSR_CYCLE] =3D               { ctr,  read_instret                  =
      },
>      [CSR_INSTRET] =3D             { ctr,  read_instret                  =
      },
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index debb22a..fee02c0 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -76,3 +76,357 @@ DEF_HELPER_2(mret, tl, env, tl)
>  DEF_HELPER_1(wfi, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
>  #endif
> +/* Vector functions */

Think about how you could split this patch up to introduce a group of
instructions at a time. This will make it a lot easier review.

I'm going to leave review of the specifics to the RISCV maintainers but
I suspect they will want to wait until a v2 of the series. However it
looks like a good first pass at implementing vectors.

--
Alex Benn=C3=A9e

