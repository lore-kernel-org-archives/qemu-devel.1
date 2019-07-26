Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F375EC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE51D20869
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5lG/tc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE51D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr3Wx-0001Hg-1F
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 12:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hr3Wl-0000rs-Kg
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hr3Wj-0005TK-Ts
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:57:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hr3Wj-0005LT-HV
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:57:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so55111541wrf.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=s3WF8CoI8DIoXoqdJWkQChOEkusWU2ljBJJWUPo2R5I=;
 b=K5lG/tc/LFETt9P0zr80sIihVSbGc6ZjwchQmn90zvvuztR7y5TlQkU0+qg2H3kq8x
 vZwPF5B2TwWMfheOjuDj2INJKadYtRwVmIRYmrFg2qFvsnz188CpzcMoJ/DFGOMS6MNC
 PB6VDAdkhZXdyahXowx4oBa0RX7HwYHWuCaakucdTJOgG2mfAYVRDkp48IQRlWiHvDlF
 iWf8hcBOcKfdhFjo2878/sL3+j7D7KSyu91fYJYEFf8JqoI7jWHMrA3lyT+CstQPIx5S
 93wFbHlbnKorGeywviP25peZsIEzC8rwAoT4LuKwksKopO3BxnzdXcIq32gBmkn1ILS3
 Nzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=s3WF8CoI8DIoXoqdJWkQChOEkusWU2ljBJJWUPo2R5I=;
 b=aeJ7O9EiTvdlBPyomzhLqQnZYfmbR4zUN1ohNMlUpptpozOwh5gkx3wLu5jskxVLnx
 dv6RwMIIzvJXoeKUVmckbWz2UEK3fT1xqMsSmIAiqW6iNsQNPUqmHePvY7XW7WaMJxya
 F9Rq3DHapUD2tneXfOF6cMm9sPIKlG5z5pipasPQhhSsuIIgD7H3ZpWblS3g4ejOI1tu
 mr9/F8PJbMIKGY78clDmz3f0lX8+kM5x6DD/9Wn2y+UllSqgu00VXsHqQ88XFKKuhRVt
 zuDJhO3hMg+2ZF6VwoXYQggfYYkBTFUfEA9HSJo8ploiN9OKZtJAvxp+b68DT3ulri3d
 193A==
X-Gm-Message-State: APjAAAX2L1iwaFsVtUEjyBJFh5T2cgiJoAuyJc/0qnQqD7q+yOZXl3ts
 KNFgfIf6TQoKANVH0u9louj+jA==
X-Google-Smtp-Source: APXvYqzz/WkWKlhcgc6cQjASA99qCXC667L1sus4bC82DHJU655ZglgB+eKrXTzw7nI2bIyyqioG0g==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr33370403wro.81.1564160223931; 
 Fri, 26 Jul 2019 09:57:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v16sm33138578wrn.28.2019.07.26.09.57.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 09:57:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01B9B1FF87;
 Fri, 26 Jul 2019 17:57:03 +0100 (BST)
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
 <20190720010235.32444-7-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190720010235.32444-7-vandersonmr2@gmail.com>
Date: Fri, 26 Jul 2019 17:57:02 +0100
Message-ID: <87muh0hgyp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v4 6/7] monitor: adding tb_stats hmp command
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

> Adding tb_stats [start|pause|stop|filter] command to hmp.
> This allows controlling the collection of statistics.
> It is also possible to set the level of collection:
> all, jit, or exec.
>
> The goal of this command is to allow the dynamic exploration
> of the TCG behavior and quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tb-stats.c    | 107 ++++++++++++++++++++++++++++++++++++++++
>  hmp-commands.hx         |  17 +++++++
>  include/exec/tb-stats.h |  13 +++++
>  include/qemu/log.h      |   1 +
>  monitor/misc.c          |  40 +++++++++++++++
>  5 files changed, 178 insertions(+)
>
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 44497d4f9b..6c330e1b02 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -6,6 +6,9 @@
>
>  #include "qemu/qemu-print.h"
>
> +/* only accessed in safe work */
> +static GList *last_search;
> +
>  struct jit_profile_info {
>      uint64_t translations;
>      uint64_t aborted;
> @@ -104,4 +107,108 @@ void dump_jit_profile_info(TCGProfile *s)
>      }
>  }
>
> +static void dessaloc_tbstats(void *p, uint32_t hash, void *userp)
> +{
> +    g_free(p);
> +}

