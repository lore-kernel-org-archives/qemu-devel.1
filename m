Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F7C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE3620735
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al4ki30B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRBRZ-0004wP-I8
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 05:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jRBQa-0004VH-Lo
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jRBQZ-0000V7-0k
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:12:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jRBQY-0000QB-GO
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:12:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id v4so4405926wme.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=+5SvUSocQ16vavAyCCi86Tqqylqdf38GWnn4J678WG8=;
 b=Al4ki30BExko3rQ7ilHTeJXVz/xnLodxvmdQbcZNbWDJhwZkZ4qKbkjCKSKRbXgP40
 6iI7fFy8VPkUiSyg7QtAXlG0QPOse9Fbr7gQ71LRlcL3mvU7ATVFqlv9SOHi1C36rCIF
 Bok12Kwz5cCagzDEEZEH/6aWJhu9AFm1X9R1wCq2qKs66Lgy8s4eoHGeAcjJFLQIcK32
 vZE3NjtdHJqqGNDkZ1zvCr6nSWExIuARiMzQzdCFe+2niTjP41DPY0yy0LY9HVXSCvSf
 gWGsLmSInrzOXITWgwAFXfD8nb1DrQ3sR9CHiqOQJjTNIg1UiZeutwGwJU5rxJ4vqO6K
 hAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=+5SvUSocQ16vavAyCCi86Tqqylqdf38GWnn4J678WG8=;
 b=jMHLAr3OTd/A9mj9jNeXDD+yzA7SiER6FpoLAcdLsjhKnczVtr2m7OiGbpJjOpqAd/
 rH81x+/JLMtlFxclp9UiqLCPYUu0oVARTSZPqQo4nqSulkfsLYJifAisJmSF/Yk6I5lb
 pCi433/UvywB8jrQ3O/RXDwqHrbouPvsFhYbOxcmnCn+1dJejUYKN6nNdV6cj1PRRlRr
 yN8Qmb68nWnXB2+rIx2VlbX6n60rTCX9AcoVHf2a31bYUxCgf0isCmA/62zKdK/zZzLF
 bdV8/8JSguMEh09493gUwFik/Y+wrxc76m3de1UEc7FnK8y1lQKaONNDcajXBKNMj0Jr
 Bu6A==
X-Gm-Message-State: AGi0Pub5Llfbf3zdPiXqPI9p1W9GKIt9gYs9jBesD8Ubsce1mN2Mbe5f
 w9hIYvvp0NBx0G3YqS6uSPMH2HVq813Ue8dKlx0=
X-Google-Smtp-Source: APiQypL3eT8nFOmc1fyALD9/LHHTpUkRfDy8xsn7Ph6ngj63nQo0WdaWLQJes2PuvlEERfF2EBtjZv05kbRzokY75YE=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr9064777wmk.36.1587546736815; 
 Wed, 22 Apr 2020 02:12:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c3:0:0:0:0:0 with HTTP; Wed, 22 Apr 2020 02:12:16
 -0700 (PDT)
In-Reply-To: <20200422011722.13287-21-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-21-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 22 Apr 2020 11:12:16 +0200
Message-ID: <CAHiYmc4GMkNteMDRE2j7uqsMzhJc5BE3qXmr9DzdeCFjsVZopw@mail.gmail.com>
Subject: Re: [PATCH v2 20/36] tcg: Remove movi and dupi opcodes
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004ff1aa05a3dd8715"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004ff1aa05a3dd8715
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 22. =D0=B0=D0=BF=D1=80=D0=B8=D0=BB 2020., R=
ichard Henderson <richard.henderson@linaro.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> These are now completely covered by mov from a
> TYPE_CONST temporary.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


