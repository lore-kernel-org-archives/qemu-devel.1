Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B080C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565A6207F5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="wgIE6GpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565A6207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOA7-0000VM-FS
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jwO7K-0008GI-6e
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:01:26 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:41054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jwO7H-00066m-Lx
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:01:25 -0400
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 4B643219CA;
 Fri, 17 Jul 2020 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1594983678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1yZgltZX69nmLEMIes/f3jdrWq7hYN5FXevKxCyNac=;
 b=wgIE6GpDEcRoOBbyF4P9mLWobccJNi56U3ACihhbkS0fmuMd52aAiZLE47cpU3tLArWRJF
 5gEeoSB9jjB+1SqRCGl6Wt3kvGNLKzc+xSIT/PBf62mXf/rxFCO1NK6za8CNAvgjK7NJ3O
 lMqir3h4koxODumpKmjQwDXjkxTmFXc=
Subject: Re: [RFC PATCH] tcg/cpu-exec: precise single-stepping after an
 exception
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200716100445.3748740-1-luc.michel@greensocs.com>
 <CAFEAcA_fGQoPXGg_t0jsXk7R+aSbWp9S+mpVJbAVZRr9FyUSpw@mail.gmail.com>
 <8e78c1c1-dd3f-fe07-5bd2-a0d8b0bc48ac@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <5802fcc2-a6ca-2aee-55be-7e19126874e1@greensocs.com>
Date: Fri, 17 Jul 2020 13:01:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8e78c1c1-dd3f-fe07-5bd2-a0d8b0bc48ac@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 07:01:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/16/20 11:08 PM, Richard Henderson wrote:
> On 7/16/20 1:12 PM, Peter Maydell wrote:
>> On Thu, 16 Jul 2020 at 11:08, Luc Michel <luc.michel@greensocs.com> wrote:
>>>
>>> When single-stepping with a debugger attached to QEMU, and when an
>>> exception is raised, the debugger misses the first instruction after the
>>> exception:
>>
>> This is a long-standing bug; thanks for looking at it.
>> (https://bugs.launchpad.net/qemu/+bug/757702)
>>
>>
>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>> index d95c4848a4..e85fab5d40 100644
>>> --- a/accel/tcg/cpu-exec.c
>>> +++ b/accel/tcg/cpu-exec.c
>>> @@ -502,10 +502,21 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>>>              CPUClass *cc = CPU_GET_CLASS(cpu);
>>>              qemu_mutex_lock_iothread();
>>>              cc->do_interrupt(cpu);
>>>              qemu_mutex_unlock_iothread();
>>>              cpu->exception_index = -1;
>>> +
>>> +            if (unlikely(cpu->singlestep_enabled)) {
>>> +                /*
>>> +                 * After processing the exception, ensure an EXCP_DEBUG is
>>> +                 * raised when single-stepping so that GDB doesn't miss the
>>> +                 * next instruction.
>>> +                 */
>>> +                cpu->exception_index = EXCP_DEBUG;
>>> +                return cpu_handle_exception(cpu, ret);
>>> +            }
>>
>> I like the idea of being able to do this generically in
>> the main loop.
>>
>> How about interrupts? If we are single-stepping and we
>> take an interrupt I guess we want to stop before the first
>> insn of the interrupt handler rather than after it, which
>> would imply a similar change to cpu_handle_interrupt().
> 
> Fair.  I think something like this:
> 
>             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
>                 replay_interrupt();
> -               cpu->exception_index = -1;
> +               cpu->exception_index =
> +                   (cpu->singlestep_enabled ? EXCP_DEBUG : -1);
>                 *last_tb = NULL;
>             }
> 
> I'm not quite sure how to test this though...
I wrote a small test case for the interrupt side that can be run on the
virt board:


8<-----------------------------------------------
    .global _start
    .text

#define GIC_DIST_BASE 0x08000000
#define GIC_CPU_BASE  0x08010000

#define ARCH_TIMER_NS_EL1_IRQ (16 + 14)

.org 0x280
_irq_handler:
    nop
    nop


.org 0x1000
_start:
    ldr x1, =GIC_DIST_BASE  /* GICD_CTLR */
    mov w0, #1              /* enable */
    str w0, [x1]

    ldr x1, =GIC_DIST_BASE + 0x100 /* GICD_ISENABLER0 */
    ldr w0, =(1 << ARCH_TIMER_NS_EL1_IRQ)
    str w0, [x1]

    ldr x1, =GIC_CPU_BASE   /* GICC_CTLR */
    mov w0, #1              /* enable */
    str w0, [x1]

    ldr x1, =GIC_CPU_BASE + 0x4  /* GICC_PMR */
    mov w0, #255              /* min priority */
    str w0, [x1]

    msr daifclr, 2          /* unmask IRQ line */

    mov x0, 10              /* timer will trigger in 10 ticks */
    msr cntp_tval_el0, x0

    mov x0, 1               /* enable timer */
enable_timer:
    msr cntp_ctl_el0, x0

1:
    b 1b

8<-----------------------------------------------------

$ aarch64-linux-gnu-gcc -g -nostdinc -nostdlib -Wl,-Ttext=0x0 -o foo foo.S

$ qemu-system-aarch64 -display none -M virt -cpu cortex-a53 -kernel foo
-s -S

$ aarch64-linux-gnu-gdb foo
(gdb) tar rem :1234
(gdb) maintenance packet Qqemu.sstep=0x1
(gdb) b enable_timer
(gdb) disp /i $pc
(gdb) c
Continuing.

Breakpoint 1, enable_timer () at foo.S:40
1: x/i $pc
=> 0x1040 <enable_timer>:	msr	cntp_ctl_el0, x0

(gdb) si
1: x/i $pc
=> 0x1044 <enable_timer+4>:	b	0x1044 <enable_timer+4>

(gdb)
1: x/i $pc
=> 0x280 <_irq_handler>:	nop

This is with your fix. Without it, the second stepi stops on 0x284.

> 
> Probably best to keep this a separate patch anyway.
Do you want me to send it? If yes, how should I give credit to you?
Should I put your Signed-off-by: in it?

thanks

Luc

> 
> 
> r~
> 

