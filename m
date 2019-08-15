Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A905C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441112067D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAFxhHBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441112067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyH9a-00030U-7y
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hyH8m-0002a2-Lg
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hyH8i-0004Z9-8n
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:54:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hyH8i-0004Y2-0w
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:54:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id p74so1512466wme.4
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7Zd1VeIvJJTKFlfB0C619go0c3lxtupiGwV3YH4QWVE=;
 b=QAFxhHBDstcMbIwtVlsmzgMyMOch12h45PkPeRISiQ0fvav5CLY6csCW0C1p7ChDnk
 RDHoFexfMWhNyNOzpNAs86GwEvFt57+L15cVJW4jUizLVvkk9eLSS3xFZXkOCD+LgHa6
 iwqXE5ioTzBYLRCvnYg791kGOqoAOMwSsthYYgib0Z61WW6/oqPhAuEoIO43/9Ao3xB8
 k4sQxq9qZ19fDpdWzrwv8jY8LSqu/f/Y36e3gWXPUrvGhOdty3iwXvjktoxPQqKzPg0r
 UItcDeDLe53WHpmzI/vVdsHiQ0HkrVbonCOgd3+Thcc6Rf/PbuLI7eWLmIG7z3EQuElf
 Gevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7Zd1VeIvJJTKFlfB0C619go0c3lxtupiGwV3YH4QWVE=;
 b=TqOaHDmJPkO7THI7amjBOdCmPMqx8yLmFNC5qXrhSQUyn++Mw8ufPCIwqEJ5nLSHKD
 4g2lR34Vgrmy53Cmx4VsplB2JBIjSOsWv6wPJF2ZFvE96lbiQksa+e4rzeAJA0LNrnuZ
 ImbHsP+sXgl8gsw45gD1RS/DjybJ7svuTTUrbJx7F8+mT35OEfA1qulmmIKg80riRP87
 5JN66BpSJKSo/4tlbb3yX7NV9TOsVoWRdScRjPDBh8cuuTvplYZqKw/iLwsEpnI9MewN
 HrKNhH6wvhFpVyhhkQt049mQRYHXAjR2pDwlRrTrDaEpyVoAJ4v18p0eqYTUihfz4hiG
 Jdrg==
X-Gm-Message-State: APjAAAVmeP+pKKkmKJgM7+Zyhx+esx+O75bRfkSp1NzOiDb+QMj2khJk
 4IHJMPXOfVxqMLG/+3VKxanThw==
X-Google-Smtp-Source: APXvYqwaGYI4TY3XhxOqi4bhLWLJZ9V0a4LJKf/xAv4RApblEQWimTJlDnSX80EpKm79E81m6sDwRw==
X-Received: by 2002:a1c:d10b:: with SMTP id i11mr3306988wmg.78.1565880846902; 
 Thu, 15 Aug 2019 07:54:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o9sm2269401wrj.17.2019.08.15.07.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 07:54:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E66271FF87;
 Thu, 15 Aug 2019 15:54:05 +0100 (BST)
References: <20190815021857.19526-1-vandersonmr2@gmail.com>
 <20190815021857.19526-5-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190815021857.19526-5-vandersonmr2@gmail.com>
