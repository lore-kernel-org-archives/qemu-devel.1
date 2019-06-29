Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6833CC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 16:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3199F20665
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 16:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ODvPkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3199F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhGLl-0001Ml-3G
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 12:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52831)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hhGL1-0000vF-8z
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 12:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hhGKz-0004Hb-4g
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 12:36:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:39004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hhGKy-0004G1-RN
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 12:36:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id j2so4463932pfe.6
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=l46NW/2PaHvKYOc+SYT1Ll5+7fjrY7Y4twLIQqXTMsc=;
 b=e6ODvPkjLd8x8vISm3KNKqhYlh4xHmP3sxtX14Td9HMa7hm1kRrprmUam/pyWeunKU
 VIP/XGUm5+bJFOzY0IAAIknuNHtGwTDU3ZpemUS1EZmHznFBMGMgVTtH+qf5yjNwB1gn
 zfJSXw0X65Qz8+VBlb0Ojg2BdMVtQwbplrmhYmlRCBue49XopoXD73gTuxIAj/3Tt5Dh
 6W0BejKPWezCdTWOer6fhKTNSACIF5MpH+HFsmvlVhuHsHfyi3zOj8v6qPOYL7vHkeNz
 MJYFvuknTaix1xwfItVywOVlhSLe95bn1upS8GZ7r7q/0pD8C62hTk+WjcP1ftWcyd0w
 Webg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=l46NW/2PaHvKYOc+SYT1Ll5+7fjrY7Y4twLIQqXTMsc=;
 b=D+h/kUuGdmLQad7pPTdH/AuELpL3dLJT9Iz3+xdHolRINlaaRyaJLR8HzDmgkFHbSi
 szqtf6Mq897zrPWq7yyVCr41LX9govhOu+Ax0td9anE5PuGZLmOeyXtq282qUuZQDIAw
 DpXYA8h8v8g7WQqBmKXybA1DPCQvpk2YxsQktMcDM0zj6GcQ6KaLZQ1XOsfo2Qg6KCvr
 xDFReFipAfsl8tHNkBYa5nPSlGN9aQbRGxksv2lt17lwLzU1vtkdfF3dhaYulrtKBU1z
 p2lGMHqlza9OP+4xLG4ZSEW6s5mFnldc+aqaXLw4Zapnx91UnIRjFQ/+dUbHV2FeCqP9
 vo0A==
X-Gm-Message-State: APjAAAVmsO4OZCmjUrcdVw0jI/HsiwcUnNS/6fWBNiFZQNSJ+A2uS4Lv
 aaMmY583qU3dnoFUOENFVmg=
X-Google-Smtp-Source: APXvYqxxfwhMCgb8e96yRd7sO6iW1CFE+hrMx2ub3WCNx9AXakz1nlQiCvLAyhGJT4vZ7GxMLIqf7Q==
X-Received: by 2002:a17:90a:bf08:: with SMTP id
 c8mr20222010pjs.75.1561826186707; 
 Sat, 29 Jun 2019 09:36:26 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id i3sm4502536pgq.40.2019.06.29.09.36.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 09:36:25 -0700 (PDT)
Date: Sun, 30 Jun 2019 01:36:21 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190629163621.GA111724@localhost.localdomain>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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

