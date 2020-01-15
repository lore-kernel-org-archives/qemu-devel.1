Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78027C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFE322522
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUO/M/KJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFE322522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqWD-0004HT-W3
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 16:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irqV5-0003MP-72
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irqV3-00005m-QJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:46:54 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irqV3-00004z-J8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:46:53 -0500
Received: by mail-pj1-x1044.google.com with SMTP id s7so545115pjc.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 13:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bRHxtr/gEoRmIvcSsH4ljVDo6r+lSxazyG4v9oNPHvM=;
 b=hUO/M/KJVduBZNvdSfBtQ+s9JuVJpOv3oNUzT05nrIInQn4IPDoUTb4oOKzBrKCtV+
 436wk2H2fkDNat0ZO0uKteqd8VwfsjJIqKtS24WDWUn4Q5g7WgjtXZoLOFOEsM3lMb6V
 xA9PRJmw/gypJSy0e4VF2jwoNAVSz7f7HHNfdLz4xuOapQayY8KiqUn2YEZaaNOLtMtF
 ZpYHUyDLoWLOT2xlcQwR2w4ChNZCPwjK/2/5sEC3uHG8S16tDZnsqds0NqQDvoxElloe
 /XPoleB94rvm6ZaTN5/mmXApUtMFRLKLD78h6VXEiQkH28MDjtHucGS0f2PT6Oak0+x2
 7w+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bRHxtr/gEoRmIvcSsH4ljVDo6r+lSxazyG4v9oNPHvM=;
 b=rp9H3PFm51qfu9noYubQcl36bO97r+yc0Hgmd2JrBMD9ZE+98lIQ5jFV3SsBDBRLTf
 MCUJ4P/VKBoWr0N9fFyJcq9BTPtq+q/I7rNKnkAsA+w3qT6igS1BDwTZ5JsXWi69TIgY
 k787LUTKvAgKiud2AUrr3F4hjd9UuzMhhF84KIUsHvalhGC1i2wyQyBgrz74w8CsP/JN
 OmyJW1oJTse6MCOJ/diiUM1gCwsbjkVa+Zfiblg6filnIvua5nEyhubSkFAqK/1qiEzz
 +GLL6po4plH0l7jbd8bosFDDDILemkelKo20Aa6FUMvjqk5HSvAKuy+z0w1XoO4+LCSV
 MDuQ==
X-Gm-Message-State: APjAAAUVn5VEnPAskJZ6B/tjRJMTxzGs5NIBsXq53isYDMuRVgQ9zad1
 ONAsf67QyIvYiYgwReYkBiy2zw==
X-Google-Smtp-Source: APXvYqzDg/6J39JZiH1htlFNt5qhLvP1t52CKHLoU+RiLrApl81zuSfpC1NHIddANtKmgAg3SbjvBg==
X-Received: by 2002:a17:90a:d34c:: with SMTP id
 i12mr2519102pjx.18.1579124812061; 
 Wed, 15 Jan 2020 13:46:52 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id p5sm21570504pgs.28.2020.01.15.13.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 13:46:51 -0800 (PST)
Subject: Re: [PATCH v3 1/3] target/riscv: Fix tb->flags FS status
To: Alistair Francis <alistair23@gmail.com>, shihpo.hung@sifive.com
References: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
 <CAKmqyKNeAFRP7eCLtw1b0P53ub3k--+dROpPRynzCwM8DF15ng@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d63e90b-0779-6432-3a35-1b759f5ae279@linaro.org>
Date: Wed, 15 Jan 2020 11:46:47 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNeAFRP7eCLtw1b0P53ub3k--+dROpPRynzCwM8DF15ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 8:28 PM, Alistair Francis wrote:
> On Wed, Jan 15, 2020 at 4:18 PM <shihpo.hung@sifive.com> wrote:
>>
>> It was found that running libquantum on riscv-linux qemu produced an
>> incorrect result. After investigation, FP registers are not saved
>> during context switch due to incorrect mstatus.FS.
>>
>> In current implementation tb->flags merges all non-disabled state to
>> dirty. This means the code in mark_fs_dirty in translate.c that
>> handles initial and clean states is unreachable.
>>
>> This patch fixes it and is successfully tested with:
>>   libquantum
>>
>> Thanks to Richard for pointing out the actual bug.
>>
>> v3: remove the redundant condition
>> v2: root cause FS problem
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/riscv/cpu.h | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index e59343e..de0a8d8 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -293,10 +293,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>>  #ifdef CONFIG_USER_ONLY
>>      *flags = TB_FLAGS_MSTATUS_FS;
>>  #else
>> -    *flags = cpu_mmu_index(env, 0);
>> -    if (riscv_cpu_fp_enabled(env)) {
>> -        *flags |= TB_FLAGS_MSTATUS_FS;
>> -    }
>> +    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> 
> I don't think this is right, you should use the riscv_cpu_fp_enabled() function.
> 
> Right now it's the same as env->mstatus & MSTATUS_FS but when the
> Hypervisor extension goes in riscv_cpu_fp_enabled() will be more
> complex.

Hmm.  Are you sure something like

  flags |= riscv_cpu_effective_mstatus(env) & MSTATUS_FS;

wouldn't be more appropriate for the hypervisor extension?

I guess I should have another browse through your hv patchset, but I worry now
about bare uses of env->mstatus, if they no longer mean what they appear to mean.


r~

