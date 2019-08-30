Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B809AC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBEB20659
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThXYR2h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBEB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3iE0-0007WP-BP
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 10:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3iA8-0005Bt-Lu
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3i9b-0001QC-Gr
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:45:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3i9b-0001Ky-41
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:45:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id y19so7263192wrd.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2TX+CsptW3pfviH7DKjQlYteCYje1wFcaKP7IlHfQY4=;
 b=ThXYR2h1uxZ5sjCvHDi5RbbHM2FtFmWMD0wC7wA8omTOztJmajqY0jcJWduJSYap7P
 LJ1uQxXMDCTrNNyoMNd7qI/CUTbazGMxe2eSqVH5183s9GYuyVpfPiw9FubCBCfLsPtY
 uENzKuRMB7s4mOt33mTVv6Rq4S3Jw3wMc+9CiokY4Fe/fdxZdj/g0oV2/DfQD2Q19cfb
 7FQyhjsRSlMh2nfaOGpn8YYdJiXKwq1I9pTnD60q67IT99LNLC3maLIa4pqpH2qLVbg+
 0l4gX6mYbe4Z7BomosRTjPvnlmxbH3WaAdc3Kb99kQ2ilF+KpI7+IOqfZAGH8AFVknFB
 7Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2TX+CsptW3pfviH7DKjQlYteCYje1wFcaKP7IlHfQY4=;
 b=NF75Fx0gMUpbIprE40iOO3ISStXi24l6mPhaUQpjHNY4F7DdlQh4kbZ7cqsYBqWQ+h
 rvEoGRfAWr8VXbHpbKt/aF7BXU2mVuCchfzxSgv0NO2CaDKEfmVXA+pHJy5lOCXtOsU+
 wYNiqyWX4mRLFyX+z4xuYB1t2jAz5LNMyKnI8TrmdzUywY5aVRnWCRIqhb4IrgxpZ5fL
 /bpzW/wIUQlJLNJSTOxHDYSzbjh1BsNRlC45wYRZTHcOoFKivR0GdS0nsU2ufF0fo7Jq
 v6KMC/4Sd+JffHbcwzIRPpIJAP6iE3OYfSZb5g8ru01Ae/F9Jhn9MSKUVc+0kTt2F3t6
 E0BA==
X-Gm-Message-State: APjAAAV/AKOc8ginCBc6IPPprvqqTG6ADzbn74n2eWu/PEFnDXYhVZwB
 NlOXlMZN0Yjr5KiD45JB2fsxow==
X-Google-Smtp-Source: APXvYqw5AUaVIOTe8UDveQmTCPqbnQK4dydqSi1lcZAUgMStiqCOycv+cZLci9nuwU5ROASfQK+lEQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr3798474wrq.238.1567176328940; 
 Fri, 30 Aug 2019 07:45:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f23sm8058484wmj.37.2019.08.30.07.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 07:45:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 752941FF87;
 Fri, 30 Aug 2019 15:45:27 +0100 (BST)
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-7-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190829173437.5926-7-vandersonmr2@gmail.com>
Date: Fri, 30 Aug 2019 15:45:27 +0100
Message-ID: <87v9ue7lvc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v8 06/11] Adding -d tb_stats to control
 TBStatistics collection:
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

>  -d tb_stats[[,level=3D(+all+jit+exec+time)][,dump_limit=3D<number>]]
>
> "dump_limit" is used to limit the number of dumped TBStats in
> linux-user mode.
>
> [all+jit+exec+time] control the profilling level used
> by the TBStats. Can be used as follow:
>
> -d tb_stats
> -d tb_stats,level=3Djit+time
> -d tb_stats,dump_limit=3D15
> ...
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  include/exec/gen-icount.h     |  1 +
>  include/exec/tb-stats-flags.h | 42 +++++++++++++++++++++++++++++++++++
>  include/exec/tb-stats.h       | 18 +++------------
>  include/qemu/log.h            |  1 +
>  util/log.c                    | 35 +++++++++++++++++++++++++++++
>  5 files changed, 82 insertions(+), 15 deletions(-)
>  create mode 100644 include/exec/tb-stats-flags.h
>
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index be006383b9..3987adfb0e 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -2,6 +2,7 @@
>  #define GEN_ICOUNT_H
>
>  #include "qemu/timer.h"
> +#include "tb-stats-flags.h"
>
>  /* Helpers for instruction counting code generation.  */
>
> diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
> new file mode 100644
> index 0000000000..c936ac1084
> --- /dev/null
> +++ b/include/exec/tb-stats-flags.h
> @@ -0,0 +1,42 @@
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

Any reason not to use GPLv2 or later here?

