Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF7C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC9F2238C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sE9BF/52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9F2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0Qe-0004QC-HN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hr0QS-00041j-Pr
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hr0QR-0008Oi-6V
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:38:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hr0QQ-0008N6-TK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:38:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id g67so43621668wme.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9c1bx5vKFRhv5r6jqgbJgMLS7iBg8ZJQIuUm6ruOKqw=;
 b=sE9BF/5280An3ArPFSuPyT7wsnUIPLasSqJ/WIl3BRL6vb3vUMPjhLe+/tNlw8ij2q
 a5DbAwb6tYNYiz3geYHR3OvCojPs5Qs1mV9KPhezLe1JVS+5yK7fVwcS9KuauYBRTeAM
 i19c5+poHXxlf9CyOSKeJoaNtNA/mkBY1RKPYuS8zoVBTysKVzMIIq31Yfdx1hWXKOri
 gc5d0PURlIpMVtu5FgJAp/W/Rz07S3Ccgt9FvNQPWqyb9KByI51O/CT7uthrS042g2pt
 LzpnQ/WeXv+N7pLUBjQsvuPmP59VvB/wA9K8e1OF36aHESnRdHGvS4GEqyyiy/7Zgpj/
 4YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9c1bx5vKFRhv5r6jqgbJgMLS7iBg8ZJQIuUm6ruOKqw=;
 b=AtUFZ25SBo8OBNWAMO+w7WrsSGk2eOhbXnCeC4gDClFDh5HnTinH8U8uhF8sIkeqZQ
 cWJMCDzlI7Ef/SddWrX5CcFVpm7iivncchA7znWMPowdo1IIRRzARBl9PKIzKow/6zJ9
 CoHGMwkk9NEBD0VQPx+dhb+WFipoPbzhv/ia/XyVNRJ+9HOGNmkS5GFSM084k9mCKi92
 YtJxy67C+eYErkEyhLvOIsSg4yamauLkW3clHQ4chWi8b+WI+3hNtPIHLUxwh7IXXH8E
 kWbACCgpOijp9X+XD8FHD1KGQsBhcci7NhLP43yl3rbZI5PTLCpHnnp4EBABgHdEyG9a
 SZSA==
X-Gm-Message-State: APjAAAWIbpiz04HEptPV0MCs6RO759LZnWvV6X0heo8CVSDqOZd/iKQ/
 Zpxr1v19iKd1c3VCn8rxxTrKeg==
X-Google-Smtp-Source: APXvYqyiJjUNhjl0CFxNfv6fJRVVc+4c8ms28vUv51RodDexcWA9xsDVNB7lDwnRGbcUCFckj/RZEA==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr82995503wmb.66.1564148301395; 
 Fri, 26 Jul 2019 06:38:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b203sm66516268wmd.41.2019.07.26.06.38.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 06:38:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6A2A71FF87;
 Fri, 26 Jul 2019 14:38:20 +0100 (BST)
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
 <20190720010235.32444-3-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190720010235.32444-3-vandersonmr2@gmail.com>
Date: Fri, 26 Jul 2019 14:38:20 +0100
Message-ID: <87sgqshq5v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 2/7] accel: collecting TB execution count
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

