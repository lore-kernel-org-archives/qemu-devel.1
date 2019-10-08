Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ED5C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11534206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="piv/1ZS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11534206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrkB-0001de-3U
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHrj1-00016q-CN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHriz-0006mc-Vo
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:48:35 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:41982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHriz-0006mG-Q3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:48:33 -0400
Received: by mail-yb1-xb42.google.com with SMTP id 206so6051855ybc.8
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SdlX0MnUUKFPpByZjO+PoHNbhQAi/bKNoAnDjis9Dio=;
 b=piv/1ZS18g5RG5dcvKFSKBK81QgEjt9SfoHR0KNy+0/bkq9VB6qF4hIl1Hlto24iBq
 U+WQqlJ69AtqZ+gY3NWbzR5h+XfiZSFx2h6naB2klvnwF4rPomOmE3N9wTwBpyymsl9M
 O32ex7kwQEs+KyuPNc07f52meDDvoNcYKbOxGku2gRuPjk5P4zWmfcjU+XwXNiDO7r9A
 mDGW77aDLQPvQ5eeXdruu9rzsXvhE8jNbM8CjK522rR3QgZwTHUm038oMKIh4KJ+dxg5
 /ypEZmEUnFd+ew4c7t+aqdXV+Pig5HJ3BswReTaYptTzqqb80EYKll9H1WQOiWgVGwM6
 6waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdlX0MnUUKFPpByZjO+PoHNbhQAi/bKNoAnDjis9Dio=;
 b=kDGi4Hkx93JwvAzR97IGO+DyS3+9YEb3Htx8IunE9WXidukrHI52IUpKN9ckwnfXoz
 QI+M/AShuAepNFPP5rfIG6uSSNp7tmu46ou+Ncfu2dDjMB6hjvXS25bhkHDd4q0YkPHf
 G8zIZnETDHFBfCXkwRTfvRPyDJaOe6edWIFM/fkOrQWJ6DYPIYJ1PFkaKMTzbQ90GZrP
 jyAXEFeFT6tFEp3BWjfeb6BqkA+K/GePnKA8IrYa6IU2l0TK1YqsGKgQerEYm5YtZtKU
 ewhSrZqtC7hcURR1JMgwATydUrqKniigM9bYw3rI5p7e73GTzVzrXovAzq/3+HdyJUzo
 IEgw==
X-Gm-Message-State: APjAAAW96HEoyqJHeWi+FLobPNuXUcbqjZOGixm97wtvuxRu9tTuydEI
 mNRD49e/5GKjugmO9w/bp94KOg==
X-Google-Smtp-Source: APXvYqwctCHONaOEIDO+HJH4CaBqnSqr3MSzvH6k/2cfpaUQPCPsUaT7LKz2Vk7FDevyVHy3N7w9Ng==
X-Received: by 2002:a25:da0c:: with SMTP id n12mr15254483ybf.160.1570549712688; 
 Tue, 08 Oct 2019 08:48:32 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id v8sm4849092ywg.91.2019.10.08.08.48.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 08:48:31 -0700 (PDT)
Subject: Re: [PATCH v9 07/13] monitor: adding tb_stats hmp command
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a93808e3-ce65-765f-f2fa-cfe341fb0ec4@linaro.org>
Date: Tue, 8 Oct 2019 11:48:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> Adding tb_stats [start|pause|stop|filter] command to hmp.
> This allows controlling the collection of statistics.
> It is also possible to set the level of collection:
> all, jit, or exec.
> 
> tb_stats filter allow to only collect statistics for the TB
> in the last_search list.
> 
> The goal of this command is to allow the dynamic exploration
> of the TCG behavior and quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
> 
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-8-vandersonmr2@gmail.com>
> [AJB: fix authorship]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> monitor: add tb_stats [start|pause|stop|filter] command to hmp.
> 
> This allows controlling the collection of statistics.
> It is also possible to set the level of collection:
> all, jit, or exec.
> 
> tb_stats filter allow to only collect statistics for the TB
> in the last_search list.
> 
> The goal of this command is to allow the dynamic exploration
> of the TCG behavior and quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
> 
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Message-Id: <20190829173437.5926-9-vandersonmr2@gmail.com>
> [AJB: fix authorship]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

Duplicated commit message contents.

> +void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)

Deserves a comment "Run via async_safe_run_on_cpu", as otherwise the "safe"
part of the function name is fairly obscure.

> +    char *slevel = (char *) qdict_get_try_str(qdict, "level");
> +    uint32_t level = TB_EXEC_STATS | TB_JIT_STATS | TB_JIT_TIME;
> +    if (slevel) {
> +        if (strcmp(slevel, "jit") == 0) {
> +            level = TB_JIT_STATS;
> +        } else if (strcmp(slevel, "exec") == 0) {
> +            level = TB_EXEC_STATS;
> +        } else if (strcmp(slevel, "time") == 0) {
> +            level = TB_JIT_TIME;
> +        }
> +    }

No support for "+" or "all" as we do for the command-line?


> +static void reset_tbstats_flag(void *p, uint32_t hash, void *userp)
> +{
> +    uint32_t flag = *((int *)userp);

Type cast doesn't match...

> +    TBStatistics *tbs = p;
> +    tbs->stats_enabled = flag;
> +}
> +
> +void set_tbstats_flags(uint32_t flag)
> +{
> +    /* iterate over tbstats setting their flag as TB_NOTHING */
> +    qht_iter(&tb_ctx.tb_stats, reset_tbstats_flag, &flag);
> +}

... here.

It does make me wonder if you'd do just as well with (void *)(uintptr_t)flag
and avoid the indirection.  It is an opaque quantity shared only between these
two functions.


>  static void hmp_info_profile(Monitor *mon, const QDict *qdict)
>  {
> +#ifdef CONFIG_TCG
>      dump_jit_exec_time_info(dev_time);
>      dev_time = 0;
> +#else
> +    error_report("TCG should be enabled!");
> +#endif
>  }
>  
>  /* Capture support */
> diff --git a/vl.c b/vl.c
> index f91bc6fb4c..781fddaf18 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1796,11 +1796,17 @@ static bool main_loop_should_exit(void)
>  
>  static void main_loop(void)
>  {
> +#ifdef CONFIG_TCG
>      uint64_t ti;
> +#endif
>      while (!main_loop_should_exit()) {
> +#ifdef CONFIG_TCG
>          ti = profile_getclock();
> +#endif
>          main_loop_wait(false);
> +#ifdef CONFIG_TCG
>          dev_time += profile_getclock() - ti;
> +#endif
>      }
>  }

All of this was CONFIG_PROFILE just a few patches ago.  If you need this, then
you broke bisection with !defined(CONFIG_TCG) a few patches ago.


r~

