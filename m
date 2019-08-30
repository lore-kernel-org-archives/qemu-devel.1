Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98414C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A032087F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAYwQt4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A032087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3k3a-0000nX-Cx
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 12:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3jaq-0003f4-JH
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3jah-00072P-Np
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:17:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3jag-0006od-Iq
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:17:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id c3so7551700wrd.7
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FVaGIoMyX535qfdIMdWGiY5Yqp/8GbLdZOfJ00Vpzt4=;
 b=NAYwQt4JX32vYK+Bce5sxM6GuvwNjJ58vM5WkaowxOKeoT89e0+SxrFKNuIQplOkCc
 egR1CsVX9yU4WKbG5x0wYlzsRhhND1+zJuUNaWk1BT/IH9bG/kPGURZQHcB4pRABeZ6r
 Qs4wG9jATn4hCUIFGubTDEELrNzsplBdg45lTORZGv1y+BGjx8nbvapxFl7Ee4TFFeLt
 ArAieSpijA42CQxWbiBwSld3S/endJzwO5vwg7Cid8HXBitZVoi5s9HGk1NPFcD8+jcw
 lgngciHL+fmIOiYXie9JKIR89wyf+hsVJ97WNPccRxbqqwNtqg8OwyHwqwZvYFu4MOm/
 6Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FVaGIoMyX535qfdIMdWGiY5Yqp/8GbLdZOfJ00Vpzt4=;
 b=CERhQHA2OudsfmJS9RvSs7xxHEjLhEe2UG1pzReW7O9qiFaHL2xMuV2971sEZAPER9
 DcHKra0hEYwvZSAChfm9igsMn/WvKR9fwh6F3DOEOLcYIUj/E3EYkO7LQlmu6xj0xtZe
 dirU3zMMXgCbj7taPi0gut76siDQZjXZU794SPofJ/QNl9Jlv/PI88b5NSirL6QOzlS2
 j2RqA+wliyIicwLjzhwvbJHuA8OnVXg0GduhK7YIjZt34ZS8p9tTj2TeT9LwxbdD4mjG
 pIwQe2kS+uZZncwkYbESvDjClJtw/L4oTmH2xoD0lJS3BdOTmSstQANfIepHbWd8wofH
 FN2A==
X-Gm-Message-State: APjAAAXejuf1EsvaBcBBF/U/nUKuk/iGxzWpPjGhmD5UtJwK1IO9NuJL
 7x7G94lZjEjhvPkKvSzurh+2Vw==
