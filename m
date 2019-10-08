Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A6FC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10831206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/eFpn+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10831206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrPS-00077f-9n
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHrN4-0004Ld-Lk
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHrN2-00067u-Ql
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:25:54 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:45196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHrN2-00067Z-Ke
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:25:52 -0400
Received: by mail-yw1-xc41.google.com with SMTP id x65so6552398ywf.12
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vh6mG5HPPZeENrzXfYha8T7lVrBGfv6HdbXWG6uD+90=;
 b=F/eFpn+8E5Rgx6cK8/ZwvMKqQXxMmVEbNfSnforBIJGV9HgH6n2OXvRTB5o89jJsbT
 KsRPsooMahLsXSFrz3jpaIt9ivApOYD8EwnhkwBdGYcivAxu7YZwzEOdoHfWM6yhr2VO
 3mfPjuWhxgGw2hxNlEhBrSURD/S0YWjQY3N/3C1u+9Fo6e8RI08XWRKyp1JESVnh0Bag
 xKRacWGIc5H0HRRts5E8TxL1EtXKXIKCu4TACLUsaK6xr3PGOreQNoCuUNgN7DzUuPrP
 b8zluZiUdDmu4bZ+PBkRZabqC+IKYZ6CZ+NiG8F9YEJiFDNT+4MVLXuwPoCAY2cZsssy
 G0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vh6mG5HPPZeENrzXfYha8T7lVrBGfv6HdbXWG6uD+90=;
 b=sbKW3clkm01tYOT6IOG4/UV07/lbZdccwVxHhR7jIwsYy2yvw4Gm7ib9BJg+g8C+N8
 /iNc6NSsQx2dPOsG/M81pkVgBxnsvRQa5MWmYsGN9++jqoeGqSG2LZNON20+5yYP+dH+
 UXp5E0rVm/pHE5BBzYGc44d4Rc0oYKHu2v3Q7ngnCNZx1/dttFqWuRm2qU7tAVcpukYf
 wp7ankTpB1dMrWPeY2F5+MLiYEDg2cwqAOjIb26ior/dLcMwIAlK02Q2b3OZigLelsr9
 Xu5WL9qPQg3MrQZvz4/F7o1S1dUGjBaj4Rk2EcIdzWc4H2CFcEZ9ig5MbOTLInYssB4/
 hFzw==
X-Gm-Message-State: APjAAAXkSQUiGtB4tb+qOvejyn63NEtGaOZ/+jcDUCc0ulDiIElJmBud
 h3djCnqrWPZjLlJMepyqYoilCA==
X-Google-Smtp-Source: APXvYqz6h4imZfqNaigVCA519EJpTWVoRUXwbblSqU09NRWQGEEcFh9hGa5qxJdQuh8+IqyRVdqExg==
X-Received: by 2002:a81:5f85:: with SMTP id t127mr24289211ywb.26.1570548351723; 
 Tue, 08 Oct 2019 08:25:51 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id y205sm4700976ywc.6.2019.10.08.08.25.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 08:25:50 -0700 (PDT)
Subject: Re: [PATCH v9 05/13] accel: adding TB_JIT_TIME and full replacing
 CONFIG_PROFILER
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f7038a5e-ac42-bf7f-9191-13fc80eba7c8@linaro.org>
Date: Tue, 8 Oct 2019 11:25:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> Replace all others CONFIG_PROFILER statistics and migrate it to
> TBStatistics system. However, TCGProfiler still exists and can
> be use to store global statistics and times. All TB related
> statistics goes to TBStatistics.
> 
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-6-vandersonmr2@gmail.com>
> [AJB: fix authorship]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/tb-stats.c      |  98 +++++++++++++++++++++---------
>  accel/tcg/translate-all.c |  46 ++++++++-------
>  configure                 |   3 -
>  cpus.c                    |  14 ++---
>  include/exec/tb-stats.h   |  15 +++++
>  include/qemu/timer.h      |   5 +-
>  monitor/misc.c            |  28 ++-------
>  tcg/tcg.c                 | 121 ++++++++++++--------------------------
>  tcg/tcg.h                 |   2 +-
>  vl.c                      |   8 +--
>  10 files changed, 159 insertions(+), 181 deletions(-)
> 
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 0e64c176b3..f431159fd2 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -17,11 +17,18 @@
>  #include "exec/tb-stats.h"
>  
>  /* TBStatistic collection controls */
> -enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
> +enum TBStatsStatus {
> +    TB_STATS_DISABLED = 0,
> +    TB_STATS_RUNNING,
> +    TB_STATS_PAUSED,
> +    TB_STATS_STOPPED
> +};

