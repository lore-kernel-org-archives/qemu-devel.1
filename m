Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E25C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C012F21726
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8ERfbuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C012F21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3h9g-0007W3-Vl
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 09:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3h2G-0001bA-Jt
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3h2D-00016E-1D
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:33:51 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:44242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3h2C-000133-Gl
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:33:48 -0400
Received: by mail-qk1-x743.google.com with SMTP id i78so4664764qke.11
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U6ojGf3MP8Gs+Ld7Ak4+LtdP2GzCKp0FNQzXh4xQGaQ=;
 b=c8ERfbuzu4UmvNUDSM7F83NeRRrwXtJHy4gvCp3FGih3KnkMsi75U5SE/gJwxdxctK
 Ij3LGCJHwp299jpizzrzPPnbKvTEmEgiPkMzhbYaGEeqFHBbqgSx9AJOB8uU+CajnKff
 RY/Qd9ZCHL1R39oBURwCnmBr9WtA9SAnS+GzuzZJ0qBVcpqUx3S2EuuIzjwAbSJwq8nb
 4L/8D/9Dz76+QJ9XLN5c9ASoD84Zc3EI4NgRgY1rfhLSBjOSCuAPmym9+DyHFeEccQqv
 RblYfHP4XAg+fr0JaAM6JAxR1arCNFm/sH03NfTsFk2eDaW/h0SErNyeRkOzE2U0DsB8
 qIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U6ojGf3MP8Gs+Ld7Ak4+LtdP2GzCKp0FNQzXh4xQGaQ=;
 b=Rg0Dl0o3f4uoqMYSWKVvJsB+b4mHWLoUbNj/OkwcsrcPfol+6LeuHRFReOVdWXNWBD
 /6Biq4iRFou6sUwUOMyCNxU8c39dq1McaZfF5eA8/ecrjb2ab1pkZZUh8GAw82hzYpVd
 h3S1GFJPJAIDXuTwae2gI2cNSp2RDvWqAG8u+M0fc0KwLJmcx6lelFsLq+Cgs+0ZDTiQ
 atuPXytZhSVHuxZqHYr3vpJfbZWdQdG1MaOZYD98qCZpOpqNv8OtEIvLgw3sB2bmvydd
 DYcbDVKI263OC7vVup/K6qhQ1KH4n85+Hny6WrxAnaAc9H0O65Fc0rL+0NbL+YM6LZfa
 /6Yw==
X-Gm-Message-State: APjAAAU8AGY9ii+WZjFASxm3rMESYSICTt87Ctl7WLV8izavx9DQ3UEA
 9xGWC3H3rxTri+UD7kzUJ3i+41F2m+eCEgz8+npU1fA47as=
X-Google-Smtp-Source: APXvYqw4LFz4r2dnhxQbESGT9lX/scLRIrIylvE9mCRDucLLpeWHDOd9mbfJ9WJWHAKj7//V6bXjOfD4E6yQVvf+luM=
X-Received: by 2002:a37:4fcf:: with SMTP id
 d198mr15007208qkb.394.1567168314266; 
 Fri, 30 Aug 2019 05:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-3-vandersonmr2@gmail.com>
 <87sgpj3qdl.fsf@linaro.org>
In-Reply-To: <87sgpj3qdl.fsf@linaro.org>
From: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
Date: Fri, 30 Aug 2019 09:31:42 -0300
Message-ID: <CAMzYVD2BVLbNo_q4s0CZYsoecp_NTUtfecM4zYe=Lx58nssJMA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v8 02/11] accel: collecting TB execution
 count
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

Ok. I haven't change it before because I would like to be able to collect
information for already translated TBs when I, for instance, remove the
filter during execution. Having the TBStats already created guarantee this.
To guarantee this in your approach, we would need to tb_flush when changing
the filter. Does it make sense? Is that ok for you?

Vanderson M. Rosario


