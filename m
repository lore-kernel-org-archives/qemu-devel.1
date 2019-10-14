Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046FEECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 23:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9ABB21835
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 23:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ABB21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKACP-0006qu-Vo
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 19:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iKABZ-0006Rr-9E
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iKABX-0004bZ-Tw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:55:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iKABX-0004aU-O7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:55:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so10965935pgi.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 16:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=BpoutjnfqIKl7I6Jf3lUtLfwY2kBdts7cm8qAU6Hitk=;
 b=SwrIGs6dL9MJRh1aYspwWzCCWZYME6mBte2TBiP3gKv2JboQtGXAB11wvkZCkFErLg
 i+ODJf15G4b1j1qfGZ6S14tugH+zkL9pj/JJtplb73kpVrpMm5EeMSrXzlGLnH3wTJTB
 a1uNR5PtlfP+4YqGODOCHgLd4vMyY8uCWDh9waaWQ8mkAYdy2DU2n4L9o/m+xmXcaWsI
 mY7abosrV/ka3ayBpj7pZyMMZ3NKg/aELbuT+5bd1d3TIdD11fKiP9C+CYxUBR0HhqWj
 P+cvurwNWbaT/xYfwSloNvZDz+x9Ny4zo4Z0sJSxvuwDQ/KwzM/urP1SBc37qRFOgwdS
 ZW3g==
X-Gm-Message-State: APjAAAUTfELo2ZU6PMSct7o/wEkcVbI+iainOPUDtSk0uqAiN0awWrI1
 FE90aQ0EOgyL3hSTOFPlM96hzoMEs2c=
X-Google-Smtp-Source: APXvYqw/N46TXC9a5nYnissOcdQUUCYTOMQN/AD72r1IedasxCa2XSd5QNIbW3U4+bR0sTIxjQ/Liw==
X-Received: by 2002:a62:685:: with SMTP id 127mr17276394pfg.211.1571097329248; 
 Mon, 14 Oct 2019 16:55:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id c128sm19824225pfc.166.2019.10.14.16.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 16:55:28 -0700 (PDT)
Date: Mon, 14 Oct 2019 16:55:28 -0700 (PDT)
X-Google-Original-Date: Mon, 14 Oct 2019 16:50:45 PDT (-0700)
Subject: Re: [PATCH] linux-user/riscv: Propagate fault address
In-Reply-To: <5059f7eb-07c4-62c7-542b-e71315a4f675@gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: thatlemon@gmail.com
Message-ID: <mhng-c4d38f7e-0fa8-4e8e-ada3-3e7ee83bd92a@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 01 Oct 2019 09:39:52 PDT (-0700), thatlemon@gmail.com wrote:
> The CPU loop tagged all the queued signals as QEMU_SI_KILL while it was
> filling the `_sigfault` part of `siginfo`: this caused QEMU to copy the
> wrong fields over to the userspace program.
>
> Make sure the fault address recorded by the MMU is is stored in the CPU
> environment structure.
>
> In case of memory faults store the exception address into `siginfo`.
>
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> ---
>  linux-user/riscv/cpu_loop.c | 3 ++-
>  target/riscv/cpu_helper.c   | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index 12aa3c0f16..aa9e437875 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -89,6 +89,7 @@ void cpu_loop(CPURISCVState *env)
>          case RISCV_EXCP_STORE_PAGE_FAULT:
>              signum = TARGET_SIGSEGV;
>              sigcode = TARGET_SEGV_MAPERR;
> +            sigaddr = env->badaddr;
>              break;
>          case EXCP_DEBUG:
>          gdbstep:
> @@ -108,7 +109,7 @@ void cpu_loop(CPURISCVState *env)
>                  .si_code = sigcode,
>                  ._sifields._sigfault._addr = sigaddr
>              };
> -            queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
> +            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>          }
>
>          process_pending_signals(env);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 87dd6a6ece..58e40e9824 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -446,9 +446,9 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool probe, uintptr_t retaddr)
>  {
> -#ifndef CONFIG_USER_ONLY
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> +#ifndef CONFIG_USER_ONLY
>      hwaddr pa = 0;
>      int prot;
>      bool pmp_violation = false;
> @@ -499,7 +499,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      case MMU_DATA_STORE:
>          cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
>          break;
> +    default:
> +        g_assert_not_reached();
>      }
> +    env->badaddr = address;
>      cpu_loop_exit_restore(cs, retaddr);
>  #endif
>  }

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I fixed up your Author tag and added this to for-master.  Thanks!

