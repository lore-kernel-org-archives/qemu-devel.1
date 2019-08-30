Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB17C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0892E2173E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD8j9g5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0892E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58779 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3h57-0003gD-W4
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 09:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3h03-0007wo-Dr
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3h00-000625-1w
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:31:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3gzw-0005wN-Aw
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:31:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id h7so5650447wrt.13
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8MNhdNWay9XECOW4+EoJHomOcPvMY82WnWpXTu887Mo=;
 b=rD8j9g5M/yvxZ1hjXG2h9gd3HwUMFCqQnDIlVCjjsJeZaYoNBnGbsw5WHi7MnIXNEW
 VC5o3MjwpZFRpRTy6fFvfikFNiK0EJUeCih+f0pN+Acb2uw4GFJSx5nbgRmGbmGfbLIF
 pE/CZF33rKwZIOGibpLvu1+qbhYHRGOfCPROwGnCA6Ju3fqNKb8t/SgHEeyq3tt/APWJ
 3o4OjH8O2/adMlZ6r7PXTZ9Xl/OQQVNMZV9wqzx+tjGntUKcJOdypk4TXc4qwFXpXbvo
 spWRKTWCcrcOXFPdxfCWVLlBCBx0H8UkfZUAF7mwvfsciO3aj4RPZmvaEyGohWZWA6V5
 u7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8MNhdNWay9XECOW4+EoJHomOcPvMY82WnWpXTu887Mo=;
 b=j7Ba1CLyPDvCNTmxYbgBc+RdLmY+MY6gGUGEtTUSjts6JrDe8SRxEg6aksiWAnGF52
 gWiQ3lajLmNibZaAbHGPsU9uo3x4bk+D1OXNNLNIBhFUxfP9BgjMelJaJeAGzGT7AY/C
 jZe6hM95OOiSqjzG1MEOGuhc5Z10GDwqfEB8DYMQ4WXeGBYB927pQHtupXqU9mWGbal1
 sx7cuDPlixL7r19ezG2FoenwPOt34EzSI9ludYeCf2XRbj9MBTXo5ha598XGPyVVo7b+
 lkXZqJBu7cMD2koMzhe+MN1Tg6leVKTm4XRTIEi+NdfyRNCwv35L42kMawLUUSpB2PYV
 0+3g==
X-Gm-Message-State: APjAAAXrPedonnVFnIdiGnCYWy2QRQaJbyOky1MDZ5g1L9nw+H4NSXuL
 V3qPfAbWicc7y9lo70SZ/F4zq4UeUis=
X-Google-Smtp-Source: APXvYqyeoK9ert9G1dcgnQKSkAJQqQ0borZMkPk8aZZW+/oMCF+1UPawvZU7GKfXMDEOgXuo6ZkP6Q==
X-Received: by 2002:adf:f204:: with SMTP id p4mr15950181wro.317.1567170603044; 
 Fri, 30 Aug 2019 06:10:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i5sm7997797wrn.48.2019.08.30.06.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 06:10:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B21C81FF87;
 Fri, 30 Aug 2019 14:10:01 +0100 (BST)
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-4-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: vandersonmr <vandersonmr2@gmail.com>
In-reply-to: <20190829173437.5926-4-vandersonmr2@gmail.com>
Date: Fri, 30 Aug 2019 14:10:01 +0100
Message-ID: <871rx294uu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v8 03/11] accel: collecting JIT statistics
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
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
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/translate-all.c | 15 ++++++++++++++-
>  accel/tcg/translator.c    |  4 ++++
>  include/exec/tb-stats.h   | 15 +++++++++++++++
>  tcg/tcg.c                 | 23 +++++++++++++++++++++++
>  tcg/tcg.h                 |  2 ++
>  5 files changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index e72aeba682..fb2fe0fa1f 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1705,6 +1705,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t ph=
ys_pc, target_ulong pc,
>           * then just make the new TB point to the older TBStatistic
>           */
>          g_free(new_stats);
> +        ((TBStatistics *) existing_stats)->tb =3D current_tb;

This seems out of place and again I can't see what we are doing with
this information yet.

>          return existing_stats;
>      } else {
>          return new_stats;
> @@ -1785,13 +1786,18 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       */
>      if (tb_stats_collection_enabled()) {
>          tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags, tb);
> +        uint32_t flag =3D get_default_tbstats_flag();
>
>          if (qemu_log_in_addr_range(tb->pc)) {
> -            uint32_t flag =3D get_default_tbstats_flag();
>              if (flag & TB_EXEC_STATS) {
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
> @@ -1869,6 +1875,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
> @@ -1926,6 +1936,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
> index ec6bd829a0..9b2e248b09 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -116,6 +116,10 @@ void translator_loop(const TranslatorOps *ops, Disas=
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
> index c4a8715400..b68edd5d24 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -58,6 +58,20 @@ struct TBStatistics {
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
> @@ -71,6 +85,7 @@ enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED,=
 TB_STATS_STOPPED };
>
>  #define TB_NOTHING    (1 << 0)
>  #define TB_EXEC_STATS (1 << 1)
> +#define TB_JIT_STATS  (1 << 2)
>
>  extern int tcg_collect_tb_stats;
>  extern uint32_t default_tbstats_flag;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 0458eaec57..ae3e7a2217 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3125,6 +3125,11 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, =
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
> @@ -3996,6 +4001,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
>      int i, num_insns;
>      TCGOp *op;
>
> +    s->current_tb =3D tb;
> +
>  #ifdef CONFIG_PROFILER
>      {
>          int n =3D 0;
> @@ -4027,6 +4034,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
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
> @@ -4093,6 +4108,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
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
> index 529acb2ed8..b4601162f8 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -740,6 +740,8 @@ struct TCGContext {
>
>      uint16_t gen_insn_end_off[TCG_MAX_INSNS];
>      target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
> +
> +    TranslationBlock *current_tb;

As we are only using this to get to tb_stats why not skip the middle man
and go directly to:

       TBStatistics *current_stats;

?

You already have a tbs_stats_enabled() helper=20

>  };
>
>  extern TCGContext tcg_init_ctx;


--
Alex Benn=C3=A9e

