Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4ACC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 20:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBAC2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 20:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFQBtb3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBAC2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRLdQ-0005at-Cs
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 16:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRLcB-0004qU-Mn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRLc9-0002Tq-VD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:04:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRLc9-0002J4-Gx
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:04:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so3976364wma.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=n3qyYTobdBCFjVRPEDkwnOfMZVp9RXvbPMtzM9vaTV8=;
 b=RFQBtb3PieMR0GUdyhGMAkQjuFlkGek+l4KBPqpxyAt65lxb+HbgnBjengLGr6aEF+
 E/CHT8B5zCxOHW89oJfyLfU13CKMWhwpXlxrrj8hgXT6GHXjdpGPODIS67TkyxkbC2kH
 w5jKhbaFZTva5PpgYduiFwMPYRCSe7k8+bo3B8mq+RksdVFf7DjFU8ZjbBndntZxq8jX
 XAxxVTgk9pMD23fq6hXm5lIaCeJjsfC6GV+/of8sGsHRRb9yf9iy4Pvd9+UVlWCX7XW7
 g5/7hMJ1Jhms9cmxlR6V8MwgJI1dKbCk3xfwX55VHBMTvcxe7eYy6Ng9G5AvMnuITHPb
 PaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=n3qyYTobdBCFjVRPEDkwnOfMZVp9RXvbPMtzM9vaTV8=;
 b=kx9TvJENd0aJf4j1kpoAwgGA+CWxDuf9yIX+Wcy1bMCiWqlgXu/lwb3yPST/NAD3ub
 4MXTGGP8d3SbFlAUfjL6hl9UBFFbV+H8S7KqhqzA1x3/Zy+zRL41jJTQgoe6T+m1N67w
 /TDqVqDqxmOn1VUyPd2dAhCIxb1mdtDI8SKPcG50ZduPCi4L0np5a/0fop5RPrv+Qded
 J8K1bjB8jqCxDCcwMUb9p5kcyFz+AIKi+AhQgOq/NWo7nchANiMlnLzZ2u5Ny6GvGYd+
 u5+a5zDEhqHRt08VNW38ptraMRFozIm5EPQTq3CbuJSxk5MFbSH3I/WtofvNwTEFJSXA
 GlQA==
X-Gm-Message-State: AGi0PuaO/2ysr+xqLb0QCTNXTNfw7eaN0juLMe4k9kInsIwJGx9Bsyie
 VTvcjSP+jxULLmHt68FIAP8FRA==
X-Google-Smtp-Source: APiQypKFAaGTc21Il9495vslZKT0gQE1e4eb3wgN+ZWXmYk/chIINmOjOXeHtpsMv9FiNLfn1L2TJA==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr159179wmk.73.1587585893841;
 Wed, 22 Apr 2020 13:04:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p5sm363878wrg.49.2020.04.22.13.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 13:04:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB9431FF7E;
 Wed, 22 Apr 2020 21:04:51 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-14-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 13/36] tcg: Use tcg_constant_{i32,i64} with tcg int
 expanders
In-reply-to: <20200422011722.13287-14-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 21:04:51 +0100
Message-ID: <87ftcvb82k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

We have a regression. Setting up a build dir with:

  ../../configure --disable-tools --disable-docs --target-list=3Dsparc-soft=
mmu,sparc64-softmmu
  make -j30 && make check-acceptance

And then running a bisect between HEAD and master:

  git bisect run /bin/sh -c "cd builds/bisect && make -j30 && ./tests/venv/=
bin/avocado run ./tests/acceptance/boot_linux_console.py:BootLinuxConsole.t=
est_sparc_ss20"

Fingers:

  a4d42b76dd29818e4f393c4c3eb59601b0015b2f is the first bad commit
  commit a4d42b76dd29818e4f393c4c3eb59601b0015b2f
  Author: Richard Henderson <richard.henderson@linaro.org>
  Date:   Tue Apr 21 18:16:59 2020 -0700

      tcg: Use tcg_constant_{i32,i64} with tcg int expanders

      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
      Message-Id: <20200422011722.13287-14-richard.henderson@linaro.org>

  :040000 040000 45283ae0961f2794f5f15e09c29f160372fb5fae 92939e91645a5cf4f=
