Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60809C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A13E21726
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMDkBbMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A13E21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3h8p-0006d0-8B
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3gzT-0007nz-IL
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3gzO-0005iH-Bv
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:30:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3gzI-0005eG-1e
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:30:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id z11so6993436wrt.4
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qyFOLcrYwwbLm0VEwBgVrUS1ukPOAoEMcgM89uB/AbQ=;
 b=ZMDkBbMoyGP09rVp6bk36yU7q5j4tQ+wAUprZzn4nFKb8OyF6WiiXej3pNhRy6nya3
 zUaIiSnH3MjK7GJJlrVaIFdnjfEbaR9SBHEGsJtBSnt4VCcYj80jYnWxvpCsnkSfj/Oz
 PkebjcyoGCgrbxArTRZGUEoRIRguHvvBh/HK4FSa7TaF7cnahlXVWk4da5D0f3jwe+wo
 qszCnRhDW71yG5sHoAGJAxD8zENS7okkIm0I7gzHLVBStSjH5D4iXf6lHFoFFMfacQZP
 x9X+JyjcoiwUPpkAmw03Lwgj+4Byzr/b8Ss5baXNwjgx4BhW7hH+o8St8LRF/UpHZaEK
 0Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qyFOLcrYwwbLm0VEwBgVrUS1ukPOAoEMcgM89uB/AbQ=;
 b=tLw+2yuxrKHKpoo824ee7ct4C7S6KOlclfNX/hpBQmOhCY8ooD+pZ2iYuyFx/pQ8/C
 IndON3k1rgtFzDeAvKYY5eZ/kxvFVANpF2YHYVh6hqh/sNmV0DacCLO7ggcElMQQzX7+
 I8BywAPEjZDUAtObXZSw4pcmHbIhAYcsykcjCvOBAcZfRGd1J+emLFtZplzRwxnW7TOZ
 m8rFukg3QW2JjgKg/OjsTBg0xsNPg7DK+WI4Kb7lFCBPUazMeBhNKjIWjUGyOovC3SjQ
 sNT+KvxRQ8c2oLiJ05YXfoHJ0kcfero4I3FQ4IF8UvVuVeD51FV0+LVwg0pXXddwX3dQ
 j7mQ==
X-Gm-Message-State: APjAAAVRsUo2jMC55DpnmXduk0vY86bmmxly7Txa6JjceMbiOhWPYNC4
 F83F94Ip6QOKsvmNY+0snxFNd9EdvxQ=
X-Google-Smtp-Source: APXvYqzKDiY8hSlFJzuigPcTKVy9kBKwTVboGF+5DIh0GY4h6UmmZi6actofnkveRapzeQwiSpJxnQ==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr8893456wrr.318.1567170074262; 
 Fri, 30 Aug 2019 06:01:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v7sm6218740wru.87.2019.08.30.06.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 06:01:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C030B1FF87;
 Fri, 30 Aug 2019 14:01:12 +0100 (BST)
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-3-vandersonmr2@gmail.com> <87sgpj3qdl.fsf@linaro.org>
 <CAMzYVD2BVLbNo_q4s0CZYsoecp_NTUtfecM4zYe=Lx58nssJMA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
In-reply-to: <CAMzYVD2BVLbNo_q4s0CZYsoecp_NTUtfecM4zYe=Lx58nssJMA@mail.gmail.com>
Date: Fri, 30 Aug 2019 14:01:12 +0100
Message-ID: <8736hi959j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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


Vanderson Martins do Rosario <vandersonmr2@gmail.com> writes:

> Ok. I haven't change it before because I would like to be able to collect
> information for already translated TBs when I, for instance, remove the
> filter during execution. Having the TBStats already created guarantee thi=
s.
> To guarantee this in your approach, we would need to tb_flush when changi=
ng
> the filter. Does it make sense? Is that ok for you?

I think so. While tb_flush is a bit of hammer translation is pretty
cheap so things will be running pretty quickly afterwards. We don't need
to flush the old TB stats entries though - we can keep them for the
lifetime of the run.

