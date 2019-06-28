Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F418AC5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50C120828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0jqgwIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50C120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtGn-0007Ih-1s
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hgt9A-0000tb-RG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hgt97-0005XW-6T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:50:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:37777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hgt93-0005Si-2o
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:50:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id bh12so3458513plb.4
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KsLbvpCyR4a+KRaZnpaucBBRgOyS27v+zOrb4BVFYrA=;
 b=E0jqgwIm03hEirBQb+06MpgeJUE8RaQVdIm+zKGC3qNbrR+ZkNIe33zMI5jX7MRxVT
 r98GWtgKHDWsLjdmNR1ceo02u4azXgaz4rpYnzd4NJl7ty22PpEC4zczab7FcyJd2mnF
 9VFlqqdofaangOai66H7LJlUhL+Eftnnvb3P5iAL9zDBBByif6J6yunyDZ/1PGmRzSYM
 mffN/HyOYciskDQzgXdgnmKyrjz1e/n9fE8FQp5HOBfMMhAGORRtUR0NvphANGe2ZQo0
 SA/VVdKBSPY/NokIwp+GXBNHdnsXjQGKz/Kdq03OHjOB0q9BvzNKHWX/CLzT3QLB/xdf
 aj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KsLbvpCyR4a+KRaZnpaucBBRgOyS27v+zOrb4BVFYrA=;
 b=CsBkDIztKrKvQ/xazjHKp/39OKs64VTTr+MTDzejicuZ87ITGf+4vfIbqMDyb2mpoJ
 OBMfnxlAmjXMxV2jZsN6M4CHg45CG0iiOfgSY47/y4y0Y6Wo+n/2+CPFMf9ONNx2rNKk
 Q0N/sIcAfeA7SqRMy7BnJwkG/+Cb8tFa99x2xJDVgbsnYBzknR9MTBBvMg/2KT85hjel
 hwuE5lbHfWq9w7ksxepd3fBr4eaQIF0SIOB2LzDZ1HmFTwBLUZHAVarPLNARKk6dC8hF
 Gc/ImQY+rzHS3lgJaRvjNJAldTPk2D758yPW0JWHrXc7agF5FrajmEw2bo8895WpCD9R
 SSkA==
X-Gm-Message-State: APjAAAWzHQFdewUavkt9Um8hEwyvRGl/2h3HfCJrTcBnsY86U78eTsFj
 Lk/7xwZWBEdc2JLGggtgu4g=
X-Google-Smtp-Source: APXvYqyxurdj53HyPM2ViXii917O8N6ExAsuhSFkiZ3PMtAJKaxMWiK0A6aZkqje0N5n8L1Cr0/Y7A==
X-Received: by 2002:a17:902:b594:: with SMTP id
 a20mr12812848pls.259.1561737034469; 
 Fri, 28 Jun 2019 08:50:34 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id u10sm1987622pgk.41.2019.06.28.08.50.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 08:50:33 -0700 (PDT)
Date: Sat, 29 Jun 2019 00:50:30 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190628155030.GA34320@localhost.localdomain>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
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

On Fri, Jun 28, 2019 at 11:35:48AM +0200, Richard Henderson wrote:
> On 6/28/19 2:27 AM, Lucien Murray-Pitts wrote:
> > 
> > [snip] ... the "return" address is the instruction that causes the exception.
> > So it immediately does return to the ISR.
> > This is a different issue, but I think interrelated to the original problem.
> 
> Is this a synchronous exception, like a SIGSEGV, that the instruction is
> causing?  I have made attempts at fixing asynchronous interrupts, like the
> clock, in the presence of single-stepping.  I haven't tested that in a while
> and I hope it's still working...

This issue is to do with the stack frame generation storing the retaddr
which is the current PC, I cant find any way to obtain the next PC when
not inside the instructions (say a bus handler).  So RTE will return to
the instruction causing SIGSEGV

 op_helper.c
   static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
   ...
     if (cs->exception_index == EXCP_ACCESS) {
      ...
      do_stack_frame(env, &sp, 7, oldsr, 0, retaddr /*LMP: BROKEN - needs PC NEXT*/);

Actually according to the MC68000 manuals the "return address" (the PC saved on
the stack) can be upto 5 instructions later due to prefetch. So some pc_next would best
be used here.

I am not clear how this should work in the presence of an MMU though.

I am triggering this from inside my device by doing the following, since that memory address
should dynamically cause a bus error (I hope this is the right way to do it)
   cpuclass->do_unassigned_access( s->cpu, /*addr*/0x0, /*is_write*/1, /*is_exec*/0, opaque, /*size*/4);

Something similar with TRAP#0 / RTE combination will happen.
Stepping on the TRAP#0 does correctly get me to the ISR, but a subsequent RTE will
step me +1 past the return whilst a break point and run will land in the right place.
I need to experiment a bit more with a solid setup.


> > Further single stepping INTO the failing instruction results in ending up
> > at the ISR +1 instruction
> 
> For a synchronous exception, that sounds like a real bug.
> 
> Probably within cpu_handle_exception,
> 
>   #else
>           if (replay_exception()) {
>               CPUClass *cc = CPU_GET_CLASS(cpu);
>               qemu_mutex_lock_iothread();
>               cc->do_interrupt(cpu);
>               qemu_mutex_unlock_iothread();
> +             /* Single-step into the exception handler.  */
> +             if (cpu->singlestep_enabled) {
> +                 cpu_handle_debug_exception(cpu);
> +             }
>               cpu->exception_index = -1;
>           } else if (!replay_has_interrupt()) {
> 
> 
> r~

I see the function but in 4.0 its been mangled a bit more, so I will have to get
back to you.  Seems that the issue persists in 2.x so maybe this is something new.

Cheers,
Luc


