Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00902C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44EB214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bs4d4Udd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44EB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2bHD-00009s-M1
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2bGF-00085d-HZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2bGC-0002m5-Vk
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:11:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2bGC-0002h0-L7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:11:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id q12so18713112wrj.12
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qzMfcW5IvivZDVMsb10Sa+A6OEDRjQdkUZhLt0/KtLI=;
 b=bs4d4UdddulTTsTtScVcfZtd2O5wasUARljEcX5StIaeCLmJVfj+KiHzLh4ru1WNC4
 gfzsNuwI+RXWVqbWdvm9m2gn6VsbpZXkNhHkVGwrucL8bZednnmHr47Jy+ygx9vHxpdP
 VzWu5e5tRC3oodY1VYrHE+tkb+fAZvXu74KBuHnyE5/+zH/6CEEzg2SvkjH/uTNGnqQW
 YIrvWqHjNNErWSWIt1bg51lIe47zgQNyFmpQ7VuIAW+nYwnSh3+P58pV5f5x76eyqXPy
 5kypyq7HjHNUPl4sv3XmDfUAe/q4uFIpx//mBe8GwoaLbvUCs8f+pZvDW4dLD9BuRoAr
 tRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qzMfcW5IvivZDVMsb10Sa+A6OEDRjQdkUZhLt0/KtLI=;
 b=OjiTZVFUynugv+yCn8IClaAtlSwR6cJykcTKBXCmiWP2pxOF7EMleBPkEB+wFdQR9B
 EpGpo3npyKWFuuSykht+7wG0gcucN9OL4td8sxER26IXvG2BkyPXnEGR61Rw649nOeAh
 uOun0ZJkpEbClIFWvlpqryRneLuvJt6GsoDSXUay6GkfHsUg5DqwYCE7o2OCgl36OrWR
 baWW8AiuMgxXVowmVAU1QUnojP3OGlchMOkIH/1sJond7cptRK48tLNN08KdhJYuFV2J
 A8BAlz3GJIWw7NpkHyNzbwa2N3hKdZh45bXjASLpLI3uk74G+Rg6u2BgtrIQRGQLp4VS
 Vc6w==
X-Gm-Message-State: APjAAAWLim6CXQ042PCfF0Eb3cwrdxCytQyWYu2XMuHqqxj+s6wk9lZj
 n24vQ0QqK3OQC1aPgA9LRa4EoA==
X-Google-Smtp-Source: APXvYqxY4oKVg7LqklYneQoqe8cL+jA+ws2k3LsXXB5kGCkmrYw0at8VMFsoyBAY2j59WObaXinW1w==
X-Received: by 2002:a5d:4ec6:: with SMTP id s6mr28547644wrv.327.1566911502783; 
 Tue, 27 Aug 2019 06:11:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f18sm13108973wrx.85.2019.08.27.06.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 06:11:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 266C11FF87;
 Tue, 27 Aug 2019 14:11:41 +0100 (BST)
References: <20190821172329.2062-1-vandersonmr2@gmail.com>
 <20190821172329.2062-6-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190821172329.2062-6-vandersonmr2@gmail.com>
