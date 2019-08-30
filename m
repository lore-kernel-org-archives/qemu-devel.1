Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E02C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D5222CE9
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvMy88S2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D5222CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3h05-0007Y1-Pb
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 09:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3gxD-0005qy-H1
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3gxA-0001vt-9H
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:28:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3gx9-0001nz-Mv
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:28:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id t17so7336147wmi.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TjLDgIMhVUHJPVzEyQ17g0RGQo6p2C5WxoMNwt3HEmo=;
 b=YvMy88S2Iz0aEj90iCwkZHDjy/pLQV9wts+TL672lTGR8rUXs47ZOctc3fdaICVgDE
 mIZfUlsZs+xOrUWbrgtPxRqLK7y1CLl7RkkZ/tEdXdR0sxxFTio6LfIusiBgCoedn52H
 6PB6GwDPWdwJd/MKmeO4T1OKFHH+XLF7MQ98XmYxVnObVMaaGMG+NwX6de+C2Jwir9J7
 k7fKc+6lYwtaYANlPX+jHROiIkCiYiVbL4ry2DCKp3OCsiJC4b7aOSUhxzUOjTu8gcDD
 yC+B2Xo50TzIX8j6LJ8qZD5urjdbcDKaET5xkNvhJVwRSl+/SiLYy5SV44rQRn4f9uku
 V0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TjLDgIMhVUHJPVzEyQ17g0RGQo6p2C5WxoMNwt3HEmo=;
 b=p5eITxcV28aXvFagKBrbPgleeMmZ6ciKkY2+qql7g03w5nddQm3OSMITkpy04j/fj3
 mFf2WwCI06h9e11Os6OvGe+dkf15LpuMnfiTBBeci4ZiTUuKROkO5UCiJSpTXims4k1R
 2i5Mk9xrh3q/rperFaY7SdQ88qMtVY2T2tAzGkQbAWonYK4eCtlRiBzWAXSlYwV2ZYrS
 2dO6y/ti5N9x7N3TT/RZg/Jj/0mAAQ2+QsN2W04cqsGQYcXcpBF1gHeWFM/A51QGPeOx
 hNmNeGLDrkYwjqiKu0n/TjdS0rveaB0f6lkpWUXDcmrGQ5rnzxy1KRTYB6obGifuzfKy
 KYTg==
X-Gm-Message-State: APjAAAXrVTDYNd/DQu5KxCTousFyUGplAgd2KngBv2WW0isCwzto9aD4
 FcDUJauZ9fx/8kLMbAjOJy0T3bIBWN4=
X-Google-Smtp-Source: APXvYqwawC6CC+w5EMzpsZ6uBonHOiQFbzrnFmk8qubR2kfBmGk0KmaDD51Sk9nEFLinH0pt25GvCg==
X-Received: by 2002:a1c:a003:: with SMTP id j3mr18265727wme.42.1567169960360; 
 Fri, 30 Aug 2019 05:59:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z10sm430630wrg.12.2019.08.30.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 05:59:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01B7E1FF87;
 Fri, 30 Aug 2019 13:59:19 +0100 (BST)
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-2-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: vandersonmr <vandersonmr2@gmail.com>
In-reply-to: <20190829173437.5926-2-vandersonmr2@gmail.com>
Date: Fri, 30 Aug 2019 13:59:18 +0100
Message-ID: <874l1y95cp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v8 01/11] accel: introducing TBStatistics
 structure
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


vandersonmr <vandersonmr2@gmail.com> writes:

