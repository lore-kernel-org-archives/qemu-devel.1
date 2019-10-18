Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B050221835
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrzDDv0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B050221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWSJ-00088j-Gz
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iLWIp-0006PA-OB
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iLWIn-0005M9-Vb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:39 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iLWIn-0005KV-NQ; Fri, 18 Oct 2019 13:44:37 -0400
Received: by mail-lj1-x242.google.com with SMTP id y3so7058199ljj.6;
 Fri, 18 Oct 2019 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N6l0akIILUO/kYUgAyjPb4Ghk7rY8V+k5NeOQBSDm5E=;
 b=OrzDDv0WDz3MgbWa+wnO39mcqy3HnXGWuN4TF5MLBqSJnQIQ6M76wVxVTZFAtITbeG
 9CFDGrdK1gw+YgkDSi+5NuJBoSPZTkSzOYVYHN9qxXeXw4qztS2HmFxjHFpTptY7sNdU
 k7Vjw1cIB3ASLiHaAhYsaz+rY1oau5pyY7BcOGGogYizO9GhaD1AaGd/5e9+wQxhj6fU
 nsHLnxMnpgMxC1aGlbU+f1LGQm4E1rmB0Ed+5Q5FgHxXv21eJX6yohCWV91ZOU5LS+wX
 fLyTpr7iEALPwA2ty/RIxBtaA58v3XDo5DCjNK/UEl4P+xR1+u0Xai+KSYAG13BKfsiP
 6ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N6l0akIILUO/kYUgAyjPb4Ghk7rY8V+k5NeOQBSDm5E=;
 b=mM7ENptIWMrdh+gx3rmc9MljeQewDdmzZO2dauZANpLCcwchcOVRcfkwoWjKVy/0Nc
 Zbf4DveM7y+l1zVUyoBqvnlJWJPdQXOL/5m06QJxZPiorjHB50IjCVDSxzmAuFT+Foa9
 ZTlrIPd/U/AJxI4DNps4+AhTBK0Xm1sne1Vw2hpf7XK9sYLFLwSwq4cbppV5RoSX06yu
 R+e4cpFKw0XgmSCdLrxMC6HPsDyh3MEZJbUNqC8HPd9dNvgWFJ0+KL2Sl9VwZc/FYdMV
 MqGJ8M9bbytU6j6IzB5gE4NccZnPmDd7Pl+C7ROPWEtF/d2Ye571VFBnkDqkCcpTNZHg
 9wwA==
X-Gm-Message-State: APjAAAXvEYL00hktNmLoegPdEw9kxnzTJFHrXbSECHBGU0Ywmjsgy52+
 bsUQN+dIdQ7k+6bo+5tx94/78/drEIygDTOGOTA=
X-Google-Smtp-Source: APXvYqzyVbGUuhbt7y2XK5319htfkqUEsl99Xt/ndSeYf//b5M8OhEWjxV/v/4xEWfFq2ib1MhsEuFA65hxdbcz/S2k=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr6865043ljm.7.1571420675500;
 Fri, 18 Oct 2019 10:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <34350af3b53fadc50bfe4f1fbc452c7d3a8fe8f7.1570572202.git.alistair.francis@wdc.com>
 <mhng-55b18e6b-d882-4d24-a4af-2cbecd403a49@palmer-si-x1c4>
