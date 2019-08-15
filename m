Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FA7C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F59206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGXSJN8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F59206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGmD-00026L-Ov
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hyGlK-0001Pe-HM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hyGlF-0006TO-KE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:29:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hyGlF-0006Rw-A0
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:29:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id i63so1418043wmg.4
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Do+lFqCdg+S/4kuYB+AioAZUhBp4TolHdQYAwGLJDa8=;
 b=wGXSJN8NnQtnjqD2DQfsNeClzcxvW2BehbnVlt4URblOuryOWD26sEhKNt2w+CtybM
 wXhmUMg9QoISOGqboM0V1EJc8TXzaU3+ntOjU91rY5FtMIIJWGtBPZUKxjZOi00SOaGh
 h9F9elp6xr/7Uk+cHT0IHvwwnzXTGnVc9uaMW7Y3dKX8zJxRgEbOmBfqJG2rIKToCVHv
 IntOhahR/SLMe17unzL58oERfURFig4wC4grUavXytEVst79aGD0BZCPoU8x0BnEnGKu
 sBzxldqJKPHskvBQfhC58U5ecsq8ORQ6KCTQg9kwMeBaTPBZ5r65zWtUij0RtS0uRX6L
 blUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Do+lFqCdg+S/4kuYB+AioAZUhBp4TolHdQYAwGLJDa8=;
 b=dCq/KbiqkXI+OZ7asSIFFil4JVAnjmJgmaggDV8XUW8g087MNeMvxE/tWwo2FbEeP/
 xsT2PJUffrFNa+2KWZwmCCnrXPveOk6hQzFcgZn9lAVAvzVNt8xFwl62X04j0bWWCSGP
 UdWME25VtI0+kbao2nUq2KRjqy3HLhAeSa5OP1CvhE5UTE89pNRjsxB4GGYIBsSqrl0a
 /xbNS8q+m/JZ1o4AGtaN0JfiEylTgNCTXMj0hGj+ubpKJM+/t2vVZYaWqvbPuYYvUg0W
 R07lGTLD3VGvobHjYLfSbuho/xGQZObgfxXzk3K3AD23lVEsH0cALvj+H7wOaMK4o2Si
 qnpw==
X-Gm-Message-State: APjAAAWPALeOJKPlAFPHjRAm2OWFi5a9Q4RnFu5A8rv1KLMpABBSoIWu
 1R4XLqO2tkOjG6i3I3WCKVzMoQ==
X-Google-Smtp-Source: APXvYqy4rtRm+1bN7Sk2KXxVy3q9lKlHuJVyLURvZ3yCnxpyFaceaLHGAL5rxm57Cg3NySaPCowvsg==
X-Received: by 2002:a1c:c1cd:: with SMTP id r196mr3170200wmf.127.1565879391893; 
 Thu, 15 Aug 2019 07:29:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l14sm4250973wrn.42.2019.08.15.07.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 07:29:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD15F1FF87;
 Thu, 15 Aug 2019 15:29:50 +0100 (BST)
References: <20190815021857.19526-1-vandersonmr2@gmail.com>
 <20190815021857.19526-4-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190815021857.19526-4-vandersonmr2@gmail.com>
