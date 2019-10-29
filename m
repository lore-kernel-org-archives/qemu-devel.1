Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DADCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49399208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnSairzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49399208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQGT-0006wD-AD
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iPQEB-0004go-7W
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iPQE8-0001Vr-Vy
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:03:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iPQE7-0001V9-QE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:03:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id q70so2293167wme.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1EfezWfQS4/maBDvfQ+2CoBQC3UGh2pF5F3aMbBn1QI=;
 b=PnSairzH1S+bowlIRuciH6B+PnCNEx3ue5Xb9BJdl1WYM3c9W9XZeC8NbIkYWWlgDf
 b5hHFVyZ+aAdJ60AIIModUY+7LU31wXbsBLGz/KHBQCPhzIjuhaLqzx3FsA7GPzSrs3R
 XyuwJcgXdv5/bClkfhEqqar/KeSPe5b4OrAJxBp3BIvQw8ktMjH0BUypV5La972vnz/q
 uHvuCQC8zpTw5gqRgpa4CIMwwoM19OrTVJ1yWXevQjzRVvzhnrQ7D3cPGFhOwIKdl1mw
 RONb2x/R1krKWBzVF9LDA+nV/V51sjq9C8ks1weyjO7PUAejOuo62XLffad+juuF+2mU
 AomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1EfezWfQS4/maBDvfQ+2CoBQC3UGh2pF5F3aMbBn1QI=;
 b=E+FAvkJ4PwaygvawCv/B9XKbC4sIfZr+64JT85EJ+cuW5lUCP+C1w0CdJ632b/4xwL
 M1SJChQ4/AfRW9zC254dfDA0veSOxDbMBjxNZjDUS15JzZWHskMjw7N1kJMTNxNQCoB7
 BMxIyuo2bVv1tSvb2qgaM9OnhcIjNrqb9ArWJhWAouPxouHo5FFvPibuRo7cu9zRoTbV
 d03YG3pfT1qkei9X+TaAJKC+gbyEWIqAhkHEVTV/97RVu+dP+FEA+ENlEDLZAU7/DNSI
 VdmcpOhDep5q/XqDC1dgIl9xcH606XPgy3Km0DkwBcRMi3w6qAAj2xxHbV0wvoM2pGBO
 PWPQ==
X-Gm-Message-State: APjAAAVJidpEjkGIX4vSq3vXHG8bekHpEtL11Ve4fwPX8HznRMyT7d2J
 jhg2BwZ8bhwFjyeZSyP6t/BHIw==
X-Google-Smtp-Source: APXvYqwhNaqfwi40GOPvYkm6XVWISVSV0KEQ6/cwQcSUCE2F/1j6Wo7+POOr7hGWA+R6cVa2AJoY4A==
X-Received: by 2002:a1c:9601:: with SMTP id y1mr3608867wmd.157.1572350633108; 
 Tue, 29 Oct 2019 05:03:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i3sm14863366wrw.69.2019.10.29.05.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 05:03:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA1751FF87;
 Tue, 29 Oct 2019 12:03:50 +0000 (GMT)
References: <34350af3b53fadc50bfe4f1fbc452c7d3a8fe8f7.1570572202.git.alistair.francis@wdc.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/1] target/riscv: Remove atomic accesses to MIP CSR
In-reply-to: <34350af3b53fadc50bfe4f1fbc452c7d3a8fe8f7.1570572202.git.alistair.francis@wdc.com>
Date: Tue, 29 Oct 2019 12:03:50 +0000
Message-ID: <87v9s792s9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com, palmer@sifive.com,
 qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alistair Francis <alistair.francis@wdc.com> writes:

> Instead of relying on atomics to access the MIP register let's update
> our helper function to instead just lock the IO mutex thread before
> writing. This follows the same concept as used in PPC for handling
> interrupts
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Generally anything that can trigger an IRQ or IO type activity should be
locking with the BQL. MMIO accesses are automatically locked by the
memory sub-system but you need to take special care with system
registers that have cross vCPU effects.

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
> @@ -224,8 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *=
f, int flags)
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
>       * Definition of the WFI instruction requires it to ignore the privi=
lege
>       * mode and delegation registers, but respect individual enables
>       */
> -    return (atomic_read(&env->mip) & env->mie) !=3D 0;
> +    return (env->mip & env->mie) !=3D 0;
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
> -     * CAUTION! Unlike the rest of this struct, mip is accessed asynchon=
ously
> -     * by I/O threads. It should be read with atomic_read. It should be =
updated
> -     * using riscv_cpu_update_mip with the iothread mutex held. The ioth=
read
> -     * mutex must be held because mip must be consistent with the CPU in=
turrept
> -     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_inte=
rrupt
> -     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-=
zero.
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
> @@ -38,7 +39,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *e=
nv)
>  {
>      target_ulong mstatus_mie =3D get_field(env->mstatus, MSTATUS_MIE);
>      target_ulong mstatus_sie =3D get_field(env->mstatus, MSTATUS_SIE);
> -    target_ulong pending =3D atomic_read(&env->mip) & env->mie;
> +    target_ulong pending =3D env->mip & env->mie;
>      target_ulong mie =3D env->priv < PRV_M || (env->priv =3D=3D PRV_M &&=
 mstatus_mie);
>      target_ulong sie =3D env->priv < PRV_S || (env->priv =3D=3D PRV_S &&=
 mstatus_sie);
>      target_ulong irqs =3D (pending & ~env->mideleg & -mie) |
> @@ -92,42 +93,29 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_=
t interrupts)
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
> -    struct CpuAsyncInfo *info =3D (struct CpuAsyncInfo *) data.host_ptr;
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
>  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t val=
ue)
>  {
>      CPURISCVState *env =3D &cpu->env;
>      CPUState *cs =3D CPU(cpu);
> -    struct CpuAsyncInfo *info;
> -    uint32_t old, new, cmp =3D atomic_read(&env->mip);
> +    uint32_t old =3D env->mip;
> +    bool locked =3D false;
> +
> +    if (!qemu_mutex_iothread_locked()) {
> +        locked =3D true;
> +        qemu_mutex_lock_iothread();
> +    }
>
> -    do {
> -        old =3D cmp;
> -        new =3D (old & ~mask) | (value & mask);
> -        cmp =3D atomic_cmpxchg(&env->mip, old, new);
> -    } while (old !=3D cmp);
> +    env->mip =3D (env->mip & ~mask) | (value & mask);
>
> -    info =3D g_new(struct CpuAsyncInfo, 1);
> -    info->new_mip =3D new;
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
> @@ -579,7 +579,7 @@ static int rmw_mip(CPURISCVState *env, int csrno, tar=
get_ulong *ret_value,
>      if (mask) {
>          old_mip =3D riscv_cpu_update_mip(cpu, mask, (new_value & mask));
>      } else {
> -        old_mip =3D atomic_read(&env->mip);
> +        old_mip =3D env->mip;
>      }
>
>      if (ret_value) {


--
Alex Benn=C3=A9e