> + */
> +#ifndef TB_STATS_FLAGS
> +#define TB_STATS_FLAGS
> +
> +enum TBStatsStatus {
> +    TB_STATS_DISABLED =3D 0,
> +    TB_STATS_RUNNING,
> +    TB_STATS_PAUSED,
> +    TB_STATS_STOPPED
> +};
> +
> +#define TB_NOTHING    (1 << 0)
> +#define TB_EXEC_STATS (1 << 1)
> +#define TB_JIT_STATS  (1 << 2)
> +#define TB_JIT_TIME   (1 << 3)
> +
> +extern int tcg_collect_tb_stats;
> +extern uint32_t default_tbstats_flag;
> +
> +#endif
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 0b9a6e2f72..6a53bef31b 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -30,6 +30,8 @@
>  #include "exec/tb-context.h"
>  #include "tcg.h"
>
> +#include "exec/tb-stats-flags.h"
> +
>  #define tb_stats_enabled(tb, JIT_STATS) \
>      (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
>
> @@ -98,26 +100,12 @@ bool tb_stats_cmp(const void *ap, const void *bp);
>
>  void dump_jit_exec_time_info(uint64_t dev_time);
>
> +void set_tbstats_flags(uint32_t flags);
>  void init_tb_stats_htable_if_not(void);
>
>  void dump_jit_profile_info(TCGProfile *s);
>
>  /* TBStatistic collection controls */
> -enum TBStatsStatus {
> -    TB_STATS_DISABLED =3D 0,
> -    TB_STATS_RUNNING,
> -    TB_STATS_PAUSED,
> -    TB_STATS_STOPPED
> -};
> -
> -#define TB_NOTHING    (1 << 0)
> -#define TB_EXEC_STATS (1 << 1)
> -#define TB_JIT_STATS  (1 << 2)
> -#define TB_JIT_TIME   (1 << 3)
> -
> -extern int tcg_collect_tb_stats;
> -extern uint32_t default_tbstats_flag;
> -
>  void enable_collect_tb_stats(void);
>  void disable_collect_tb_stats(void);
>  void pause_collect_tb_stats(void);
> diff --git a/include/qemu/log.h b/include/qemu/log.h
> index b097a6cae1..a8d1997cde 100644
> --- a/include/qemu/log.h
> +++ b/include/qemu/log.h
> @@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
>  /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
>  #define CPU_LOG_TB_OP_IND  (1 << 16)
>  #define CPU_LOG_TB_FPU     (1 << 17)
> +#define CPU_LOG_TB_STATS   (1 << 18)
>
>  /* Lock output for a series of related logs.  Since this is not needed
>   * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
> diff --git a/util/log.c b/util/log.c
> index 29021a4584..c3805b331b 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -19,17 +19,20 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/qemu-print.h"
>  #include "qemu/range.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "trace/control.h"
> +#include "exec/tb-stats-flags.h"
>
>  static char *logfilename;
>  FILE *qemu_logfile;
>  int qemu_loglevel;
>  static int log_append =3D 0;
>  static GArray *debug_regions;
> +int32_t max_num_hot_tbs_to_dump;
>
>  int tcg_collect_tb_stats;
>  uint32_t default_tbstats_flag;
> @@ -276,6 +279,9 @@ const QEMULogItem qemu_log_items[] =3D {
>      { CPU_LOG_TB_NOCHAIN, "nochain",
>        "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
>        "complete traces" },
> +    { CPU_LOG_TB_STATS, "tb_stats[[,level=3D(+all+jit+exec+time)][,dump_=
limit=3D<number>]]",
> +      "enable collection of TBs statistics"
> +      "(and dump until given a limit if in user mode).\n" },
>      { 0, NULL, NULL },
>  };
>
> @@ -297,6 +303,35 @@ int qemu_str_to_log_mask(const char *str)
>              trace_enable_events((*tmp) + 6);
>              mask |=3D LOG_TRACE;
>  #endif
> +        } else if (g_str_has_prefix(*tmp, "tb_stats")) {
> +            mask |=3D CPU_LOG_TB_STATS;
> +            default_tbstats_flag =3D TB_JIT_STATS | TB_EXEC_STATS | TB_J=
IT_TIME;
> +            tcg_collect_tb_stats =3D TB_STATS_RUNNING;
> +        } else if (tcg_collect_tb_stats =3D=3D TB_STATS_RUNNING &&
> +                g_str_has_prefix(*tmp, "dump_limit=3D")) {
> +
> +            max_num_hot_tbs_to_dump =3D atoi((*tmp) + 11);
> +        } else if (tcg_collect_tb_stats =3D=3D TB_STATS_RUNNING &&
> +                g_str_has_prefix(*tmp, "level=3D")) {
> +
> +            default_tbstats_flag =3D 0;
> +            char **level_parts =3D g_strsplit(*tmp + 6, "+", 0);
> +            char **level_tmp;
> +            for (level_tmp =3D level_parts; level_tmp && *level_tmp; lev=
el_tmp++) {
> +                if (g_str_equal(*level_tmp, "jit")) {
> +                    default_tbstats_flag |=3D TB_JIT_STATS;
> +                } else if (g_str_equal(*level_tmp, "exec")) {
> +                    default_tbstats_flag |=3D TB_EXEC_STATS;
> +                } else if (g_str_equal(*level_tmp, "time")) {
> +                    default_tbstats_flag |=3D TB_JIT_TIME;
> +                } else if (g_str_equal(*level_tmp, "all")) {
> +                    default_tbstats_flag |=3D TB_JIT_STATS | TB_EXEC_STA=
TS | TB_JIT_TIME;
> +                } else {
> +                    fprintf(stderr, "no option level=3D%s, valid options=
 are:"
> +                            "all, jit, exec or/and time\n", *level_tmp);
> +                    exit(1);

You can't exit here - for one thing a typo on the HMP will kill your
machine. You should pass Error **err to the helper and use error_setg to
report the failure.

From vl.c/main.c you can pass &error_fatal and it will report and
error out as you expect.

From the HMP hooks:

    Error *err =3D NULL;

    ...
    qemu_str_to_log_mask(flags, &err)
    ...
    if (err) {
        hmp_handle_error(mon, &err);
        return;
    }

You'll need to fix up the existing calls to do this instead of the if
!mask error_report they currently do.


> +                }
> +            }
>          } else {
>              for (item =3D qemu_log_items; item->mask !=3D 0; item++) {
>                  if (g_str_equal(*tmp, item->name)) {


--
Alex Benn=C3=A9e