Date: Thu, 15 Aug 2019 15:29:50 +0100
Message-ID: <87pnl6mrhd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v5 03/10] accel: collecting JIT statistics
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> If a TB has a TBS (TBStatistics) with the TB_JIT_STATS
> enabled then we collect statistics of its translation
> processes and code translation.
>
> Collecting the number of host instructions seems to be
> not simple as it would imply in having to modify several
> target source files. So, for now, we are only collecting
> the size of the host gen code.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 14 ++++++++++++++
>  accel/tcg/translator.c    |  4 ++++
>  include/exec/tb-stats.h   | 15 +++++++++++++++
>  tcg/tcg.c                 | 23 +++++++++++++++++++++++
>  tcg/tcg.h                 |  2 ++
>  5 files changed, 58 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index df08d183df..85c6b7b409 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1696,6 +1696,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t ph=
ys_pc, target_ulong pc,
>      new_stats->cs_base =3D cs_base;
>      new_stats->flags =3D flags;
>      new_stats->tb =3D current_tb;
> +    new_stats->translations.total =3D 1;
>
>      qht_insert(&tb_ctx.tb_stats, new_stats, hash, &existing_stats);
>
> @@ -1705,6 +1706,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t ph=
ys_pc, target_ulong pc,
>           * then just make the new TB point to the older TBStatistic
>           */
>          g_free(new_stats);
> +        ((TBStatistics *) existing_stats)->tb =3D current_tb;
>          return existing_stats;
>      } else {
>          return new_stats;
> @@ -1792,6 +1794,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>                  tb->tb_stats->stats_enabled |=3D TB_EXEC_STATS;
>              }
>          }
> +
> +        if (flag & TB_JIT_STATS) {
> +            tb->tb_stats->stats_enabled |=3D TB_JIT_STATS;
> +            atomic_inc(&tb->tb_stats->translations.total);
> +        }
>      } else {
>          tb->tb_stats =3D NULL;
>      }
> @@ -1869,6 +1876,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      atomic_set(&prof->search_out_len, prof->search_out_len + search_size=
);
>  #endif
>
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        atomic_add(&tb->tb_stats->code.out_len, gen_code_size);
> +    }
> +
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
>          qemu_log_in_addr_range(tb->pc)) {
> @@ -1926,6 +1937,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      phys_page2 =3D -1;
>      if ((pc & TARGET_PAGE_MASK) !=3D virt_page2) {
>          phys_page2 =3D get_page_addr_code(env, virt_page2);
> +        if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +            atomic_inc(&tb->tb_stats->translations.spanning);
> +        }
>      }
>      /*
>       * No explicit memory barrier is required -- tb_link_page() makes the
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 396a11e828..834265d5be 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -117,6 +117,10 @@ void translator_loop(const TranslatorOps *ops, Disas=
ContextBase *db,
>      db->tb->size =3D db->pc_next - db->pc_first;
>      db->tb->icount =3D db->num_insns;
>
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        atomic_add(&db->tb->tb_stats->code.num_guest_inst, db->num_insns=
);
> +    }
> +
>  #ifdef DEBUG_DISAS
>      if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>          && qemu_log_in_addr_range(db->pc_first)) {
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 0265050b79..3c219123c2 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -34,6 +34,20 @@ struct TBStatistics {
>          unsigned long atomic;
>      } executions;
>
> +    struct {
> +        unsigned num_guest_inst;
> +        unsigned num_tcg_ops;
> +        unsigned num_tcg_ops_opt;
> +        unsigned spills;
> +        unsigned out_len;
> +    } code;
> +
> +    struct {
> +        unsigned long total;
> +        unsigned long uncached;
> +        unsigned long spanning;
> +    } translations;
> +
>      /* current TB linked to this TBStatistics */
>      TranslationBlock *tb;
>  };
> @@ -47,6 +61,7 @@ enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED,=
 TB_STATS_STOPPED };
>
>  #define TB_NOTHING    0
>  #define TB_EXEC_STATS 1
> +#define TB_JIT_STATS  (1 << 2)
>
>  extern int tcg_collect_tb_stats;
>  extern uint32_t default_tbstats_flag;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index be2c33c400..446e3d1708 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3126,6 +3126,11 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, =
TCGRegSet allocated_regs,
>          case TEMP_VAL_REG:
>              tcg_out_st(s, ts->type, ts->reg,
>                         ts->mem_base->reg, ts->mem_offset);
> +
> +            /* Count number of spills */
> +            if (tb_stats_enabled(s->current_tb, TB_JIT_STATS)) {
> +                atomic_inc(&s->current_tb->tb_stats->code.spills);
> +            }
>              break;
>
>          case TEMP_VAL_MEM:
> @@ -3997,6 +4002,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
>      int i, num_insns;
>      TCGOp *op;
>
> +    s->current_tb =3D tb;
> +
>  #ifdef CONFIG_PROFILER
>      {
>          int n =3D 0;
> @@ -4028,6 +4035,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
tb)
>      }
>  #endif
>
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        int n =3D 0;
> +        QTAILQ_FOREACH(op, &s->ops, link) {
> +            n++;
> +        }
> +        atomic_add(&tb->tb_stats->code.num_tcg_ops, n);
> +    }
> +
>  #ifdef CONFIG_DEBUG_TCG
>      /* Ensure all labels referenced have been emitted.  */
>      {
> @@ -4094,6 +4109,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
tb)
>      }
>  #endif
>
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        int n =3D 0;
> +        QTAILQ_FOREACH(op, &s->ops, link) {
> +            n++;
> +        }
> +        atomic_add(&tb->tb_stats->code.num_tcg_ops_opt, n);
> +    }
> +
>      tcg_reg_alloc_start(s);
>
>      s->code_buf =3D tb->tc.ptr;
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index b411e17a28..bf6f3bcba3 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -738,6 +738,8 @@ struct TCGContext {
>
>      uint16_t gen_insn_end_off[TCG_MAX_INSNS];
>      target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
> +
> +    TranslationBlock *current_tb;
>  };
>
>  extern TCGContext tcg_init_ctx;


--
Alex Benn=C3=A9e

