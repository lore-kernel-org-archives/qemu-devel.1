Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A624FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B8820854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KhRT4sWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B8820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVWT-0006cx-JJ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iLVTa-0003er-Uh
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iLVTY-0001Dq-FA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:51:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iLVTW-0001DD-RD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:51:39 -0400
Received: by mail-pf1-x441.google.com with SMTP id q7so4231905pfh.8
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=ARYfeLlfHFBjrpxDYrmOJMzIkA5EYdBh/O+HE0MSO9s=;
 b=KhRT4sWuJKWpr9dQ3RdIDJ3hRbQOWEWHZ+OQ9RdkmXjhyG/ZcZfROYiNUZrQ2pctIJ
 DDHmgipwlLkFXT87B6Bgs4exe3PgdH4l0SsG1Bi55eCuQWN+/I6UThvX5nWW3jgNircb
 QWEGv/0ShCyVsWGdhW+YDp6CwvSDD9cXXgN3NywL1w6cE7brFecLl22ElRihsjqHlLLb
 1nLIxxzIEWGk3CkCnAu8blI7TjawjOFtjpycYqDQBTaGGr6VIlMEVXiolA81aP5PIFYB
 5UI/Wrveko2tX84jfHVZouwE2uSEEhU9m0qrvSPNOnNV/DPN3xBj+JcBJXTbbLasyH/O
 EzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=ARYfeLlfHFBjrpxDYrmOJMzIkA5EYdBh/O+HE0MSO9s=;
 b=soeyXLPN/WNVar8LcevS4JGS4u8Qm1ztSDGPsb8sSZDUO/8dUYMAP3lF4QzVc/PCtP
 um4XFLiNSx9vVexN1nyui46vf3N8kNP0apgISQpCkb5PB/KGl3J/BBMERj/MRK8b4EQ0
 XEdZI9DwVk8hmajWzGilkAQTkNyDe1cCe6dF6DqfdOZcg7y7Rnev5ZPcJeLPMqUeK+KE
 zimJRGIaNel/bQCPXEgli5hAGYqIuPnTGFoZ439XJMh+aCew2wwKuVPB8pNJxZ7bPccm
 m57aYlKOwzb/QeZa29cr9lsHEgGBdRWrdxBlyjRWcmJ/nxH9uBuUcdI0LsrVOl5SxMUe
 07ug==
X-Gm-Message-State: APjAAAXmU7GzsIL1PVshX9+x60ogwgNLDMIrL8CZcNK0ipVgDrvE6z36
 N+6wZDldiqN78Cke+Cw7b9C2a0RLt7eriQ==
X-Google-Smtp-Source: APXvYqys1aGXk96w7zvObecfYzCtmUy/4gXurQ7nAx6bEzc5I+TnJEha7fYxCsr4CSgtQlcraspCHQ==
X-Received: by 2002:a63:3853:: with SMTP id h19mr7720183pgn.55.1571417496628; 
 Fri, 18 Oct 2019 09:51:36 -0700 (PDT)
Received: from localhost ([152.179.112.46])
 by smtp.gmail.com with ESMTPSA id y9sm6343841pgq.11.2019.10.18.09.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 09:51:35 -0700 (PDT)
