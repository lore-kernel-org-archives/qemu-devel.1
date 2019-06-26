Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CDC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F55A20656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDjx0aLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F55A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg5km-00051F-F1
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hg5jp-000495-PE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hg5jm-000503-Ga
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:05:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hg5jm-0004vl-2h
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:05:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id k11so2260299wrl.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HsSLYnVRQQbUZOBm4Xxp5MmWFpnvV2V2qJme7UlG63E=;
 b=CDjx0aLFs5l9NeAz+MnqyGsJbHrJtUDsjerOOwAwl2OnzzVQ3hxmGpCnjru76PUY+U
 q+VdKSAlqj6ACjI3o0gyXyMbJZriYoLiPBmYDFnywneNP+dDPoXrhQda3IoKimdrIA6h
 zA9av5beYFIKht2f28eN7UfPkT6Wdk+5usjndWHFqGa0qPv94MLwFbYPU1yjNxUYm5tI
 dgwpCBU3Zv+10RkOWTq/NZ/7yMzOvo3aiYk86cvFgGj+RbetOim+PbhpX+EcynSZfahX
 W1Pg1Gr04NdMXE50hmHSGIh6s7TOPRBakBRKkfBMHd3H7Ipf5pVilW3UEGb9nhrsIQ1g
 ndSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HsSLYnVRQQbUZOBm4Xxp5MmWFpnvV2V2qJme7UlG63E=;
 b=AH2t7ShWqtQjzudxFkkvSl6NjPAB7jhhFJMLo64ISY3OlXLpIZ/h/6aOn6L6BQI7/2
 5y7MH/j3dPjQM+eYvMZo4DNbBefRI1tGFYRYuvbphyS9H1fKOfTsLkRSi5SAO/IkJxcU
 8jtcVuIe0jtDiRR+uuSfmAxYBVhFrt5EJLrVwQGX9z0IcOolyQ8r5phZidzSpw4HOZQE
 E4lcgO8oIcMvBE1kfGHC1LqnrG5fFvBjEIqOOUU6j6Hm9Bdq4vtDwv1ThO3d9gWA16GK
 BLnyO6flqvbLnOfI1UxgRgLV36sWaadElku5qIWYqThidKD2p5SpBPG1NMr9yQAF0gN8
 vMzg==
X-Gm-Message-State: APjAAAWKmpuU7wHVHxfAp3AJw5Ia+cjS85JBc+zCDP7ie11/ji1Rx5hd
 uuZnNwqeSRp69R2bbdMX/AGBVA==
X-Google-Smtp-Source: APXvYqztGHFBs3aDSH1tCcG3q7gU7ytbqAKWoyHxrdJ8/M3tXsFK4EJi+nFojbEM5xxtAZeJ84nyWA==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr3289274wrw.279.1561547112048; 
 Wed, 26 Jun 2019 04:05:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q20sm35291551wra.36.2019.06.26.04.05.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 04:05:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01DD01FF87;
 Wed, 26 Jun 2019 12:05:11 +0100 (BST)
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
 <20190624055442.2973-2-vandersonmr2@gmail.com>
 <87mui710qx.fsf@zen.linaroharston> <87d0j11veo.fsf@zen.linaroharston>
 <CAMzYVD1Y1EzDvSbWzpV35tePGAJdfzt_0SB3sJDDm4tTmj38Yg@mail.gmail.com>
 <87blyl1r2i.fsf@zen.linaroharston>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
