Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23552C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E896E217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5jASd28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E896E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JYe-0000xp-5l
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j2JTC-0006dA-DT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j2JTB-0002FK-5n
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:44:14 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j2JTB-00029D-0F
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:44:13 -0500
Received: by mail-pf1-x443.google.com with SMTP id 185so3510126pfv.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
 :content-transfer-encoding;
 bh=lF8cg/+QniS/8crnOoiSQJaSy/JUvfCFg8+8SNK/r9E=;
 b=q5jASd28cyUetgoyaFDw9yERRByGN4UoDCchSu6OdPnProuGyfOK17AXMRbKZe4J2p
 t//L+N4+6CsGcyOnxLRFr2A6xKzKDMQN2h+bLoQNj58chMnmv3LpUSVNcrAk7stgRkco
 HlBuwxh9TGwIJOMnNVMO1lm3uRfU4R/uvMtu7YDbdn2o8otvfSTLEeKCiFtGFiQ+G9En
 Drw3zWPi3R7W6tz8W+ThuHreKOChAv5Md75jmsKZPhfqwAdLBmNmySRZC+KIGQ7QXSfm
 vLNYcvYKtHSd3GsXRa5f5FUTa8MJkyTMxhUHQLYzZgtawsVCgOTVt4wEZl3bPfc5k3Os
 FTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
 :mime-version:content-transfer-encoding;
 bh=lF8cg/+QniS/8crnOoiSQJaSy/JUvfCFg8+8SNK/r9E=;
 b=kAKA7LPrRL+l0AJECwlCr19KU7LwPLSndU/mWi/oyUy+Z718HZPTh4wFl8FzDm6o++
 NbxEhy/7D8pKXPQa3VLp7tCkOgcl1J00z1scC8/br6GhzSkKYqZmUcgLZme4hxa3l/uS
 mABHClC7S87G/I/OD6xxYY2zQ41lYgVHxXralZMK24QU+bMqU0LBR4EcE0YAjVr429Gk
 S+pijy/gMZfZnXkY5vFhzi5pCSfMgZ6WgdF1Mp+Yfs23ERfjRsF5PQs5JluJ8wnALdP3
 oEqWq5t1QP+3HRNXqwDSib33duywWweKJe+7jRkmYVarJSYmgpkqI2DV7A7C5icAl6uP
 i1/A==
X-Gm-Message-State: APjAAAWHcDFCUXphi6UFVatBVeQPa5KGzTzoMf1iQLL4Ulfw/GmRLjKk
 nACENpvIavGEJETUhVkKXG859/ToWPM=
X-Google-Smtp-Source: APXvYqzUGXarw6AA9QRiZGlkEypHS1SY2ld8xsqbeQvv9dCB6xLg2R8cPJt4Pbb7tYteSFFx+R1UmA==
X-Received: by 2002:aa7:8654:: with SMTP id a20mr15073872pfo.88.1581619448571; 
 Thu, 13 Feb 2020 10:44:08 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id d22sm3801549pfo.187.2020.02.13.10.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 10:44:07 -0800 (PST)
Date: Thu, 13 Feb 2020 10:44:07 -0800 (PST)
X-Google-Original-Date: Thu, 13 Feb 2020 10:44:05 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 27/35] target/riscv: Mark both sstatus and msstatus_hs
 as dirty
In-Reply-To: <5f3b8fd9e9743c13fd9e40bf811303bc2937667a.1580518859.git.alistair.francis@wdc.com>
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-47cdaa98-793e-4dd1-8307-f53d1daec9e1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

On Fri, 31 Jan 2020 17:02:46 PST (-0800), Alistair Francis wrote:
> Mark both sstatus and vsstatus as dirty (3).
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index afa2d6eea2..61fe9f03be 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -44,6 +44,7 @@ typedef struct DisasContext {
>      /* pc_succ_insn points to the instruction following base.pc_next */
>      target_ulong pc_succ_insn;
>      target_ulong priv_ver;
> +    bool virt_enabled;
>      uint32_t opcode;
>      uint32_t mstatus_fs;
>      uint32_t misa;
> @@ -396,6 +397,12 @@ static void mark_fs_dirty(DisasContext *ctx)
>      tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
>      tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
>      tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
> +
> +    if (ctx->virt_enabled) {
> +        tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus_hs));
> +        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);
> +        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus_hs));
> +    }

I suppose we could #ifdef this, but I don't think it's worth it.

>      tcg_temp_free(tmp);
>  }
>  #else
> @@ -740,6 +747,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
>      ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
>      ctx->priv_ver = env->priv_ver;
> +#if !defined(CONFIG_USER_ONLY)
> +    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
> +#else
> +    ctx->virt_enabled = false;
> +#endif
>      ctx->misa = env->misa;
>      ctx->frm = -1;  /* unknown rounding mode */
>      ctx->ext_ifencei = cpu->cfg.ext_ifencei;

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

