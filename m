Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3799C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE322173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="opw0Q9yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE322173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1C9w-0007Jv-Ji
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1C8T-0005t4-7C
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1C8R-000096-Se
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:09:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1C8R-00008U-JW
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:09:55 -0400
Received: by mail-pf1-x442.google.com with SMTP id b24so6769598pfp.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UkwbiksoG6Udtd9evHWHnNmWTWGrWzIv+xsMHyRibPA=;
 b=opw0Q9yQoCrT6JbDbHIg8yoFKJGGsfox/mh/VtjXT5DYPKvzjrDmzLa27Jdp3IGzXi
 91i2Gyc5lIZpxfkjt7dBYBdBow9TlsBp28pdJmTLe8XAUfguyxfJzDAQ0AqrS+985Aid
 IX5myQIyarr6LBKHLE//Ayb+rUgIBGtGAa+r1NoisLHlO34K2pneNTWByIVss5KbnLrV
 0Ri4RPRCKu0Fns95RKdKe7OvDdTKDrXtXKMCNCML+argqLAHwvaLkybSb5VvGoRzp/NT
 +WeFzvj3+klbyZkf5Ip/AlfrvJnc0EgAIPS9fhHw3dX3McmZxSYo8qwZmb0/c1Y3D7bN
 LD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UkwbiksoG6Udtd9evHWHnNmWTWGrWzIv+xsMHyRibPA=;
 b=MfmNjFSCJxYrPrQiCB2RWuru2gPZiwV/NiZppc/qBBLbOIZJyG7hvU/hWnKcOi3+f4
 l6Lq+YN8RyTeGplsZ9AGvzDSUp1F/FBshZqXvuBUWCDEQlvptPQWmgOg2HYqqLxqXopp
 Oo3YwrqBylUORuMYRXr/+GE/Jj2rsmmVHLmkcPfdhnIefNlVJ4s5C52BqPFkPQKBAewq
 jGVOUh9RrEcDNWcpFSGDJHKDWtwau/bnH9jJyE1tMYdA3rp1U0cTwz08TAlpDEakRpJF
 XmKgO/ACrBxSw/4om5slUqe6L5GU9inFanovhy2ABpdVSh45wtht9TtuEHYuelcYB5N6
 p/Ng==
X-Gm-Message-State: APjAAAUdDxbrC4C9tZC9dw7Wv9CeLh4j9nk0h2g6jHchSSr/pwTZi4Yk
 n3Ryf7y4bWDZPjbdaECQjh8wPg==
X-Google-Smtp-Source: APXvYqxdOSUrA3Fc56rMPBgaI0dyw41f1AN+5f1BjYdqJOhBKLoH0P/POi8KsgRBsbThK8LGFflBmQ==
X-Received: by 2002:a17:90a:9f01:: with SMTP id
 n1mr5929864pjp.103.1566576594183; 
 Fri, 23 Aug 2019 09:09:54 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id ce7sm2621617pjb.16.2019.08.23.09.09.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 09:09:53 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-9-david@redhat.com>
 <8df7d599-bc35-621e-c5d9-ac8554cba512@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f08aa5d3-636f-7a48-659a-bd433e7a60b6@linaro.org>