> If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
> enabled, then we instrument the start code of the TB
> to atomically count the number of times it is executed.
> The execution count of the TB is stored in its respective
> TBS.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tcg-runtime.c   |  7 +++++++
>  accel/tcg/tcg-runtime.h   |  2 ++
>  accel/tcg/translate-all.c |  8 ++++++++
>  accel/tcg/translator.c    |  1 +
>  include/exec/gen-icount.h |  9 +++++++++
>  include/exec/tb-stats.h   | 11 +++++++++++
>  include/qemu/log.h        |  6 ++++++
>  util/log.c                | 11 +++++++++++
>  8 files changed, 55 insertions(+)
>
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 8a1e408e31..f332eae334 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
>  {
>      cpu_loop_exit_atomic(env_cpu(env), GETPC());
>  }
> +
> +void HELPER(inc_exec_freq)(void *ptr)
> +{
> +    TBStatistics *stats =3D (TBStatistics *) ptr;
> +    g_assert(stats);
> +    atomic_inc(&stats->executions.total);
> +}
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 4fa61b49b4..bf0b75dbe8 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, pt=
r, env)
>
>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>
> +DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
> +
>  #ifdef CONFIG_SOFTMMU
>
>  DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a574890a80..7497dae508 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1785,6 +1785,14 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       */
>      if (tb_stats_collection_enabled()) {
>          tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags);
> +        uint32_t flag =3D get_default_tbstats_flag();
> +
> +        if (qemu_log_in_addr_range(tb->pc)) {
> +            if (flag & TB_EXEC_STATS) {
> +                tb->tb_stats->stats_enabled |=3D TB_EXEC_STATS;
> +            }
> +        }
> +
>      } else {
>          tb->tb_stats =3D NULL;
>      }
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 9226a348a3..396a11e828 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -46,6 +46,7 @@ void translator_loop(const TranslatorOps *ops, DisasCon=
textBase *db,
>
>      ops->init_disas_context(db, cpu);
>      tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
> +    gen_tb_exec_count(tb);
>
>      /* Reset the temp count so that we can identify leaks */
>      tcg_clear_temp_count();
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index f7669b6841..b3efe41894 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -7,6 +7,15 @@
>
>  static TCGOp *icount_start_insn;
>
> +static inline void gen_tb_exec_count(TranslationBlock *tb)
> +{
> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> +        TCGv_ptr ptr =3D tcg_const_ptr(tb->tb_stats);
> +        gen_helper_inc_exec_freq(ptr);
> +        tcg_temp_free_ptr(ptr);
> +    }
> +}
> +
>  static inline void gen_tb_start(TranslationBlock *tb)
>  {
>      TCGv_i32 count, imm;
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 0913155ec3..ee1e8de0d3 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -6,6 +6,9 @@
>  #include "exec/tb-context.h"
>  #include "tcg.h"
>
> +#define tb_stats_enabled(tb, JIT_STATS) \
> +    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
> +
>  typedef struct TBStatistics TBStatistics;
>
>  /*
> @@ -22,6 +25,14 @@ struct TBStatistics {
>      uint32_t     flags;
>      /* cs_base isn't included in the hash but we do check for matches */
>      target_ulong cs_base;
> +
> +    uint32_t stats_enabled;
> +
> +    /* Execution stats */
> +    struct {
> +        unsigned long total;
> +        unsigned long atomic;

We are not incrementing atomic in this patch. Also it's not total so
maybe "normal" makes more sense. Something like:

fixup! accel: collecting TB execution count

4 files changed, 11 insertions(+), 6 deletions(-)
accel/tcg/cpu-exec.c    | 4 ++++
accel/tcg/tb-stats.c    | 9 +++++----
accel/tcg/tcg-runtime.c | 2 +-
include/exec/tb-stats.h | 2 +-

modified   accel/tcg/cpu-exec.c
@@ -252,6 +252,10 @@ void cpu_exec_step_atomic(CPUState *cpu)

         start_exclusive();

+        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+            tb->tb_stats->executions.atomic++;
+        }
+
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus =3D false;
         in_exclusive_region =3D true;
modified   accel/tcg/tb-stats.c
@@ -233,11 +233,12 @@ static void dump_tb_header(TBStatistics *tbs)
     float guest_host_prop =3D g ? ((float) h / g) : 0;

     qemu_log("TB%d: phys:0x"TB_PAGE_ADDR_FMT" virt:0x"TARGET_FMT_lx
-             " flags:%#08x (trans:%lu uncached:%lu exec:%lu ints: g:%u op:=
%u op_opt:%u h:%u h/g:%.2f spills:%d)\n",
+             " flags:%#08x (trans:%lu uncached:%lu exec:%lu/%lu ints: g:%u=
 op:%u op_opt:%u h:%u h/g:%.2f spills:%d)\n",
              tbs->display_id,
              tbs->phys_pc, tbs->pc, tbs->flags,
              tbs->translations.total, tbs->translations.uncached,
-             tbs->executions.total, g, ops, ops_opt, h, guest_host_prop,
+             tbs->executions.normal, tbs->executions.atomic,
+             g, ops, ops_opt, h, guest_host_prop,
              spills);
 }

@@ -254,8 +255,8 @@ inverse_sort_tbs(gconstpointer p1, gconstpointer p2, gp=
ointer psort_by)
         c1 =3D tbs1->code.spills;
         c2 =3D tbs2->code.spills;
     } else if (likely(sort_by =3D=3D SORT_BY_HOTNESS)) {
-        c1 =3D tbs1->executions.total;
-        c2 =3D tbs2->executions.total;
+        c1 =3D tbs1->executions.normal;
+        c2 =3D tbs2->executions.normal;
     } else if (likely(sort_by =3D=3D SORT_BY_HG)) {
         if (tbs1->code.num_guest_inst =3D=3D 0) {
             return -1;
modified   accel/tcg/tcg-runtime.c
@@ -172,5 +172,5 @@ void HELPER(inc_exec_freq)(void *ptr)
 {
     TBStatistics *stats =3D (TBStatistics *) ptr;
     g_assert(stats);
-    atomic_inc(&stats->executions.total);
+    atomic_inc(&stats->executions.normal);
 }
modified   include/exec/tb-stats.h
@@ -33,7 +33,7 @@ struct TBStatistics {

     /* Execution stats */
     struct {
-        unsigned long total;
+        unsigned long normal;
         unsigned long atomic;
     } executions;

> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index e175d4d5d0..b213411836 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -129,10 +129,16 @@ void qemu_log_flush(void);
>  /* Close the log file */
>  void qemu_log_close(void);
>
> +#define TB_NOTHING    0
> +#define TB_EXEC_STATS (1 << 1)
> +
>  void enable_collect_tb_stats(void);
>  void disable_collect_tb_stats(void);
>  void pause_collect_tb_stats(void);
>  bool tb_stats_collection_enabled(void);
>  bool tb_stats_collection_paused(void);
>
> +void set_default_tbstats_flag(uint32_t flag);
> +uint32_t get_default_tbstats_flag(void);
> +
>  #endif
> diff --git a/util/log.c b/util/log.c
> index ab73fdc100..f81653d712 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -354,3 +354,14 @@ bool tb_stats_collection_paused(void)
>      return tcg_collect_tb_stats =3D=3D 2;
>  }
>
> +uint32_t default_tbstats_flag;
> +
> +void set_default_tbstats_flag(uint32_t flag)
> +{
> +    default_tbstats_flag =3D flag;
> +}
> +
> +uint32_t get_default_tbstats_flag(void)
> +{
> +    return default_tbstats_flag;
> +}

Some comment about not overloading log.c as before.

--
Alex Benn=C3=A9e