c36d475ff5dddd0839a7314 M      include
  :040000 040000 1083f94f8f045924fbf1e1f9c116f05827c25345 31a5dfc97636fcd0a=
114b910095b11cb767a22db M      tcg
  bisect run success

> ---
>  include/tcg/tcg-op.h |  13 +--
>  tcg/tcg-op.c         | 216 ++++++++++++++++++++-----------------------
>  2 files changed, 100 insertions(+), 129 deletions(-)
>
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 230db6e022..11ed9192f7 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -271,6 +271,7 @@ void tcg_gen_mb(TCGBar);
>=20=20
>  /* 32 bit ops */
>=20=20
> +void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
>  void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
>  void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
>  void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> @@ -349,11 +350,6 @@ static inline void tcg_gen_mov_i32(TCGv_i32 ret, TCG=
v_i32 arg)
>      }
>  }
>=20=20
> -static inline void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
> -{
> -    tcg_gen_op2i_i32(INDEX_op_movi_i32, ret, arg);
> -}
> -
>  static inline void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2,
>                                      tcg_target_long offset)
>  {
> @@ -467,6 +463,7 @@ static inline void tcg_gen_not_i32(TCGv_i32 ret, TCGv=
_i32 arg)
>=20=20
>  /* 64 bit ops */
>=20=20
> +void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
>  void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
>  void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
>  void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> @@ -550,11 +547,6 @@ static inline void tcg_gen_mov_i64(TCGv_i64 ret, TCG=
v_i64 arg)
>      }
>  }
>=20=20
> -static inline void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
> -{
> -    tcg_gen_op2i_i64(INDEX_op_movi_i64, ret, arg);
> -}
> -
>  static inline void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2,
>                                      tcg_target_long offset)
>  {
> @@ -698,7 +690,6 @@ static inline void tcg_gen_sub_i64(TCGv_i64 ret, TCGv=
_i64 arg1, TCGv_i64 arg2)
>=20=20
>  void tcg_gen_discard_i64(TCGv_i64 arg);
>  void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg);
> -void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
>  void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offse=
t);
>  void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offse=
t);
>  void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offs=
et);
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index e2e25ebf7d..07eb661a07 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -104,15 +104,18 @@ void tcg_gen_mb(TCGBar mb_type)
>=20=20
>  /* 32 bit ops */
>=20=20
> +void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
> +{
> +    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
> +}
> +
>  void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
>      /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_add_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
> @@ -122,9 +125,7 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TC=
Gv_i32 arg2)
>          /* Don't recurse with tcg_gen_neg_i32.  */
>          tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg2);
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg1);
> -        tcg_gen_sub_i32(ret, t0, arg2);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
>      }
>  }
>=20=20
> @@ -134,15 +135,12 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, =
int32_t arg2)
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_sub_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_sub_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
>  void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>  {
> -    TCGv_i32 t0;
>      /* Some cases can be optimized here.  */
>      switch (arg2) {
>      case 0:
> @@ -165,9 +163,8 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, in=
t32_t arg2)
>          }
>          break;
>      }
> -    t0 =3D tcg_const_i32(arg2);
> -    tcg_gen_and_i32(ret, arg1, t0);
> -    tcg_temp_free_i32(t0);
> +
> +    tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
>  }
>=20=20
>  void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
> @@ -178,9 +175,7 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int=
32_t arg2)
>      } else if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_or_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
> @@ -193,9 +188,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, in=
t32_t arg2)
>          /* Don't recurse with tcg_gen_not_i32.  */
>          tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_xor_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
> @@ -205,9 +198,7 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, in=
t32_t arg2)
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_shl_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
> @@ -217,9 +208,7 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, in=
t32_t arg2)
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_shr_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
> @@ -229,9 +218,7 @@ void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, in=
t32_t arg2)
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_sar_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
> @@ -250,9 +237,7 @@ void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1,=
 int32_t arg2, TCGLabel *l)
