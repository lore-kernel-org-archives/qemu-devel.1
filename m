Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A418BC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636DD214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVbryDKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636DD214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifsv4-0001fN-Kk
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 16:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ifsp1-00086S-VF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ifsoz-0001XT-Vb
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:50:03 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ifsox-0001Rf-Rs
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:50:00 -0500
Received: by mail-wm1-x342.google.com with SMTP id w8so316342wmd.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0c2HqkNzPuxLxjLub8aZreW+j1/US7MJsRuJNEQVx4o=;
 b=VVbryDKTUZqPDaXkvXhWiD+MwT6pjV3sNllDzC8rt+NuusxljiI+C9HkF4AwQXAjw+
 oqsPEnKRmpnW2Jwb/NZhuBJ6X+jjBLQiOgJzGmfB0MWLHJ2KKDScBELMQ/LY0HxbVc9j
 Qf3FZKC/IEO5hHRvGmTbQpDyU+Bk4TxAo+FtCpq8fb1uBfK+7TV7qIYKydm+Ln7KvXp8
 9YGY1aO56kv3gnOCkgHMrAF2GcVSOEHKTeEGIDGZ2cwNRoxm7NjFQqgo/j7q1saURbk2
 q1yVCkjqbqBsK/KN4VggwogaDxUcWwpF3EVBM7USXXuFeTUsI3O/f9KJw0n/b79cbtpO
 n7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0c2HqkNzPuxLxjLub8aZreW+j1/US7MJsRuJNEQVx4o=;
 b=EL//3GgnxyrlvCdRAozUL08AJI60DN7qgehKTJwuCf3Ln1HxNn7YjmJB17jbT/nL9d
 jTI1SBydfrIxJdbnWslFa42XhKKxQ3QhEtQf47RMwQZZXFW6GtaN83mz5Ms/P9lz1dmO
 wFY9ApAPNqCOJx4px5mTf28JhnZ07BCvkHFg2gfFnsq7xakl5D2YAkND7O+48cgF7Gg9
 5deeObuZ/HHJ7ql0dMDDudE+KopiyRMNauzog9Af5cCU8s/0qWqOMlOB9WKiSTtcFn2z
 07aEtETN9BueAG4Ji/uIGfPJyyqyX6zIVl+3u52wVqfgNaEH1FGoDBIocRNlX8q6wCW4
 kamw==
X-Gm-Message-State: APjAAAX7HYyK55ldirI4V7WefuYhMec1JfbS+6vAc1gNvwvWIF2mKko5
 JhBeGJYPSu7LKmWBgKP+sbO8/g==
X-Google-Smtp-Source: APXvYqyX6EGxInKu7XFEK/9K53zKytYBov708LgQ1CaTMG9KT7o2byM9GfTBdX8M+RSrJM4SDn7o0A==
X-Received: by 2002:a05:600c:2c08:: with SMTP id
 q8mr15275671wmg.45.1576273797874; 
 Fri, 13 Dec 2019 13:49:57 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u24sm4706751wml.10.2019.12.13.13.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 13:49:56 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC4891FF87;
 Fri, 13 Dec 2019 21:49:55 +0000 (GMT)
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-6-alex.bennee@linaro.org>
 <f7038a5e-ac42-bf7f-9191-13fc80eba7c8@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 05/13] accel: adding TB_JIT_TIME and full replacing
 CONFIG_PROFILER