> To store statistics for each TB, we created a TBStatistics structure
> which is linked with the TBs. TBStatistics can stay alive after
> tb_flush and be relinked to a regenerated TB. So the statistics can
> be accumulated even through flushes.
>
> The goal is to have all present and future qemu/tcg statistics and
> meta-data stored in this new structure.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/Makefile.objs   |  2 +-
>  accel/tcg/tb-stats.c      | 63 ++++++++++++++++++++++++++++++++++++
>  accel/tcg/translate-all.c | 57 +++++++++++++++++++++++++++++++++
>  include/exec/exec-all.h   | 15 +++------
>  include/exec/tb-context.h | 12 +++++++
>  include/exec/tb-hash.h    |  7 ++++
>  include/exec/tb-stats.h   | 67 +++++++++++++++++++++++++++++++++++++++
>  util/log.c                |  2 ++
>  8 files changed, 213 insertions(+), 12 deletions(-)
>  create mode 100644 accel/tcg/tb-stats.c
>  create mode 100644 include/exec/tb-stats.h
>
> diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
> index d381a02f34..49ffe81b5d 100644
> --- a/accel/tcg/Makefile.objs
> +++ b/accel/tcg/Makefile.objs
> @@ -2,7 +2,7 @@ obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
>  obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
>  obj-y +=3D tcg-runtime.o tcg-runtime-gvec.o
>  obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o
> -obj-y +=3D translator.o
> +obj-y +=3D translator.o tb-stats.o
>=20=20
>  obj-$(CONFIG_USER_ONLY) +=3D user-exec.o
>  obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D user-exec-stub.o
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> new file mode 100644
> index 0000000000..948b107e68
> --- /dev/null
> +++ b/accel/tcg/tb-stats.c
> @@ -0,0 +1,63 @@
> +/*
> + * QEMU System Emulator, Code Quality Monitor System
> + *
> + * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "disas/disas.h"
> +
> +#include "exec/tb-stats.h"
> +
> +void init_tb_stats_htable_if_not(void)
> +{
> +    if (tb_stats_collection_enabled() && !tb_ctx.tb_stats.map) {
> +        qht_init(&tb_ctx.tb_stats, tb_stats_cmp,
> +                CODE_GEN_HTABLE_SIZE, QHT_MODE_AUTO_RESIZE);
> +    }
> +}
> +
> +void enable_collect_tb_stats(void)
> +{
> +    init_tb_stats_htable_if_not();
> +    tcg_collect_tb_stats =3D TB_STATS_RUNNING;
> +}
> +
> +void disable_collect_tb_stats(void)
> +{
> +    tcg_collect_tb_stats =3D TB_STATS_PAUSED;
> +}
> +
> +void pause_collect_tb_stats(void)
> +{
> +    tcg_collect_tb_stats =3D TB_STATS_STOPPED;
> +}
> +
> +bool tb_stats_collection_enabled(void)
> +{
> +    return tcg_collect_tb_stats =3D=3D TB_STATS_RUNNING;
> +}
> +
> +bool tb_stats_collection_paused(void)
> +{
> +    return tcg_collect_tb_stats =3D=3D TB_STATS_PAUSED;
> +}
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5d1e08b169..b7bccacd3b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1118,6 +1118,23 @@ static inline void code_gen_alloc(size_t tb_size)
>      }
>  }
>=20=20
> +/*
> + * This is the more or less the same compare as tb_cmp(), but the
> + * data persists over tb_flush. We also aggregate the various
> + * variations of cflags under one record and ignore the details of
> + * page overlap (although we can count it).
> + */
> +bool tb_stats_cmp(const void *ap, const void *bp)
> +{
> +    const TBStatistics *a =3D ap;
> +    const TBStatistics *b =3D bp;
> +
> +    return a->phys_pc =3D=3D b->phys_pc &&
> +        a->pc =3D=3D b->pc &&
> +        a->cs_base =3D=3D b->cs_base &&
> +        a->flags =3D=3D b->flags;
> +}
> +
>  static bool tb_cmp(const void *ap, const void *bp)
>  {
>      const TranslationBlock *a =3D ap;
> @@ -1137,6 +1154,7 @@ static void tb_htable_init(void)
>      unsigned int mode =3D QHT_MODE_AUTO_RESIZE;
>=20=20
>      qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
> +    init_tb_stats_htable_if_not();
>  }
>=20=20
>  /* Must be called before using the QEMU cpus. 'tb_size' is the size
> @@ -1666,6 +1684,34 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t =
phys_pc,
>      return tb;
>  }
>=20=20
> +static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong p=
c,
> +                                  target_ulong cs_base, uint32_t flags,
> +                                  TranslationBlock *current_tb)
> +{
> +    TBStatistics *new_stats =3D g_new0(TBStatistics, 1);
> +    uint32_t hash =3D tb_stats_hash_func(phys_pc, pc, flags);
> +    void *existing_stats =3D NULL;
> +    new_stats->phys_pc =3D phys_pc;
> +    new_stats->pc =3D pc;
> +    new_stats->cs_base =3D cs_base;
> +    new_stats->flags =3D flags;
> +    new_stats->tb =3D current_tb;

Drop the current_tb and the field from TBStatistics - it's not used by
anything else in this patch. Also see bellow:

> +
> +    qht_insert(&tb_ctx.tb_stats, new_stats, hash, &existing_stats);
> +
> +    if (unlikely(existing_stats)) {
> +        /*
> +         * If there is already a TBStatistic for this TB from a previous=
 flush
> +         * then just make the new TB point to the older TBStatistic
> +         */
> +        g_free(new_stats);
> +        return existing_stats;
> +    } else {
> +        return new_stats;
> +    }
> +}
> +
> +
>  /* Called with mmap_lock held for user mode emulation.  */
>  TranslationBlock *tb_gen_code(CPUState *cpu,
>                                target_ulong pc, target_ulong cs_base,
> @@ -1732,6 +1778,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      ti =3D profile_getclock();
>  #endif
>=20=20
> +    /*
> +     * We want to fetch the stats structure before we start code
> +     * generation so we can count interesting things about this
> +     * generation.
> +     */
> +    if (tb_stats_collection_enabled()) {
> +        tb->tb_stats =3D tb_get_stats(phys_pc, pc, cs_base, flags, tb);
> +    } else {
> +        tb->tb_stats =3D NULL;
> +    }
> +
>      tcg_func_start(tcg_ctx);
>=20=20
>      tcg_ctx->cpu =3D env_cpu(env);
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 135aeaab0d..1e0bd4e147 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -23,21 +23,11 @@
>  #include "cpu.h"
>  #include "exec/tb-context.h"
>  #include "sysemu/cpus.h"
> +#include "exec/tb-stats.h"
>=20=20
>  /* allow to see translation results - the slowdown should be negligible,=
 so we leave it */
>  #define DEBUG_DISAS
>=20=20
> -/* Page tracking code uses ram addresses in system mode, and virtual
> -   addresses in userspace mode.  Define tb_page_addr_t to be an appropri=
ate
> -   type.  */
> -#if defined(CONFIG_USER_ONLY)
> -typedef abi_ulong tb_page_addr_t;
> -#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
> -#else
> -typedef ram_addr_t tb_page_addr_t;
> -#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
> -#endif
> -
>  #include "qemu/log.h"
>=20=20
>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_=
insns);
> @@ -404,6 +394,9 @@ struct TranslationBlock {
>      uintptr_t jmp_list_head;
>      uintptr_t jmp_list_next[2];
>      uintptr_t jmp_dest[2];
> +
> +    /* Pointer to a struct where statistics from the TB is stored */
> +    TBStatistics *tb_stats;
>  };
>=20=20
>  extern bool parallel_cpus;
> diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
> index feb585e0a7..3cfb62a338 100644
> --- a/include/exec/tb-context.h
> +++ b/include/exec/tb-context.h
> @@ -23,6 +23,17 @@
>  #include "qemu/thread.h"
>  #include "qemu/qht.h"
>=20=20
> +/* Page tracking code uses ram addresses in system mode, and virtual
> +   addresses in userspace mode.  Define tb_page_addr_t to be an appropri=
ate
> +   type.  */
> +#if defined(CONFIG_USER_ONLY)
> +typedef abi_ulong tb_page_addr_t;
> +#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
> +#else
> +typedef ram_addr_t tb_page_addr_t;
> +#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
> +#endif
> +
>  #define CODE_GEN_HTABLE_BITS     15
>  #define CODE_GEN_HTABLE_SIZE     (1 << CODE_GEN_HTABLE_BITS)
>=20=20
> @@ -35,6 +46,7 @@ struct TBContext {
>=20=20
>      /* statistics */
>      unsigned tb_flush_count;
> +    struct qht tb_stats;
>  };
>=20=20
>  extern TBContext tb_ctx;
> diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
> index 805235d321..dd8e8f252a 100644
> --- a/include/exec/tb-hash.h
> +++ b/include/exec/tb-hash.h
> @@ -66,4 +66,11 @@ uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_u=
long pc, uint32_t flags,
>      return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
>  }
>=20=20
> +static inline
> +uint32_t tb_stats_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
> +                            uint32_t flags)
> +{
> +    return qemu_xxhash5(phys_pc, pc, flags);
> +}
> +
>  #endif
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> new file mode 100644
> index 0000000000..898e05a36f
> --- /dev/null
> +++ b/include/exec/tb-stats.h
> @@ -0,0 +1,67 @@
> +/*
> + * QEMU System Emulator, Code Quality Monitor System
> + *
> + * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef TB_STATS_H
> +
> +#define TB_STATS_H
> +
> +#include "exec/cpu-common.h"
> +#include "exec/tb-context.h"
> +#include "tcg.h"
> +
> +typedef struct TBStatistics TBStatistics;
> +
> +/*
> + * This struct stores statistics such as execution count of the
> + * TranslationBlocks. Each sets of TBs for a given phys_pc/pc/flags
> + * has its own TBStatistics which will persist over tb_flush.
> + *
> + * We include additional counters to track number of translations as
> + * well as variants for compile flags.
> + */
> +struct TBStatistics {
> +    tb_page_addr_t phys_pc;
> +    target_ulong pc;
> +    uint32_t     flags;
> +    /* cs_base isn't included in the hash but we do check for matches */
> +    target_ulong cs_base;
> +    /* current TB linked to this TBStatistics */
> +    TranslationBlock *tb;

This seems sketchy to me. The TBStats have a 1 to many relationship so
I'm not sure what this information can be used for.

> +};
> +
> +bool tb_stats_cmp(const void *ap, const void *bp);
> +
> +void init_tb_stats_htable_if_not(void);
> +
> +/* TBStatistic collection controls */
> +enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED=
 };
> +extern int tcg_collect_tb_stats;
> +
> +void enable_collect_tb_stats(void);
> +void disable_collect_tb_stats(void);
> +void pause_collect_tb_stats(void);
> +bool tb_stats_collection_enabled(void);
> +bool tb_stats_collection_paused(void);
> +
> +#endif
> diff --git a/util/log.c b/util/log.c
> index 1d1b33f7d9..393a17115b 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -31,6 +31,8 @@ int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
>=20=20
> +int tcg_collect_tb_stats;
> +
>  /* Return the number of characters emitted.  */
>  int qemu_log(const char *fmt, ...)
>  {


--=20
Alex Benn=C3=A9e