>      if (cond =3D=3D TCG_COND_ALWAYS) {
>          tcg_gen_br(l);
>      } else if (cond !=3D TCG_COND_NEVER) {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_brcond_i32(cond, arg1, t0, l);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
>      }
>  }
>=20=20
> @@ -271,9 +256,7 @@ void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
>  void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
>                            TCGv_i32 arg1, int32_t arg2)
>  {
> -    TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -    tcg_gen_setcond_i32(cond, ret, arg1, t0);
> -    tcg_temp_free_i32(t0);
> +    tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
>  }
>=20=20
>  void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
> @@ -283,9 +266,7 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, in=
t32_t arg2)
>      } else if (is_power_of_2(arg2)) {
>          tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
>      } else {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_mul_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
> @@ -433,9 +414,7 @@ void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCG=
v_i32 arg2)
>=20=20
>  void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
>  {
> -    TCGv_i32 t =3D tcg_const_i32(arg2);
> -    tcg_gen_clz_i32(ret, arg1, t);
> -    tcg_temp_free_i32(t);
> +    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
>  }
>=20=20
>  void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
> @@ -468,10 +447,9 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TC=
Gv_i32 arg2)
>              tcg_gen_clzi_i32(t, t, 32);
>              tcg_gen_xori_i32(t, t, 31);
>          }
> -        z =3D tcg_const_i32(0);
> +        z =3D tcg_constant_i32(0);
>          tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
>          tcg_temp_free_i32(t);
> -        tcg_temp_free_i32(z);
>      } else {
>          gen_helper_ctz_i32(ret, arg1, arg2);
>      }
> @@ -487,9 +465,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, ui=
nt32_t arg2)
>          tcg_gen_ctpop_i32(ret, t);
>          tcg_temp_free_i32(t);
>      } else {
> -        TCGv_i32 t =3D tcg_const_i32(arg2);
> -        tcg_gen_ctz_i32(ret, arg1, t);
> -        tcg_temp_free_i32(t);
> +        tcg_gen_ctz_i32(ret, arg1, tcg_constant_i32(arg2));
>      }
>  }
>=20=20
> @@ -547,9 +523,7 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, u=
nsigned arg2)
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i32(ret, arg1);
>      } else if (TCG_TARGET_HAS_rot_i32) {
> -        TCGv_i32 t0 =3D tcg_const_i32(arg2);
> -        tcg_gen_rotl_i32(ret, arg1, t0);
> -        tcg_temp_free_i32(t0);
> +        tcg_gen_rotl_i32(ret, arg1, tcg_constant_i32(arg2));
>      } else {
>          TCGv_i32 t0, t1;
>          t0 =3D tcg_temp_new_i32();
> @@ -653,9 +627,8 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
>          tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
>      } else if (TCG_TARGET_HAS_deposit_i32
>                 && TCG_TARGET_deposit_i32_valid(ofs, len)) {
> -        TCGv_i32 zero =3D tcg_const_i32(0);
> +        TCGv_i32 zero =3D tcg_constant_i32(0);
>          tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len=
);
> -        tcg_temp_free_i32(zero);
>      } else {
>          /* To help two-operand hosts we prefer to zero-extend first,
>             which allows ARG to stay live.  */
> @@ -1052,7 +1025,7 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
>      } else {
>          TCGv_i32 t0 =3D tcg_temp_new_i32();
>          TCGv_i32 t1 =3D tcg_temp_new_i32();
> -        TCGv_i32 t2 =3D tcg_const_i32(0x00ff00ff);
> +        TCGv_i32 t2 =3D tcg_constant_i32(0x00ff00ff);
>=20=20
>                                          /* arg =3D abcd */
>          tcg_gen_shri_i32(t0, arg, 8);   /*  t0 =3D .abc */
> @@ -1067,7 +1040,6 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
>=20=20
>          tcg_temp_free_i32(t0);
>          tcg_temp_free_i32(t1);
> -        tcg_temp_free_i32(t2);
>      }
>  }
>=20=20
> @@ -1237,6 +1209,14 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, =
TCGv_i64 arg2)
>      tcg_temp_free_i64(t0);
>      tcg_temp_free_i32(t1);
>  }
> +
> +#else
> +
> +void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
> +{
> +    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
> +}
> +
>  #endif /* TCG_TARGET_REG_SIZE =3D=3D 32 */
>=20=20
>  void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
> @@ -1244,10 +1224,12 @@ void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1=
, int64_t arg2)
>      /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
> +    } else if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
>      } else {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_add_i64(ret, arg1, t0);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
> +                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
> +                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >=
> 32));
>      }
>  }
>=20=20
> @@ -1256,10 +1238,12 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1=
, TCGv_i64 arg2)
>      if (arg1 =3D=3D 0 && TCG_TARGET_HAS_neg_i64) {
>          /* Don't recurse with tcg_gen_neg_i64.  */
>          tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg2);
> +    } else if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
>      } else {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg1);
> -        tcg_gen_sub_i64(ret, t0, arg2);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
> +                         tcg_constant_i32(arg1), tcg_constant_i32(arg1 >=
> 32),
> +                         TCGV_LOW(arg2), TCGV_HIGH(arg2));
>      }
>  }
>=20=20
> @@ -1268,17 +1252,17 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1=
, int64_t arg2)
>      /* some cases can be optimized here */
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
> +    } else if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +        tcg_gen_sub_i64(ret, arg1, tcg_constant_i64(arg2));
>      } else {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_sub_i64(ret, arg1, t0);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
> +                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
> +                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >=
> 32));
>      }
>  }
>=20=20
>  void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
>  {
> -    TCGv_i64 t0;
> -
>      if (TCG_TARGET_REG_BITS =3D=3D 32) {
>          tcg_gen_andi_i32(TCGV_LOW(ret), TCGV_LOW(arg1), arg2);
>          tcg_gen_andi_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), arg2 >> 32);
> @@ -1313,9 +1297,8 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, =
int64_t arg2)
>          }
>          break;
>      }
> -    t0 =3D tcg_const_i64(arg2);
> -    tcg_gen_and_i64(ret, arg1, t0);
> -    tcg_temp_free_i64(t0);
> +
> +    tcg_gen_and_i64(ret, arg1, tcg_constant_i64(arg2));
>  }
>=20=20
>  void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
> @@ -1331,9 +1314,7 @@ void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, i=
nt64_t arg2)
>      } else if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
>      } else {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_or_i64(ret, arg1, t0);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
>      }
>  }
>=20=20
> @@ -1351,9 +1332,7 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, =
int64_t arg2)
>          /* Don't recurse with tcg_gen_not_i64.  */
>          tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
>      } else {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_xor_i64(ret, arg1, t0);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
>      }
>  }
>=20=20
> @@ -1415,9 +1394,7 @@ void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, =
int64_t arg2)
>      } else if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
>      } else {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_shl_i64(ret, arg1, t0);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
>      }
>  }
>=20=20
> @@ -1429,9 +1406,7 @@ void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, =
int64_t arg2)
>      } else if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
>      } else {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_shr_i64(ret, arg1, t0);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
>      }
>  }
>=20=20
> @@ -1443,9 +1418,7 @@ void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, =
int64_t arg2)
>      } else if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
>      } else {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_sar_i64(ret, arg1, t0);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
>      }
>  }
>=20=20
> @@ -1468,12 +1441,17 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 ar=
g1, TCGv_i64 arg2, TCGLabel *l)
>=20=20
>  void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGL=
abel *l)
>  {
> -    if (cond =3D=3D TCG_COND_ALWAYS) {
> +    if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +        tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
> +    } else if (cond =3D=3D TCG_COND_ALWAYS) {
>          tcg_gen_br(l);
>      } else if (cond !=3D TCG_COND_NEVER) {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_brcond_i64(cond, arg1, t0, l);
> -        tcg_temp_free_i64(t0);
> +        l->refs++;
> +        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
> +                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
> +                          tcg_constant_i32(arg2),
> +                          tcg_constant_i32(arg2 >> 32),
> +                          cond, label_arg(l));
>      }
>  }
>=20=20
> @@ -1499,9 +1477,19 @@ void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 re=
t,
>  void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
>                            TCGv_i64 arg1, int64_t arg2)
>  {
> -    TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -    tcg_gen_setcond_i64(cond, ret, arg1, t0);
> -    tcg_temp_free_i64(t0);
> +    if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +        tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
> +    } else if (cond =3D=3D TCG_COND_ALWAYS) {
> +        tcg_gen_movi_i64(ret, 1);
> +    } else if (cond =3D=3D TCG_COND_NEVER) {
> +        tcg_gen_movi_i64(ret, 0);
> +    } else {
> +        tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
> +                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
> +                         tcg_constant_i32(arg2),
> +                         tcg_constant_i32(arg2 >> 32), cond);
> +        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
> +    }
>  }
>=20=20
>  void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
> @@ -1690,7 +1678,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg)
>      } else {
>          TCGv_i64 t0 =3D tcg_temp_new_i64();
>          TCGv_i64 t1 =3D tcg_temp_new_i64();
> -        TCGv_i64 t2 =3D tcg_const_i64(0x00ff00ff);
> +        TCGv_i64 t2 =3D tcg_constant_i64(0x00ff00ff);
>=20=20
>                                          /* arg =3D ....abcd */
>          tcg_gen_shri_i64(t0, arg, 8);   /*  t0 =3D .....abc */
> @@ -1706,7 +1694,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg)
>=20=20
>          tcg_temp_free_i64(t0);
>          tcg_temp_free_i64(t1);
> -        tcg_temp_free_i64(t2);
>      }
>  }
>=20=20
> @@ -1850,16 +1837,16 @@ void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1=
, uint64_t arg2)
>      if (TCG_TARGET_REG_BITS =3D=3D 32
>          && TCG_TARGET_HAS_clz_i32
>          && arg2 <=3D 0xffffffffu) {
> -        TCGv_i32 t =3D tcg_const_i32((uint32_t)arg2 - 32);
> -        tcg_gen_clz_i32(t, TCGV_LOW(arg1), t);
> +        TCGv_i32 t =3D tcg_temp_new_i32();
> +        tcg_gen_clzi_i32(t, TCGV_LOW(arg1), arg2 - 32);
>          tcg_gen_addi_i32(t, t, 32);
>          tcg_gen_clz_i32(TCGV_LOW(ret), TCGV_HIGH(arg1), t);
>          tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
>          tcg_temp_free_i32(t);
>      } else {
> -        TCGv_i64 t =3D tcg_const_i64(arg2);
> -        tcg_gen_clz_i64(ret, arg1, t);
> -        tcg_temp_free_i64(t);
> +        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> +        tcg_gen_clz_i64(ret, arg1, t0);
> +        tcg_temp_free_i64(t0);
>      }
>  }
>=20=20
> @@ -1881,7 +1868,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, T=
CGv_i64 arg2)
>              tcg_gen_clzi_i64(t, t, 64);
>              tcg_gen_xori_i64(t, t, 63);
>          }
> -        z =3D tcg_const_i64(0);
> +        z =3D tcg_constant_i64(0);
>          tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
>          tcg_temp_free_i64(t);
>          tcg_temp_free_i64(z);
> @@ -1895,8 +1882,8 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, =
uint64_t arg2)
>      if (TCG_TARGET_REG_BITS =3D=3D 32
>          && TCG_TARGET_HAS_ctz_i32
>          && arg2 <=3D 0xffffffffu) {
> -        TCGv_i32 t32 =3D tcg_const_i32((uint32_t)arg2 - 32);
> -        tcg_gen_ctz_i32(t32, TCGV_HIGH(arg1), t32);
> +        TCGv_i32 t32 =3D tcg_temp_new_i32();
> +        tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
>          tcg_gen_addi_i32(t32, t32, 32);
>          tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
>          tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
> @@ -1911,9 +1898,9 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, =
uint64_t arg2)
>          tcg_gen_ctpop_i64(ret, t);
>          tcg_temp_free_i64(t);
>      } else {
> -        TCGv_i64 t64 =3D tcg_const_i64(arg2);
> -        tcg_gen_ctz_i64(ret, arg1, t64);
> -        tcg_temp_free_i64(t64);
> +        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> +        tcg_gen_ctz_i64(ret, arg1, t0);
> +        tcg_temp_free_i64(t0);
>      }
>  }
>=20=20
> @@ -1969,9 +1956,7 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1,=
 unsigned arg2)