Date: Fri, 23 Aug 2019 09:09:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8df7d599-bc35-621e-c5d9-ac8554cba512@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 8/9] exec.c: Factor out core logic of
 check_watchpoint()
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 4:27 AM, David Hildenbrand wrote:
> On 23.08.19 12:07, David Hildenbrand wrote:
>> We want to perform the same checks in probe_write() to trigger a cpu
>> exit before doing any modifications. We'll have to pass a PC.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  exec.c                | 23 +++++++++++++++++------
>>  include/hw/core/cpu.h |  2 ++
>>  2 files changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index 1df966d17a..d233a4250b 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -2810,12 +2810,10 @@ static const MemoryRegionOps notdirty_mem_ops = {
>>      },
>>  };
>>  
>> -/* Generate a debug exception if a watchpoint has been hit.  */
>> -static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
>> +void cpu_check_watchpoint(CPUState *cpu, vaddr vaddr, int len,
>> +                          MemTxAttrs attrs, int flags, uintptr_t ra)
>>  {
>> -    CPUState *cpu = current_cpu;
>>      CPUClass *cc = CPU_GET_CLASS(cpu);
>> -    target_ulong vaddr;
>>      CPUWatchpoint *wp;
>>  
>>      assert(tcg_enabled());
>> @@ -2826,7 +2824,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
>>          cpu_interrupt(cpu, CPU_INTERRUPT_DEBUG);
>>          return;
>>      }
>> -    vaddr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
>> +
>>      vaddr = cc->adjust_watchpoint_address(cpu, vaddr, len);
>>      QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
>>          if (cpu_watchpoint_address_matches(wp, vaddr, len)
>> @@ -2851,11 +2849,14 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
>>                  if (wp->flags & BP_STOP_BEFORE_ACCESS) {
>>                      cpu->exception_index = EXCP_DEBUG;
>>                      mmap_unlock();
>> -                    cpu_loop_exit(cpu);
>> +                    cpu_loop_exit_restore(cpu, ra);
>>                  } else {
>>                      /* Force execution of one insn next time.  */
>>                      cpu->cflags_next_tb = 1 | curr_cflags();
>>                      mmap_unlock();
>> +                    if (ra) {
>> +                        cpu_restore_state(cpu, ra, true);
>> +                    }
>>                      cpu_loop_exit_noexc(cpu);
>>                  }
>>              }
>> @@ -2865,6 +2866,16 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
>>      }
>>  }
>>  
>> +/* Generate a debug exception if a watchpoint has been hit.  */
>> +static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
>> +{
>> +    CPUState *cpu = current_cpu;
>> +    vaddr vaddr;
>> +
>> +    vaddr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
>> +    cpu_check_watchpoint(cpu, vaddr, len, attrs, flags, 0);
>> +}
>> +
>>  /* Watchpoint access routines.  Watchpoints are inserted using TLB tricks,
>>     so these check for a hit then pass through to the normal out-of-line
>>     phys routines.  */
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 77fca95a40..3a2d76b32c 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -1070,6 +1070,8 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
>>      return false;
>>  }
>>  
>> +void cpu_check_watchpoint(CPUState *cpu, vaddr vaddr, int len,
>> +                          MemTxAttrs attrs, int flags, uintptr_t ra);
>>  int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>>                            int flags, CPUWatchpoint **watchpoint);
>>  int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
>>
> 
> As we will have bigger accesses with probe_write(), we should do
> 
> diff --git a/exec.c b/exec.c
> index d233a4250b..4f8cc62a5f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2834,7 +2834,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr
> vaddr, int len,
>              } else {
>                  wp->flags |= BP_WATCHPOINT_HIT_WRITE;
>              }
> -            wp->hitaddr = vaddr;
> +            wp->hitaddr = MAX(vaddr, wp->vaddr);
>              wp->hitattrs = attrs;
>              if (!cpu->watchpoint_hit) {
>                  if (wp->flags & BP_CPU &&
> 
> I guess, to make sure we actually indicate the watchpoint.

Yes, that looks right.

As for your changes to use cpu_loop_exit_restore...  Those are so right that I
didn't even recognize how wrong this code is when I was looking through it the
other day.  Watchpoints must not actually be working at all at the moment, really.

I suspect that we need to use a page flag for this and not use I/O memory at
all.  Or convert to read/write_with_attrs and use magic MemTxResult values, but
that seems sketchier than page flags.  Either way is the only way that we can
get access to the host return address so that we can unwind and return to the
main loop.

But this is a good step, in the right direction.  We'll fix the rest later.

With the MAX,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

