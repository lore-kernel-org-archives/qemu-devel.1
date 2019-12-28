Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF3CC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 20:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D701207E0
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 20:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpI8MYdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D701207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilJAw-0001LY-Gz
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 15:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJA4-0000qf-PS
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJ9z-0001tB-Fp
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:58:12 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:36379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilJ9z-0001lA-73
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:58:07 -0500
Received: by mail-pf1-x433.google.com with SMTP id x184so16444107pfb.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fHYPKfLLQWAIEkGy5V3bqff0OTSs+G7VIiLlHEJJBb0=;
 b=YpI8MYdlXoWh3mlW7VAY3KSvBBk/tLqCJiwuqfzicxZullm4g6T61WDDvVyJBbxynj
 ul7NPEjrh0ydJtY+5t5s7w2S8TylVuGK5cf+bjmWBHKcaOb8u+ZdR1g6U1OUV9PlKL0c
 vIlnR68teLCKp6WycU6sdc3WcTARIACdnPNeNqTCVMsHNQZ7fod9EU0KlOdkmfFuIMDU
 tOlQXta1rAxLyZJrFq+xmiJe7gq5U3HXPYujhzI1HckRVTZX4QPyJcMsqgWXk4yQiUSH
 jhUfaTeqRRVrD51o48T/PffciEPkyRoedW8/5BqjnDl1GegPj+8CeN9az7FnFV42Tcvx
 5x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fHYPKfLLQWAIEkGy5V3bqff0OTSs+G7VIiLlHEJJBb0=;
 b=SYxGzdeZpm0CmajyguLpTiqG0UqWwjz2uSQN+f41ncOkrgSQSyJrQC6Evz1g9o2hDQ
 j3LbHgNOYCQ+/8EI7OeWMZ7FjaSfUN0mrXzOXWTfrz+JQQrJgNb/rRNfL6izNkVqSS8U
 /hLK1/wB5VaDGFogSgbB0gVDH/UhGl0wAApNisSf0vQ7FYs2vbiyxSe9GQJZuuiQSvZA
 WKLayusqqj5L1uysD18kvN9zYl1NRd7vji2WrwYfHOhc3jHwvsaBjFzFi2KxMnAhQBHR
 SIT6OJ2daBUyxARFkb7QCyaPeRJi9OGZvMfiByQwI7fURO1u+TArHPHnGJSTPmfRsPLE
 31fw==
X-Gm-Message-State: APjAAAVi/6Z3S8BXcNoq1u2aCGSCBWgLPZ5jIJcRtb5+X3IOivB6W6DB
 tfEhpGS3uy8mCKBbQqK70sui1g==
X-Google-Smtp-Source: APXvYqxdq1K3wo7HyS21Q5JDBG2XMZqhbgMe+sElN4IbsC0gYhG96TcZdlJTDrD1zK2tnQZavMjrYA==
X-Received: by 2002:a63:5b0a:: with SMTP id p10mr61587746pgb.228.1577566685508; 
 Sat, 28 Dec 2019 12:58:05 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id r3sm45885495pfg.145.2019.12.28.12.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 12:58:04 -0800 (PST)
Subject: Re: [PATCH v2 06/28] cputlb: Rename helper_ret_ld*_cmmu to
 cpu_ld*_code
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-7-richard.henderson@linaro.org>
 <87tv5udi3q.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7cb3a9ac-7382-dac6-b2d5-a3450d3ff60c@linaro.org>
Date: Sun, 29 Dec 2019 07:58:00 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87tv5udi3q.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 4:25 AM, Alex Bennée wrote:
>> -#define CPU_MMU_INDEX (cpu_mmu_index(env, true))
>> -#define MEMSUFFIX _code
>> -#define SOFTMMU_CODE_ACCESS
>> +uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
>> +uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
>> +uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
>> +uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
>>
>> -#define DATA_SIZE 1
>> -#include "exec/cpu_ldst_template.h"
>> +static inline int cpu_ldsb_code(CPUArchState *env, abi_ptr addr)
>> +{
>> +    return (int8_t)cpu_ldub_code(env, addr);
>> +}
...
>> -uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
>> -                            TCGMemOpIdx oi, uintptr_t retaddr);
>> -int8_t helper_ret_ldsb_cmmu(CPUArchState *env, target_ulong addr,
>> -                            TCGMemOpIdx oi, uintptr_t retaddr);
>> -uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
>> -                             TCGMemOpIdx oi, uintptr_t retaddr);
>> -int16_t helper_le_ldsw_cmmu(CPUArchState *env, target_ulong addr,
>> -                             TCGMemOpIdx oi, uintptr_t retaddr);
>> -uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
>> -                            TCGMemOpIdx oi, uintptr_t retaddr);
>> -uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
>> -                            TCGMemOpIdx oi, uintptr_t retaddr);
>> -uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
>> -                             TCGMemOpIdx oi, uintptr_t retaddr);
>> -int16_t helper_be_ldsw_cmmu(CPUArchState *env, target_ulong addr,
>> -                             TCGMemOpIdx oi, uintptr_t retaddr);
>> -uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
>> -                            TCGMemOpIdx oi, uintptr_t retaddr);
>> -uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
>> -                            TCGMemOpIdx oi, uintptr_t retaddr);
>> -
> <snip>
> 
> Why have we dropped the final type and stuck to uint32/64? Do we rely on
> the caller truncating any data by casting the result of their eventual
> cpu_ldFoo?

I have *preserved* the existing type of cpu_ld*_code(), the actual interface
that is being used.

Cleaning up the load return and store value types is another project.  I would
not limit that to *_code, though.  And I'd want to think of some way to prove
that all callers are getting the promotion that they expected.


r~