X-Google-Smtp-Source: APXvYqz/PwQcRvDIcMF9xBYzTgV2G3L6Z1amS6YqOXLVg0v0qHZE55TRDrre0lg5by+ToL12MbeyjQ==
X-Received: by 2002:adf:a4c7:: with SMTP id h7mr5426392wrb.137.1567181851638; 
 Fri, 30 Aug 2019 09:17:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a7sm11411393wra.43.2019.08.30.09.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 09:17:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DA0A21FF87;
 Fri, 30 Aug 2019 17:17:29 +0100 (BST)
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-10-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190829173437.5926-10-vandersonmr2@gmail.com>
Date: Fri, 30 Aug 2019 17:17:29 +0100
Message-ID: <87sgpi7hly.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v8 09/11] Adding info [tb-list|tb|coverset]
 commands to HMP.
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> These commands allow the exploration of TBs
> generated by the TCG. Understand which one
> hotter, with more guest/host instructions...
> and examine their guest, host and IR code.
>
> The goal of this command is to allow the dynamic exploration
> of TCG behavior and code quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
>
> Example of output:
>
> TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
> 	| exec:4828932/0 guest inst cov:16.38%
> 	| trans:1 ints: g:3 op:82 op_opt:34 spills:3
> 	| h/g (host bytes / guest insts): 90.666664
> 	| time to gen at 2.4GHz =3D> code:3150.83(ns) IR:712.08(ns)
> 	| targets: 0x0000000000034d5e (id:11), 0x0000000000034d0d (id:2)
>
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:4825842/0 guest inst cov:21.82%
> 	| trans:1 ints: g:4 op:80 op_opt:38 spills:2
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz =3D> code:3362.92(ns) IR:793.75(ns)
> 	| targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)
>
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:6956495/0  guest inst cov:21.82%
> 	| trans:2 ints: g:2 op:40 op_opt:19 spills:1
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz =3D> code:3130.83(ns) IR:722.50(ns)
> 	| targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)
>
> ----------------
> IN:
> 0x00034d0d:  89 de                    movl     %ebx, %esi
> 0x00034d0f:  26 8b 0e                 movl     %es:(%esi), %ecx
> 0x00034d12:  26 f6 46 08 80           testb    $0x80, %es:8(%esi)
> 0x00034d17:  75 3b                    jne      0x34d54
>
> ------------------------------
>
> TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
> 	| exec:5202686/0 guest inst cov:11.28%
> 	| trans:1 ints: g:3 op:82 op_opt:34 spills:3
> 	| h/g (host bytes / guest insts): 90.666664
> 	| time to gen at 2.4GHz =3D> code:2793.75(ns) IR:614.58(ns)
> 	| targets: 0x0000000000034d5e (id:3), 0x0000000000034d0d (id:2)
>
> TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
> 	| exec:5199468/0 guest inst cov:15.03%
> 	| trans:1 ints: g:4 op:80 op_opt:38 spills:2
> 	| h/g (host bytes / guest insts): 84.000000
> 	| time to gen at 2.4GHz =3D> code:2958.75(ns) IR:719.58(ns)
> 	| targets: 0x0000000000034d19 (id:4), 0x0000000000034d54 (id:1)
>
> ------------------------------
> 2 TBs to reach 25% of guest inst exec coverage
> Total of guest insts exec: 138346727
>
> ------------------------------
>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tb-stats.c         | 421 ++++++++++++++++++++++++++++++++++-
>  accel/tcg/translate-all.c    |   2 +-
>  disas.c                      |  31 ++-
>  hmp-commands-info.hx         |  24 ++
>  include/exec/tb-stats.h      |  45 +++-
>  include/qemu/log-for-trace.h |   4 +
>  include/qemu/log.h           |   2 +
>  monitor/misc.c               |  74 ++++++
>  util/log.c                   |  52 ++++-
>  9 files changed, 634 insertions(+), 21 deletions(-)
>
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 9959477fbb..d588c551c9 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -34,9 +34,35 @@
>
>  /* only accessed in safe work */
>  static GList *last_search;
> -
> +int id =3D 1; /* display_id increment counter */
>  uint64_t dev_time;
>
> +static TBStatistics *get_tbstats_by_id(int id)
> +{
> +    GList *iter;
> +
> +    for (iter =3D last_search; iter; iter =3D g_list_next(iter)) {
> +        TBStatistics *tbs =3D iter->data;
> +        if (tbs && tbs->display_id =3D=3D id) {
> +            return tbs;
> +            break;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static TBStatistics *get_tbstats_by_addr(target_ulong pc)
> +{
> +    GList *iter;
> +    for (iter =3D last_search; iter; iter =3D g_list_next(iter)) {
> +        TBStatistics *tbs =3D iter->data;
> +        if (tbs && tbs->pc =3D=3D pc) {
> +            return tbs;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  struct jit_profile_info {
>      uint64_t translations;
>      uint64_t aborted;
> @@ -175,6 +201,7 @@ static void clean_tbstats(void)
>      qht_destroy(&tb_ctx.tb_stats);
>  }
>
> +
>  void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
>  {
>      struct TbstatsCommand *cmdinfo =3D icmd.host_ptr;
> @@ -261,6 +288,398 @@ void init_tb_stats_htable_if_not(void)
>      }
>  }
>
> +static void collect_tb_stats(void *p, uint32_t hash, void *userp)
> +{
> +    last_search =3D g_list_prepend(last_search, p);
> +}
> +
> +static void dump_tb_targets(TBStatistics *tbs)
> +{
> +    if (tbs && tbs->tb) {
> +        TBStatistics *valid_target_tbstats[2] =3D {NULL, NULL};
> +
> +        /*
> +         * Check and ensure that targets' tbstats have a valid display_i=
d and
> +         * are in last_search list
> +         */
> +        for (int jmp_id =3D 0; jmp_id < 2; jmp_id++) {
> +            qemu_spin_lock(&tbs->tb->jmp_lock);
> +            TranslationBlock *tb_dst =3D
> +                (TranslationBlock *)
> (atomic_read(&tbs->tb->jmp_dest[jmp_id]) & ~1);

Ahh I see. But I don't think this can be right because tbs->tb will
point to the last translated TB which may not be the hottest. It could
even been a shortened TB during some sort of IO transaction.

But more fundamentally we are going to miss a bunch of the transitions.
Any block that ends in a computed jump will not be linked here. Any
block that transitions across a page boundary won't get linked (they may
end up using tcg_gen_lookup_and_goto_ptr). It's true these won't be
blocks we might be able to join together in a future code optimisation
but it's missing the full picture.

So rather than trying to reverse infer from the partial data I think we
need to capture the destinations within the tb_stats mechanism itself.
Either by growing a list/array of TranslationBlocks (or possibly
TBStatistics) that any given TBStatistics entry may end up in. We may
also have to keep a tally of the hits of each destination as well. I
think that means hooking into:

  tcg_gen_exit_tb
  tcg_gen_goto_tb
  tcg_gen_lookup_and_goto_ptr

(c.f. CPU_LOG_TB_NOCHAIN which prevents chaining and causes a return to
the outer loop after every block).

> +            qemu_spin_unlock(&tbs->tb->jmp_lock);
> +
> +            if (tb_dst) {
> +                target_ulong pc =3D tb_dst ? tb_dst->pc : 0;
> +
> +                /* Check if tb_dst is on the last_search list */
> +                TBStatistics *tbstats_pc =3D get_tbstats_by_addr(pc);
> +
> +                /* if not in the last_search list, then insert it */
> +                if (!tbstats_pc) {
> +                    last_search =3D g_list_append(last_search, tb_dst->t=
b_stats);
> +                }
> +
> +                /* if the tb_stats does not have a valid display_id, the=
n set one. */
> +                if (tb_dst->tb_stats && tb_dst->tb_stats->display_id =3D=
=3D 0) {
> +                    tb_dst->tb_stats->display_id =3D id++;
> +                    valid_target_tbstats[jmp_id] =3D tb_dst->tb_stats;
> +                }
> +            }
> +        }
> +
> +        if (valid_target_tbstats[0] && !valid_target_tbstats[1]) {
> +            qemu_log("\t| targets: 0x"TARGET_FMT_lx" (id:%d)\n",
> +                    valid_target_tbstats[0]->pc, valid_target_tbstats[0]=
->display_id);
> +        } else if (!valid_target_tbstats[0] && valid_target_tbstats[1]) {
> +            qemu_log("\t| targets: 0x"TARGET_FMT_lx" (id:%d)\n",
> +                    valid_target_tbstats[1]->pc, valid_target_tbstats[1]=
->display_id);
> +        } else if (valid_target_tbstats[0] && valid_target_tbstats[1]) {
> +            qemu_log("\t| targets: 0x"TARGET_FMT_lx" (id:%d), "
> +                     "0x"TARGET_FMT_lx" (id:%d)\n",
> +                    valid_target_tbstats[0]->pc, valid_target_tbstats[0]=
->display_id,
> +                    valid_target_tbstats[1]->pc, valid_target_tbstats[1]=
->display_id);
> +        } else {
> +            qemu_log("\t| targets: no direct target\n");
> +        }
> +    }
> +}
> +
> +static void dump_tb_header(TBStatistics *tbs)
> +{
> +    unsigned g =3D stat_per_translation(tbs, code.num_guest_inst);
> +    unsigned ops =3D stat_per_translation(tbs, code.num_tcg_ops);
> +    unsigned ops_opt =3D stat_per_translation(tbs, code.num_tcg_ops_opt);
> +    unsigned spills =3D stat_per_translation(tbs, code.spills);
> +    unsigned h =3D stat_per_translation(tbs, code.out_len);
> +
> +    float guest_host_prop =3D g ? ((float) h / g) : 0;
> +
> +    qemu_log("TB id:%d | phys:0x"TB_PAGE_ADDR_FMT" virt:0x"TARGET_FMT_lx
> +             " flags:%#08x\n", tbs->display_id, tbs->phys_pc, tbs->pc, t=
bs->flags);
> +
> +    if (tbs_stats_enabled(tbs, TB_EXEC_STATS)) {
> +        qemu_log("\t| exec:%lu/%lu guest inst cov:%.2f%%\n", tbs->execut=
ions.normal,
> +                tbs->executions.atomic, tbs->executions.coverage / 100.0=
f);
> +    }
> +
> +    if (tbs_stats_enabled(tbs, TB_JIT_STATS)) {
> +        qemu_log("\t| trans:%lu ints: g:%u op:%u op_opt:%u spills:%d"
> +             "\n\t| h/g (host bytes / guest insts): %f\n",
> +             tbs->translations.total, g, ops, ops_opt, spills, guest_hos=
t_prop);
> +    }
> +
> +    if (tbs_stats_enabled(tbs, TB_JIT_TIME)) {
> +        qemu_log("\t| time to gen at 2.4GHz =3D> code:%0.2lf(ns) IR:%0.2=
lf(ns)\n",
> +             tbs->time.code / 2.4, tbs->time.interm / 2.4);
> +    }
> +
> +    dump_tb_targets(tbs);
> +    qemu_log("\n");
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
> +
> +    if (likely(sort_by =3D=3D SORT_BY_SPILLS)) {
> +        c1 =3D stat_per_translation(tbs1, code.spills);
> +        c2 =3D stat_per_translation(tbs2, code.spills);
> +    } else if (likely(sort_by =3D=3D SORT_BY_HOTNESS)) {
> +        c1 =3D stat_per_translation(tbs1, executions.normal);
> +        c2 =3D stat_per_translation(tbs2, executions.normal);
> +    } else if (likely(sort_by =3D=3D SORT_BY_HG)) {
> +        if (tbs1->code.num_guest_inst =3D=3D 0) {
> +            return -1;
> +        }
> +        if (tbs2->code.num_guest_inst =3D=3D 0) {
> +            return 1;
> +        }
> +
> +        float a =3D
> +            (float) stat_per_translation(tbs1, code.out_len) / tbs1->cod=
e.num_guest_inst;
> +        float b =3D
> +            (float) stat_per_translation(tbs2, code.out_len) / tbs2->cod=
e.num_guest_inst;
> +        c1 =3D a <=3D b ? 0 : 1;
> +        c2 =3D a <=3D b ? 1 : 0;
> +    }
> +
> +    return c1 < c2 ? 1 : c1 =3D=3D c2 ? 0 : -1;
> +}
> +
> +static void dump_last_search_headers(int count)
> +{
> +    if (!last_search) {
> +        qemu_log("No data collected yet\n");
> +        return;
> +    }
> +
> +    GList *l =3D last_search;
> +    while (l !=3D NULL && count--) {
> +        TBStatistics *tbs =3D (TBStatistics *) l->data;
> +        GList *next =3D l->next;
> +        dump_tb_header(tbs);
> +        l =3D next;
> +    }
> +}
> +
> +static uint64_t calculate_last_search_coverages(void)
> +{
> +    uint64_t total_exec_count =3D 0;
> +    GList *i;
> +
> +    /* Compute total execution count for all tbs */
> +    for (i =3D last_search; i; i =3D i->next) {
> +        TBStatistics *tbs =3D (TBStatistics *) i->data;
> +        total_exec_count +=3D
> +            (tbs->executions.atomic + tbs->executions.normal) * tbs->cod=
e.num_guest_inst;
> +    }
> +
> +    for (i =3D last_search; i; i =3D i->next) {
> +        TBStatistics *tbs =3D (TBStatistics *) i->data;
> +        uint64_t tb_total_execs =3D
> +            (tbs->executions.atomic + tbs->executions.normal) * tbs->cod=
e.num_guest_inst;
> +        tbs->executions.coverage =3D (10000 * tb_total_execs) / (total_e=
xec_count + 1);
> +    }
> +
> +    return total_exec_count;
> +}
> +
> +static void do_dump_coverset_info(int percentage)
> +{
> +    mmap_lock();
> +    uint16_t total_coverage =3D 0;
> +    unsigned coverset_size =3D 0;
> +    percentage *=3D 100;
> +    id =3D 1;
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
> +    uint64_t total_exec_count =3D calculate_last_search_coverages();
> +
> +    /* Iterate and tbs display_id until reach the coverage percentage
> count */

I think we need to finese this a bit. I ran info coverset without any
params having booted a kernel and my HMP hasn't returned yet, it's
currently on TB id 169000!

Certainly for an interactive user they would have glazed over by now...

> +    for (i =3D last_search; i && total_coverage < percentage; i =3D i->n=
ext) {
> +        TBStatistics *tbs =3D (TBStatistics *) i->data;
> +        tbs->display_id =3D id++;
> +        coverset_size++;
> +        total_coverage +=3D tbs->executions.coverage;
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
> +
> +    dump_last_search_headers(coverset_size);
> +    mmap_unlock();
> +
> +    qemu_log("------------------------------\n");
> +    qemu_log("%u TBs to reach %d%% of guest inst exec coverage\n",
> +                coverset_size, percentage / 100);
> +    qemu_log("Total of guest insts exec: %lu", total_exec_count);
> +    qemu_log("\n------------------------------\n");
> +}
> +
> +static void do_dump_tbs_info(int total, int sort_by)
> +{
> +    id =3D 1;
> +    GList *i;
> +    int count =3D total;
> +
> +    g_list_free(last_search);
> +    last_search =3D NULL;
> +
> +    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
> +
> +    last_search =3D g_list_sort_with_data(last_search, inverse_sort_tbs,=
 &sort_by);
> +
> +    if (!last_search) {
> +        qemu_printf("No data collected yet!\n");
> +        return;
> +    }
> +
> +    calculate_last_search_coverages();
> +
> +    for (i =3D last_search; i && count--; i =3D i->next) {
> +        TBStatistics *tbs =3D (TBStatistics *) i->data;
> +        tbs->display_id =3D id++;
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
> +
> +    dump_last_search_headers(total);
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
> +static GString *get_code_string(TBStatistics *tbs, int log_flags)
> +{
> +    int old_log_flags =3D qemu_loglevel;
> +
> +    CPUState *cpu =3D first_cpu;
> +    uint32_t cflags =3D curr_cflags() | CF_NOCACHE;
> +    TranslationBlock *tb =3D NULL;
> +
> +    GString *code_s =3D g_string_new(NULL);
> +    qemu_log_to_string(true, code_s);
> +
> +    qemu_set_log(log_flags);
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
> +        qemu_log("\ncould not gen code for this TB\n");
> +        assert_no_pages_locked();
> +    }
> +
> +    qemu_set_log(old_log_flags);
> +    qemu_log_to_string(false, NULL);
> +
> +    if (tb) {
> +        tcg_tb_remove(tb);
> +    }
> +
> +    return code_s;
> +}
> +
> +static void do_tb_dump_with_statistics(TBStatistics *tbs, int log_flags)
> +{
> +    qemu_log("\n------------------------------\n\n");
> +    dump_tb_header(tbs);
> +
> +    GString *code_s =3D get_code_string(tbs, log_flags);
> +    qemu_log("%s", code_s->str);
> +    g_string_free(code_s, true);
> +    qemu_log("------------------------------\n");
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
> +
> +    if (!last_search) {
> +        qemu_log("no search on record\n");
> +        return;
> +    }
> +
> +    qemu_log_to_monitor(tbdi->use_monitor);
> +
> +    TBStatistics *tbs =3D get_tbstats_by_id(tbdi->id);
> +    if (tbs) {
> +        do_tb_dump_with_statistics(tbs, tbdi->log_flags);
> +    } else {
> +        qemu_log("no TB statitics found with id %d\n", tbdi->id);
> +    }
> +
> +    qemu_log_to_monitor(false);
> +
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
> +
>  void enable_collect_tb_stats(void)
>  {
>      init_tb_stats_htable_if_not();
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a2e65bb85c..fa163440dc 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1778,7 +1778,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       * generation so we can count interesting things about this
>       * generation.
>       */
> -    if (tb_stats_collection_enabled()) {
> +    if (tb_stats_collection_enabled() && !(tb->cflags & CF_NOCACHE))
> {

It feels like this should be part of an earlier patch. It's not like
we've suddenly decided not to count uncached runs?

>          tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags, tb);
>          uint32_t flag =3D get_default_tbstats_flag();
>
> diff --git a/disas.c b/disas.c
> index 3e2bfa572b..d5292d4246 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -8,6 +8,8 @@
>  #include "disas/disas.h"
>  #include "disas/capstone.h"
>
> +#include "qemu/log-for-trace.h"
> +
>  typedef struct CPUDebug {
>      struct disassemble_info info;
>      CPUState *cpu;
> @@ -420,6 +422,22 @@ static bool cap_disas_monitor(disassemble_info *info=
, uint64_t pc, int count)
>  # define cap_disas_monitor(i, p, c)  false
>  #endif /* CONFIG_CAPSTONE */
>
> +static int fprintf_log(struct _IO_FILE *a, const char *b, ...)
> +{
> +    va_list ap;
> +    va_start(ap, b);
> +
> +    if (!to_string) {
> +        vfprintf(a, b, ap);
> +    } else {
> +        qemu_vlog(b, ap);
> +    }
> +
> +    va_end(ap);
> +
> +    return 1;
> +}
> +
>  /* Disassemble this for me please... (debugging).  */
>  void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>                    target_ulong size)
> @@ -429,7 +447,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ul=
ong code,
>      int count;
>      CPUDebug s;
>
> -    INIT_DISASSEMBLE_INFO(s.info, out, fprintf);
> +    INIT_DISASSEMBLE_INFO(s.info, out, fprintf_log);
>
>      s.cpu =3D cpu;
>      s.info.read_memory_func =3D target_read_memory;
> @@ -460,11 +478,12 @@ void target_disas(FILE *out, CPUState *cpu, target_=
ulong code,
>      }
>
>      for (pc =3D code; size > 0; pc +=3D count, size -=3D count) {
> -	fprintf(out, "0x" TARGET_FMT_lx ":  ", pc);
> -	count =3D s.info.print_insn(pc, &s.info);
> -	fprintf(out, "\n");
> -	if (count < 0)
> -	    break;
> +        fprintf_log(out, "0x" TARGET_FMT_lx ":  ", pc);
> +        count =3D s.info.print_insn(pc, &s.info);
> +        fprintf_log(out, "\n");
> +        if (count < 0) {
> +            break;
> +        }
>          if (size < count) {
>              fprintf(out,
>                      "Disassembler disagrees with translator over instruc=
tion "
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59444c461..f415479011 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -289,6 +289,30 @@ ETEXI
>          .help       =3D "show dynamic compiler info",
>          .cmd        =3D hmp_info_jit,
>      },
> +    {
> +        .name       =3D "tb-list",
> +        .args_type  =3D "number:i?,sortedby:s?",
> +        .params     =3D "[number sortedby]",
> +        .help       =3D "show a [number] translated blocks sorted by [so=
rtedby]"
> +                      "sortedby opts: hotness hg spills",
> +        .cmd        =3D hmp_info_tblist,
> +    },
> +    {
> +        .name       =3D "tb",
> +        .args_type  =3D "id:i,flags:s?",
> +        .params     =3D "id [flag1,flag2,...]",
> +        .help       =3D "show information about one translated block by =
id."
> +                      "dump flags can be used to set dump code level: ou=
t_asm in_asm op",
> +        .cmd        =3D hmp_info_tb,
> +    },
> +    {
> +        .name       =3D "coverset",
> +        .args_type  =3D "coverage:i?",
> +        .params     =3D "[coverage]",
> +        .help       =3D "show hottest translated blocks neccesary to cov=
er"
> +                      "[coverage]% of the execution count",
> +        .cmd        =3D hmp_info_coverset,
> +    },
>  #endif
>
>  STEXI
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 65063c52d7..51d73e1c5f 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -35,8 +35,11 @@
>  enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPIL=
LS };
>  enum TbstatsCmd { START, PAUSE, STOP, FILTER };
>
> +#define tbs_stats_enabled(tbs, JIT_STATS) \
> +    (tbs && (tbs->stats_enabled & JIT_STATS))
> +
>  #define tb_stats_enabled(tb, JIT_STATS) \
> -    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
> +    (tb && tb->tb_stats && tbs_stats_enabled(tb->tb_stats, JIT_STATS))
>
>  #define stat_per_translation(stat, name) \
>      (stat->translations.total ? stat->name / stat->translations.total : =
0)
> @@ -64,6 +67,8 @@ struct TBStatistics {
>      struct {
>          unsigned long normal;
>          unsigned long atomic;
> +        /* filled only when dumping x% cover set */
> +        uint16_t coverage;
>      } executions;
>
>      struct {
> @@ -82,7 +87,6 @@ struct TBStatistics {
>
>      struct {
>          unsigned long total;
> -        unsigned long uncached;
>          unsigned long spanning;
>      } translations;
>
> @@ -95,6 +99,9 @@ struct TBStatistics {
>          int64_t la;
>      } time;
>
> +    /* HMP information - used for referring to previous search */
> +    int display_id;
> +
>      /* current TB linked to this TBStatistics */
>      TranslationBlock *tb;
>  };
> @@ -115,6 +122,40 @@ struct TbstatsCommand {
>
>  void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
>
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
>  /* TBStatistic collection controls */
>  void enable_collect_tb_stats(void);
>  void disable_collect_tb_stats(void);
> diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
> index 2f0a5b080e..3de88484cb 100644
> --- a/include/qemu/log-for-trace.h
> +++ b/include/qemu/log-for-trace.h
> @@ -20,6 +20,9 @@
>
>  /* Private global variable, don't use */

This smells bad.

>  extern int qemu_loglevel;
> +extern bool to_string;
> +
> +extern int32_t max_num_hot_tbs_to_dump;
>
>  #define LOG_TRACE          (1 << 15)
>
> @@ -31,5 +34,6 @@ static inline bool qemu_loglevel_mask(int mask)
>
>  /* main logging function */
>  int GCC_FMT_ATTR(1, 2) qemu_log(const char *fmt, ...);
> +int qemu_vlog(const char *fmt, va_list va);
>
>  #endif
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index a8d1997cde..804cf90f0f 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -114,6 +114,8 @@ typedef struct QEMULogItem {
>  extern const QEMULogItem qemu_log_items[];
>
>  void qemu_set_log(int log_flags);
> +void qemu_log_to_monitor(bool enable);
> +void qemu_log_to_string(bool enable, GString *s);
>  void qemu_log_needs_buffers(void);
>  void qemu_set_log_filename(const char *filename, Error **errp);
>  void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 218263d29a..b99c018124 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -504,6 +504,80 @@ static void hmp_tbstats(Monitor *mon, const QDict *q=
dict)
>
>  }
>
> +static void hmp_info_tblist(Monitor *mon, const QDict *qdict)
> +{
> +    int number_int;
> +    const char *sortedby_str =3D NULL;
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
> +    number_int =3D qdict_get_try_int(qdict, "number", 10);
> +    sortedby_str =3D qdict_get_try_str(qdict, "sortedby");
> +
> +    int sortedby =3D SORT_BY_HOTNESS;
> +    if (sortedby_str =3D=3D NULL || strcmp(sortedby_str, "hotness") =3D=
=3D 0) {
> +        sortedby =3D SORT_BY_HOTNESS;
> +    } else if (strcmp(sortedby_str, "hg") =3D=3D 0) {
> +        sortedby =3D SORT_BY_HG;
> +    } else if (strcmp(sortedby_str, "spills") =3D=3D 0) {
> +        sortedby =3D SORT_BY_SPILLS;
> +    } else {
> +        error_report("valid sort options are: hotness hg spills");
> +        return;
> +    }
> +
> +    dump_tbs_info(number_int, sortedby, true);
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
> +        error_report("Unable to parse log flags, see 'help log'");
> +        return;
> +    }
> +
> +    dump_tb_info(id, mask, true);
> +}
> +
> +static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
> +{
> +    int coverage;
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
> +    coverage =3D qdict_get_try_int(qdict, "coverage", 90);
> +
> +    if (coverage < 0 || coverage > 100) {
> +        error_report("Coverset percentage should be between 0 and 100");
> +        return;
> +    }
> +
> +    dump_coverset_info(coverage, true);
> +}
> +
>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>  {
>      if (!tcg_enabled()) {
> diff --git a/util/log.c b/util/log.c
> index c3805b331b..698b48d083 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -33,28 +33,58 @@ int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
>  int32_t max_num_hot_tbs_to_dump;
> +static bool to_monitor;
> +bool to_string;
>
>  int tcg_collect_tb_stats;
>  uint32_t default_tbstats_flag;
>
> -/* Return the number of characters emitted.  */
> -int qemu_log(const char *fmt, ...)
> +GString *string;
> +
> +int qemu_vlog(const char *fmt, va_list va)
>  {
>      int ret =3D 0;
> -    if (qemu_logfile) {
> -        va_list ap;
> -        va_start(ap, fmt);
> -        ret =3D vfprintf(qemu_logfile, fmt, ap);
> -        va_end(ap);
> -
> -        /* Don't pass back error results.  */
> -        if (ret < 0) {
> -            ret =3D 0;
> +    if (to_string) {
> +        if (string) {
> +            g_string_append_vprintf(string, fmt, va);
>          }
> +    } else if (to_monitor) {
> +        ret =3D qemu_vprintf(fmt, va);
> +    } else if (qemu_logfile) {
> +        ret =3D vfprintf(qemu_logfile, fmt, va);
> +    }
> +
> +    /* Don't pass back error results.  */
> +    if (ret < 0) {
> +        ret =3D 0;
>      }
>      return ret;
>  }
>
> +/* Return the number of characters emitted.  */
> +int qemu_log(const char *fmt, ...)
> +{
> +    int ret =3D 0;
> +    va_list ap;
> +    va_start(ap, fmt);
> +
> +    ret =3D qemu_vlog(fmt, ap);
> +
> +    va_end(ap);
> +    return ret;
> +}
> +
> +void qemu_log_to_monitor(bool enable)
> +{
> +    to_monitor =3D enable;
> +}
> +
> +void qemu_log_to_string(bool enable, GString *s)
> +{
> +    to_string =3D enable;
> +    string =3D s;
> +}
> +
>  static bool log_uses_own_buffers;
>
>  /* enable or disable low levels log */


--
Alex Benn=C3=A9e

