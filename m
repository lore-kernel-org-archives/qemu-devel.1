Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA2C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BC72084B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwg8gQOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BC72084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34306 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfpQk-00032E-M3
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 13:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfpOZ-0002F2-3k
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfpOX-0000oZ-04
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:38:15 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:37622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hfpOW-0000nN-NE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:38:12 -0400
Received: by mail-qt1-x841.google.com with SMTP id y57so19365017qtk.4
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mB6oyAl/9LK9wc322pTH2oWgJXxTwKdYNSp3JT3XHUw=;
 b=fwg8gQOeYTaLfKq4i+vCNpKDAJtg4yXCEJwdw+GBemA3qZzldhml3GjZTCItjNZ7mU
 Kyz2IGqNFU4qsFlCUut7CO83hFJp6ZdM+oHiywPkR+N8R09vzxMtLayiLqVFGew7xXV3
 RuOq+VTExD85R6guSXcmDZ+QHITLMxh4BjsmU9ZK/G15srEL7KsSfvfuRnIWod8G2zvT
 JjpZ0FYhn9Xzroe1LdJosQcmaplDtWA1znau0NGumJQrM4y6V3sAk1FuxBN4qLvRNi/b
 Xg0FP8N+aQ4BfcmCqCKq45QYrBHqdk9ZWYV+DhK3/zqvB2goM+EcOU9WecV5N2FZMVss
 WnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mB6oyAl/9LK9wc322pTH2oWgJXxTwKdYNSp3JT3XHUw=;
 b=UhnaPjQjdSL/kczzntsCVbslY6p6YX2TedXFONjvStT8I6u0U9r8iS013J4W6irvX4
 z+KiKrARIAw8/mM9NwexYIPPzR6YtysXBOn3fvpaxTDDo03l6zc/rmqCyX3Jn6AAy5l4
 /kpxj7V9R2rMsM2fd65PqFi57I+e/Vwm2jQ0lbgt3PpTHJ0pIu+Be1NwntxxbLAEVzGw
 TM5up+zKOpE3JdPviP+A7N5T3GyEFhq1p849O5WFLnrcPwnatpK9V9PH2O1IE39gPhDB
 67JKq0MxrV1uwY73O7Y5JaqBu0/DJVpop0pP5ae0HRkso/XjI9tqYPiamPcBiQrEJF0E
 6ulQ==
X-Gm-Message-State: APjAAAWHWN9UA9bf9eMN7qQrWCZ38Gqi3q7PLBOHSr1S0ZZbixlsPveE
 mbeXDkicU8rVGC3Te08w0ENktI6pldn83pTQuGo=
X-Google-Smtp-Source: APXvYqwjtkgnyJNVhasVEFqmHgNu+CowQAweOC8TdFdYY4sO1zHksJNtSQlHWD3MAtYHLa26X5KYhO1kYlCkRGW0Qik=
X-Received: by 2002:a0c:9e5b:: with SMTP id z27mr61708219qve.67.1561484290611; 
 Tue, 25 Jun 2019 10:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
 <20190624055442.2973-2-vandersonmr2@gmail.com>
 <87mui710qx.fsf@zen.linaroharston> <87d0j11veo.fsf@zen.linaroharston>
In-Reply-To: <87d0j11veo.fsf@zen.linaroharston>
From: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
Date: Tue, 25 Jun 2019 14:37:59 -0300
Message-ID: <CAMzYVD1Y1EzDvSbWzpV35tePGAJdfzt_0SB3sJDDm4tTmj38Yg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 1/4] add and link a statistic struct to
 TBs
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

When the tb_flush removes a block and it's recreated, this shouldn't
be creating a new block but using the one that is found by:

lookup_result =3D g_list_find_custom(tb_ctx.tb_statistics, new_stats,
statistics_cmp);

So the tb_statisticics will be reused and we could just add this
regen counter in the if statement: if (lookup_result)

isn't that correct?

Vanderson M. Rosario