In-reply-to: <f7038a5e-ac42-bf7f-9191-13fc80eba7c8@linaro.org>
Date: Fri, 13 Dec 2019 21:49:55 +0000
Message-ID: <8736dnc2v0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/7/19 11:28 AM, Alex Benn=C3=A9e wrote:
>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>=20
>> Replace all others CONFIG_PROFILER statistics and migrate it to
>> TBStatistics system. However, TCGProfiler still exists and can
>> be use to store global statistics and times. All TB related
>> statistics goes to TBStatistics.
>>=20
>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> Message-Id: <20190829173437.5926-6-vandersonmr2@gmail.com>
>> [AJB: fix authorship]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  accel/tcg/tb-stats.c      |  98 +++++++++++++++++++++---------
>>  accel/tcg/translate-all.c |  46 ++++++++-------
>>  configure                 |   3 -
>>  cpus.c                    |  14 ++---
>>  include/exec/tb-stats.h   |  15 +++++
>>  include/qemu/timer.h      |   5 +-
>>  monitor/misc.c            |  28 ++-------
>>  tcg/tcg.c                 | 121 ++++++++++++--------------------------
>>  tcg/tcg.h                 |   2 +-
>>  vl.c                      |   8 +--
>>  10 files changed, 159 insertions(+), 181 deletions(-)
>>=20
>> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
>> index 0e64c176b3..f431159fd2 100644
>> --- a/accel/tcg/tb-stats.c
>> +++ b/accel/tcg/tb-stats.c
>> @@ -17,11 +17,18 @@
>>  #include "exec/tb-stats.h"
>>=20=20
>>  /* TBStatistic collection controls */
>> -enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPE=
D };
>> +enum TBStatsStatus {
>> +    TB_STATS_DISABLED =3D 0,
>> +    TB_STATS_RUNNING,
>> +    TB_STATS_PAUSED,
>> +    TB_STATS_STOPPED
>> +};
>
> This should be in patch 1, I should think.
>
>> +uint64_t dev_time;
>
> This patch is doing several things at once, and I think it should be spli=
t.
> All of the changes to dev_time, for instance, are unrelated to TBStatisti=
c.
>
>> +    jpi->interm_time +=3D stat_per_translation(tbs, time.interm);
>> +    jpi->code_time +=3D stat_per_translation(tbs, time.code);
>> +    jpi->opt_time +=3D stat_per_translation(tbs, time.opt);
>> +    jpi->la_time +=3D stat_per_translation(tbs, time.la);
>> +    jpi->restore_time +=3D tbs->time.restore;
>> +    jpi->restore_count +=3D tbs->time.restore_count;
>
> Why are some of these "per translation" and some not?

The restore_time is an amortised time or all restore operations (so
dividable by restore_count rather than the number of translations).

I've added some commentary.

>
>> @@ -370,11 +371,11 @@ static int cpu_restore_state_from_tb
>>      }
>>      restore_state_to_opc(env, tb, data);
>>=20=20
>> -#ifdef CONFIG_PROFILER
>> -    atomic_set(&prof->restore_time,
>> -                prof->restore_time + profile_getclock() - ti);
>> -    atomic_set(&prof->restore_count, prof->restore_count + 1);
>> -#endif
>> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
>> +        atomic_add(&tb->tb_stats->time.restore, profile_getclock() - ti=
);
>> +        atomic_inc(&tb->tb_stats->time.restore_count);
>> +    }
>
> Would it be better to use a the TBStatistics lock than two atomic
> updates?

Yeah I think keeping the locking consistent as a mutex probably pays of
in reducing complexity as well.

>
>> @@ -1826,10 +1828,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>>          tcg_ctx->tb_jmp_target_addr =3D tb->jmp_target_arg;
>>      }
>>=20=20
>> -#ifdef CONFIG_PROFILER
>> -    atomic_set(&prof->interm_time, prof->interm_time + profile_getclock=
() - ti);
>> -    ti =3D profile_getclock();
>> -#endif
>> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
>> +        atomic_add(&tb->tb_stats->time.interm, profile_getclock() - ti);
>> +        ti =3D profile_getclock();
>> +    }
>
> You should call profile_getclock() only once here.
>
> Why does this need an atomic_add, while the rest of TB_JIT_STATS within
> tb_gen_code do not, and in fact have a comment:
>
>> +    /*
>> +     * Collect JIT stats when enabled. We batch them all up here to
>> +     * avoid spamming the cache with atomic accesses
>> +     */
>
>> @@ -1871,9 +1873,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>>      }
>>      tb->tc.size =3D gen_code_size;
>>=20=20
>> -#ifdef CONFIG_PROFILER
>> -    atomic_set(&prof->code_time, prof->code_time + profile_getclock() -=
 ti);