>  include/tcg/tcg-opc.h        |  3 ---
>  tcg/aarch64/tcg-target.inc.c |  3 ---
>  tcg/arm/tcg-target.inc.c     |  1 -
>  tcg/i386/tcg-target.inc.c    |  3 ---
>  tcg/mips/tcg-target.inc.c    |  2 --
>  tcg/optimize.c               |  4 ----
>  tcg/ppc/tcg-target.inc.c     |  3 ---
>  tcg/riscv/tcg-target.inc.c   |  2 --
>  tcg/s390/tcg-target.inc.c    |  2 --
>  tcg/sparc/tcg-target.inc.c   |  2 --
>  tcg/tcg-op-vec.c             |  1 -
>  tcg/tcg.c                    | 18 +-----------------
>  tcg/tci/tcg-target.inc.c     |  2 --
>  13 files changed, 1 insertion(+), 45 deletions(-)
>
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 7dee9b38f7..4a9cbf5426 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -45,7 +45,6 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END)
>  DEF(mb, 0, 0, 1, 0)
>
>  DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
> -DEF(movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)
>  DEF(setcond_i32, 1, 2, 1, 0)
>  DEF(movcond_i32, 1, 4, 1, IMPL(TCG_TARGET_HAS_movcond_i32))
>  /* load/store */
> @@ -110,7 +109,6 @@ DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
>  DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
>
>  DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
> -DEF(movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
>  DEF(setcond_i64, 1, 2, 1, IMPL64)
>  DEF(movcond_i64, 1, 4, 1, IMPL64 | IMPL(TCG_TARGET_HAS_movcond_i64))
>  /* load/store */
> @@ -215,7 +213,6 @@ DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,
>  #define IMPLVEC  TCG_OPF_VECTOR | IMPL(TCG_TARGET_MAYBE_vec)
>
>  DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
> -DEF(dupi_vec, 1, 0, 1, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
>
>  DEF(dup_vec, 1, 1, 0, IMPLVEC)
>  DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS =3D=3D 32))
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 843fd0ca69..7918aeb9d5 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -2261,8 +2261,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc=
,
>
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          g_assert_not_reached();
> @@ -2467,7 +2465,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode
> opc,
>          break;
>
>      case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
> -    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
>      default:
>          g_assert_not_reached();
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 6aa7757aac..b967499fa4 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -2068,7 +2068,6 @@ static inline void tcg_out_op(TCGContext *s,
> TCGOpcode opc,
>          break;
>
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index ec083bddcf..320a4bddd1 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -2678,8 +2678,6 @@ static inline void tcg_out_op(TCGContext *s,
> TCGOpcode opc,
>          break;
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> @@ -2965,7 +2963,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode
> opc,
>          break;
>
>      case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
> -    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
>      default:
>          g_assert_not_reached();
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 4d32ebc1df..09dc5a94fa 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -2155,8 +2155,6 @@ static inline void tcg_out_op(TCGContext *s,
> TCGOpcode opc,
>          break;
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index dd5187be31..9a2c945dbe 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1099,10 +1099,6 @@ void tcg_optimize(TCGContext *s)
>          CASE_OP_32_64_VEC(mov):
>              tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
>              break;
> -        CASE_OP_32_64(movi):
> -        case INDEX_op_dupi_vec:
> -            tcg_opt_gen_movi(s, &temps_used, op, op->args[0],
> op->args[1]);
> -            break;
>
>          case INDEX_op_dup_vec:
>              if (arg_is_const(op->args[1])) {
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index ee1f9227c1..fb390ad978 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -2967,8 +2967,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc=
,
> const TCGArg *args,
>
>      case INDEX_op_mov_i32:   /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32:  /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> @@ -3310,7 +3308,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode
> opc,
>          return;
>
>      case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
> -    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
>      default:
>          g_assert_not_reached();
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 2bc0ba71f2..ec609272ad 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -1606,8 +1606,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc=
,
>
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          g_assert_not_reached();
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index b07e9ff7d6..f6b003a700 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -2310,8 +2310,6 @@ static inline void tcg_out_op(TCGContext *s,
> TCGOpcode opc,
>
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index 65fddb310d..0808b79eee 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -1591,8 +1591,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc=
,
>
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 655b3ae32d..6343046e18 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -83,7 +83,6 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
>          case INDEX_op_xor_vec:
>          case INDEX_op_mov_vec:
>          case INDEX_op_dup_vec:
> -        case INDEX_op_dupi_vec:
>          case INDEX_op_dup2_vec:
>          case INDEX_op_ld_vec:
>          case INDEX_op_st_vec:
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 59beb2bf29..adb71f16ae 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1463,7 +1463,6 @@ bool tcg_op_supported(TCGOpcode op)
>          return TCG_TARGET_HAS_goto_ptr;
>
>      case INDEX_op_mov_i32:
> -    case INDEX_op_movi_i32:
>      case INDEX_op_setcond_i32:
>      case INDEX_op_brcond_i32:
>      case INDEX_op_ld8u_i32:
> @@ -1557,7 +1556,6 @@ bool tcg_op_supported(TCGOpcode op)
>          return TCG_TARGET_REG_BITS =3D=3D 32;
>
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i64:
>      case INDEX_op_setcond_i64:
>      case INDEX_op_brcond_i64:
>      case INDEX_op_ld8u_i64:
> @@ -1663,7 +1661,6 @@ bool tcg_op_supported(TCGOpcode op)
>
>      case INDEX_op_mov_vec:
>      case INDEX_op_dup_vec:
> -    case INDEX_op_dupi_vec:
>      case INDEX_op_dupm_vec:
>      case INDEX_op_ld_vec:
>      case INDEX_op_st_vec:
> @@ -3447,7 +3444,7 @@ static void tcg_reg_alloc_bb_end(TCGContext *s,
> TCGRegSet allocated_regs)
>  }
>
>  /*
> - * Specialized code generation for INDEX_op_movi_*.
> + * Specialized code generation for INDEX_op_mov_* with a constant.
>   */
>  static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
>                                    tcg_target_ulong val, TCGLifeData
> arg_life,
> @@ -3470,14 +3467,6 @@ static void tcg_reg_alloc_do_movi(TCGContext *s,
> TCGTemp *ots,
>      }
>  }
>
> -static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
> -{
> -    TCGTemp *ots =3D arg_temp(op->args[0]);
> -    tcg_target_ulong val =3D op->args[1];
> -
> -    tcg_reg_alloc_do_movi(s, ots, val, op->life, op->output_pref[0]);
> -}
> -
>  /*
>   * Specialized code generation for INDEX_op_mov_*.
>   */
> @@ -4263,11 +4252,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock
> *tb)
>          case INDEX_op_mov_vec:
>              tcg_reg_alloc_mov(s, op);
>              break;
> -        case INDEX_op_movi_i32:
> -        case INDEX_op_movi_i64:
> -        case INDEX_op_dupi_vec:
> -            tcg_reg_alloc_movi(s, op);
> -            break;
>          case INDEX_op_dup_vec:
>              tcg_reg_alloc_dup(s, op);
>              break;
> diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
> index 1f1639df0d..b796f4fc19 100644
> --- a/tcg/tci/tcg-target.inc.c
> +++ b/tcg/tci/tcg-target.inc.c
> @@ -815,8 +815,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
> const TCGArg *args,
>          break;
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> --
> 2.20.1
>
>
>

--0000000000004ff1aa05a3dd8715
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 22. =D0=B0=D0=BF=D1=80=D0=B8=D0=BB =
2020., Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org=
">richard.henderson@linaro.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">These=
 are now completely covered by mov from a<br>
TYPE_CONST temporary.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
---</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic=
 &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_b=
lank" style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.qe=
mu.devel@gmail.<wbr>com</a><span style=3D"color:rgb(34,34,34);font-size:14p=
x;line-height:22.1200008392334px">&gt;</span></div><div>=C2=A0<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
=C2=A0include/tcg/tcg-opc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ---<br>
=C2=A0tcg/aarch64/tcg-target.inc.c |=C2=A0 3 ---<br>
=C2=A0tcg/arm/tcg-target.inc.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0tcg/i386/tcg-target.inc.c=C2=A0 =C2=A0 |=C2=A0 3 ---<br>
=C2=A0tcg/mips/tcg-target.inc.c=C2=A0 =C2=A0 |=C2=A0 2 --<br>
=C2=A0tcg/optimize.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 4 ----<br>
=C2=A0tcg/ppc/tcg-target.inc.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ---<br>
=C2=A0tcg/riscv/tcg-target.inc.c=C2=A0 =C2=A0|=C2=A0 2 --<br>
=C2=A0tcg/s390/tcg-target.inc.c=C2=A0 =C2=A0 |=C2=A0 2 --<br>
=C2=A0tcg/sparc/tcg-target.inc.c=C2=A0 =C2=A0|=C2=A0 2 --<br>
=C2=A0tcg/tcg-op-vec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 1 -<br>
=C2=A0tcg/tcg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 18 +-----------------<br>
=C2=A0tcg/tci/tcg-target.inc.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 --<br>
=C2=A013 files changed, 1 insertion(+), 45 deletions(-)<br>
<br>
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h<br>
index 7dee9b38f7..4a9cbf5426 100644<br>
--- a/include/tcg/tcg-opc.h<br>
+++ b/include/tcg/tcg-opc.h<br>
@@ -45,7 +45,6 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END)<br>
=C2=A0DEF(mb, 0, 0, 1, 0)<br>
<br>
=C2=A0DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)<br>
-DEF(movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)<br>
=C2=A0DEF(setcond_i32, 1, 2, 1, 0)<br>
=C2=A0DEF(movcond_i32, 1, 4, 1, IMPL(TCG_TARGET_HAS_movcond_<wbr>i32))<br>
=C2=A0/* load/store */<br>
@@ -110,7 +109,6 @@ DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))<br>
=C2=A0DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32)<wbr>)<br>
<br>
=C2=A0DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)<br>
-DEF(movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)<br>
=C2=A0DEF(setcond_i64, 1, 2, 1, IMPL64)<br>
=C2=A0DEF(movcond_i64, 1, 4, 1, IMPL64 | IMPL(TCG_TARGET_HAS_movcond_<wbr>i=
64))<br>
=C2=A0/* load/store */<br>
@@ -215,7 +213,6 @@ DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,<br>
=C2=A0#define IMPLVEC=C2=A0 TCG_OPF_VECTOR | IMPL(TCG_TARGET_MAYBE_vec)<br>
<br>
=C2=A0DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)<br>
-DEF(dupi_vec, 1, 0, 1, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)<br>
<br>
=C2=A0DEF(dup_vec, 1, 1, 0, IMPLVEC)<br>
=C2=A0DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS =3D=3D 32))=
<br>
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c<br=
>
index 843fd0ca69..7918aeb9d5 100644<br>
--- a/tcg/aarch64/tcg-target.inc.c<br>
+++ b/tcg/aarch64/tcg-target.inc.c<br>
@@ -2261,8 +2261,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0/* Always emitte=
d via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
@@ -2467,7 +2465,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_vec:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_dup_vec:=C2=A0 /* Always emitted via tcg_=
out_dup_vec.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c<br>
index 6aa7757aac..b967499fa4 100644<br>
--- a/tcg/arm/tcg-target.inc.c<br>
+++ b/tcg/arm/tcg-target.inc.c<br>
@@ -2068,7 +2068,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcod=
e opc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0/* Always emitte=
d via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_abort();<br>
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c<br>
index ec083bddcf..320a4bddd1 100644<br>
--- a/tcg/i386/tcg-target.inc.c<br>
+++ b/tcg/i386/tcg-target.inc.c<br>
@@ -2678,8 +2678,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcod=
e opc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0/* Always emitte=
d via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_abort();<br>
@@ -2965,7 +2963,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_vec:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_dup_vec:=C2=A0 /* Always emitted via tcg_=
out_dup_vec.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c<br>
index 4d32ebc1df..09dc5a94fa 100644<br>
--- a/tcg/mips/tcg-target.inc.c<br>
+++ b/tcg/mips/tcg-target.inc.c<br>
@@ -2155,8 +2155,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcod=
e opc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0/* Always emitte=
d via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_abort();<br>
diff --git a/tcg/optimize.c b/tcg/optimize.c<br>
index dd5187be31..9a2c945dbe 100644<br>
--- a/tcg/optimize.c<br>
+++ b/tcg/optimize.c<br>
@@ -1099,10 +1099,6 @@ void tcg_optimize(TCGContext *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CASE_OP_32_64_VEC(mov):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_opt_gen_mov(s, op, op-&=
gt;args[0], op-&gt;args[1]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 CASE_OP_32_64(movi):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case INDEX_op_dupi_vec:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_opt_gen_movi(s, &amp;temps_u=
sed, op, op-&gt;args[0], op-&gt;args[1]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_dup_vec:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (arg_is_const(op-&gt;arg=
s[1])) {<br>
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c<br>
index ee1f9227c1..fb390ad978 100644<br>
--- a/tcg/ppc/tcg-target.inc.c<br>
+++ b/tcg/ppc/tcg-target.inc.c<br>
@@ -2967,8 +2967,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, =
const TCGArg *args,<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 =C2=A0/* Always emitted vi=
a tcg_out_mov.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32:=C2=A0 /* Always emitted via tcg_out_=
movi.=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0 /* Always emitt=
ed via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_abort();<br>
@@ -3310,7 +3308,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode o=
pc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_vec:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_dup_vec:=C2=A0 /* Always emitted via tcg_=
out_dup_vec.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c<br>
index 2bc0ba71f2..ec609272ad 100644<br>
--- a/tcg/riscv/tcg-target.inc.c<br>
+++ b/tcg/riscv/tcg-target.inc.c<br>
@@ -1606,8 +1606,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0/* Always emitte=
d via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c<br>
index b07e9ff7d6..f6b003a700 100644<br>
--- a/tcg/s390/tcg-target.inc.c<br>
+++ b/tcg/s390/tcg-target.inc.c<br>
@@ -2310,8 +2310,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcod=
e opc,<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0/* Always emitte=
d via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_abort();<br>
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c<br>
index 65fddb310d..0808b79eee 100644<br>
--- a/tcg/sparc/tcg-target.inc.c<br>
+++ b/tcg/sparc/tcg-target.inc.c<br>
@@ -1591,8 +1591,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0/* Always emitte=
d via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_abort();<br>
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c<br>
index 655b3ae32d..6343046e18 100644<br>
--- a/tcg/tcg-op-vec.c<br>
+++ b/tcg/tcg-op-vec.c<br>
@@ -83,7 +83,6 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_xor_vec:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_vec:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_dup_vec:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case INDEX_op_dupi_vec:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_dup2_vec:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_ld_vec:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_st_vec:<br>
diff --git a/tcg/tcg.c b/tcg/tcg.c<br>
index 59beb2bf29..adb71f16ae 100644<br>
--- a/tcg/tcg.c<br>
+++ b/tcg/tcg.c<br>
@@ -1463,7 +1463,6 @@ bool tcg_op_supported(TCGOpcode op)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TCG_TARGET_HAS_goto_ptr;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_setcond_i32:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_brcond_i32:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_ld8u_i32:<br>
@@ -1557,7 +1556,6 @@ bool tcg_op_supported(TCGOpcode op)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TCG_TARGET_REG_BITS =3D=3D 32;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_setcond_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_brcond_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_ld8u_i64:<br>
@@ -1663,7 +1661,6 @@ bool tcg_op_supported(TCGOpcode op)<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_vec:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_dup_vec:<br>
-=C2=A0 =C2=A0 case INDEX_op_dupi_vec:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_dupm_vec:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_ld_vec:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_st_vec:<br>
@@ -3447,7 +3444,7 @@ static void tcg_reg_alloc_bb_end(<wbr>TCGContext *s, =
TCGRegSet allocated_regs)<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
- * Specialized code generation for INDEX_op_movi_*.<br>
+ * Specialized code generation for INDEX_op_mov_* with a constant.<br>
=C2=A0 */<br>
=C2=A0static void tcg_reg_alloc_do_movi(<wbr>TCGContext *s, TCGTemp *ots,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_target_ulong val, T=
CGLifeData arg_life,<br>
@@ -3470,14 +3467,6 @@ static void tcg_reg_alloc_do_movi(<wbr>TCGContext *s=
, TCGTemp *ots,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)<br>
-{<br>
-=C2=A0 =C2=A0 TCGTemp *ots =3D arg_temp(op-&gt;args[0]);<br>
-=C2=A0 =C2=A0 tcg_target_ulong val =3D op-&gt;args[1];<br>
-<br>
-=C2=A0 =C2=A0 tcg_reg_alloc_do_movi(s, ots, val, op-&gt;life, op-&gt;outpu=
t_pref[0]);<br>
-}<br>
-<br>
=C2=A0/*<br>
=C2=A0 * Specialized code generation for INDEX_op_mov_*.<br>
=C2=A0 */<br>
@@ -4263,11 +4252,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_vec:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_reg_alloc_mov(s, op);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case INDEX_op_movi_i32:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case INDEX_op_dupi_vec:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_reg_alloc_movi(s, op);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INDEX_op_dup_vec:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_reg_alloc_dup(s, op);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c<br>
index 1f1639df0d..b796f4fc19 100644<br>
--- a/tcg/tci/tcg-target.inc.c<br>
+++ b/tcg/tci/tcg-target.inc.c<br>
@@ -815,8 +815,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, co=
nst TCGArg *args,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i32:=C2=A0 /* Always emitted via tcg_=
out_mov.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_mov_i64:<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.=
=C2=A0 */<br>
-=C2=A0 =C2=A0 case INDEX_op_movi_i64:<br>
=C2=A0 =C2=A0 =C2=A0case INDEX_op_call:=C2=A0 =C2=A0 =C2=A0/* Always emitte=
d via tcg_out_call.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_abort();<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--0000000000004ff1aa05a3dd8715--

