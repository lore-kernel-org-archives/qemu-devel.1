Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B469C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F6C22BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XONyP75O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F6C22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4mZ-0003Uf-9k
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50930)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hr4mK-00031y-Rh
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hr4mI-0001aQ-Ir
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:17:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hr4mH-0001XH-Ss
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 14:17:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id p17so55318982wrf.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0BIlhvCwrLfo9oKBhl/+Qv6AyIFZrt9+3smqxxMIf8w=;
 b=XONyP75OsTceS8jkboek77iIBmztPkJjDcRSINawsqpm57wT3YF9blin5P2h6s53gZ
 pTnxobkRfubm9NigknRi0yBwLyMD5No/1fr+qMaGq6M6y2xwnRdpsysJCGiCcK3KL23S
 Q9e5gwHl9aJ4M+PuDEPcv7bOpxH4+mh2agVGm0ErXHR/2Zi0pLBod/15wRFZ61pMrVp6
 gTNrGVlFtHKgzwx2zeJoUaPG+XI82Tt+6ReLNDZWGjBefEZCXCkDe9dpiOvpkdiArnPd
 8K3Vsf9m1AGC43mJa+mh6nk3aVstDiXPAmI832ApnHa6pjxc/6ZgxpvRYdAsYcRJaCIv
 Dv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0BIlhvCwrLfo9oKBhl/+Qv6AyIFZrt9+3smqxxMIf8w=;
 b=JhvkhpDTezQH3IrzJdYNjmtPr3kT7pn45wMWWBJn+MpeO8z4FRP2bV0ELOGy+glb8S
 z8GkHyILhVeBM8Mk166A+YSVMapzgRaTjANAGA7mBo3QGn7H5saIeiToltkqF10ixfOP
 /qSVS4IB7iMnHfUgxU1+oC5CKLRNhzVEOzmcFmhbwEqJnu0yUBQQLCN6GX1r73sIQ7Ir
 UCP8QAP+JyXq+E0v8fQLuddUTSRdtg25D6YSdM+GubIJYMt33lo0NPMdUrywKJeDD3g3
 93B2xP3GZYVtFVLlcG1x/zHRzEHSKoafCPaDNt6Hr6XGzEOI8rFD+QbFJF/yyRIZ653j
 4qDw==
X-Gm-Message-State: APjAAAVkjyxGp9CQUQasywwQMFsublC38VUXAJsu5HdB4gBqOFAn8IQa
 Bz8SqSj8kII+Fqzcx8WV2CS3Yg==
X-Google-Smtp-Source: APXvYqxRVbxawXJ2lx13Fez6VsclOYefK3r6lztP+Jhls48Q46rPiv3y/hJ9V0OZVIFrsP558/sUAg==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr31079162wrk.229.1564165031736; 
 Fri, 26 Jul 2019 11:17:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g19sm97339543wrb.52.2019.07.26.11.17.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 11:17:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A403A1FF87;
 Fri, 26 Jul 2019 19:17:10 +0100 (BST)
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
 <20190720010235.32444-8-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190720010235.32444-8-vandersonmr2@gmail.com>