>> -#endif
>> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
>> +        atomic_add(&tb->tb_stats->time.code, profile_getclock() - ti);
>> +    }
>
> Likewise.
>
>> diff --git a/configure b/configure
>> index 8f8446f52b..eedeb9016e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6566,9 +6566,6 @@ fi
>>  if test "$static" =3D "yes" ; then
>>    echo "CONFIG_STATIC=3Dy" >> $config_host_mak
>>  fi
>> -if test "$profiler" =3D "yes" ; then
>> -  echo "CONFIG_PROFILER=3Dy" >> $config_host_mak
>> -fi
>
> Removing the define without removing --enable-profiler.
>
>>  static int tcg_cpu_exec(CPUState *cpu)
>>  {
>>      int ret;
>> -#ifdef CONFIG_PROFILER
>> -    int64_t ti;
>> -#endif
>> +    uint64_t ti;
>>=20=20
>>      assert(tcg_enabled());
>> -#ifdef CONFIG_PROFILER
>>      ti =3D profile_getclock();
>> -#endif
>> +
>>      cpu_exec_start(cpu);
>>      ret =3D cpu_exec(cpu);
>>      cpu_exec_end(cpu);
>> -#ifdef CONFIG_PROFILER
>> -    atomic_set(&tcg_ctx->prof.cpu_exec_time,
>> -               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
>> -#endif
>> +
>> +    atomic_add(&tcg_ctx->prof.cpu_exec_time, profile_getclock() - ti);
>
> This is also unrelated to TBStatistics.

I'm going to split this patch up into more sub-commits to do each piece
one at a time. To make it easier can I drop CONFIG_PROFILE support
before the re-factoring so I don't need to keep both modes compiling
during the transition?

> It's also adding an unconditional atomic_add, of which I am not fond.  Sh=
ould
> this be testing tb_stats_collection_enabled() or something else?
>
> I'll also note that tcg_ctx is per-thread (for mttcg), and so perhaps thi=
s does
> not require an atomic_add anyway.  Perhaps just an atomic_set to be paire=
d with
> atomic_read in the dump function that's iterating over the tcg_ctx.

I'll try an improve the commenting of TCGProf about what is just holding
per-translations values which get copied at the end and what is
persistent and may be read from outside the translation context (I think
just the OPC count array now).

>
> Even without the atomic_add, we shouldn't make the syscall for getclock i=
n the
> normal case.
>
>
>> +    /* These are accessed with atomic operations */
>> +    struct {
>> +        int64_t restore;
>> +        uint64_t restore_count;
>> +        int64_t interm;
>> +        int64_t code;
>> +        int64_t opt;
>> +        int64_t la;
>> +    } time;
>
> Why are these signed?  We're always adding positive values.
>
> Why is restore_count here in "time"?  Indeed, why all of these unnamed
> sub-structures at all?  I don't see that "." helps organization any more =
than "_".
>
>> @@ -4020,18 +3959,18 @@ int tcg_gen_code(TCGContext *s, TranslationBlock=
 *tb)
>>      }
>>  #endif
>>=20=20
>> -#ifdef CONFIG_PROFILER
>> -    atomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
>> -#endif
>> +    if (tb_stats_enabled(tb, TB_JIT_TIME)) {
>> +        atomic_add(&tb->tb_stats->time.opt, -profile_getclock());
>> +    }
>
> Atomic add of a negative clock value?  That just means the intermediate v=
alue
> is unusable, so why make any of this atomic?

I've rewritten all this to just grab some timestamps at various key
points and then bring it all together when we update the TBStat in
translate.

>
> Also, this is tb_gen_code again, wherein we already talked about not using
> atomic_foo.
>
>> @@ -4081,14 +4020,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock=
 *tb)
>>      s->pool_labels =3D NULL;
>>  #endif
>>=20=20
>> +    if (!tb_stats_collection_enabled()) {
>> +        QTAILQ_FOREACH(op, &s->ops, link) {
>> +            TCGOpcode opc =3D op->opc;
>> +            atomic_add(&s->prof.table_op_count[opc], 1);
>> +        }
>> +    }
>
> Why would you collect stats when stats collection is disabled?  Is this a
> simple typo?

I think if we can get away with not using atomics this count can go back
to being inline with the main opc loop. If we aren't using atomics is
there really such a big cost to just doing it unconditionally?


--=20
Alex Benn=C3=A9e

