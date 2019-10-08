Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E5C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF6A20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iD+1gII3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF6A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpj8-0001lZ-FR
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHphU-0000X9-A7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHphS-00084u-Oy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:38:51 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:37527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHphS-00083V-Iu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:38:50 -0400
Received: by mail-yw1-xc44.google.com with SMTP id m7so6437673ywe.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VW4tEZruyzprI7t2CjlEklhngXvOdD9HnD2FgB1/ah0=;
 b=iD+1gII3GdoykZrxTJAd8Ur+/9DRqgIntJ7oOV29LejU7yVDwmwxzfmpMRpHYu9YLS
 6K4jV4wqbi4jtNvJU1DB71EsJznlDuBzYAZNwVyLY/Ozc7czeNJdNHBzUEjZRr4rSilE
 JK9NOmcWm/0OT6N4P9xusqMI6lg3QcFveO1NayY9GFU0wwihVtstbM1otUCv8c79FwGa
 ZTVMgnb1Kmcy4dcghsG+kvOCP+s95pjSn6xeWF3ZBdBcfD4iFuRqOtstcXQYIIJtRLKu
 oJuACjv1IfqSGBC4/O3n1aUX8mPMAouhK5xrzskyEAv8qelEk1dkym+fQSA2Hy7zckZV
 8+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VW4tEZruyzprI7t2CjlEklhngXvOdD9HnD2FgB1/ah0=;
 b=ARGXnDBv1Jj7HllmhG0Acrv7U4itjC+C9aqhDzNiXavPVgKnCWhE0QoH1p8W4zA8IR
 V5POlzTD5TAtO7AaX3f+Azgvzhg9vE1YVys9oG+NgNTKfDnSx8WrxFU7AhNqtDg9y6Sc
 mmYTk0rW2mlXFp0Bw3j+AhPFQ9W1/QJaGVMnb7nrqee1UBmECDfZ5FYJvQ15Zw0e7l92
 d71PBTbYm+w+NjJtnNuUooBqjv0LXQvVJ/mIToqsqq0wyeN5IISNxdeBHL3SprNM9KeH
 PTWGUwb6wHqvYGHH3/4NncVwuZlRVpuUSm30UmsUcK61nZFxslvdohDccNPZ31L2eZtd
 apDg==
X-Gm-Message-State: APjAAAV2VMSwcQICNqWbnZr9ujZ+RWRFLFClA3nx5CYrqEy6rSKh5s5I
 rYk01P0XIjZRoEQpbosdi0Jncg==
X-Google-Smtp-Source: APXvYqxJxK+t38FH60piWP4pMb+d83o8XmKp66Qjbxqa3PD/uVHrsF2gfowHsu7nEYYx2QxFsTNyIw==
X-Received: by 2002:a81:4895:: with SMTP id
 v143mr24170975ywa.154.1570541929405; 
 Tue, 08 Oct 2019 06:38:49 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id u138sm4435882ywf.7.2019.10.08.06.38.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 06:38:48 -0700 (PDT)
Subject: Re: [PATCH v9 03/13] accel: collecting JIT statistics
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c9b4b7e3-9ba3-f40f-7ef3-eb2a34290f82@linaro.org>
Date: Tue, 8 Oct 2019 09:38:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
> @@ -1795,6 +1799,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>          if (flag & TB_EXEC_STATS) {
>              tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
>          }
> +
> +        if (flag & TB_JIT_STATS) {
> +            tb->tb_stats->stats_enabled |= TB_JIT_STATS;
> +        }

So, assuming that you really meant this, and not replacing as I was guessing vs
patch 2, then this is

    tb->tb_stats->stats_enabled |=
        flag & (TB_EXEC_STATS | TB_JIT_STATS);

But I still think it's weird to be wanting to modify the shared structure.
What does that mean for concurrent code generation?

> +    /*
> +     * Collect JIT stats when enabled. We batch them all up here to
> +     * avoid spamming the cache with atomic accesses
> +     */
> +    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
> +        TBStatistics *ts = tb->tb_stats;
> +        qemu_mutex_lock(&ts->jit_stats_lock);
> +
> +        ts->code.num_guest_inst += prof->translation.nb_guest_insns;
> +        ts->code.num_tcg_ops += prof->translation.nb_ops_pre_opt;
> +        ts->code.num_tcg_ops_opt += tcg_ctx->nb_ops;
> +        ts->code.spills += prof->translation.nb_spills;
> +        ts->code.out_len += tb->tc.size;
> +
> +        ts->translations.total++;
> +        if (phys_page2 != -1) {
> +            ts->translations.spanning++;
> +        }
> +
> +        g_ptr_array_add(ts->tbs, tb);
> +
> +        qemu_mutex_unlock(&ts->jit_stats_lock);
> +    }

Hmm.  So we're to interpret all of code.field as sums, the average of which can
be obtained by dividing by translations.total.  Ok, but that should probably be
mentioned in a comment in/near the structure definition.

What are we planning to do with the set of all tb's collected here?

> @@ -3125,6 +3126,7 @@ static void temp_sync
>          case TEMP_VAL_REG:
>              tcg_out_st(s, ts->type, ts->reg,
>                         ts->mem_base->reg, ts->mem_offset);
> +            s->prof.translation.nb_spills++;
>              break;
>  
>          case TEMP_VAL_MEM:

This is not a spill in the common compiler definition.

This is "write the temp to its backing storage".  While this does happen in the
course of spilling, the vast majority of these are because we've finished
modifying a global temp and must now update memory.  Which is not nearly the
same thing as "spill".

A spill in the compiler definition happens in tcg_reg_alloc, right after the
comment "We must spill something".  ;-)


r~