Date: Fri, 26 Jul 2019 19:17:10 +0100
Message-ID: <87o91gd5jt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v4 7/7] monitor: adding info tbs, tb,
 and coverset
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
Cc: vandersonmr <vandersonmr2@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Adding info [tbs|tb|coverset] commands to HMP.
> These commands allow the exploration of TBs
> generated by the TCG. Understand which one
> hotter, with more guest/host instructions...
> and examine their guest, host and IR code.
>
> The goal of this command is to allow the dynamic exploration
> of TCG behavior and code quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
>
> Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tb-stats.c         | 275 +++++++++++++++++++++++++++++++++++
>  hmp-commands-info.hx         |  23 +++
>  include/exec/tb-stats.h      |  37 +++++
>  include/qemu/log-for-trace.h |   2 +
>  include/qemu/log.h           |   1 +
>  linux-user/exit.c            |   4 +
>  monitor/misc.c               |  71 +++++++++
>  util/log.c                   |  26 +++-
>  8 files changed, 431 insertions(+), 8 deletions(-)
>
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 6c330e1b02..85a16cd563 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -212,3 +212,278 @@ void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_=
data icmd)
>      g_free(cmdinfo);
>  }
>=20=20
> +static void collect_tb_stats(void *p, uint32_t hash, void *userp)
> +{
> +    last_search =3D g_list_prepend(last_search, p);
> +}
> +
> +static void dump_tb_header(TBStatistics *tbs)
> +{
> +    unsigned g =3D tbs->translations.total ?
> +        tbs->code.num_guest_inst / tbs->translations.total : 0;
> +    unsigned ops =3D tbs->translations.total ?
> +        tbs->code.num_tcg_ops / tbs->translations.total : 0;
> +    unsigned ops_opt =3D tbs->translations.total ?
> +        tbs->code.num_tcg_ops_opt / tbs->translations.total : 0;
> +    unsigned h =3D tbs->translations.total ?
> +        tbs->code.num_host_inst / tbs->translations.total : 0;
> +    unsigned spills =3D tbs->translations.total ?
> +        tbs->code.spills / tbs->translations.total : 0;

A helper like:

  #define stat_per_translation(stat, name) \
      stat->translations.total ? stat->name / stat->translations.total : 0

could be helpful here (and useful for later re-use).

> +
> +    float guest_host_prop =3D g ? ((float) h / g) : 0;
> +
> +    qemu_log("TB%d: phys:0x"TB_PAGE_ADDR_FMT" virt:0x"TARGET_FMT_lx
> +             " flags:%#08x (trans:%lu uncached:%lu exec:%lu ints: g:%u o=
p:%u op_opt:%u h:%u h/g:%.2f spills:%d)\n",
> +             tbs->display_id,
> +             tbs->phys_pc, tbs->pc, tbs->flags,
> +             tbs->translations.total, tbs->translations.uncached,
> +             tbs->executions.total, g, ops, ops_opt, h, guest_host_prop,
> +             spills);
> +}
> +
> +static gint
> +inverse_sort_tbs(gconstpointer p1, gconstpointer p2, gpointer psort_by)
> +{
> +    const TBStatistics *tbs1 =3D (TBStatistics *) p1;
> +    const TBStatistics *tbs2 =3D (TBStatistics *) p2;
> +    int sort_by =3D *((int *) psort_by);
> +    unsigned long c1 =3D 0;
> +    unsigned long c2 =3D 0;

Like here. As we aggregate our spill and instruction stats by the number
of translations on display we will want the same for the sort. Otherwise
heavily translated blocks will distort the figures.

> +
> +    if (likely(sort_by =3D=3D SORT_BY_SPILLS)) {
> +        c1 =3D tbs1->code.spills;
> +        c2 =3D tbs2->code.spills;
> +    } else if (likely(sort_by =3D=3D SORT_BY_HOTNESS)) {
> +        c1 =3D tbs1->executions.total;
> +        c2 =3D tbs2->executions.total;
> +    } else if (likely(sort_by =3D=3D SORT_BY_HG)) {
> +        if (tbs1->code.num_guest_inst =3D=3D 0) {
> +            return -1;
> +        }
> +        if (tbs2->code.num_guest_inst =3D=3D 0) {
> +            return 1;
> +        }
> +
> +        float a =3D (float) tbs1->code.num_host_inst / tbs1->code.num_gu=
est_inst;
> +        float b =3D (float) tbs2->code.num_host_inst / tbs2->code.num_gu=
est_inst;
> +        c1 =3D a <=3D b ? 0 : 1;
> +        c2 =3D a <=3D b ? 1 : 0;
> +    }
> +
> +    return c1 < c2 ? 1 : c1 =3D=3D c2 ? 0 : -1;
> +}
> +
> +static void do_dump_coverset_info(int percentage)
> +{
> +    uint64_t total_exec_count =3D 0;
> +    uint64_t covered_exec_count =3D 0;
> +    unsigned coverset_size =3D 0;
> +    int id =3D 1;
> +    GList *i;
> +
> +    g_list_free(last_search);
> +    last_search =3D NULL;
> +
> +    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
> +
> +    int sort_by =3D SORT_BY_HOTNESS;
> +    last_search =3D g_list_sort_with_data(last_search, inverse_sort_tbs,=
 &sort_by);
> +
> +    if (!last_search) {
> +        qemu_log("No data collected yet\n");
> +        return;
> +    }
> +
> +    /* Compute total execution count for all tbs */
> +    for (i =3D last_search; i; i =3D i->next) {
> +        TBStatistics *tbs =3D (TBStatistics *) i->data;
> +        total_exec_count +=3D tbs->executions.total * tbs->code.num_gues=
t_inst;
> +    }
> +
> +    for (i =3D last_search; i; i =3D i->next) {
> +        TBStatistics *tbs =3D (TBStatistics *) i->data;
> +        covered_exec_count +=3D tbs->executions.total * tbs->code.num_gu=
est_inst;
> +        tbs->display_id =3D id++;
> +        coverset_size++;
> +        dump_tb_header(tbs);
> +
> +        /* Iterate and display tbs until reach the percentage count cove=
r */
> +        if (((double) covered_exec_count / total_exec_count) >
> +                ((double) percentage / 100)) {

I'd hoist at least the target percentage calculation to the start of the
function. In fact you can calculate what your target covered exec count
is as an integer once you have computed the total above and avoid doing
an expensive float operation each iteration.

> +            break;
> +        }
> +    }
> +
> +    qemu_log("\n------------------------------\n");
> +    qemu_log("# of TBs to reach %d%% of the total of guest insts exec: %=
u\t",
> +                percentage, coverset_size);
> +    qemu_log("Total of guest insts exec: %lu\n", total_exec_count);
> +    qemu_log("\n------------------------------\n");
> +
> +    /* free the unused bits */
> +    if (i) {
> +        if (i->next) {
> +            i->next->prev =3D NULL;
> +        }
> +        g_list_free(i->next);
> +        i->next =3D NULL;
> +    }
> +}
> +
> +static void do_dump_tbs_info(int count, int sort_by)
> +{
> +    int id =3D 1;
> +    GList *i;
> +
> +    g_list_free(last_search);
> +    last_search =3D NULL;
> +
> +    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
> +
> +    last_search =3D g_list_sort_with_data(last_search, inverse_sort_tbs,
> +                                        &sort_by);
> +
> +    if (!last_search) {
> +        qemu_printf("No data collected yet!\n");
> +        return;
> +    }
> +
> +    for (i =3D last_search; i && count--; i =3D i->next) {
> +        TBStatistics *tbs =3D (TBStatistics *) i->data;
> +        tbs->display_id =3D id++;
> +        dump_tb_header(tbs);
> +    }
> +
> +    /* free the unused bits */
> +    if (i) {
> +        if (i->next) {
> +            i->next->prev =3D NULL;
> +        }
> +        g_list_free(i->next);
> +        i->next =3D NULL;
> +    }
> +}
> +
> +static void
> +do_dump_coverset_info_safe(CPUState *cpu, run_on_cpu_data percentage)
> +{
> +    qemu_log_to_monitor(true);
> +    do_dump_coverset_info(percentage.host_int);
> +    qemu_log_to_monitor(false);
> +}
> +
> +struct tbs_dump_info {
> +    int count;
> +    int sort_by;
> +};
> +
> +static void do_dump_tbs_info_safe(CPUState *cpu, run_on_cpu_data tbdi)
> +{
> +    struct tbs_dump_info *info =3D tbdi.host_ptr;
> +    qemu_log_to_monitor(true);
> +    do_dump_tbs_info(info->count, info->sort_by);
> +    qemu_log_to_monitor(false);
> +    g_free(info);
> +}
> +
> +/*
> + * When we dump_tbs_info on a live system via the HMP we want to
> + * ensure the system is quiessent before we start outputting stuff.
> + * Otherwise we could pollute the output with other logging output.
> + */
> +void dump_coverset_info(int percentage, bool use_monitor)
> +{
> +    if (use_monitor) {
> +        async_safe_run_on_cpu(first_cpu, do_dump_coverset_info_safe,
> +                              RUN_ON_CPU_HOST_INT(percentage));
> +    } else {
> +        do_dump_coverset_info(percentage);
> +    }
> +}
> +
> +void dump_tbs_info(int count, int sort_by, bool use_monitor)
> +{
> +    if (use_monitor) {
> +        struct tbs_dump_info *tbdi =3D g_new(struct tbs_dump_info, 1);
> +        tbdi->count =3D count;
> +        tbdi->sort_by =3D sort_by;
> +        async_safe_run_on_cpu(first_cpu, do_dump_tbs_info_safe,
> +                              RUN_ON_CPU_HOST_PTR(tbdi));
> +    } else {
> +        do_dump_tbs_info(count, sort_by);
> +    }
> +}
> +
> +static void do_tb_dump_with_statistics(TBStatistics *tbs, int log_flags)
> +{
> +    CPUState *cpu =3D current_cpu;
> +    uint32_t cflags =3D curr_cflags() | CF_NOCACHE;
> +    int old_log_flags =3D qemu_loglevel;
> +    TranslationBlock *tb =3D NULL;
> +
> +    qemu_set_log(log_flags);
> +
> +    qemu_log("\n------------------------------\n");
> +    dump_tb_header(tbs);
> +
> +    if (sigsetjmp(cpu->jmp_env, 0) =3D=3D 0) {
> +        mmap_lock();
> +        tb =3D tb_gen_code(cpu, tbs->pc, tbs->cs_base, tbs->flags, cflag=
s);
> +        tb_phys_invalidate(tb, -1);
> +        mmap_unlock();
> +    } else {
> +        /*
> +         * The mmap_lock is dropped by tb_gen_code if it runs out of
> +         * memory.
> +         */
> +        fprintf(stderr, "%s: dbg failed!\n", __func__);
> +        assert_no_pages_locked();
> +    }
> +
> +    qemu_set_log(old_log_flags);
> +
> +    tcg_tb_remove(tb);
> +}
> +
> +struct tb_dump_info {
> +    int id;
> +    int log_flags;
> +    bool use_monitor;
> +};
> +
> +static void do_dump_tb_info_safe(CPUState *cpu, run_on_cpu_data info)
> +{
> +    struct tb_dump_info *tbdi =3D (struct tb_dump_info *) info.host_ptr;
> +    GList *iter;
> +
> +    if (!last_search) {
> +        qemu_printf("no search on record");
> +        return;
> +    }
> +    qemu_log_to_monitor(tbdi->use_monitor);
> +
> +    for (iter =3D last_search; iter; iter =3D g_list_next(iter)) {
> +        TBStatistics *tbs =3D iter->data;
> +        if (tbs->display_id =3D=3D tbdi->id) {
> +            do_tb_dump_with_statistics(tbs, tbdi->log_flags);
> +            break;
> +        }
> +    }
> +    qemu_log_to_monitor(false);
> +    g_free(tbdi);
> +}
> +
> +void dump_tb_info(int id, int log_mask, bool use_monitor)
> +{
> +    struct tb_dump_info *tbdi =3D g_new(struct tb_dump_info, 1);
> +
> +    tbdi->id =3D id;
> +    tbdi->log_flags =3D log_mask;
> +    tbdi->use_monitor =3D use_monitor;
> +
> +    async_safe_run_on_cpu(first_cpu, do_dump_tb_info_safe,
> +                          RUN_ON_CPU_HOST_PTR(tbdi));
> +
> +    /* tbdi free'd by do_dump_tb_info_safe */
> +}
> +
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59444c461..761c76619b 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -289,6 +289,29 @@ ETEXI
>          .help       =3D "show dynamic compiler info",
>          .cmd        =3D hmp_info_jit,
>      },
> +    {
> +        .name       =3D "tbs",
> +        .args_type  =3D "number:i?,sortedby:s?",
> +        .params     =3D "[number sortedby]",
> +        .help       =3D "show a [number] translated blocks sorted by [so=
rtedby]"
> +                      "sortedby opts: hotness hg",
> +        .cmd        =3D hmp_info_tbs,
> +    },
> +    {
> +        .name       =3D "tb",
> +        .args_type  =3D "id:i,flags:s?",
> +        .params     =3D "id [log1[,...] flags]",
> +        .help       =3D "show information about one translated block by =
id",
> +        .cmd        =3D hmp_info_tb,
> +    },
> +    {
> +        .name       =3D "coverset",
> +        .args_type  =3D "number:i?",
> +        .params     =3D "[number]",
> +        .help       =3D "show hottest translated blocks neccesary to cov=
er"
> +                      "[number]% of the execution count",
> +        .cmd        =3D hmp_info_coverset,
> +    },
>  #endif
>=20=20
>  STEXI
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index d1debd3262..e2ab1068c3 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -57,6 +57,9 @@ struct TBStatistics {
>          unsigned long uncached;
>          unsigned long spanning;
>      } translations;
> +
> +    /* HMP information - used for referring to previous search */
> +    int display_id;
>  };
>=20=20
>  bool tb_stats_cmp(const void *ap, const void *bp);
> @@ -73,4 +76,38 @@ struct TbstatsCommand {
>=20=20
>  void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
>=20=20
> +/**
> + * dump_coverset_info: report the hottest blocks to cover n% of execution
> + *
> + * @percentage: cover set percentage
> + * @use_monitor: redirect output to monitor
> + *
> + * Report the hottest blocks to either the log or monitor
> + */
> +void dump_coverset_info(int percentage, bool use_monitor);
> +
> +
> +/**
> + * dump_tbs_info: report the hottest blocks
> + *
> + * @count: the limit of hotblocks
> + * @sort_by: property in which the dump will be sorted
> + * @use_monitor: redirect output to monitor
> + *
> + * Report the hottest blocks to either the log or monitor
> + */
> +void dump_tbs_info(int count, int sort_by, bool use_monitor);
> +
> +/**
> + * dump_tb_info: dump information about one TB
> + *
> + * @id: the display id of the block (from previous search)
> + * @mask: the temporary logging mask
> + * @Use_monitor: redirect output to monitor
> + *
> + * Re-run a translation of a block at addr for the purposes of debug out=
put
> + */
> +void dump_tb_info(int id, int log_mask, bool use_monitor);
> +
> +
>  #endif
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index 2f0a5b080e..d65eb83037 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -21,6 +21,8 @@
>  /* Private global variable, don't use */
>  extern int qemu_loglevel;
>=20=20
> +extern int32_t max_num_hot_tbs_to_dump;
> +
>  #define LOG_TRACE          (1 << 15)
>=20=20
>  /* Returns true if a bit is set in the current loglevel mask */
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index 47071d72c7..27ba267faa 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -114,6 +114,7 @@ typedef struct QEMULogItem {
>  extern const QEMULogItem qemu_log_items[];
>=20=20
>  void qemu_set_log(int log_flags);
> +void qemu_log_to_monitor(bool enable);
>  void qemu_log_needs_buffers(void);
>  void qemu_set_log_filename(const char *filename, Error **errp);
>  void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index bdda720553..7226104959 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -28,6 +28,10 @@ extern void __gcov_dump(void);
>=20=20
>  void preexit_cleanup(CPUArchState *env, int code)
>  {
> +    if (tb_stats_collection_enabled()) {
> +        dump_tbs_info(max_num_hot_tbs_to_dump, SORT_BY_HOTNESS, false);
> +    }
> +
>  #ifdef TARGET_GPROF
>          _mcleanup();
>  #endif
> diff --git a/monitor/misc.c b/monitor/misc.c
> index aea9b0db4f..78ada8aa0e 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -499,6 +499,77 @@ static void hmp_tbstats(Monitor *mon, const QDict *q=
dict)
>=20=20
>  }
>=20=20
> +static void hmp_info_tbs(Monitor *mon, const QDict *qdict)
> +{
> +    int n;
> +    const char *s =3D NULL;
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +    if (!tb_ctx.tb_stats.map) {
> +        error_report("no TB information recorded");
> +        return;
> +    }
> +
> +    n =3D qdict_get_try_int(qdict, "number", 10);
> +    s =3D qdict_get_try_str(qdict, "sortedby");
> +
> +    int sortedby =3D 0;
> +    if (s =3D=3D NULL || strcmp(s, "hotness") =3D=3D 0) {
> +        sortedby =3D SORT_BY_HOTNESS;
> +    } else if (strcmp(s, "hg") =3D=3D 0) {
> +        sortedby =3D SORT_BY_HG;
> +    } else if (strcmp(s, "spills") =3D=3D 0) {
> +        sortedby =3D SORT_BY_SPILLS;
> +    }
> +
> +    dump_tbs_info(n, sortedby, true);
> +}
> +
> +static void hmp_info_tb(Monitor *mon, const QDict *qdict)
> +{
> +    const int id =3D qdict_get_int(qdict, "id");
> +    const char *flags =3D qdict_get_try_str(qdict, "flags");
> +    int mask;
> +
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +
> +    mask =3D flags ? qemu_str_to_log_mask(flags) : CPU_LOG_TB_IN_ASM;
> +
> +    if (!mask) {
> +        help_cmd(mon, "log");
> +        return;
> +    }
> +
> +    dump_tb_info(id, mask, true);
> +}
> +
> +static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
> +{
> +    int n;
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +    if (!tb_stats_collection_enabled()) {
> +        error_report("TB information not being recorded");
> +        return;
> +    }
> +
> +    n =3D qdict_get_try_int(qdict, "number", 90);
> +
> +    if (n < 0 || n > 100) {
> +        error_report("Coverset percentage should be between 0 and 100");
> +        return;
> +    }
> +
> +    dump_coverset_info(n, true);
> +}
> +
>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>  {
>      if (!tcg_enabled()) {
> diff --git a/util/log.c b/util/log.c
> index 8109d19afb..7bfcbe3703 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -19,6 +19,7 @@
>=20=20
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/qemu-print.h"
>  #include "qemu/range.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -31,25 +32,34 @@ int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
>  int32_t max_num_hot_tbs_to_dump;
> +static bool to_monitor;
>=20=20
>  /* Return the number of characters emitted.  */
>  int qemu_log(const char *fmt, ...)
>  {
>      int ret =3D 0;
> -    if (qemu_logfile) {
> -        va_list ap;
> -        va_start(ap, fmt);
> +    va_list ap;
> +    va_start(ap, fmt);
> +
> +    if (to_monitor) {
> +        ret =3D qemu_vprintf(fmt, ap);
> +    } else if (qemu_logfile) {
>          ret =3D vfprintf(qemu_logfile, fmt, ap);
> -        va_end(ap);
> +    }
> +    va_end(ap);
>=20=20
> -        /* Don't pass back error results.  */
> -        if (ret < 0) {
> -            ret =3D 0;
> -        }
> +    /* Don't pass back error results.  */
> +    if (ret < 0) {
> +        ret =3D 0;
>      }
>      return ret;
>  }
>=20=20
> +void qemu_log_to_monitor(bool enable)
> +{
> +    to_monitor =3D enable;
> +}
> +

This tweaking to qemu_log should be in a separate patch.

>  static bool log_uses_own_buffers;
>=20=20
>  /* enable or disable low levels log */


--=20
Alex Benn=C3=A9e

