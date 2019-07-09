Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A4C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2428B20645
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4BLVdXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2428B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknCp-0008NT-NI
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56060)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hknAx-0007jA-0P
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hknAu-0003XD-W1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:16:42 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hknAu-0003WC-OH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:16:40 -0400
Received: by mail-io1-xd43.google.com with SMTP id g20so20836551ioc.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N/zqEfHweZpvWhYqszDyHO6ksEGHkIX6yNDAbrcEfvo=;
 b=j4BLVdXEeznO7Y6oDtfOW+xqq93GqxPuAI5llcWf6NAwwXqx0QD9s09XDnl/W0u4jQ
 pycMryM8XL/9GVngK5pb5Y8RrGVaYKmVfCjst0TJ3WkoKJSRY1Ishv3X9NojnhynUSU/
 FKVk4X26ssNwhAXeyQcjCm7U/s10fJd4lADLJWpwHnrZjrYlD3AVJ+kqgLvotDuQ7k64
 dBwxH2jcjamW1IoOzCzYowjQk/wr8aFpYGbcKK7Nk1v0p5i0HbN9G904D4sOS8Bovqrm
 eflIuvcvVls2oLrBUrEqQvD6XIvvvD0sxNBXqJVMDn6H5dcFgP7qNiJYpggFnkK2eNj3
 1iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N/zqEfHweZpvWhYqszDyHO6ksEGHkIX6yNDAbrcEfvo=;
 b=gPBdC+3jFCzJrr2IyjgZCcfLY9/5T9coh1clDUrI/S8Rg9UQBYOWdaaa3Y1J3zYLjb
 XZ9j9ioaD0xK+TwundxtSp/saj0EAChiZXGWelLULaas7zAiezlZgIB8eQWDn1ndNdUC
 qDiSG/If/xnZjKvzLfau14kpnMez2+qImE+Nq0JPULMtRedF3/hTeI+9FI0GfGA5bvfY
 EmRbNUnDpOtWi+NZoBAmrn2qR+dGcW2ogascMCb+GVP3wggLueVhkg8p/cj6ViNFfBWm
 6Qfq4OqmOwuKWjRD/bSRJ8x6rckudp3ddvb4sWPoDvgIVohzwLDyqG1VMH+Et5uFDqFu
 kzDA==
X-Gm-Message-State: APjAAAWnAuiq9sQsI2vVlke6jpe1jkyDbZZZ9bF00G+x0SyFIQezkdHY
 qZvhTDnY3J41b/6YIh3RNJrOfw==
X-Google-Smtp-Source: APXvYqy51j+OSm5Mjjq75foMFG9254K1TZ1KH+hVdXJavlzjSS91gpwtQyy7SE9gVx33RYWiyy+UoQ==
X-Received: by 2002:a6b:4107:: with SMTP id n7mr1614788ioa.12.1562667399447;
 Tue, 09 Jul 2019 03:16:39 -0700 (PDT)
Received: from [192.168.43.94] ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id q22sm16486996ioj.56.2019.07.09.03.16.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 03:16:38 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190709092049.13771-1-richard.henderson@linaro.org>
 <20190709092049.13771-3-richard.henderson@linaro.org>
 <87zhlned2x.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ae07033e-a29c-7419-09e0-703212d228a0@linaro.org>
