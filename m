Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3303CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BB42070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYjqVSyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BB42070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrYA-0004jx-Iu
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHrVO-0002qx-FY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHrVK-0003FU-4S
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:34:28 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:33781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHrVJ-0003Dp-Nk
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:34:25 -0400
Received: by mail-yb1-xb41.google.com with SMTP id w141so5489633ybe.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=occy/0P0YqklpuNNWMcd2ifDefVYrjnp1F8NovR6F2A=;
 b=BYjqVSyC8V8tjaiiAepu94yeVbJ3drkACu1ytt7MemGjTBgHKsXfVNnrVF+ajzKRqp
 rZGtuTbvp3sYWxT4YhZqNXFujv23TwnwaU5/FyfKJzqdwlJ73zMYhYQTg44cGmc6/08f
 71R2x8EYR2zipHPaWij53/JGAq7ehq6jqeGyWf+sj204+BjghM88PURrr+52Zz6ZlE7i
 7KRBaL1frY9YYMV5JJmE7p5/lkc8RR8zkb1yQbTzydxYCOUMoW18MN1IU3A6rGKZVElV
 2m6lgxRgljSIdg7ZMlPtDPqbpvvfqcGMkQE5mPMv7Z0Fh1Bgwb1/hI2D1QFlClweSxKO
 p86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=occy/0P0YqklpuNNWMcd2ifDefVYrjnp1F8NovR6F2A=;
 b=j13TLfI4t/ewpsVPAhP1k89BOLwnm5J9ygziM8RPWIfQLD+xV/Cp2KpskJ5qIaRNQr
 r/zAxpFRcRcUzujH87fi3cfADu86ceDtOezdI8RrgxFrMaVo8r83Tc2v6zLh+rcIVm5n
 TNHpb483iYcMhWChwrq3S6bEs2lHfyVR5v4G2YowbMYcZjn0671AJQ8YTmKmCrJDyYUK
 ngz2NNSI7SoQLIjtsY8VnD2NKmUwm8eetvoNkff1QC3y8yoz1+SRcZj9qPk5jUT4GdtG
 V6mdTAgUeSeEEpCb5ZAbhJMpeKJ9w7cFmTAx1/2DhqqSDP89q/sXpv2LE1fCPhyCeZtR
 ZlAg==
X-Gm-Message-State: APjAAAVPRQM5zTQBzzaOk1mF1RKnuKBfhXU6pdJtdjefINymqrCqPsIV
 VpW9j3M5NPQjLTSJfK6kMG79nw==
X-Google-Smtp-Source: APXvYqyuyrzZrq8g64Z9HiogzA9LTPIPbsXzZQ4HyZ6jmcJqY0QKeSVv4xfUxmDR9AUh3Y+VPsODhQ==
X-Received: by 2002:a05:6902:4d1:: with SMTP id
 v17mr15357018ybs.398.1570548864652; 
 Tue, 08 Oct 2019 08:34:24 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id p10sm4639574ywc.19.2019.10.08.08.34.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 08:34:23 -0700 (PDT)
Subject: Re: [PATCH v9 06/13] debug: add -d tb_stats to control TBStatistics
 collection:
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <174fe11d-e3f5-011b-0beb-b3c237d0d9e6@linaro.org>
Date: Tue, 8 Oct 2019 11:34:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
>  -d tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]
> 
> "dump_limit" is used to limit the number of dumped TBStats in
> linux-user mode.
> 
> [all+jit+exec+time] control the profilling level used
> by the TBStats. Can be used as follow:
> 
> -d tb_stats
> -d tb_stats,level=jit+time
> -d tb_stats,dump_limit=15
> ...
> 
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-7-vandersonmr2@gmail.com>
> [AJB: fix authorship, reword title]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> AJB:
>   - reword title
>   - add stubs for enabling
>   - move things across to tb-stats-flags.h
> ---
>  accel/tcg/tb-stats.c          |  5 +++++
>  include/exec/gen-icount.h     |  1 +
>  include/exec/tb-stats-flags.h | 29 +++++++++++++++++++++++++++++
>  include/exec/tb-stats.h       | 16 +++-------------
>  include/qemu/log.h            |  1 +
>  stubs/Makefile.objs           |  1 +
>  stubs/tb-stats.c              | 27 +++++++++++++++++++++++++++
>  util/log.c                    | 35 +++++++++++++++++++++++++++++++++++
>  8 files changed, 102 insertions(+), 13 deletions(-)
>  create mode 100644 include/exec/tb-stats-flags.h
>  create mode 100644 stubs/tb-stats.c
> 
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index f431159fd2..1c66e03979 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -193,3 +193,8 @@ uint32_t get_default_tbstats_flag(void)
>  {
>      return default_tbstats_flag;
>  }
> +
> +void set_default_tbstats_flag(uint32_t flags)
> +{
> +    default_tbstats_flag = flags;
> +}
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
> index 0000000000..8455073048
> --- /dev/null
> +++ b/include/exec/tb-stats-flags.h
> @@ -0,0 +1,29 @@
> +/*
> + * QEMU System Emulator, Code Quality Monitor System
> + *
> + * We define the flags and control bits here to avoid complications of
> + * including TCG/CPU information in common code.
> + *
> + * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef TB_STATS_FLAGS
> +#define TB_STATS_FLAGS
> +
> +#define TB_NOTHING    (1 << 0)

Repeating my question about TB_NOTHING -- what is it?

> +#define TB_EXEC_STATS (1 << 1)
> +#define TB_JIT_STATS  (1 << 2)
> +#define TB_JIT_TIME   (1 << 3)
> +
> +/* TBStatistic collection controls */
> +void enable_collect_tb_stats(void);
> +void disable_collect_tb_stats(void);
> +void pause_collect_tb_stats(void);
> +bool tb_stats_collection_enabled(void);
> +bool tb_stats_collection_paused(void);
> +
> +uint32_t get_default_tbstats_flag(void);
> +void set_default_tbstats_flag(uint32_t);

Is a get/set really better than an exported variable?

Should we have created this header in the first place,
rather than moving stuff here in patch 6?


> +        } else if (g_str_has_prefix(*tmp, "tb_stats")) {
> +            mask |= CPU_LOG_TB_STATS;
> +            set_default_tbstats_flag(TB_JIT_STATS | TB_EXEC_STATS | TB_JIT_TIME);

Surely TB_ALL_STATS?

> +                } else if (g_str_equal(*level_tmp, "all")) {
> +                    flags |= TB_JIT_STATS | TB_EXEC_STATS | TB_JIT_TIME;

Likewise.


r~