>      if (arg2 =3D=3D 0) {
>          tcg_gen_mov_i64(ret, arg1);
>      } else if (TCG_TARGET_HAS_rot_i64) {
> -        TCGv_i64 t0 =3D tcg_const_i64(arg2);
> -        tcg_gen_rotl_i64(ret, arg1, t0);
> -        tcg_temp_free_i64(t0);
> +        tcg_gen_rotl_i64(ret, arg1, tcg_constant_i64(arg2));
>      } else {
>          TCGv_i64 t0, t1;
>          t0 =3D tcg_temp_new_i64();
> @@ -2089,9 +2074,8 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 a=
rg,
>          tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
>      } else if (TCG_TARGET_HAS_deposit_i64
>                 && TCG_TARGET_deposit_i64_valid(ofs, len)) {
> -        TCGv_i64 zero =3D tcg_const_i64(0);
> +        TCGv_i64 zero =3D tcg_constant_i64(0);
>          tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len=
);
> -        tcg_temp_free_i64(zero);
>      } else {
>          if (TCG_TARGET_REG_BITS =3D=3D 32) {
>              if (ofs >=3D 32) {
> @@ -3102,9 +3086,8 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv=
 addr, TCGv_i32 cmpv,
>=20=20
>  #ifdef CONFIG_SOFTMMU
>          {
> -            TCGv_i32 oi =3D tcg_const_i32(make_memop_idx(memop & ~MO_SIG=
N, idx));
> -            gen(retv, cpu_env, addr, cmpv, newv, oi);
> -            tcg_temp_free_i32(oi);
> +            TCGMemOpIdx oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
> +            gen(retv, cpu_env, addr, cmpv, newv, tcg_constant_i32(oi));
>          }
>  #else
>          gen(retv, cpu_env, addr, cmpv, newv);
> @@ -3147,9 +3130,8 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv=
 addr, TCGv_i64 cmpv,
>=20=20
>  #ifdef CONFIG_SOFTMMU
>          {
> -            TCGv_i32 oi =3D tcg_const_i32(make_memop_idx(memop, idx));
> -            gen(retv, cpu_env, addr, cmpv, newv, oi);
> -            tcg_temp_free_i32(oi);
> +            TCGMemOpIdx oi =3D make_memop_idx(memop, idx);
> +            gen(retv, cpu_env, addr, cmpv, newv, tcg_constant_i32(oi));
>          }
>  #else
>          gen(retv, cpu_env, addr, cmpv, newv);
> @@ -3210,9 +3192,8 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv add=
r, TCGv_i32 val,
>=20=20
>  #ifdef CONFIG_SOFTMMU
>      {
> -        TCGv_i32 oi =3D tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, i=
dx));
> -        gen(ret, cpu_env, addr, val, oi);
> -        tcg_temp_free_i32(oi);
> +        TCGMemOpIdx oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
> +        gen(ret, cpu_env, addr, val, tcg_constant_i32(oi));
>      }
>  #else
>      gen(ret, cpu_env, addr, val);
> @@ -3255,9 +3236,8 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv add=
r, TCGv_i64 val,
>=20=20
>  #ifdef CONFIG_SOFTMMU
>          {
> -            TCGv_i32 oi =3D tcg_const_i32(make_memop_idx(memop & ~MO_SIG=
N, idx));
> -            gen(ret, cpu_env, addr, val, oi);
> -            tcg_temp_free_i32(oi);
> +            TCGMemOpIdx oi =3D make_memop_idx(memop & ~MO_SIGN, idx);
> +            gen(ret, cpu_env, addr, val, tcg_constant_i32(oi));
>          }
>  #else
>          gen(ret, cpu_env, addr, val);


--=20
Alex Benn=C3=A9e