Date: Tue, 27 Aug 2019 14:11:41 +0100
Message-ID: <87pnkq69de.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v6 05/10] accel: adding TB_JIT_TIME and
 full replacing CONFIG_PROFILER
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 vandersonmr <vandersonmr2@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Replace all others CONFIG_PROFILER statistics and migrate it to
> TBStatistics system. However, TCGProfiler still exists and can
> be use to store global statistics and times. All TB related
> statistics goes to TBStatistics.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tb-stats.c      |  91 +++++++++++++++++++---------
>  accel/tcg/translate-all.c |  47 ++++++++-------
>  configure                 |   3 -
>  cpus.c                    |  14 ++---
>  include/exec/tb-stats.h   |  19 +++++-
>  include/qemu/timer.h      |   5 +-
>  monitor/misc.c            |  28 ++-------
>  tcg/tcg.c                 | 124 +++++++++++---------------------------
>  tcg/tcg.h                 |  10 +--
>  vl.c                      |   8 +--
>  10 files changed, 156 insertions(+), 193 deletions(-)
>
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index f53e889d01..e0ac254fc1 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -8,6 +8,8 @@
>
>  #include "exec/tb-stats.h"
>
> +uint64_t dev_time;
> +
>  struct jit_profile_info {
>      uint64_t translations;
>      uint64_t aborted;
> @@ -19,6 +21,13 @@ struct jit_profile_info {
>      uint64_t host;
>      uint64_t guest;
>      uint64_t search_data;
> +
> +    uint64_t interm_time;
> +    uint64_t code_time;
> +    uint64_t restore_count;
> +    uint64_t restore_time;
> +    uint64_t opt_time;
> +    uint64_t la_time;
>  };
>
>  /* accumulate the statistics from all TBs */
> @@ -40,6 +49,29 @@ static void collect_jit_profile_info(void *p, uint32_t=
 hash, void *userp)
>      jpi->host +=3D tbs->code.out_len;
>      jpi->guest +=3D tbs->code.in_len;
>      jpi->search_data +=3D tbs->code.search_out_len;
> +
> +    jpi->interm_time +=3D stat_per_translation(tbs, time.interm);
> +    jpi->code_time +=3D stat_per_translation(tbs, time.code);
> +    jpi->opt_time +=3D stat_per_translation(tbs, time.opt);
> +    jpi->la_time +=3D stat_per_translation(tbs, time.la);
> +    jpi->restore_time +=3D tbs->time.restore;
> +    jpi->restore_count +=3D tbs->time.restore_count;
> +}
> +
> +void dump_jit_exec_time_info(uint64_t dev_time)
> +{
> +    static uint64_t last_cpu_exec_time;
> +    uint64_t cpu_exec_time;
> +    uint64_t delta;
> +
> +    cpu_exec_time =3D tcg_cpu_exec_time();
> +    delta =3D cpu_exec_time - last_cpu_exec_time;
> +
> +    qemu_printf("async time  %" PRId64 " (%0.3f)\n",
> +                   dev_time, dev_time / (double) NANOSECONDS_PER_SECOND);
> +    qemu_printf("qemu time   %" PRId64 " (%0.3f)\n",
> +                   delta, delta / (double) NANOSECONDS_PER_SECOND);
> +    last_cpu_exec_time =3D cpu_exec_time;
>  }
>
>  /* dump JIT statisticis using TCGProfile and TBStats */
> @@ -66,34 +98,39 @@ void dump_jit_profile_info(TCGProfile *s)
>          qemu_printf("avg search data/TB  %0.1f\n",
>                  jpi->search_data / (double) jpi->translations);
>
> +        uint64_t tot =3D jpi->interm_time + jpi->code_time;
> +
> +        qemu_printf("JIT cycles          %" PRId64 " (%0.3fs at 2.4 GHz)=
\n",
> +                tot, tot / 2.4e9);
> +        qemu_printf("  cycles/op           %0.1f\n",
> +                jpi->ops ? (double)tot / jpi->ops : 0);
> +        qemu_printf("  cycles/in byte      %0.1f\n",
> +                jpi->guest ? (double)tot / jpi->guest : 0);
> +        qemu_printf("  cycles/out byte     %0.1f\n",
> +                jpi->host ? (double)tot / jpi->host : 0);
> +        qemu_printf("  cycles/search byte  %0.1f\n",
> +                jpi->search_data ? (double)tot / jpi->search_data : 0);
> +        if (tot =3D=3D 0) {
> +            tot =3D 1;
> +        }
> +
> +        qemu_printf("  gen_interm time     %0.1f%%\n",
> +                (double)jpi->interm_time / tot * 100.0);
> +        qemu_printf("  gen_code time       %0.1f%%\n",
> +                (double)jpi->code_time / tot * 100.0);
> +
> +        qemu_printf("    optim./code time    %0.1f%%\n",
> +                (double)jpi->opt_time / (jpi->code_time ? jpi->code_time=
 : 1) * 100.0);
