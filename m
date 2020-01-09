Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CCAC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21079206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6bLA1LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21079206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNhW-0007SA-Ak
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipNgL-0006xP-Un
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipNgH-0004jh-AB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:36:21 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipNgH-0004hI-0K
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:36:17 -0500
Received: by mail-pl1-x642.google.com with SMTP id a6so1915289plm.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=1u20Y16UTLTK3vGnMCMvTg+KplB+/S/bHmNElPoWiDI=;
 b=O6bLA1LOZeQlJADeWsre7LaHvyWkHEKyhJJxTfuA4Z1qQjwdO99fIIDr1drLpj7qtm
 k5tnLbeEJuzXNaK482Kl3HkHk5drFlWcZZBuSuWyHCxxnN+dbxkanGvlSCktFmUH3Rgg
 e6dlcOKjGK5+RcDhSIZz+2eOCZsa/6ulvKzKoJslUMEPTrDOe4u1KoPLZ8rSiyEFxVQD
 55fB5YgRWFFIZF0c+wR5m3Ubh1z+dvvEo2apvne+iiqk4ovp9IOpe6sW3wGBU7KJrs6Y
 c6ZQUgsvJrB/hQQj3uBcxTOqdA6a4Sr+We0NAzXmIK4F1LIDtODUVVkvCeINancE859R
 BAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=1u20Y16UTLTK3vGnMCMvTg+KplB+/S/bHmNElPoWiDI=;
 b=dXm+lUa+VL1UAY5lBiopH4K8n/Fq7dcbupSOU6Vcy+eupb8kIQMbtMl6VzaxPQlHKq
 Sy+IuSokRmZwPmWT1GD7DGtwJozxBucQogM+GrN8vwMNuO4sCmaENnZpv4w40bQHkguT
 IVwRqSyNa5g4jOr81rM7JVew8yw/BSf4jRSjgvsCsYPdJItq8MRDB9l1snJFYjZdaQqx
 +HN9oCOU50ZSEs1Kn0O0DjSFIFpzgoKIf/HC817WjkaE3PT1jqeSDjH268bLekL5mZnM
 WhlRd5U9ZQYlfG3zd1Ogy/q3K39YDITyQokEjYyrdP7RBT3Xa3Z1XD69/FNUj48YSPR3
 WxOA==
X-Gm-Message-State: APjAAAUxpRUaRlw4tHh3ml6T7spDcG4r0HGZ8rJj9S1RKNcfbSfT55Kh
 Y69XXstsVrUG9RxjIy1a8ptWCw6NMPE=
X-Google-Smtp-Source: APXvYqzQKG7/Dt2LK8mdtNaB1XN0G//XlUNpBLg9uK3Qrz9IEBS4zegYYcVP7AD7HK+7d2idcD4J/A==
X-Received: by 2002:a17:90b:941:: with SMTP id
 dw1mr2350377pjb.21.1578537373890; 
 Wed, 08 Jan 2020 18:36:13 -0800 (PST)
Received: from localhost (189.8.197.35.bc.googleusercontent.com.
 [35.197.8.189])
 by smtp.gmail.com with ESMTPSA id p21sm5094988pfn.103.2020.01.08.18.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:36:13 -0800 (PST)
Date: Wed, 08 Jan 2020 18:36:13 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 18:35:57 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 35/36] target/riscv: Add the MSTATUS_MPV_ISSET helper
 macro
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <c6b8c2739278b63e5e03c2a2095254fa0afedbda.1575914822.git.alistair.francis@wdc.com>
References: <c6b8c2739278b63e5e03c2a2095254fa0afedbda.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-ac524f0b-4bc9-41ab-a177-7d3da237a83a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 09 Dec 2019 10:12:12 PST (-0800), Alistair Francis wrote:
> Add a helper macro MSTATUS_MPV_ISSET() which will determine if the
> MSTATUS_MPV bit is set for both 32-bit and 64-bit RISC-V.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_bits.h   | 11 +++++++++++
>  target/riscv/cpu_helper.c |  4 ++--
>  target/riscv/op_helper.c  |  2 +-
>  target/riscv/translate.c  |  2 +-
>  4 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 049032f2ae..dd012a514e 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -363,8 +363,19 @@
>  #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
>  #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
>  #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
> +#if defined(TARGET_RISCV64)
>  #define MSTATUS_MTL         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> +#elif defined(TARGET_RISCV32)
> +#define MSTATUS_MTL         0x00000040
> +#define MSTATUS_MPV         0x00000080
> +#endif
> +
> +#ifdef TARGET_RISCV32
> +# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatush, MSTATUS_MPV)
> +#else
> +# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatus, MSTATUS_MPV)
> +#endif
>
>  #define MSTATUS64_UXL       0x0000000300000000ULL
>  #define MSTATUS64_SXL       0x0000000C00000000ULL
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c2ad0bbce7..7166e6199e 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -314,7 +314,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>              mode = get_field(*env->mstatus, MSTATUS_MPP);
>
>              if (riscv_has_ext(env, RVH) &&
> -                get_field(*env->mstatus, MSTATUS_MPV)) {
> +                MSTATUS_MPV_ISSET(env)) {
>                  use_background = true;
>              }
>          }
> @@ -714,7 +714,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          m_mode_two_stage = env->priv == PRV_M &&
>                             access_type != MMU_INST_FETCH &&
>                             get_field(*env->mstatus, MSTATUS_MPRV) &&
> -                           get_field(*env->mstatus, MSTATUS_MPV);
> +                           MSTATUS_MPV_ISSET(env);
>
>          hs_mode_two_stage = env->priv == PRV_S &&
>                              !riscv_cpu_virt_enabled(env) &&
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index a0a631d722..b0b9890a15 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -146,7 +146,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>
>      target_ulong mstatus = *env->mstatus;
>      target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> -    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
> +    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
>      mstatus = set_field(mstatus,
>          env->priv_ver >= PRIV_VERSION_1_10_0 ?
>          MSTATUS_MIE : MSTATUS_UIE << prev_priv,
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index dd93e12b45..0a28f208a2 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -752,7 +752,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>          ctx->virt_enabled = riscv_cpu_virt_enabled(env);
>          if (env->priv_ver == PRV_M &&
>              get_field(*env->mstatus, MSTATUS_MPRV) &&
> -            get_field(*env->mstatus, MSTATUS_MPV)) {
> +            MSTATUS_MPV_ISSET(env)) {
>              ctx->virt_enabled = true;
>          } else if (env->priv == PRV_S &&
>                     !riscv_cpu_virt_enabled(env) &&

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