In-Reply-To: <mhng-55b18e6b-d882-4d24-a4af-2cbecd403a49@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 18 Oct 2019 10:44:09 -0700
Message-ID: <CAKmqyKPmKc2hhNkVrDgZerXVzyCyrS4WJjMY8fRKf8MNAwmLKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/riscv: Remove atomic accesses to MIP CSR
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 9:51 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 08 Oct 2019 15:04:18 PDT (-0700), Alistair Francis wrote:
> > Instead of relying on atomics to access the MIP register let's update
> > our helper function to instead just lock the IO mutex thread before
> > writing. This follows the same concept as used in PPC for handling
> > interrupts
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.c        |  5 ++--
> >  target/riscv/cpu.h        |  9 --------
> >  target/riscv/cpu_helper.c | 48 +++++++++++++++------------------------
> >  target/riscv/csr.c        |  2 +-
> >  4 files changed, 21 insertions(+), 43 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index f13e298a36..e09dd7aa23 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -224,8 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> >  #ifndef CONFIG_USER_ONLY
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> > -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
> > -                 (target_ulong)atomic_read(&env->mip));
> > +    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
> > @@ -275,7 +274,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
> >       * Definition of the WFI instruction requires it to ignore the privilege
> >       * mode and delegation registers, but respect individual enables
> >       */
> > -    return (atomic_read(&env->mip) & env->mie) != 0;
> > +    return (env->mip & env->mie) != 0;
> >  #else
> >      return true;
> >  #endif
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 124ed33ee4..a71473b243 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -121,15 +121,6 @@ struct CPURISCVState {
> >      target_ulong mhartid;
> >      target_ulong mstatus;
> >
> > -    /*
> > -     * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
> > -     * by I/O threads. It should be read with atomic_read. It should be updated
> > -     * using riscv_cpu_update_mip with the iothread mutex held. The iothread
> > -     * mutex must be held because mip must be consistent with the CPU inturrept
> > -     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interrupt
> > -     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
> > -     * mip is 32-bits to allow atomic_read on 32-bit hosts.
> > -     */
> >      uint32_t mip;
> >      uint32_t miclaim;
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 87dd6a6ece..4334978c2e 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -19,6 +19,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qemu/log.h"
> > +#include "qemu/main-loop.h"
> >  #include "cpu.h"
> >  #include "exec/exec-all.h"
> >  #include "tcg-op.h"
> > @@ -38,7 +39,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
> >  {
> >      target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
> >      target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
> > -    target_ulong pending = atomic_read(&env->mip) & env->mie;
> > +    target_ulong pending = env->mip & env->mie;
> >      target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
> >      target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
> >      target_ulong irqs = (pending & ~env->mideleg & -mie) |
> > @@ -92,42 +93,29 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
> >      }
> >  }
> >
> > -struct CpuAsyncInfo {
> > -    uint32_t new_mip;
> > -};
> > -
> > -static void riscv_cpu_update_mip_irqs_async(CPUState *target_cpu_state,
> > -                                            run_on_cpu_data data)
> > -{
> > -    struct CpuAsyncInfo *info = (struct CpuAsyncInfo *) data.host_ptr;
> > -
> > -    if (info->new_mip) {
> > -        cpu_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
> > -    } else {
> > -        cpu_reset_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
> > -    }
> > -
> > -    g_free(info);
> > -}
> > -
> >  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
> >  {
> >      CPURISCVState *env = &cpu->env;
> >      CPUState *cs = CPU(cpu);
> > -    struct CpuAsyncInfo *info;
> > -    uint32_t old, new, cmp = atomic_read(&env->mip);
> > +    uint32_t old = env->mip;
> > +    bool locked = false;
> > +
> > +    if (!qemu_mutex_iothread_locked()) {
> > +        locked = true;
> > +        qemu_mutex_lock_iothread();
> > +    }
>
> I must be lost here, because I have no idea what this is trying to do.

We lock the QEMU IO Thread before we trigger an interrupt. This way we
can call it from the PLIC.

Alistair

>
> > -    do {
> > -        old = cmp;
> > -        new = (old & ~mask) | (value & mask);
> > -        cmp = atomic_cmpxchg(&env->mip, old, new);
> > -    } while (old != cmp);
> > +    env->mip = (env->mip & ~mask) | (value & mask);
> >
> > -    info = g_new(struct CpuAsyncInfo, 1);
> > -    info->new_mip = new;
> > +    if (env->mip) {
> > +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> > +    } else {
> > +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> > +    }
> >
> > -    async_run_on_cpu(cs, riscv_cpu_update_mip_irqs_async,
> > -                     RUN_ON_CPU_HOST_PTR(info));
> > +    if (locked) {
> > +        qemu_mutex_unlock_iothread();
> > +    }
> >
> >      return old;
> >  }
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index f767ad24be..db0cc6ef55 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -579,7 +579,7 @@ static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
> >      if (mask) {
> >          old_mip = riscv_cpu_update_mip(cpu, mask, (new_value & mask));
> >      } else {
> > -        old_mip = atomic_read(&env->mip);
> > +        old_mip = env->mip;
> >      }
> >
> >      if (ret_value) {