On Tue, Jun 25, 2019 at 1:28 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > vandersonmr <vandersonmr2@gmail.com> writes:
> >
> >> We want to store statistics for each TB even after flushes.
> >> We do not want to modify or grow the TB struct.
> >> So we create a new struct to contain this statistics and
> >> link it to each TB while they are created.
> >>
> >> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> >> ---
> >>  accel/tcg/translate-all.c | 40 ++++++++++++++++++++++++++++++++++++++=
+
> >>  include/exec/exec-all.h   | 21 ++++++++++++++++++++
> >>  include/exec/tb-context.h |  1 +
> >>  include/qemu/log.h        |  1 +
> >>  4 files changed, 63 insertions(+)
> >>
> >> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> >> index 5d1e08b169..f7e99f90e0 100644
> >> --- a/accel/tcg/translate-all.c
> >> +++ b/accel/tcg/translate-all.c
> >> @@ -1118,6 +1118,18 @@ static inline void code_gen_alloc(size_t tb_siz=
e)
> >>      }
> >>  }
> >>
> >> +static gint statistics_cmp(gconstpointer p1, gconstpointer p2)
> >> +{
> >> +    const TBStatistics *a =3D (TBStatistics *) p1;
> >> +    const TBStatistics *b =3D (TBStatistics *) p2;
> >> +
> >> +    return (a->pc =3D=3D b->pc &&
> >> +               a->cs_base =3D=3D b->cs_base &&
> >> +               a->flags =3D=3D b->flags &&
> >> +           a->page_addr[0] =3D=3D b->page_addr[0] &&
> >> +               a->page_addr[1] =3D=3D b->page_addr[1]) ? 0 : 1;
> >> +}
> >> +
> >
> > There are a bunch of white space errors that need fixing up as you
> > probably already know from patchew ;-)
> >
> >>  static bool tb_cmp(const void *ap, const void *bp)
> >>  {
> >>      const TranslationBlock *a =3D ap;
> >> @@ -1586,6 +1598,29 @@ static inline void tb_page_add(PageDesc *p,
> TranslationBlock *tb,
> >>  #endif
> >>  }
> >>
> >> +static void tb_insert_statistics_structure(TranslationBlock *tb) {
> >> +    TBStatistics *new_stats =3D g_new0(TBStatistics, 1);
> >> +    new_stats->pc =3D tb->pc;
> >> +    new_stats->cs_base =3D tb->cs_base;
> >> +    new_stats->flags =3D tb->flags;
> >> +    new_stats->page_addr[0] =3D tb->page_addr[0];
> >> +    new_stats->page_addr[1] =3D tb->page_addr[1];
> >> +
> >> +    GList *lookup_result =3D g_list_find_custom(tb_ctx.tb_statistics,
> new_stats, statistics_cmp);
> >> +
> >> +    if (lookup_result) {
> >> +            /* If there is already a TBStatistic for this TB from a
> previous flush
> >> +            * then just make the new TB point to the older TBStatisti=
c
> >> +            */
> >> +            free(new_stats);
> >> +            tb->tb_stats =3D lookup_result->data;
> >> +    } else {
> >> +            /* If not, then points to the new tb_statistics and add i=
t
> to the hash */
> >> +            tb->tb_stats =3D new_stats;
> >> +            tb_ctx.tb_statistics =3D g_list_prepend(tb_ctx.tb_statist=
ics,
> >> new_stats);
> >
> > This is going to race as nothing prevents two threads attempting to
> > insert records at the same time.
> >
> >> +    }
> >> +}
> >> +
> >>  /* add a new TB and link it to the physical page tables. phys_page2 i=
s
> >>   * (-1) to indicate that only one page contains the TB.
> >>   *
> >> @@ -1636,6 +1671,11 @@ tb_link_page(TranslationBlock *tb,
> tb_page_addr_t phys_pc,
> >>          void *existing_tb =3D NULL;
> >>          uint32_t h;
> >>
> >> +        if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
> >> +            /* create and link to its TB a structure to store
> statistics */
> >> +            tb_insert_statistics_structure(tb);
> >> +            }
> >> +
> >>          /* add in the hash table */
> >>          h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags &
> CF_HASH_MASK,
> >>                           tb->trace_vcpu_dstate);
> >
> > Perhaps we could just have a second qht array which allows for
> > "unlocked" insertion of record. You could take advantage of the fact th=
e
> > hash would be the same:
> >
> >         h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags &
> CF_HASH_MASK,
> >                          tb->trace_vcpu_dstate);
> >         qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
> >
> >         /* remove TB from the page(s) if we couldn't insert it */
> >         if (unlikely(existing_tb)) {
> >             ...
> >             tb =3D existing_tb;
> >         } else if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
> >             TBStatistics *new_stats =3D g_new0(TBStatistics, 1);
> >             bool ok;
> >             new_stats->pc =3D tb->pc;
> >             new_stats->cs_base =3D tb->cs_base;
> >             new_stats->flags =3D tb->flags;
> >             new_stats->page_addr[0] =3D tb->page_addr[0];
> >             new_stats->page_addr[1] =3D tb->page_addr[1];
> >             ok =3D qht_insert(&tb_ctx.tb_stats, new_stats, h, NULL);
> >             /*
> >              * This should never fail as we succeeded in inserting the
> >              * TB itself which means we haven't seen this combination
> yet.
> >              */
> >             g_assert(ok);
> >         }
> >
> > It would also avoid the clunkiness of having to allocate and then
> > freeing an unused structure.
>
>
> Actually thinking on this we still have to handle it. We may have
> tb_flushed away a translation and just be regenerating the same block.
> As TBStatistics should transcend tb_flush events we need to re-use it's
> structure.
>
> It would be worth counting the regens as well so we can see blocks that
> keep getting re-translated after each flush.
>
> >
> >> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> >> index 16034ee651..359100ef3b 100644
> >> --- a/include/exec/exec-all.h
> >> +++ b/include/exec/exec-all.h
> >> @@ -324,6 +324,24 @@ static inline void
> tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
> >>  #define CODE_GEN_AVG_BLOCK_SIZE 150
> >>  #endif
> >>
> >> +typedef struct TBStatistics TBStatistics;
> >> +
> >> +/*
> >> + * This struct stores statistics such as execution count of the
> TranslationBlocks.
> >> + * Each TB has its own TBStatistics. TBStatistics is suppose to live
> even after
> >> + * flushes.
> >> + */
> >> +struct TBStatistics {
> >> +    target_ulong pc;
> >> +    target_ulong cs_base;
> >> +    uint32_t flags;
> >> +    tb_page_addr_t page_addr[2];
> >> +
> >> +    // total number of times that the related TB have being executed
> >
> > No c++ style comments
> >
> >> +    uint32_t exec_count;
> >> +    uint32_t exec_count_overflows;
> >> +};
> >> +
> >>  /*
> >>   * Translation Cache-related fields of a TB.
> >>   * This struct exists just for convenience; we keep track of TB's in =
a
> binary
> >> @@ -403,6 +421,9 @@ struct TranslationBlock {
> >>      uintptr_t jmp_list_head;
> >>      uintptr_t jmp_list_next[2];
> >>      uintptr_t jmp_dest[2];
> >> +
> >> +    // Pointer to a struct where statistics from the TB is stored
> >
> > No c++ style comments
> >
> >> +    TBStatistics *tb_stats;
> >>  };
> >>
> >>  extern bool parallel_cpus;
> >> diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
> >> index feb585e0a7..a78ce92e60 100644
> >> --- a/include/exec/tb-context.h
> >> +++ b/include/exec/tb-context.h
> >> @@ -35,6 +35,7 @@ struct TBContext {
> >>
> >>      /* statistics */
> >>      unsigned tb_flush_count;
> >> +    GList *tb_statistics;
> >>  };
> >>
> >>  extern TBContext tb_ctx;
> >> diff --git a/include/qemu/log.h b/include/qemu/log.h
> >> index b097a6cae1..2fca65dd01 100644
> >> --- a/include/qemu/log.h
> >> +++ b/include/qemu/log.h
> >> @@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
> >>  /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
> >>  #define CPU_LOG_TB_OP_IND  (1 << 16)
> >>  #define CPU_LOG_TB_FPU     (1 << 17)
> >> +#define CPU_LOG_HOT_TBS    (1 << 18)
> >>
> >>  /* Lock output for a series of related logs.  Since this is not neede=
d
> >>   * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
>
>
> --
> Alex Benn=C3=A9e
>
