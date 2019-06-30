Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E5C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 08:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6B12089C
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 08:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5bF0pV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6B12089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhV5m-0005Lp-BI
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 04:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57416)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhV4Y-0004uT-H6
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 04:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhV4V-0006a0-Tn
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 04:20:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhV4S-0006Pr-8I
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 04:20:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id 207so12850962wma.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IXBF/77dzVY0TXRRhnoU21hCnEhrNzaqpwM2aDv+AaU=;
 b=S5bF0pV24W6Y1LzPdWcTOfwGjFVtPbRaRx4zqvboX2cOnUiI/UQb5z7x4uv623ewxt
 XgodkFNrLiT+XfpC5LV4KFWDnG0I/YYum820TtQs5n8wJIhRCPbVUApNf6RZfuk6wFKO
 GbbV+ImBVsfOS4Y1KnFPqiSVs8M5YRDMqBW/ZXXVNHauMkDb/+yKMroTeXDGx8HqLvuE
 Zyx/4f6yk2KAjhkWBrV+K/TUiLaZrCklHdH382Z3BMOoVgBdWe5dXc8WBVyDgMaSVi42
 NsKH6eOgftj6NbK3DAAeEeryGzM+BRDzQEqeZcweEgdcGtbrcf9W1YxYBsr/nwLXPS70
 tRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IXBF/77dzVY0TXRRhnoU21hCnEhrNzaqpwM2aDv+AaU=;
 b=tvKRe3hHvSvXDn/4SgNIb1fltlOaDgNv3Ck0My+FJA7KJa2HnQqrdde6GwegHR+FPE
 VX5Vf8gqwCAOI6pdGFYtqds/peUqdBFgjwI1sHVL0eWWIEfmzDamxZeb78eO4SOMOqY3
 VmOsZfDpfwgtIPnBXJlaTL7onAemahoaQS3vaUD3T+TGU4PUP/ZKaKwhZZSjEi2SxA1u
 1zRp5RTl0PSNmJzJZl1y/TFuxTGIrb0RCPZ/3mtMZGO/N9KErZft0ZYGjG+Bylh52qzx
 t5yk1D7QWEwdy6Xx4hYLMtvRebHmYmse/tUxm1JPLnh4LmDGM9sh6mI27ppVVocUghNC
 tASw==
X-Gm-Message-State: APjAAAWS9TE3R5DN3oaqpPg1HxYf7JTtoBy1yM3Jh2gHrJVbmKXh9VgD
 CXvc4CMFSW6C7Mtl8CTgTxWdGA==
X-Google-Smtp-Source: APXvYqwFMZsyVj6cRweFYrjZ5NK0UCCZ2mZbs5wHrlqYPAe36MoWTU5rk35NV0bOWSI6LiYkAU6MBA==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr13404517wmf.111.1561882822489; 
 Sun, 30 Jun 2019 01:20:22 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id h90sm9066745wrh.15.2019.06.30.01.20.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jun 2019 01:20:21 -0700 (PDT)
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <039ad116-d181-a928-1c79-1444c4620fe9@linaro.org>
Date: Sun, 30 Jun 2019 10:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190629163621.GA111724@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/19 6:36 PM, Lucien Murray-Pitts wrote:
> On Sat, Jun 29, 2019 at 12:15:44PM +0200, Richard Henderson wrote:
>> On 6/28/19 5:50 PM, Lucien Murray-Pitts wrote:
>>>  op_helper.c
>>>    static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>>>    ...
>>>      if (cs->exception_index == EXCP_ACCESS) {
>>>       ...
>>>       do_stack_frame(env, &sp, 7, oldsr, 0, retaddr /*LMP: BROKEN - needs PC NEXT*/);
>>>
>>> Actually according to the MC68000 manuals the "return address" (the PC saved on
>>> the stack) can be upto 5 instructions later due to prefetch. So some pc_next
>>> would best be used here.
>>
>> The way I read it from the 68040 manual, it's "the pc of the instruction
>> executing at the time the fault was detected".  Well, we did in fact detect the
>> fault at "retaddr", so that seems to be the right answer.  The fact that real
>> hardware has a different pipeline and detects the fault later seems immaterial,
>> and largely irrelevant, since the programmer wasn't given any guarantees for
>> what sort of value appears in that slot.
>>
> 
> I was reading the 68000/68020, and based on your suggestion now the 68060 manual
> The 68000 is pretty rough, but I agree you could expect it to more likely be the
> next or even upto 5 or so instructions away.
> 
> MC68000UM.pdf, 5.4.1 Bus Error Operation
>   ....the following information is placed on the supervisor stack:
>     1. Status register
>     2. Program counter (two words, which may be up to five words past the
>        instruction being executed)
> ....
> MC68000UM.pdf, 6.3.9.1 BUS ERROR.
>   ...value saved for the program counter is advanced 2–10 bytes beyond the
>   address of the first word of the instruction that made the reference causing
>   the bus error. If the bus error occurred during the fetch of the next
>   instruction, the saved program counter has a value in the vicinity of the
>   current instruction, even if the current instruction is a branch, a jump, or
>   a return instruction ...
> 
> MC68020UM.pdf, 6.1.2 Bus Error Exception
>   The saved PC value is the logical address of the instruction that was
>   executing at the time the fault was detected. This is not necessarily the
>   instruction that initiated the bus cycle since the processor overlaps
>   execution of instructions
>   (See 6.4 Bus Fault REcovery and 6.3.11 Return From Exception)
>   
> MC68060UM.pdf, 8.4.4.1 Program Counter (PC).
> On read access faults, the PC points to the instruction that caused the
> access error. This instruction is restarted when an RTE is executed, hence,
> the read cycle is re-executed. On read access errors on the second or later
> of misaligned reads, the read cycles that are successful prior to the access
> error are re-executed since the processor uses a restart model for recovery
> from exceptions.

Interesting.  Thanks for digging through the other manuals.

> In my case I think the original firmware expects to return after the
> faulting instruction, and the retry of the bus io is to be ignored
> (this is a memory map probe routine).

Oh my.  Ok, well, if there's software that relies on some advance, I guess we
can conditionally do that.  It'll take a bit of work...

In

  https://patchwork.ozlabs.org/patch/1072596/

I arrange for the length of the current instruction to be stored in qemu's
exception unwind data.  Within restore_state_to_opc, the "ilen" is stored into
an existing slot in s390's env structure; you'd have to add such a slot for m68k.

Given the length of the insn currently executing, you can reliably compute the
pc of the next instruction.  Which would let you advance the pc for this case,
for the appropriate cpu type.

> However for the m68k the do_transaction_failed function pointer field
> has not been implemented.
> 
> I implemented it in a rudamentary fashion copying from already existing
> m68k_cpu_unassigned_access.  I really dont know if this is the right way.
> 
>   void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>                                   unsigned size, MMUAccessType access_type,
>                                   int mmu_idx, MemTxAttrs attrs,
>                                   MemTxResult response, uintptr_t retaddr)
>   {
>       cs->exception_index = EXCP_ACCESS;
>       cpu_loop_exit(cs);
>   }

At minimum that's going to need

  cpu_loop_exit_restore(cs, retaddr);

But usually store some of the addr and access_type data into fields so that you
can properly fill in the exception frame later.

> Then I reverted my device to the "mem with attributes" io with a return of
> MEMTX_ERROR and found that the behavior during single-step were the same as
> before.
> 
> I end up ISR+1 instruction stepped in.

So, earlier, I suggested adding a call to cpu_handle_debug_exception within
cpu_handle_exception.  Did you try that?


r~