In-reply-to: <87blyl1r2i.fsf@zen.linaroharston>
Date: Wed, 26 Jun 2019 12:05:10 +0100
Message-ID: <87a7e41uah.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Vanderson Martins do Rosario <vandersonmr2@gmail.com> writes:
>
>> When the tb_flush removes a block and it's recreated, this shouldn't
>> be creating a new block but using the one that is found by:
>>
>> lookup_result =3D g_list_find_custom(tb_ctx.tb_statistics, new_stats,
>> statistics_cmp);
>>
>> So the tb_statisticics will be reused and we could just add this
>> regen counter in the if statement: if (lookup_result)
>>
>> isn't that correct?
>
> Yes, although as I said earlier you want to use a QHT hash table rather
> than a g_list to avoid racing with multiple translations at once.
>
>>
>> Vanderson M. Rosario
>>
>>
>> On Tue, Jun 25, 2019 at 1:28 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>
>>>
>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>>
>>> > vandersonmr <vandersonmr2@gmail.com> writes:
>>> >
>>> >> We want to store statistics for each TB even after flushes.
>>> >> We do not want to modify or grow the TB struct.
>>> >> So we create a new struct to contain this statistics and
>>> >> link it to each TB while they are created.
>>> >>
>>> >> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>>> >> ---
>>> >>  accel/tcg/translate-all.c | 40 ++++++++++++++++++++++++++++++++++++=
+++
>>> >>  include/exec/exec-all.h   | 21 ++++++++++++++++++++
>>> >>  include/exec/tb-context.h |  1 +
>>> >>  include/qemu/log.h        |  1 +
>>> >>  4 files changed, 63 insertions(+)
>>> >>
>>> >> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>> >> index 5d1e08b169..f7e99f90e0 100644
>>> >> --- a/accel/tcg/translate-all.c
>>> >> +++ b/accel/tcg/translate-all.c
>>> >> @@ -1118,6 +1118,18 @@ static inline void code_gen_alloc(size_t tb_s=
ize)
>>> >>      }
>>> >>  }
>>> >>
>>> >> +static gint statistics_cmp(gconstpointer p1, gconstpointer p2)
>>> >> +{
>>> >> +    const TBStatistics *a =3D (TBStatistics *) p1;
>>> >> +    const TBStatistics *b =3D (TBStatistics *) p2;
>>> >> +
>>> >> +    return (a->pc =3D=3D b->pc &&
>>> >> +               a->cs_base =3D=3D b->cs_base &&
>>> >> +               a->flags =3D=3D b->flags &&
>>> >> +           a->page_addr[0] =3D=3D b->page_addr[0] &&
>>> >> +               a->page_addr[1] =3D=3D b->page_addr[1]) ? 0 : 1;
>>> >> +}
>>> >> +
>>> >
>>> > There are a bunch of white space errors that need fixing up as you
>>> > probably already know from patchew ;-)
>>> >
>>> >>  static bool tb_cmp(const void *ap, const void *bp)
>>> >>  {
>>> >>      const TranslationBlock *a =3D ap;
>>> >> @@ -1586,6 +1598,29 @@ static inline void tb_page_add(PageDesc *p,
>>> TranslationBlock *tb,
>>> >>  #endif
>>> >>  }
>>> >>
>>> >> +static void tb_insert_statistics_structure(TranslationBlock *tb) {
>>> >> +    TBStatistics *new_stats =3D g_new0(TBStatistics, 1);
>>> >> +    new_stats->pc =3D tb->pc;
>>> >> +    new_stats->cs_base =3D tb->cs_base;
>>> >> +    new_stats->flags =3D tb->flags;
>>> >> +    new_stats->page_addr[0] =3D tb->page_addr[0];
>>> >> +    new_stats->page_addr[1] =3D tb->page_addr[1];
>>> >> +
>>> >> +    GList *lookup_result =3D g_list_find_custom(tb_ctx.tb_statistic=
s,
>>> new_stats, statistics_cmp);
>>> >> +
>>> >> +    if (lookup_result) {
>>> >> +            /* If there is already a TBStatistic for this TB from a
>>> previous flush
>>> >> +            * then just make the new TB point to the older TBStatis=
tic
>>> >> +            */
>>> >> +            free(new_stats);
>>> >> +            tb->tb_stats =3D lookup_result->data;
>>> >> +    } else {
>>> >> +            /* If not, then points to the new tb_statistics and add=
 it
>>> to the hash */
>>> >> +            tb->tb_stats =3D new_stats;
>>> >> +            tb_ctx.tb_statistics =3D g_list_prepend(tb_ctx.tb_stati=
stics,
>>> >> new_stats);
>>> >
>>> > This is going to race as nothing prevents two threads attempting to
>>> > insert records at the same time.
>>> >
>>> >> +    }
>>> >> +}
>>> >> +
>>> >>  /* add a new TB and link it to the physical page tables. phys_page2=
 is
>>> >>   * (-1) to indicate that only one page contains the TB.
>>> >>   *
>>> >> @@ -1636,6 +1671,11 @@ tb_link_page(TranslationBlock *tb,
>>> tb_page_addr_t phys_pc,
>>> >>          void *existing_tb =3D NULL;
>>> >>          uint32_t h;
>>> >>
>>> >> +        if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
>>> >> +            /* create and link to its TB a structure to store
>>> statistics */
>>> >> +            tb_insert_statistics_structure(tb);
>>> >> +            }
>>> >> +
>>> >>          /* add in the hash table */
>>> >>          h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags &
>>> CF_HASH_MASK,
>>> >>                           tb->trace_vcpu_dstate);
>>> >
>>> > Perhaps we could just have a second qht array which allows for
>>> > "unlocked" insertion of record. You could take advantage of the fact =
the
>>> > hash would be the same:
>>> >
>>> >         h =3D tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags &
>>> CF_HASH_MASK,
>>> >                          tb->trace_vcpu_dstate);
>>> >         qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
>>> >
>>> >         /* remove TB from the page(s) if we couldn't insert it */
>>> >         if (unlikely(existing_tb)) {
>>> >             ...
>>> >             tb =3D existing_tb;
>>> >         } else if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
>>> >             TBStatistics *new_stats =3D g_new0(TBStatistics, 1);
>>> >             bool ok;
>>> >             new_stats->pc =3D tb->pc;
>>> >             new_stats->cs_base =3D tb->cs_base;
>>> >             new_stats->flags =3D tb->flags;
>>> >             new_stats->page_addr[0] =3D tb->page_addr[0];
>>> >             new_stats->page_addr[1] =3D tb->page_addr[1];
>>> >             ok =3D qht_insert(&tb_ctx.tb_stats, new_stats, h, NULL);
>>> >             /*
>>> >              * This should never fail as we succeeded in inserting the
>>> >              * TB itself which means we haven't seen this combination
>>> yet.
>>> >              */
>>> >             g_assert(ok);
>>> >         }
>>> >
>>> > It would also avoid the clunkiness of having to allocate and then
>>> > freeing an unused structure.
>>>
>>>
>>> Actually thinking on this we still have to handle it. We may have
>>> tb_flushed away a translation and just be regenerating the same block.
>>> As TBStatistics should transcend tb_flush events we need to re-use it's
>>> structure.
>>>
>>> It would be worth counting the regens as well so we can see blocks that
>>> keep getting re-translated after each flush.

Another issue is lifetime. We really want to have the statistics
available before we generate the code (so we can pass a direct pointer
to the helper) and we can't wait until after we qht_insert the TB into
the buffer (as any thread can start executing that buffer from that
point). So we need to ensure tb->tb_stats is live and ready as
translation time.

--
Alex Benn=C3=A9e