> +        qemu_printf("    liveness/code time  %0.1f%%\n",
> +                (double)jpi->la_time / (jpi->code_time ? jpi->code_time =
: 1) * 100.0);
> +
> +        qemu_printf("cpu_restore count   %" PRId64 "\n", jpi->restore_co=
unt);
> +        qemu_printf("  avg cycles        %0.1f\n",
> +                jpi->restore_count ? (double)jpi->restore_time / jpi->re=
store_count : 0);
> +
>          if (s) {
> -            int64_t tot =3D s->interm_time + s->code_time;
> -            qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4=
 GHz)\n",
> -                            tot, tot / 2.4e9);
> -            qemu_printf("cycles/op           %0.1f\n",
> -                        jpi->ops ? (double)tot / jpi->ops : 0);
> -            qemu_printf("cycles/in byte      %0.1f\n",
> -                        jpi->guest ? (double)tot / jpi->guest : 0);
> -            qemu_printf("cycles/out byte     %0.1f\n",
> -                        jpi->host ? (double)tot / jpi->host : 0);
> -            qemu_printf("cycles/search byte     %0.1f\n",
> -                        jpi->search_data ? (double)tot / jpi->search_dat=
a : 0);
> -            if (tot =3D=3D 0) {
> -                tot =3D 1;
> -            }
> -            qemu_printf("  gen_interm time   %0.1f%%\n",
> -                        (double)s->interm_time / tot * 100.0);
> -            qemu_printf("  gen_code time     %0.1f%%\n",
> -                        (double)s->code_time / tot * 100.0);
> -            qemu_printf("optim./code time    %0.1f%%\n",
> -                        (double)s->opt_time / (s->code_time ? s->code_ti=
me : 1)
> -                        * 100.0);
> -            qemu_printf("liveness/code time  %0.1f%%\n",
> -                    (double)s->la_time / (s->code_time ? s->code_time : =
1) * 100.0);
> -            qemu_printf("cpu_restore count   %" PRId64 "\n",
> -                    s->restore_count);
> -            qemu_printf("  avg cycles        %0.1f\n",
> -                    s->restore_count ? (double)s->restore_time / s->rest=
ore_count : 0);
> +            qemu_printf("cpu exec time  %" PRId64 " (%0.3fs)\n",
> +                s->cpu_exec_time, s->cpu_exec_time / (double) NANOSECOND=
S_PER_SECOND);
>          }
>      }
>      g_free(jpi);
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fe890f0782..a2e65bb85c 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -337,10 +337,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu,=
 TranslationBlock *tb,