On Sat, Jun 29, 2019 at 12:15:44PM +0200, Richard Henderson wrote:
> On 6/28/19 5:50 PM, Lucien Murray-Pitts wrote:
> >  op_helper.c
> >    static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
> >    ...
> >      if (cs->exception_index == EXCP_ACCESS) {
> >       ...
> >       do_stack_frame(env, &sp, 7, oldsr, 0, retaddr /*LMP: BROKEN - needs PC NEXT*/);
> > 
> > Actually according to the MC68000 manuals the "return address" (the PC saved on
> > the stack) can be upto 5 instructions later due to prefetch. So some pc_next
> > would best be used here.
> 
> The way I read it from the 68040 manual, it's "the pc of the instruction
> executing at the time the fault was detected".  Well, we did in fact detect the
> fault at "retaddr", so that seems to be the right answer.  The fact that real
> hardware has a different pipeline and detects the fault later seems immaterial,
> and largely irrelevant, since the programmer wasn't given any guarantees for
> what sort of value appears in that slot.
> 

I was reading the 68000/68020, and based on your suggestion now the 68060 manual
The 68000 is pretty rough, but I agree you could expect it to more likely be the
next or even upto 5 or so instructions away.

MC68000UM.pdf, 5.4.1 Bus Error Operation
  ....the following information is placed on the supervisor stack:
    1. Status register
    2. Program counter (two words, which may be up to five words past the
       instruction being executed)
....
MC68000UM.pdf, 6.3.9.1 BUS ERROR.
  ...value saved for the program counter is advanced 2–10 bytes beyond the
  address of the first word of the instruction that made the reference causing
  the bus error. If the bus error occurred during the fetch of the next
  instruction, the saved program counter has a value in the vicinity of the
  current instruction, even if the current instruction is a branch, a jump, or
  a return instruction ...

MC68020UM.pdf, 6.1.2 Bus Error Exception
  The saved PC value is the logical address of the instruction that was
  executing at the time the fault was detected. This is not necessarily the
  instruction that initiated the bus cycle since the processor overlaps
  execution of instructions
  (See 6.4 Bus Fault REcovery and 6.3.11 Return From Exception)
  
MC68060UM.pdf, 8.4.4.1 Program Counter (PC).
On read access faults, the PC points to the instruction that caused the
access error. This instruction is restarted when an RTE is executed, hence,
the read cycle is re-executed. On read access errors on the second or later
of misaligned reads, the read cycles that are successful prior to the access
error are re-executed since the processor uses a restart model for recovery
from exceptions.

So it would seem the m68k was rather rough, but with the introduction
of MMUs the 68010 and beyond handle it differently.  68010/20 have
pipeline stage retries, and 68060 just returns to retry the instruction.

In my case I think the original firmware expects to return after the
faulting instruction, and the retry of the bus io is to be ignored
(this is a memory map probe routine).

So I think it would take significant work to fake the pipeline retry
in the RTE instruction - so I will hack somethign into the memory region
so it passes the second time the instruciton is exected.

What are your thoughts?


> > I am triggering this from inside my device by doing the following, since that memory address
> > should dynamically cause a bus error (I hope this is the right way to do it)
> >    cpuclass->do_unassigned_access( s->cpu, /*addr*/0x0, /*is_write*/1, /*is_exec*/0, opaque, /*size*/4);
> 
> 
> For a device to raise a bus error, it should return MEMTX_ERROR (or something).
>  This eventually reaches cpu_transaction_failed, which has all of the data that
> you seem to be missing above.
> 

I was originally using this but it wasnt doing anything, now that you recommend it I see why -
thank you for your help.

qemu/accel/tcg/cputlb.c
   ...
   r = memory_region_dispatch_read(mr, mr_offset,
                                    &val, size, iotlbentry->attrs);
    if (r != MEMTX_OK) {
        hwaddr physaddr = mr_offset +
            section->offset_within_address_space -
            section->offset_within_region;

        cpu_transaction_failed(cpu, physaddr, addr, size, access_type,
                               mmu_idx, iotlbentry->attrs, r, retaddr);
    }
    ...

As you say this call directly flows through to CPUClass->transaction_failed
( as found in the struct for CPUClass in qemu/include/qom/cpu.h )

However for the m68k the do_transaction_failed function pointer field
has not been implemented.

I implemented it in a rudamentary fashion copying from already existing
m68k_cpu_unassigned_access.  I really dont know if this is the right way.

  void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  unsigned size, MMUAccessType access_type,
                                  int mmu_idx, MemTxAttrs attrs,
                                  MemTxResult response, uintptr_t retaddr)
  {
      cs->exception_index = EXCP_ACCESS;
      cpu_loop_exit(cs);
  }

Then I reverted my device to the "mem with attributes" io with a return of
MEMTX_ERROR and found that the behavior during single-step were the same as
before.

I end up ISR+1 instruction stepped in.

I will have to dig more.  See some other peoples implementation and methods.

If you have time I would appreciate your input, I am still very hazy on how
the complete interaction, sepcially with gdb happens.

Cheers,
Luc