On Fri, Aug 30, 2019 at 7:21 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> vandersonmr <vandersonmr2@gmail.com> writes:
>
> > If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
> > enabled, then we instrument the start code of this TB
> > to atomically count the number of times it is executed.
> > We count both the number of "normal" executions and atomic
> > executions of a TB.
> >
> > The execution count of the TB is stored in its respective
> > TBS.
> >
> > All TBStatistics are created by default with the flags from
> > default_tbstats_flag.
> >
> > Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> > ---
> >  accel/tcg/cpu-exec.c      |  4 ++++
> >  accel/tcg/tb-stats.c      |  5 +++++
> >  accel/tcg/tcg-runtime.c   |  7 +++++++
> >  accel/tcg/tcg-runtime.h   |  2 ++
> >  accel/tcg/translate-all.c |  7 +++++++
> >  accel/tcg/translator.c    |  1 +
> >  include/exec/gen-icount.h |  9 +++++++++
> >  include/exec/tb-stats.h   | 19 +++++++++++++++++++
> >  util/log.c                |  1 +
> >  9 files changed, 55 insertions(+)
> >
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 48272c781b..9b2b7bff80 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -251,6 +251,10 @@ void cpu_exec_step_atomic(CPUState *cpu)
> >
> >          start_exclusive();
> >
> > +        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> > +            tb->tb_stats->executions.atomic++;
> > +        }
> > +
> >          /* Since we got here, we know that parallel_cpus must be true.
> */
> >          parallel_cpus =3D false;
> >          in_exclusive_region =3D true;
> > diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> > index 948b107e68..1db81d83e7 100644
> > --- a/accel/tcg/tb-stats.c
> > +++ b/accel/tcg/tb-stats.c
> > @@ -61,3 +61,8 @@ bool tb_stats_collection_paused(void)
> >  {
> >      return tcg_collect_tb_stats =3D=3D TB_STATS_PAUSED;
> >  }
> > +
> > +uint32_t get_default_tbstats_flag(void)
> > +{
> > +    return default_tbstats_flag;
> > +}
> > diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> > index 8a1e408e31..6f4aafba11 100644
> > --- a/accel/tcg/tcg-runtime.c
> > +++ b/accel/tcg/tcg-runtime.c
> > @@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
> >  {
> >      cpu_loop_exit_atomic(env_cpu(env), GETPC());
> >  }
> > +
> > +void HELPER(inc_exec_freq)(void *ptr)
> > +{
> > +    TBStatistics *stats =3D (TBStatistics *) ptr;
> > +    g_assert(stats);
> > +    atomic_inc(&stats->executions.normal);
> > +}
> > diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> > index 4fa61b49b4..bf0b75dbe8 100644
> > --- a/accel/tcg/tcg-runtime.h
> > +++ b/accel/tcg/tcg-runtime.h
> > @@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE,
> ptr, env)
> >
> >  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
> >
> > +DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
> > +
> >  #ifdef CONFIG_SOFTMMU
> >
> >  DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > index b7bccacd3b..e72aeba682 100644
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -1785,6 +1785,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
> >       */
> >      if (tb_stats_collection_enabled()) {
> >          tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags, tb)=
;
> > +
> > +        if (qemu_log_in_addr_range(tb->pc)) {
>
> We can open this out because this test will always pass if no dfilter
> has been set and there is no point creating a tb_stats record if we
> won't fill it in. So
>
>   if (qemu_log_in_addr_range(tb->pc)) {
>      tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags, tb);
>      uint32_t flag =3D get_default_tbstats_flag();
>
>      if (flag & TB_EXEC_STATS) {
>        ...
>
> And the additional tests that get added later. This way we'll only
> create and collect stats for what we want.
>
> > +            uint32_t flag =3D get_default_tbstats_flag();
> > +            if (flag & TB_EXEC_STATS) {
> > +                tb->tb_stats->stats_enabled |=3D TB_EXEC_STATS;
> > +            }
> > +        }
> >      } else {
> >          tb->tb_stats =3D NULL;
> >      }
> > diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> > index 70c66c538c..ec6bd829a0 100644
> > --- a/accel/tcg/translator.c
> > +++ b/accel/tcg/translator.c
> > @@ -46,6 +46,7 @@ void translator_loop(const TranslatorOps *ops,
> DisasContextBase *db,
> >
> >      ops->init_disas_context(db, cpu);
> >      tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit =
*/
> > +    gen_tb_exec_count(tb);
> >
> >      /* Reset the temp count so that we can identify leaks */
> >      tcg_clear_temp_count();
> > diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> > index 822c43cfd3..be006383b9 100644
> > --- a/include/exec/gen-icount.h
> > +++ b/include/exec/gen-icount.h
> > @@ -32,6 +32,15 @@ static inline void gen_io_end(void)
> >      tcg_temp_free_i32(tmp);
> >  }
> >
> > +static inline void gen_tb_exec_count(TranslationBlock *tb)
> > +{
> > +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
> > +        TCGv_ptr ptr =3D tcg_const_ptr(tb->tb_stats);
> > +        gen_helper_inc_exec_freq(ptr);
> > +        tcg_temp_free_ptr(ptr);
> > +    }
> > +}
> > +
> >  static inline void gen_tb_start(TranslationBlock *tb)
> >  {
> >      TCGv_i32 count, imm;
> > diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> > index 898e05a36f..c4a8715400 100644
> > --- a/include/exec/tb-stats.h
> > +++ b/include/exec/tb-stats.h
> > @@ -30,6 +30,9 @@
> >  #include "exec/tb-context.h"
> >  #include "tcg.h"
> >
> > +#define tb_stats_enabled(tb, JIT_STATS) \
> > +    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
> > +
> >  typedef struct TBStatistics TBStatistics;
> >
> >  /*
> > @@ -46,6 +49,15 @@ struct TBStatistics {
> >      uint32_t     flags;
> >      /* cs_base isn't included in the hash but we do check for matches =
*/
> >      target_ulong cs_base;
> > +
> > +    uint32_t stats_enabled;
> > +
> > +    /* Execution stats */
> > +    struct {
> > +        unsigned long normal;
> > +        unsigned long atomic;
> > +    } executions;
> > +
> >      /* current TB linked to this TBStatistics */
> >      TranslationBlock *tb;
> >  };
> > @@ -56,7 +68,12 @@ void init_tb_stats_htable_if_not(void);
> >
> >  /* TBStatistic collection controls */
> >  enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED,
> TB_STATS_STOPPED };
> > +
> > +#define TB_NOTHING    (1 << 0)
> > +#define TB_EXEC_STATS (1 << 1)
> > +
> >  extern int tcg_collect_tb_stats;
> > +extern uint32_t default_tbstats_flag;
> >
> >  void enable_collect_tb_stats(void);
> >  void disable_collect_tb_stats(void);
> > @@ -64,4 +81,6 @@ void pause_collect_tb_stats(void);
> >  bool tb_stats_collection_enabled(void);
> >  bool tb_stats_collection_paused(void);
> >
> > +uint32_t get_default_tbstats_flag(void);
> > +
> >  #endif
> > diff --git a/util/log.c b/util/log.c
> > index 393a17115b..29021a4584 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -32,6 +32,7 @@ static int log_append =3D 0;
> >  static GArray *debug_regions;
> >
> >  int tcg_collect_tb_stats;
> > +uint32_t default_tbstats_flag;
> >
> >  /* Return the number of characters emitted.  */
> >  int qemu_log(const char *fmt, ...)
>
>
> --
> Alex Benn=C3=A9e
>