surely free_tbstats would be a better name?

> +
> +void clean_tbstats(void)
> +{
> +    /* remove all tb_stats */
> +    qht_iter(&tb_ctx.tb_stats, dessaloc_tbstats, NULL);
> +    qht_destroy(&tb_ctx.tb_stats);
> +}
> +
> +static void reset_tbstats_flag(void *p, uint32_t hash, void *userp)
> +{
> +    uint32_t flag =3D *((int *)userp);
> +    TBStatistics *tbs =3D p;
> +    tbs->stats_enabled =3D flag;
> +}
> +
> +void set_tbstats_flags(uint32_t flag)
> +{
> +    /* iterate over tbstats setting their flag as TB_NOTHING */
> +    qht_iter(&tb_ctx.tb_stats, reset_tbstats_flag, &flag);
> +}
> +
> +void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
> +{
> +    struct TbstatsCommand *cmdinfo =3D icmd.host_ptr;
> +    int cmd =3D cmdinfo->cmd;
> +    uint32_t level =3D cmdinfo->level;
> +
> +    /* for safe, always pause TB generation while running this commands =
*/
> +    mmap_lock();

This doesn't serialise in all cases - in fact it's running as safe work
which is our serial case. The mmap_lock is really only needed for code
generation in linux-user. I think the lock/unlock can be dropped from
these operations.

> +
> +    switch (cmd) {
> +    case START:
> +        if (tb_stats_collection_paused()) {
> +            set_tbstats_flags(level);
> +        } else {
> +            if (tb_stats_collection_enabled()) {
> +                qemu_printf("TB information already being recorded");
> +                return;
> +            }
> +            qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZ=
E,
> +                        QHT_MODE_AUTO_RESIZE);

I'm wary of initialising this in multiple places. Maybe move this to
enable_collect_tb_stats and drop the initialisation in tb_htable_init.

> +        }
> +
> +        set_default_tbstats_flag(level);
> +        enable_collect_tb_stats();
> +        tb_flush(cpu);
> +        break;
> +    case PAUSE:
> +        if (!tb_stats_collection_enabled()) {
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +
> +        /* Continue to create TBStatistic structures but stop collecting=
 statistics */
> +        pause_collect_tb_stats();
> +        tb_flush(cpu);
> +        set_default_tbstats_flag(TB_NOTHING);
> +        set_tbstats_flags(TB_PAUSED);

Minor style suggestion - make the tb_flush the last thing you do once
you have moved things around. You are in safe work so nothing should be
happening anyway and it reads better.

> +        break;
> +    case STOP:
> +        if (!tb_stats_collection_enabled()) {
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +
> +        /* Dissalloc all TBStatistics structures and stop creating new o=
nes */
> +        disable_collect_tb_stats();
> +        tb_flush(cpu);
> +        clean_tbstats();

As above.

> +        break;
> +    case FILTER:
> +        if (!tb_stats_collection_enabled()) {
> +            qemu_printf("TB information not being recorded");
> +            return;
> +        }
> +        if (!last_search) {
> +            qemu_printf("no search on record! execute info tbs before fi=
ltering!");
> +            return;
> +        }
> +
> +        tb_flush(cpu);
> +        set_default_tbstats_flag(TB_NOTHING);
> +
> +        /* Set all tbstats as paused, then return only the ones from las=
t_search */
> +        pause_collect_tb_stats();
> +        set_tbstats_flags(TB_PAUSED);
> +
> +        for (GList *iter =3D last_search; iter; iter =3D g_list_next(ite=
r)) {
> +            TBStatistics *tbs =3D iter->data;
> +            tbs->stats_enabled =3D level;
> +        }

If we are only interested in tracking the N hotestest at this point we
want to prevent allocation of new TBStats and free all the unused ones?

> +
> +        break;
> +    default: /* INVALID */

g_assert_not_reached()? This would be an internal bug if we ever sent
the wrong command?

> +        break;
> +    }
> +
> +    mmap_unlock();
> +    g_free(cmdinfo);
> +}
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index bfa5681dd2..419898751e 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1885,6 +1885,23 @@ STEXI
>  @findex qemu-io
>  Executes a qemu-io command on the given block device.
>
> +ETEXI
> +#if defined(CONFIG_TCG)
> +    {
> +        .name       =3D "tb_stats",
> +        .args_type  =3D "command:s,level:s?",
> +        .params     =3D "command [stats_level]",
> +        .help       =3D "Control tb statistics collection:"
> +                        "tb_stats (start|pause|stop|filter)
> [all|jit_stats|exec_stats]",

What does filter do?

> +        .cmd        =3D hmp_tbstats,
> +    },
> +#endif
> +
> +STEXI
> +@item tb_stats
> +@findex
> +Control recording tb statistics
> +
>  ETEXI
>
>      {
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 7d775f2c0d..d1debd3262 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -6,6 +6,9 @@
>  #include "exec/tb-context.h"
>  #include "tcg.h"
>
> +enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPIL=
LS };
> +enum TbstatsCmd { START, PAUSE, STOP, FILTER };
> +
>  #define tb_stats_enabled(tb, JIT_STATS) \
>      (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
>
> @@ -60,4 +63,14 @@ bool tb_stats_cmp(const void *ap, const void *bp);
>
>  void dump_jit_profile_info(TCGProfile *s);
>
> +void set_tbstats_flags(uint32_t flags);
> +void clean_tbstats(void);
> +
> +struct TbstatsCommand {
> +    enum TbstatsCmd cmd;
> +    uint32_t level;
> +};
> +
> +void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
> +
>  #endif
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index 93642603e5..47071d72c7 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -133,6 +133,7 @@ void qemu_log_close(void);
>  #define TB_NOTHING    0
>  #define TB_EXEC_STATS (1 << 1)
>  #define TB_JIT_STATS  (1 << 2)
> +#define TB_PAUSED     (1 << 3)
>
>  void enable_collect_tb_stats(void);
>  void disable_collect_tb_stats(void);
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 00338c002a..aea9b0db4f 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -459,6 +459,46 @@ static void hmp_info_registers(Monitor *mon, const Q=
Dict *qdict)
>  }
>
>  #ifdef CONFIG_TCG
> +static void hmp_tbstats(Monitor *mon, const QDict *qdict)
> +{
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +
> +    char *cmd =3D (char *) qdict_get_try_str(qdict, "command");
> +    enum TbstatsCmd icmd =3D -1;
> +
> +    if (strcmp(cmd, "start") =3D=3D 0) {
> +        icmd =3D START;
> +    } else if (strcmp(cmd, "pause") =3D=3D 0) {
> +        icmd =3D PAUSE;
> +    } else if (strcmp(cmd, "stop") =3D=3D 0) {
> +        icmd =3D STOP;
> +    } else if (strcmp(cmd, "filter") =3D=3D 0) {
> +        icmd =3D FILTER;
> +    } else {
> +        error_report("invalid command!");
> +    }
> +
> +    char *slevel =3D (char *) qdict_get_try_str(qdict, "level");
> +    uint32_t level =3D TB_EXEC_STATS | TB_JIT_STATS;
> +    if (slevel) {
> +        if (strcmp(slevel, "jit_stats") =3D=3D 0) {
> +            level =3D TB_JIT_STATS;
> +        } else if (strcmp(slevel, "exec_stats") =3D=3D 0) {
> +            level =3D TB_EXEC_STATS;
> +        }
> +    }
> +
> +    struct TbstatsCommand *tbscommand =3D g_new0(struct TbstatsCommand, =
1);
> +    tbscommand->cmd =3D icmd;
> +    tbscommand->level =3D level;

It might be worth considering squashing these into a single pointer to
avoid the allocation and free?

> +    async_safe_run_on_cpu(first_cpu, do_hmp_tbstats_safe,
> +                          RUN_ON_CPU_HOST_PTR(tbscommand));
> +
> +}
> +
>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>  {
>      if (!tcg_enabled()) {


--
Alex Benn=C3=A9e