>      CPUArchState *env =3D cpu->env_ptr;
>      uint8_t *p =3D tb->tc.ptr + tb->tc.size;
>      int i, j, num_insns =3D tb->icount;
> -#ifdef CONFIG_PROFILER
> -    TCGProfile *prof =3D &tcg_ctx->prof;
> -    int64_t ti =3D profile_getclock();
> -#endif
> +    uint64_t ti =3D 0;
> +
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        ti =3D profile_getclock();
> +    }
>
>      searched_pc -=3D GETPC_ADJ;
>
> @@ -370,11 +371,11 @@ static int cpu_restore_state_from_tb(CPUState *cpu,=
 TranslationBlock *tb,
>      }
>      restore_state_to_opc(env, tb, data);
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->restore_time,
> -                prof->restore_time + profile_getclock() - ti);
> -    atomic_set(&prof->restore_count, prof->restore_count + 1);
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.restore, profile_getclock() - ti);
> +        atomic_inc(&tb->tb_stats->time.restore_count);
> +    }
> +
>      return 0;
>  }
>
> @@ -1724,10 +1725,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      target_ulong virt_page2;
>      tcg_insn_unit *gen_code_buf;
>      int gen_code_size, search_size, max_insns;
> -#ifdef CONFIG_PROFILER
> -    TCGProfile *prof =3D &tcg_ctx->prof;
> -    int64_t ti;
> -#endif
> +    uint64_t ti =3D 0;
> +
>      assert_memory_lock();
>
>      phys_pc =3D get_page_addr_code(env, pc);
> @@ -1773,9 +1772,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      tcg_ctx->tb_cflags =3D cflags;
>   tb_overflow:
>
> -#ifdef CONFIG_PROFILER
> -    ti =3D profile_getclock();
> -#endif
>
>      /*
>       * We want to fetch the stats structure before we start code
> @@ -1796,6 +1792,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>              tb->tb_stats->stats_enabled |=3D TB_JIT_STATS;
>              atomic_inc(&tb->tb_stats->translations.total);
>          }
> +
> +        if (flag & TB_JIT_TIME) {
> +            tb->tb_stats->stats_enabled |=3D TB_JIT_TIME;
> +            ti =3D profile_getclock();
> +        }
>      } else {
>          tb->tb_stats =3D NULL;
>      }
> @@ -1820,10 +1821,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>          tcg_ctx->tb_jmp_target_addr =3D tb->jmp_target_arg;
>      }
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->interm_time, prof->interm_time + profile_getclock(=
) - ti);
> -    ti =3D profile_getclock();
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.interm, profile_getclock() - ti);
> +        ti =3D profile_getclock();
> +    }
>
>      gen_code_size =3D tcg_gen_code(tcg_ctx, tb);
>      if (unlikely(gen_code_size < 0)) {
> @@ -1865,9 +1866,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      }
>      tb->tc.size =3D gen_code_size;
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->code_time, prof->code_time + profile_getclock() - =
ti);
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.code, profile_getclock() - ti);
> +    }
>
>      if (tb_stats_enabled(tb, TB_JIT_STATS)) {
>          atomic_add(&tb->tb_stats->code.in_len, tb->size);
> diff --git a/configure b/configure
> index 714e7fb6a1..0b3c45c05b 100755
> --- a/configure
> +++ b/configure
> @@ -6614,9 +6614,6 @@ fi
>  if test "$static" =3D "yes" ; then
>    echo "CONFIG_STATIC=3Dy" >> $config_host_mak
>  fi
> -if test "$profiler" =3D "yes" ; then
> -  echo "CONFIG_PROFILER=3Dy" >> $config_host_mak
> -fi
>  if test "$slirp" !=3D "no"; then
>    echo "CONFIG_SLIRP=3Dy" >> $config_host_mak
>    echo "CONFIG_SMBD_COMMAND=3D\"$smbd\"" >> $config_host_mak
> diff --git a/cpus.c b/cpus.c
> index 927a00aa90..d8e4e89c19 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1423,21 +1423,17 @@ static void process_icount_data(CPUState *cpu)
>  static int tcg_cpu_exec(CPUState *cpu)
>  {
>      int ret;
> -#ifdef CONFIG_PROFILER
> -    int64_t ti;
> -#endif
> +    uint64_t ti;
>
>      assert(tcg_enabled());
> -#ifdef CONFIG_PROFILER
>      ti =3D profile_getclock();
> -#endif
> +
>      cpu_exec_start(cpu);
>      ret =3D cpu_exec(cpu);
>      cpu_exec_end(cpu);
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&tcg_ctx->prof.cpu_exec_time,
> -               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
> -#endif
> +
> +    atomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);
> +
>      return ret;
>  }
>
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 3f062fda5a..0ea2639fd2 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -57,22 +57,39 @@ struct TBStatistics {
>          unsigned long spanning;
>      } translations;
>
> +    struct {
> +        int64_t restore;
> +        uint64_t restore_count;
> +        int64_t interm;
> +        int64_t code;
> +        int64_t opt;
> +        int64_t la;
> +    } time;
> +
>      /* current TB linked to this TBStatistics */
>      TranslationBlock *tb;
>  };
>
>  bool tb_stats_cmp(const void *ap, const void *bp);
>
> +void dump_jit_exec_time_info(uint64_t dev_time);
> +
>  void init_tb_stats_htable_if_not(void);
>
>  void dump_jit_profile_info(TCGProfile *s);
>
>  /* TBStatistic collection controls */
> -enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED=
 };