>
> Vanderson M. Rosario
>
>
> On Fri, Aug 30, 2019 at 7:21 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> vandersonmr <vandersonmr2@gmail.com> writes:
>>
>> > If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
>> > enabled, then we instrument the start code of this TB
>> > to atomically count the number of times it is executed.
>> > We count both the number of "normal" executions and atomic
>> > executions of a TB.
>> >
>> > The execution count of the TB is stored in its respective
>> > TBS.
>> >
>> > All TBStatistics are created by default with the flags from
>> > default_tbstats_flag.
>> >
>> > Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> > ---
>> >  accel/tcg/cpu-exec.c      |  4 ++++
>> >  accel/tcg/tb-stats.c      |  5 +++++
>> >  accel/tcg/tcg-runtime.c   |  7 +++++++
>> >  accel/tcg/tcg-runtime.h   |  2 ++
>> >  accel/tcg/translate-all.c |  7 +++++++
>> >  accel/tcg/translator.c    |  1 +
>> >  include/exec/gen-icount.h |  9 +++++++++
>> >  include/exec/tb-stats.h   | 19 +++++++++++++++++++
>> >  util/log.c                |  1 +
>> >  9 files changed, 55 insertions(+)
>> >
>> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> > index 48272c781b..9b2b7bff80 100644
>> > --- a/accel/tcg/cpu-exec.c
>> > +++ b/accel/tcg/cpu-exec.c
>> > @@ -251,6 +251,10 @@ void cpu_exec_step_atomic(CPUState *cpu)
>> >
>> >          start_exclusive();
>> >
>> > +        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>> > +            tb->tb_stats->executions.atomic++;
>> > +        }
>> > +
>> >          /* Since we got here, we know that parallel_cpus must be true.
>> */
>> >          parallel_cpus =3D false;
>> >          in_exclusive_region =3D true;
>> > diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
>> > index 948b107e68..1db81d83e7 100644
>> > --- a/accel/tcg/tb-stats.c
>> > +++ b/accel/tcg/tb-stats.c
>> > @@ -61,3 +61,8 @@ bool tb_stats_collection_paused(void)
>> >  {
>> >      return tcg_collect_tb_stats =3D=3D TB_STATS_PAUSED;
>> >  }
>> > +
>> > +uint32_t get_default_tbstats_flag(void)
>> > +{
>> > +    return default_tbstats_flag;
>> > +}
>> > diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
>> > index 8a1e408e31..6f4aafba11 100644
>> > --- a/accel/tcg/tcg-runtime.c
>> > +++ b/accel/tcg/tcg-runtime.c
>> > @@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
>> >  {
>> >      cpu_loop_exit_atomic(env_cpu(env), GETPC());
>> >  }
>> > +
>> > +void HELPER(inc_exec_freq)(void *ptr)
>> > +{
>> > +    TBStatistics *stats =3D (TBStatistics *) ptr;
>> > +    g_assert(stats);
>> > +    atomic_inc(&stats->executions.normal);
>> > +}
>> > diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
>> > index 4fa61b49b4..bf0b75dbe8 100644
>> > --- a/accel/tcg/tcg-runtime.h
>> > +++ b/accel/tcg/tcg-runtime.h
>> > @@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE,
>> ptr, env)
>> >
>> >  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>> >
>> > +DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
>> > +
>> >  #ifdef CONFIG_SOFTMMU
>> >
>> >  DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
>> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> > index b7bccacd3b..e72aeba682 100644
>> > --- a/accel/tcg/translate-all.c
>> > +++ b/accel/tcg/translate-all.c
>> > @@ -1785,6 +1785,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>> >       */
>> >      if (tb_stats_collection_enabled()) {
>> >          tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags, tb=
);
>> > +
>> > +        if (qemu_log_in_addr_range(tb->pc)) {
>>
>> We can open this out because this test will always pass if no dfilter
>> has been set and there is no point creating a tb_stats record if we
>> won't fill it in. So
>>
>>   if (qemu_log_in_addr_range(tb->pc)) {
>>      tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags, tb);
>>      uint32_t flag =3D get_default_tbstats_flag();
>>
>>      if (flag & TB_EXEC_STATS) {
>>        ...
>>
>> And the additional tests that get added later. This way we'll only
>> create and collect stats for what we want.
>>
>> > +            uint32_t flag =3D get_default_tbstats_flag();
>> > +            if (flag & TB_EXEC_STATS) {
>> > +                tb->tb_stats->stats_enabled |=3D TB_EXEC_STATS;
>> > +            }
>> > +        }
>> >      } else {
>> >          tb->tb_stats =3D NULL;
>> >      }
>> > diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> > index 70c66c538c..ec6bd829a0 100644
>> > --- a/accel/tcg/translator.c
>> > +++ b/accel/tcg/translator.c
>> > @@ -46,6 +46,7 @@ void translator_loop(const TranslatorOps *ops,
>> DisasContextBase *db,
>> >
>> >      ops->init_disas_context(db, cpu);
>> >      tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit=
 */
>> > +    gen_tb_exec_count(tb);
>> >
>> >      /* Reset the temp count so that we can identify leaks */
>> >      tcg_clear_temp_count();
>> > diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
>> > index 822c43cfd3..be006383b9 100644
>> > --- a/include/exec/gen-icount.h
>> > +++ b/include/exec/gen-icount.h
>> > @@ -32,6 +32,15 @@ static inline void gen_io_end(void)
>> >      tcg_temp_free_i32(tmp);
>> >  }
>> >
>> > +static inline void gen_tb_exec_count(TranslationBlock *tb)
>> > +{
>> > +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>> > +        TCGv_ptr ptr =3D tcg_const_ptr(tb->tb_stats);
>> > +        gen_helper_inc_exec_freq(ptr);
>> > +        tcg_temp_free_ptr(ptr);
>> > +    }
>> > +}
>> > +
>> >  static inline void gen_tb_start(TranslationBlock *tb)
>> >  {
>> >      TCGv_i32 count, imm;
>> > diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
>> > index 898e05a36f..c4a8715400 100644
>> > --- a/include/exec/tb-stats.h
>> > +++ b/include/exec/tb-stats.h
>> > @@ -30,6 +30,9 @@
>> >  #include "exec/tb-context.h"
>> >  #include "tcg.h"
>> >
>> > +#define tb_stats_enabled(tb, JIT_STATS) \
>> > +    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
>> > +
>> >  typedef struct TBStatistics TBStatistics;
>> >
>> >  /*
>> > @@ -46,6 +49,15 @@ struct TBStatistics {
>> >      uint32_t     flags;
>> >      /* cs_base isn't included in the hash but we do check for matches=
 */
>> >      target_ulong cs_base;
>> > +
>> > +    uint32_t stats_enabled;
>> > +
>> > +    /* Execution stats */
>> > +    struct {
>> > +        unsigned long normal;
>> > +        unsigned long atomic;
>> > +    } executions;
>> > +
>> >      /* current TB linked to this TBStatistics */
>> >      TranslationBlock *tb;
>> >  };
>> > @@ -56,7 +68,12 @@ void init_tb_stats_htable_if_not(void);
>> >
>> >  /* TBStatistic collection controls */
>> >  enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED,
>> TB_STATS_STOPPED };
>> > +
>> > +#define TB_NOTHING    (1 << 0)
>> > +#define TB_EXEC_STATS (1 << 1)
>> > +
>> >  extern int tcg_collect_tb_stats;
>> > +extern uint32_t default_tbstats_flag;
>> >
>> >  void enable_collect_tb_stats(void);
>> >  void disable_collect_tb_stats(void);
>> > @@ -64,4 +81,6 @@ void pause_collect_tb_stats(void);
>> >  bool tb_stats_collection_enabled(void);
>> >  bool tb_stats_collection_paused(void);
>> >
>> > +uint32_t get_default_tbstats_flag(void);
>> > +
>> >  #endif
>> > diff --git a/util/log.c b/util/log.c
>> > index 393a17115b..29021a4584 100644
>> > --- a/util/log.c
>> > +++ b/util/log.c
>> > @@ -32,6 +32,7 @@ static int log_append =3D 0;
>> >  static GArray *debug_regions;
>> >
>> >  int tcg_collect_tb_stats;
>> > +uint32_t default_tbstats_flag;
>> >
>> >  /* Return the number of characters emitted.  */
>> >  int qemu_log(const char *fmt, ...)
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--=20
Alex Benn=C3=A9e