Date: Thu, 15 Aug 2019 15:54:05 +0100
Message-ID: <87o90qmqcy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v5 04/10] accel: replacing part of
 CONFIG_PROFILER with TBStats
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> We add some of the statistics collected in the TCGProfiler
> into the TBStats, having the statistics not only for the whole
> emulation but for each TB. Then, we removed these stats
> from TCGProfiler and reconstruct the information for the
> "info jit" using the sum of all TBStats statistics.
>
> The goal is to have one unique and better way of collecting
> emulation statistics. Moreover, checking dynamiclly if the
> profiling is enabled showed to have an insignificant impact
> on the performance:
> https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality#Overheads.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tb-stats.c      | 95 +++++++++++++++++++++++++++++++++++++++
>  accel/tcg/translate-all.c |  8 +---
>  include/exec/tb-stats.h   | 11 +++++
>  tcg/tcg.c                 | 93 +++++---------------------------------
>  tcg/tcg.h                 | 10 -----
>  5 files changed, 118 insertions(+), 99 deletions(-)
>
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index 3489133e9e..9b720d9b86 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -1,9 +1,104 @@
>  #include "qemu/osdep.h"
>
>  #include "disas/disas.h"
> +#include "exec/exec-all.h"
> +#include "tcg.h"
> +
> +#include "qemu/qemu-print.h"
>
>  #include "exec/tb-stats.h"
>
> +struct jit_profile_info {
> +    uint64_t translations;
> +    uint64_t aborted;
> +    uint64_t ops;
> +    unsigned ops_max;
> +    uint64_t del_ops;
> +    uint64_t temps;
> +    unsigned temps_max;
> +    uint64_t host;
> +    uint64_t guest;
> +    uint64_t search_data;
> +};
> +
> +/* accumulate the statistics from all TBs */
> +static void collect_jit_profile_info(void *p, uint32_t hash, void *userp)
> +{
> +    struct jit_profile_info *jpi =3D userp;
> +    TBStatistics *tbs =3D p;
> +
> +    jpi->translations +=3D tbs->translations.total;
> +    jpi->ops +=3D tbs->code.num_tcg_ops;
> +    if (stat_per_translation(tbs, code.num_tcg_ops) > jpi->ops_max) {
> +        jpi->ops_max =3D stat_per_translation(tbs, code.num_tcg_ops);
> +    }
> +    jpi->del_ops +=3D tbs->code.deleted_ops;
> +    jpi->temps +=3D tbs->code.temps;
> +    if (stat_per_translation(tbs, code.temps) > jpi->temps_max) {
> +        jpi->temps_max =3D stat_per_translation(tbs, code.temps);
> +    }
> +    jpi->host +=3D tbs->code.out_len;
> +    jpi->guest +=3D tbs->code.in_len;
> +    jpi->search_data +=3D tbs->code.search_out_len;
> +}
> +
> +/* dump JIT statisticis using TCGProfile and TBStats */
> +void dump_jit_profile_info(TCGProfile *s)
> +{
> +    if (!tb_stats_collection_enabled()) {
> +        return;
> +    }
> +
> +    struct jit_profile_info *jpi =3D g_new0(struct jit_profile_info, 1);
> +
> +    qht_iter(&tb_ctx.tb_stats, collect_jit_profile_info, jpi);
> +
> +    if (jpi->translations) {
> +        qemu_printf("translated TBs      %" PRId64 "\n", jpi->translatio=
ns);
> +        qemu_printf("avg ops/TB          %0.1f max=3D%d\n",
> +                jpi->ops / (double) jpi->translations, jpi->ops_max);
> +        qemu_printf("deleted ops/TB      %0.2f\n",
> +                jpi->del_ops / (double) jpi->translations);
> +        qemu_printf("avg temps/TB        %0.2f max=3D%d\n",
> +                jpi->temps / (double) jpi->translations, jpi->temps_max);
> +        qemu_printf("avg host code/TB    %0.1f\n",
> +                jpi->host / (double) jpi->translations);
> +        qemu_printf("avg search data/TB  %0.1f\n",
> +                jpi->search_data / (double) jpi->translations);
> +
> +        if (s) {
> +            int64_t tot =3D s->interm_time + s->code_time;
> +            qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4=
 GHz)\n",
> +                            tot, tot / 2.4e9);
> +            qemu_printf("cycles/op           %0.1f\n",
> +                        jpi->ops ? (double)tot / jpi->ops : 0);
> +            qemu_printf("cycles/in byte      %0.1f\n",
> +                        jpi->guest ? (double)tot / jpi->guest : 0);
> +            qemu_printf("cycles/out byte     %0.1f\n",
> +                        jpi->host ? (double)tot / jpi->host : 0);
> +            qemu_printf("cycles/search byte     %0.1f\n",
> +                        jpi->search_data ? (double)tot / jpi->search_dat=
a : 0);
> +            if (tot =3D=3D 0) {
> +                tot =3D 1;
> +            }
> +            qemu_printf("  gen_interm time   %0.1f%%\n",
> +                        (double)s->interm_time / tot * 100.0);
> +            qemu_printf("  gen_code time     %0.1f%%\n",
> +                        (double)s->code_time / tot * 100.0);
> +            qemu_printf("optim./code time    %0.1f%%\n",
> +                        (double)s->opt_time / (s->code_time ? s->code_ti=
me : 1)
> +                        * 100.0);
> +            qemu_printf("liveness/code time  %0.1f%%\n",
> +                    (double)s->la_time / (s->code_time ? s->code_time : =
1) * 100.0);
> +            qemu_printf("cpu_restore count   %" PRId64 "\n",
> +                    s->restore_count);
> +            qemu_printf("  avg cycles        %0.1f\n",
> +                    s->restore_count ? (double)s->restore_time / s->rest=
ore_count : 0);
> +        }
> +    }

I think the g_free(jpi) should be moved from the later patches to here.
Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