> +enum TBStatsStatus {
> +    TB_STATS_DISABLED =3D 0,
> +    TB_STATS_RUNNING,
> +    TB_STATS_PAUSED,
> +    TB_STATS_STOPPED
> +};

>
>  #define TB_NOTHING    (1 << 0)
>  #define TB_EXEC_STATS (1 << 1)
>  #define TB_JIT_STATS  (1 << 2)
> +#define TB_JIT_STATS  (1 << 3)

This looks like a dupe, how could it compile? Should it in fact be TB_JIT_T=
IME?

>
>  extern int tcg_collect_tb_stats;
>  extern uint32_t default_tbstats_flag;
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 5d978e1634..27571a7037 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -1037,13 +1037,10 @@ static inline int64_t cpu_get_host_ticks(void)
>  }
>  #endif
>
> -#ifdef CONFIG_PROFILER
>  static inline int64_t profile_getclock(void)
>  {
>      return get_clock();
>  }
>
> -extern int64_t dev_time;
> -#endif
> -
> +extern uint64_t dev_time;
>  #endif
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 00338c002a..4839d6875f 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -472,6 +472,11 @@ static void hmp_info_jit(Monitor *mon, const QDict *=
qdict)
>
>  static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>  {
> +    if (!tb_stats_collection_enabled()) {
> +        error_report("TB information not being recorded.");
> +        return;
> +    }
> +
>      dump_opcount_info();
>  }
>  #endif
> @@ -1082,32 +1087,11 @@ static void hmp_info_mtree(Monitor *mon, const QD=
ict *qdict)
>      mtree_info(flatview, dispatch_tree, owner);
>  }
>
> -#ifdef CONFIG_PROFILER
> -
> -int64_t dev_time;
> -
>  static void hmp_info_profile(Monitor *mon, const QDict *qdict)
>  {
> -    static int64_t last_cpu_exec_time;
> -    int64_t cpu_exec_time;
> -    int64_t delta;
> -
> -    cpu_exec_time =3D tcg_cpu_exec_time();
> -    delta =3D cpu_exec_time - last_cpu_exec_time;
> -
> -    monitor_printf(mon, "async time  %" PRId64 " (%0.3f)\n",
> -                   dev_time, dev_time / (double)NANOSECONDS_PER_SECOND);
> -    monitor_printf(mon, "qemu time   %" PRId64 " (%0.3f)\n",
> -                   delta, delta / (double)NANOSECONDS_PER_SECOND);
> -    last_cpu_exec_time =3D cpu_exec_time;
> +    dump_jit_exec_time_info(dev_time);
>      dev_time =3D 0;
>  }
> -#else
> -static void hmp_info_profile(Monitor *mon, const QDict *qdict)
> -{
> -    monitor_printf(mon, "Internal profiler not compiled\n");
> -}
> -#endif
>
>  /* Capture support */
>  static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 46b31a2f68..1a306e1ec9 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3885,82 +3885,34 @@ static void tcg_reg_alloc_call(TCGContext *s, TCG=
Op *op)
>      }
>  }
>
> -#ifdef CONFIG_PROFILER
> -
>  /* avoid copy/paste errors */
>  #define PROF_ADD(to, from, field)                       \
>      do {                                                \
>          (to)->field +=3D atomic_read(&((from)->field));   \
>      } while (0)
>
> -#define PROF_MAX(to, from, field)                                       \
> -    do {                                                                \
> -        typeof((from)->field) val__ =3D atomic_read(&((from)->field));  =
  \
> -        if (val__ > (to)->field) {                                      \
> -            (to)->field =3D val__;                                      =
  \
> -        }                                                               \
> -    } while (0)
> -
> -/* Pass in a zero'ed @prof */
> -static inline
> -void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
> +static void collect_tcg_profiler(TCGProfile *prof)
>  {
> +    int i;
>      unsigned int n_ctxs =3D atomic_read(&n_tcg_ctxs);
> -    unsigned int i;
>
>      for (i =3D 0; i < n_ctxs; i++) {
>          TCGContext *s =3D atomic_read(&tcg_ctxs[i]);
>          const TCGProfile *orig =3D &s->prof;
>
> -        if (counters) {
> -            PROF_ADD(prof, orig, cpu_exec_time);
> -            PROF_ADD(prof, orig, interm_time);
> -            PROF_ADD(prof, orig, code_time);
> -            PROF_ADD(prof, orig, la_time);
> -            PROF_ADD(prof, orig, opt_time);
> -            PROF_ADD(prof, orig, restore_count);
> -            PROF_ADD(prof, orig, restore_time);
> -        }
> -        if (table) {
> -            int i;
> +        PROF_ADD(prof, orig, cpu_exec_time);
>
> -            for (i =3D 0; i < NB_OPS; i++) {
> -                PROF_ADD(prof, orig, table_op_count[i]);
> -            }
> +        for (i =3D 0; i < NB_OPS; i++) {
> +            PROF_ADD(prof, orig, table_op_count[i]);
>          }
>      }
>  }
>
> -#undef PROF_ADD
> -#undef PROF_MAX
> -
> -static void tcg_profile_snapshot_counters(TCGProfile *prof)
> -{
> -    tcg_profile_snapshot(prof, true, false);
> -}
> -
> -static void tcg_profile_snapshot_table(TCGProfile *prof)
> -{
> -    tcg_profile_snapshot(prof, false, true);
> -}
> -
> -void tcg_dump_op_count(void)
> -{
> -    TCGProfile prof =3D {};
> -    int i;
> -
> -    tcg_profile_snapshot_table(&prof);
> -    for (i =3D 0; i < NB_OPS; i++) {
> -        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name,
> -                    prof.table_op_count[i]);
> -    }
> -}
> -
> -int64_t tcg_cpu_exec_time(void)
> +uint64_t tcg_cpu_exec_time(void)
>  {
>      unsigned int n_ctxs =3D atomic_read(&n_tcg_ctxs);
>      unsigned int i;
> -    int64_t ret =3D 0;
> +    uint64_t ret =3D 0;
>
>      for (i =3D 0; i < n_ctxs; i++) {
>          const TCGContext *s =3D atomic_read(&tcg_ctxs[i]);
> @@ -3970,25 +3922,9 @@ int64_t tcg_cpu_exec_time(void)
>      }
>      return ret;
>  }
> -#else
> -void tcg_dump_op_count(void)
> -{
> -    qemu_printf("[TCG profiler not compiled]\n");
> -}
> -
> -int64_t tcg_cpu_exec_time(void)
> -{
> -    error_report("%s: TCG profiler not compiled", __func__);
> -    exit(EXIT_FAILURE);
> -}
> -#endif
> -
>
>  int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>  {
> -#ifdef CONFIG_PROFILER
> -    TCGProfile *prof =3D &s->prof;
> -#endif
>      int i, num_insns;
>      TCGOp *op;
>
> @@ -4041,18 +3977,18 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>      }
>  #endif
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.opt, -profile_getclock());
> +    }
>
>  #ifdef USE_TCG_OPTIMIZATIONS
>      tcg_optimize(s);
>  #endif
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
> -    atomic_set(&prof->la_time, prof->la_time - profile_getclock());
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.opt, profile_getclock());
> +        atomic_add(&tb->tb_stats->time.la,  -profile_getclock());
> +    }
>
>      reachable_code_pass(s);
>      liveness_pass_1(s);
> @@ -4075,9 +4011,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
>          }
>      }
>
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->la_time, prof->la_time + profile_getclock());
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.la, profile_getclock());
> +    }
>
>  #ifdef DEBUG_DISAS
>      if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP_OPT)
> @@ -4110,14 +4046,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>      s->pool_labels =3D NULL;
>  #endif
>
> +    if (!tb_stats_collection_enabled()) {
> +        QTAILQ_FOREACH(op, &s->ops, link) {
> +            TCGOpcode opc =3D op->opc;
> +            atomic_add(&s->prof.table_op_count[opc], 1);
> +        }
> +    }
> +
>      num_insns =3D -1;
>      QTAILQ_FOREACH(op, &s->ops, link) {
>          TCGOpcode opc =3D op->opc;
>
> -#ifdef CONFIG_PROFILER
> -        atomic_set(&prof->table_op_count[opc], prof->table_op_count[opc]=
 + 1);
> -#endif
> -
>          switch (opc) {
>          case INDEX_op_mov_i32:
>          case INDEX_op_mov_i64:
> @@ -4210,14 +4149,23 @@ int tcg_gen_code(TCGContext *s, TranslationBlock =
*tb)
>      return tcg_current_code_size(s);
>  }
>
> +void tcg_dump_op_count(void)
> +{
> +    TCGProfile prof =3D {};
> +    int i;
> +
> +    collect_tcg_profiler(&prof);
> +    for (i =3D 0; i < NB_OPS; i++) {
> +        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name, prof.table_=
op_count[i]);
> +    }
> +}
> +
>  void tcg_dump_info(void)
>  {
>      TCGProfile *s =3D NULL;
> -#ifdef CONFIG_PROFILER
>      TCGProfile prof =3D {};
> -    tcg_profile_snapshot_counters(&prof);
>      s =3D &prof;
> -#endif
> +    collect_tcg_profiler(s);
>      dump_jit_profile_info(s);
>  }
>
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 026a066b9a..12f54283db 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -644,12 +644,6 @@ QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
>
>  typedef struct TCGProfile {
>      int64_t cpu_exec_time;
> -    int64_t interm_time;
> -    int64_t code_time;
> -    int64_t la_time;
> -    int64_t opt_time;
> -    int64_t restore_count;
> -    int64_t restore_time;
>      int64_t table_op_count[NB_OPS];
>  } TCGProfile;
>
> @@ -677,9 +671,7 @@ struct TCGContext {
>
>      tcg_insn_unit *code_ptr;
>
> -#ifdef CONFIG_PROFILER
>      TCGProfile prof;
> -#endif
>
>  #ifdef CONFIG_DEBUG_TCG
>      int temps_in_use;
> @@ -1011,7 +1003,7 @@ int tcg_check_temp_count(void);
>  #define tcg_check_temp_count() 0
>  #endif
>
> -int64_t tcg_cpu_exec_time(void);
> +uint64_t tcg_cpu_exec_time(void);
>  void tcg_dump_info(void);
>  void tcg_dump_op_count(void);
>
> diff --git a/vl.c b/vl.c
> index b426b32134..ef7737a7bc 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1781,17 +1781,11 @@ static bool main_loop_should_exit(void)
>
>  static void main_loop(void)
>  {
> -#ifdef CONFIG_PROFILER
> -    int64_t ti;
> -#endif
> +    uint64_t ti;
>      while (!main_loop_should_exit()) {
> -#ifdef CONFIG_PROFILER
>          ti =3D profile_getclock();
> -#endif
>          main_loop_wait(false);
> -#ifdef CONFIG_PROFILER
>          dev_time +=3D profile_getclock() - ti;
> -#endif
>      }
>  }


--
Alex Benn=C3=A9e