Date: Fri, 18 Oct 2019 09:51:35 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Oct 2019 09:34:58 PDT (-0700)
Subject: Re: [PATCH v1 1/1] target/riscv: Remove atomic accesses to MIP CSR
In-Reply-To: <34350af3b53fadc50bfe4f1fbc452c7d3a8fe8f7.1570572202.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-55b18e6b-d882-4d24-a4af-2cbecd403a49@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 08 Oct 2019 15:04:18 PDT (-0700), Alistair Francis wrote:
> Instead of relying on atomics to access the MIP register let's update
> our helper function to instead just lock the IO mutex thread before
> writing. This follows the same concept as used in PPC for handling
> interrupts
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c        |  5 ++--
>  target/riscv/cpu.h        |  9 --------
>  target/riscv/cpu_helper.c | 48 +++++++++++++++------------------------
>  target/riscv/csr.c        |  2 +-
>  4 files changed, 21 insertions(+), 43 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f13e298a36..e09dd7aa23 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -224,8 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  #ifndef CONFIG_USER_ONLY
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
> -                 (target_ulong)atomic_read(&env->mip));
> +    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
> @@ -275,7 +274,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
>       * Definition of the WFI instruction requires it to ignore the privilege
>       * mode and delegation registers, but respect individual enables
>       */
> -    return (atomic_read(&env->mip) & env->mie) != 0;
> +    return (env->mip & env->mie) != 0;
>  #else
>      return true;
>  #endif
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 124ed33ee4..a71473b243 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -121,15 +121,6 @@ struct CPURISCVState {
>      target_ulong mhartid;
>      target_ulong mstatus;
>
> -    /*
> -     * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
> -     * by I/O threads. It should be read with atomic_read. It should be updated
> -     * using riscv_cpu_update_mip with the iothread mutex held. The iothread
> -     * mutex must be held because mip must be consistent with the CPU inturrept
> -     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interrupt
> -     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
> -     * mip is 32-bits to allow atomic_read on 32-bit hosts.
> -     */
>      uint32_t mip;
>      uint32_t miclaim;
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 87dd6a6ece..4334978c2e 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -19,6 +19,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "tcg-op.h"
> @@ -38,7 +39,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>  {
>      target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
>      target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
> -    target_ulong pending = atomic_read(&env->mip) & env->mie;
> +    target_ulong pending = env->mip & env->mie;
>      target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
>      target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
>      target_ulong irqs = (pending & ~env->mideleg & -mie) |
> @@ -92,42 +93,29 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>      }
>  }
>
> -struct CpuAsyncInfo {
> -    uint32_t new_mip;
> -};
> -
> -static void riscv_cpu_update_mip_irqs_async(CPUState *target_cpu_state,
> -                                            run_on_cpu_data data)
> -{
> -    struct CpuAsyncInfo *info = (struct CpuAsyncInfo *) data.host_ptr;
> -
> -    if (info->new_mip) {
> -        cpu_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
> -    } else {
> -        cpu_reset_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
> -    }
> -
> -    g_free(info);
> -}
> -
>  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
>  {
>      CPURISCVState *env = &cpu->env;
>      CPUState *cs = CPU(cpu);
> -    struct CpuAsyncInfo *info;
> -    uint32_t old, new, cmp = atomic_read(&env->mip);
> +    uint32_t old = env->mip;
> +    bool locked = false;
> +
> +    if (!qemu_mutex_iothread_locked()) {
> +        locked = true;
> +        qemu_mutex_lock_iothread();
> +    }

I must be lost here, because I have no idea what this is trying to do.

> -    do {
> -        old = cmp;
> -        new = (old & ~mask) | (value & mask);
> -        cmp = atomic_cmpxchg(&env->mip, old, new);
> -    } while (old != cmp);
> +    env->mip = (env->mip & ~mask) | (value & mask);
>
> -    info = g_new(struct CpuAsyncInfo, 1);
> -    info->new_mip = new;
> +    if (env->mip) {
> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    } else {
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +    }
>
> -    async_run_on_cpu(cs, riscv_cpu_update_mip_irqs_async,
> -                     RUN_ON_CPU_HOST_PTR(info));
> +    if (locked) {
> +        qemu_mutex_unlock_iothread();
> +    }
>
>      return old;
>  }
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index f767ad24be..db0cc6ef55 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -579,7 +579,7 @@ static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
>      if (mask) {
>          old_mip = riscv_cpu_update_mip(cpu, mask, (new_value & mask));
>      } else {
> -        old_mip = atomic_read(&env->mip);
> +        old_mip = env->mip;
>      }
>
>      if (ret_value) {