This should be in patch 1, I should think.

> +uint64_t dev_time;

This patch is doing several things at once, and I think it should be split.
All of the changes to dev_time, for instance, are unrelated to TBStatistic.

> +    jpi->interm_time += stat_per_translation(tbs, time.interm);
> +    jpi->code_time += stat_per_translation(tbs, time.code);
> +    jpi->opt_time += stat_per_translation(tbs, time.opt);
> +    jpi->la_time += stat_per_translation(tbs, time.la);
> +    jpi->restore_time += tbs->time.restore;
> +    jpi->restore_count += tbs->time.restore_count;

Why are some of these "per translation" and some not?

> @@ -370,11 +371,11 @@ static int cpu_restore_state_from_tb
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

Would it be better to use a the TBStatistics lock than two atomic updates?

> @@ -1826,10 +1828,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>          tcg_ctx->tb_jmp_target_addr = tb->jmp_target_arg;
>      }
>  
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->interm_time, prof->interm_time + profile_getclock() - ti);
> -    ti = profile_getclock();
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.interm, profile_getclock() - ti);
> +        ti = profile_getclock();
> +    }

You should call profile_getclock() only once here.

Why does this need an atomic_add, while the rest of TB_JIT_STATS within
tb_gen_code do not, and in fact have a comment:

> +    /*
> +     * Collect JIT stats when enabled. We batch them all up here to
> +     * avoid spamming the cache with atomic accesses
> +     */

> @@ -1871,9 +1873,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      }
>      tb->tc.size = gen_code_size;
>  
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->code_time, prof->code_time + profile_getclock() - ti);
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.code, profile_getclock() - ti);
> +    }

Likewise.

> diff --git a/configure b/configure
> index 8f8446f52b..eedeb9016e 100755
> --- a/configure
> +++ b/configure
> @@ -6566,9 +6566,6 @@ fi
>  if test "$static" = "yes" ; then
>    echo "CONFIG_STATIC=y" >> $config_host_mak
>  fi
> -if test "$profiler" = "yes" ; then
> -  echo "CONFIG_PROFILER=y" >> $config_host_mak
> -fi

Removing the define without removing --enable-profiler.

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
>      ti = profile_getclock();
> -#endif
> +
>      cpu_exec_start(cpu);
>      ret = cpu_exec(cpu);
>      cpu_exec_end(cpu);
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&tcg_ctx->prof.cpu_exec_time,
> -               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
> -#endif
> +
> +    atomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);

This is also unrelated to TBStatistics.

It's also adding an unconditional atomic_add, of which I am not fond.  Should
this be testing tb_stats_collection_enabled() or something else?

I'll also note that tcg_ctx is per-thread (for mttcg), and so perhaps this does
not require an atomic_add anyway.  Perhaps just an atomic_set to be paired with
atomic_read in the dump function that's iterating over the tcg_ctx.

Even without the atomic_add, we shouldn't make the syscall for getclock in the
normal case.


> +    /* These are accessed with atomic operations */
> +    struct {
> +        int64_t restore;
> +        uint64_t restore_count;
> +        int64_t interm;
> +        int64_t code;
> +        int64_t opt;
> +        int64_t la;
> +    } time;

Why are these signed?  We're always adding positive values.

Why is restore_count here in "time"?  Indeed, why all of these unnamed
sub-structures at all?  I don't see that "." helps organization any more than "_".

> @@ -4020,18 +3959,18 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>      }
>  #endif
>  
> -#ifdef CONFIG_PROFILER
> -    atomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
> -#endif
> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
> +        atomic_add(&tb->tb_stats->time.opt, -profile_getclock());
> +    }

Atomic add of a negative clock value?  That just means the intermediate value
is unusable, so why make any of this atomic?

Also, this is tb_gen_code again, wherein we already talked about not using
atomic_foo.

> @@ -4081,14 +4020,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>      s->pool_labels = NULL;
>  #endif
>  
> +    if (!tb_stats_collection_enabled()) {
> +        QTAILQ_FOREACH(op, &s->ops, link) {
> +            TCGOpcode opc = op->opc;
> +            atomic_add(&s->prof.table_op_count[opc], 1);
> +        }
> +    }

Why would you collect stats when stats collection is disabled?  Is this a
simple typo?


r~

