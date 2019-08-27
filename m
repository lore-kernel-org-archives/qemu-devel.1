Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F61FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5CE204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjVob6wG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5CE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2YsX-0007F0-DI
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i2YrK-0006UI-1d
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i2YrH-0007f9-Ml
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:37:53 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:39956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1i2YrH-0007es-Fv
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:37:51 -0400
Received: by mail-io1-xd41.google.com with SMTP id t6so45149730ios.7
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qGWoENVzVTKV7dpSowHjSTLxqUsP3iMLYyjWsyQ9480=;
 b=cjVob6wGot/LB1P3M2fYhvBmYMbJS06kMJB0VEOzyIHivg8++0J6x2NKema2GmNLgH
 8XXczSVC9HfNcdqVfDftska7JcyeouaXm5APkLV+0eLZtxlgxOSZLHK5yxk+7emsBwRP
 wJIycLsVxnrlaAiIpmNvFT7ZWFVyywMYeRWHz16nwiE8rV6nGAPD1n/FNfog+4fQo0UI
 Oaqg8SPyH/GL24aEr589hVqdqtDrVxRhzVmq3ttzQ7by5NRURcAQQr2g+1q0IWVOm8y2
 6Mve4yWWPrUAAQU4cyX+JcvRv2xJgT9ab7qxbbVBWqwhecf7yJhIDLAz8YUNG88dpaQw
 Uvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qGWoENVzVTKV7dpSowHjSTLxqUsP3iMLYyjWsyQ9480=;
 b=uaWyMfx7g++Jh17YzvNo5uTNyJhpYGjYyrphmPyAWEMUV1IEfH7kvS9L2iFpbGUPv0
 PdsKVnNFo6/Qo8IDz6ElBwh37pio0mZUA1h/0vP9sBgTHYCxtAOFP0dv/3u97ZlUWQTu
 m+CgZfvEPg/eBq7WjUc/935S05wOiLw15qlzeckaRCt2OWua7UdBKqIAcKfS7SoMrxw1
 cu4FxqOJodGqx61FOC3xvyHsy/tZUKqoPFaCt4pZU7hCKP1LiKQ4BjUtWgF1kYL4Lb9K
 VT8K+Qxp0DA9h7kdnqnaqoANPRrgK1TIYqLnXrpxxDOatAoLtjln5gxO6WNJfZGq6k8O
 iP7w==
X-Gm-Message-State: APjAAAXwzLs9buJoaGg3/rPjA3cxMdKXU8XU0W0LLvE/fhSzFOObEWmF
 adYy4MlPIR6mMeFDRhcChsHvrJat8ABlWFIbAMo=
X-Google-Smtp-Source: APXvYqwkjq7vIZwmZhM83MTssYlYiYJmVwyJXyWZXTjCbvXSX/Den4PC9Jld1QyKcVpUlD1/eYkkHLIJGMWmSHe4DOM=
X-Received: by 2002:a6b:f119:: with SMTP id e25mr11824038iog.22.1566902270179; 
 Tue, 27 Aug 2019 03:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190826151536.6771-1-richard.henderson@linaro.org>
 <20190826151536.6771-2-richard.henderson@linaro.org>
In-Reply-To: <20190826151536.6771-2-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 27 Aug 2019 12:37:38 +0200
Message-ID: <CABoDooP99S6FSM7bpf8t8s121sjFSUn-iTPeYxGDxZ7ACuegUg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PATCH 1/2] Revert "target/arm: Use
 unallocated_encoding for aarch32"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Mon, Aug 26, 2019 at 5:15 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This reverts commit 3cb36637157088892e9e33ddb1034bffd1251d3b.
>
> Despite the fact that the text for the call to gen_exception_insn
> is identical for aarch64 and aarch32, the implementation inside
> gen_exception_insn is totally different.
>
> This fixes exceptions raised from aarch64.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/translate-a64.h     |  2 ++
>  target/arm/translate.h         |  2 --
>  target/arm/translate-a64.c     |  7 +++++++
>  target/arm/translate-vfp.inc.c |  3 ++-
>  target/arm/translate.c         | 22 ++++++++++------------
>  5 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
> index 12ad8ac6ed..9cd2b3d238 100644
> --- a/target/arm/translate-a64.h
> +++ b/target/arm/translate-a64.h
> @@ -18,6 +18,8 @@
>  #ifndef TARGET_ARM_TRANSLATE_A64_H
>  #define TARGET_ARM_TRANSLATE_A64_H
>
> +void unallocated_encoding(DisasContext *s);
> +
>  #define unsupported_encoding(s, insn)                                    \
>      do {                                                                 \
>          qemu_log_mask(LOG_UNIMP,                                         \
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index 92ef790be9..64304c957e 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -99,8 +99,6 @@ typedef struct DisasCompare {
>      bool value_global;
>  } DisasCompare;
>
> -void unallocated_encoding(DisasContext *s);
> -
>  /* Share the TCG temporaries common between 32 and 64 bit modes.  */
>  extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
>  extern TCGv_i64 cpu_exclusive_addr;
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 6fd0b779d3..9183f89ba3 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -338,6 +338,13 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
>      }
>  }
>
> +void unallocated_encoding(DisasContext *s)
> +{
> +    /* Unallocated and reserved encodings are uncategorized */
> +    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                       default_exception_el(s));
> +}
> +
>  static void init_tmp_a64_array(DisasContext *s)
>  {
>  #ifdef CONFIG_DEBUG_TCG
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index 3e8ea80493..5065d4524c 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -108,7 +108,8 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
>
>      if (!s->vfp_enabled && !ignore_vfp_enabled) {
>          assert(!arm_dc_feature(s, ARM_FEATURE_M));
> -        unallocated_encoding(s);
> +        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                           default_exception_el(s));
>          return false;
>      }
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index cbe19b7a62..2aac9aae68 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -1231,13 +1231,6 @@ static void gen_exception_bkpt_insn(DisasContext *s, uint32_t syn)
>      s->base.is_jmp = DISAS_NORETURN;
>  }
>
> -void unallocated_encoding(DisasContext *s)
> -{
> -    /* Unallocated and reserved encodings are uncategorized */
> -    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> -                       default_exception_el(s));
> -}
> -
>  /* Force a TB lookup after an instruction that changes the CPU state.  */
>  static inline void gen_lookup_tb(DisasContext *s)
>  {
> @@ -1268,7 +1261,8 @@ static inline void gen_hlt(DisasContext *s, int imm)
>          return;
>      }
>
> -    unallocated_encoding(s);
> +    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                       default_exception_el(s));
>  }
>
>  static inline void gen_add_data_offset(DisasContext *s, unsigned int insn,
> @@ -7580,7 +7574,8 @@ static void gen_srs(DisasContext *s,
>      }
>
>      if (undef) {
> -        unallocated_encoding(s);
> +        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                           default_exception_el(s));
>          return;
>      }
>
> @@ -9201,7 +9196,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              break;
>          default:
>          illegal_op:
> -            unallocated_encoding(s);
> +            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                               default_exception_el(s));
>              break;
>          }
>      }
> @@ -10886,7 +10882,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>      }
>      return;
>  illegal_op:
> -    unallocated_encoding(s);
> +    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                       default_exception_el(s));
>  }
>
>  static void disas_thumb_insn(DisasContext *s, uint32_t insn)
> @@ -11709,7 +11706,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>      return;
>  illegal_op:
>  undef:
> -    unallocated_encoding(s);
> +    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
> +                       default_exception_el(s));
>  }
>
>  static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
> --
> 2.17.1
>