Date: Tue, 9 Jul 2019 12:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <87zhlned2x.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH 2/5] tcg: Introduce set/clear_helper_retaddr
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 12:07 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> At present we have a potential error in that helper_retaddr contains
>> data for handle_cpu_signal, but we have not ensured that those stores
>> will be scheduled properly before the operation that may fault.
>>
>> It might be that these races are not in practice observable, due to
>> our use of -fno-strict-aliasing, but better safe than sorry.
>>
>> Adjust all of the setters of helper_retaddr.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/exec/cpu_ldst.h                   | 20 +++++++++++
>>  include/exec/cpu_ldst_useronly_template.h | 12 +++----
>>  accel/tcg/user-exec.c                     | 11 +++---
>>  target/arm/helper-a64.c                   |  8 ++---
>>  target/arm/sve_helper.c                   | 43 +++++++++++------------
>>  5 files changed, 57 insertions(+), 37 deletions(-)
>>
>> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
>> index a08b11bd2c..9de8c93303 100644
>> --- a/include/exec/cpu_ldst.h
>> +++ b/include/exec/cpu_ldst.h
>> @@ -89,6 +89,26 @@ typedef target_ulong abi_ptr;
>>
>>  extern __thread uintptr_t helper_retaddr;
>>
>> +static inline void set_helper_retaddr(uintptr_t ra)
>> +{
>> +    helper_retaddr = ra;
>> +    /*
>> +     * Ensure that this write is visible to the SIGSEGV handler that
>> +     * may be invoked due to a subsequent invalid memory operation.
>> +     */
>> +    signal_barrier();
>> +}
>> +
>> +static inline void clear_helper_retaddr(void)
>> +{
>> +    /*
>> +     * Ensure that previous memory operations have succeeded before
>> +     * removing the data visible to the signal handler.
>> +     */
>> +    signal_barrier();
>> +    helper_retaddr = 0;
>> +}
>> +
>>  /* In user-only mode we provide only the _code and _data accessors. */
>>
>>  #define MEMSUFFIX _data
>> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
>> index bc45e2b8d4..e65733f7e2 100644
>> --- a/include/exec/cpu_ldst_useronly_template.h
>> +++ b/include/exec/cpu_ldst_useronly_template.h
>> @@ -78,9 +78,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
>>                                                    uintptr_t retaddr)
>>  {
>>      RES_TYPE ret;
>> -    helper_retaddr = retaddr;
>> +    set_helper_retaddr(retaddr);
>>      ret = glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
>> -    helper_retaddr = 0;
>> +    clear_helper_retaddr();
>>      return ret;
>>  }
>>
>> @@ -102,9 +102,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
>>                                                    uintptr_t retaddr)
>>  {
>>      int ret;
>> -    helper_retaddr = retaddr;
>> +    set_helper_retaddr(retaddr);
>>      ret = glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
>> -    helper_retaddr = 0;
>> +    clear_helper_retaddr();
>>      return ret;
>>  }
>>  #endif
>> @@ -128,9 +128,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
>>                                                    RES_TYPE v,
>>                                                    uintptr_t retaddr)
>>  {
>> -    helper_retaddr = retaddr;
>> +    set_helper_retaddr(retaddr);
>>      glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(env, ptr, v);
>> -    helper_retaddr = 0;
>> +    clear_helper_retaddr();
>>  }
>>  #endif
>>
>> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>> index cb5f4b19c5..4384b59a4d 100644
>> --- a/accel/tcg/user-exec.c
>> +++ b/accel/tcg/user-exec.c
>> @@ -134,7 +134,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>>               * currently executing TB was modified and must be exited
>>               * immediately.  Clear helper_retaddr for next execution.
>>               */
>> -            helper_retaddr = 0;
>> +            clear_helper_retaddr();
>>              cpu_exit_tb_from_sighandler(cpu, old_set);
>>              /* NORETURN */
>>
>> @@ -152,7 +152,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>>       * an exception.  Undo signal and retaddr state prior to longjmp.
>>       */
>>      sigprocmask(SIG_SETMASK, old_set, NULL);
>> -    helper_retaddr = 0;
>> +    clear_helper_retaddr();
>>
>>      cc = CPU_GET_CLASS(cpu);
>>      access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
>> @@ -682,14 +682,15 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
>>      if (unlikely(addr & (size - 1))) {
>>          cpu_loop_exit_atomic(env_cpu(env), retaddr);
>>      }
>> -    helper_retaddr = retaddr;
>> -    return g2h(addr);
>> +    void *ret = g2h(addr);
>> +    set_helper_retaddr(retaddr);
>> +    return ret;
>>  }
>>
>>  /* Macro to call the above, with local variables from the use context.  */
>>  #define ATOMIC_MMU_DECLS do {} while (0)
>>  #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
>> -#define ATOMIC_MMU_CLEANUP do { helper_retaddr = 0; } while (0)
>> +#define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
>>
>>  #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
>>  #define EXTRA_ARGS
>> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
>> index 44e45a8037..060699b901 100644
>> --- a/target/arm/helper-a64.c
>> +++ b/target/arm/helper-a64.c
>> @@ -554,7 +554,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
>>      /* ??? Enforce alignment.  */
>>      uint64_t *haddr = g2h(addr);
>>
>> -    helper_retaddr = ra;
>> +    set_helper_retaddr(ra);
>>      o0 = ldq_le_p(haddr + 0);
>>      o1 = ldq_le_p(haddr + 1);
>>      oldv = int128_make128(o0, o1);
>> @@ -564,7 +564,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
>>          stq_le_p(haddr + 0, int128_getlo(newv));
>>          stq_le_p(haddr + 1, int128_gethi(newv));
>>      }
>> -    helper_retaddr = 0;
>> +    clear_helper_retaddr();
>>  #else
>>      int mem_idx = cpu_mmu_index(env, false);
>>      TCGMemOpIdx oi0 = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
>> @@ -624,7 +624,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
>>      /* ??? Enforce alignment.  */
>>      uint64_t *haddr = g2h(addr);
>>
>> -    helper_retaddr = ra;
>> +    set_helper_retaddr(ra);
>>      o1 = ldq_be_p(haddr + 0);
>>      o0 = ldq_be_p(haddr + 1);
>>      oldv = int128_make128(o0, o1);
>> @@ -634,7 +634,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
>>          stq_be_p(haddr + 0, int128_gethi(newv));
>>          stq_be_p(haddr + 1, int128_getlo(newv));
>>      }
>> -    helper_retaddr = 0;
>> +    clear_helper_retaddr();
>>  #else
>>      int mem_idx = cpu_mmu_index(env, false);
>>      TCGMemOpIdx oi0 = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
>> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
>> index fd434c66ea..fc0c1755d2 100644
>> --- a/target/arm/sve_helper.c
>> +++ b/target/arm/sve_helper.c
>> @@ -4125,12 +4125,11 @@ static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
>>      return MIN(split, mem_max - mem_off) + mem_off;
>>  }
>>
>> -static inline void set_helper_retaddr(uintptr_t ra)
>> -{
>> -#ifdef CONFIG_USER_ONLY
>> -    helper_retaddr = ra;
>> +#ifndef CONFIG_USER_ONLY
>> +/* These are normally defined only for CONFIG_USER_ONLY in <exec/cpu_ldst.h> */
>> +static inline void set_helper_retaddr(uintptr_t ra) { }
>> +static inline void clear_helper_retaddr(void) { }
> 
> Why aren't these stubs in the #else leg of cpu_ldst.h?

I'm not sure it makes sense to spread these around generically, since they are
no-ops which require the extra help of the "host_fn" pointers within that file.

In particular, the softmmu host_fn continues to use ra, while the linux-user
host_fn does not.  Indeed, the whole point of sve_helper.c using
set_helper_retaddr is to hoist the setting of helper_retaddr that would be done
for each occurrence of cpu_ld_data_ra() et al.


r~

