Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274B9C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E500222522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za57UbWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E500222522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itr1h-0002X1-Uq
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itr0v-0001vh-Dt
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itr0u-0005nz-36
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:44:05 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itr0q-0005mW-Vr; Tue, 21 Jan 2020 05:44:01 -0500
Received: by mail-lf1-x143.google.com with SMTP id f24so1880120lfh.3;
 Tue, 21 Jan 2020 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LH5XwY6XS/oMmZmSr5Hjxd99SJgY+3/Uf3sl4xq7rZg=;
 b=Za57UbWIbk58m92C1gv25Y7n69cMhvj5LQk5mrnryciKD7llDVCfGRr0cMIokzVVJ4
 bJxXbjqCNPqdHTqEiSVIm1uHgPteWY3Cq1QTuNyFHClRYWyOtYQl4TRGWIza20++ify4
 jUIqDGGTCuD/f0K0tYzrKn0Q1NSuBhhhrmEaHXFdIA0J/ZxlVO9EM5NFq3zQziiharv2
 zcthzSayDBJrgv1hYiKIVVCPo4O0EyohpHf8BahyI8xGwHQsvlQ+JQQX7G5iKwu4azJr
 1XapiVaJE8nzjj/WVrnyM2TJY/OU8lvzUU24FSaqyCRl6rvEN7dsIPlFv4XgfaSMI7A2
 TVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LH5XwY6XS/oMmZmSr5Hjxd99SJgY+3/Uf3sl4xq7rZg=;
 b=c0ENk2Ki2ZWk6KQqLEskOMoRIA7m2iL8UYRxGrcMqgdgSqO+jn9SJNxPYiT47hCiBJ
 z4YKgbIYa+dHogOMSg66JX8555LebmhZ9+L0xen7LFSd0wrFMElnI77qnHZZVlCRuYMV
 yLSMtqmsOkCCb2WBrJ10PVfcwQaYTdgKJ6GNPHW4KeQakiSHiBc9uFLaPvF65Lh2SKmV
 kpQ1+cK4dg1+Ks/q9BMF7iRQLYW78nb5GZvTHMYO2oH6UkrmXzin5xMMrz63RJJYbTGr
 viZ7gC45CYmHpIo3Ut5Y2NKhiOMDtSPb2E+3/z/XoB06EV4LID+BYL3uZWBpHTJ+oTSh
 cE8w==
X-Gm-Message-State: APjAAAV6gGlCj6jcsACtm3oyDBlb4HnuRQf+1eHQdSLCuLDPodPliNm9
 xIUlhwfrsjC50bKwkcIg9PcmYn/U2rXLm9c+b4k=
X-Google-Smtp-Source: APXvYqzrGr8NGlBl8ekn0xdAISJvUEnIBB+xzCkyDQC1TuKVfWomzKwjtPppUn+vlDPWdUSUPMKRyT5nQJ0HSc9PyQw=
X-Received: by 2002:ac2:5f68:: with SMTP id c8mr2266883lfc.196.1579603439321; 
 Tue, 21 Jan 2020 02:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20200121085910.28834-1-anup.patel@wdc.com>
 <20200121085910.28834-2-anup.patel@wdc.com>
In-Reply-To: <20200121085910.28834-2-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jan 2020 20:43:32 +1000
Message-ID: <CAKmqyKOkTXdYW+FgyEhYKPuhgHHAZ=h+Z9GXhHOuF3ru3sxcLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Emulate TIME CSRs for privileged mode
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 7:03 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> Currently, TIME CSRs are emulated only for user-only mode. This
> patch add TIME CSRs emulation for privileged mode.
>
> For privileged mode, the TIME CSRs will return value provided
> by rdtime callback which is registered by QEMU machine/platform
> emulation (i.e. CLINT emulation). If rdtime callback is not
> available then the monitor (i.e. OpenSBI) will trap-n-emulate
> TIME CSRs in software.
>
> We see 25+% performance improvement in hackbench numbers when
> TIME CSRs are not trap-n-emulated.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  target/riscv/cpu.h        |  5 +++
>  target/riscv/cpu_helper.c |  5 +++
>  target/riscv/csr.c        | 80 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 86 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 53bc6af5f7..473e01da6c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -169,6 +169,7 @@ struct CPURISCVState {
>      target_ulong htval;
>      target_ulong htinst;
>      target_ulong hgatp;
> +    uint64_t htimedelta;
>
>      /* Virtual CSRs */
>      target_ulong vsstatus;
> @@ -204,6 +205,9 @@ struct CPURISCVState {
>      /* physical memory protection */
>      pmp_table_t pmp_state;
>
> +    /* machine specific rdtime callback */
> +    uint64_t (*rdtime_fn)(void);
> +
>      /* True if in debugger mode.  */
>      bool debugger;
>  #endif
> @@ -325,6 +329,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
>  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
> +void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
>  #endif
>  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7166e6199e..c85f44d933 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -250,6 +250,11 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
>      return old;
>  }
>
> +void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void))
> +{
> +    env->rdtime_fn = fn;
> +}
> +
>  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>  {
>      if (newpriv > PRV_M) {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index b28058f9d5..a55b543735 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -238,6 +238,30 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
>
>  #else /* CONFIG_USER_ONLY */
>
> +static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
> +
> +    if (!env->rdtime_fn)
> +        return -1;

QEMU uses brackets around single line if statements (like Rust :) ).
Can you add brackets to all of them?

After that:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +
> +    *val = env->rdtime_fn() + delta;
> +    return 0;
> +}
> +
> +#if defined(TARGET_RISCV32)
> +static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
> +
> +    if (!env->rdtime_fn)
> +        return -1;
> +
> +    *val = (env->rdtime_fn() + delta) >> 32;
> +    return 0;
> +}
> +#endif
> +
>  /* Machine constants */
>
>  #define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
> @@ -931,6 +955,52 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> +static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    if (!env->rdtime_fn)
> +        return -1;
> +
> +#if defined(TARGET_RISCV32)
> +    *val = env->htimedelta & 0xffffffff;
> +#else
> +    *val = env->htimedelta;
> +#endif
> +    return 0;
> +}
> +
> +static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    if (!env->rdtime_fn)
> +        return -1;
> +
> +#if defined(TARGET_RISCV32)
> +    env->htimedelta = deposit64(env->htimedelta, 0, 32, (uint64_t)val);
> +#else
> +    env->htimedelta = val;
> +#endif
> +    return 0;
> +}
> +
> +#if defined(TARGET_RISCV32)
> +static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    if (!env->rdtime_fn)
> +        return -1;
> +
> +    *val = env->htimedelta >> 32;
> +    return 0;
> +}
> +
> +static int write_htimedeltah(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    if (!env->rdtime_fn)
> +        return -1;
> +
> +    env->htimedelta = deposit64(env->htimedelta, 32, 32, (uint64_t)val);
> +    return 0;
> +}
> +#endif
> +
>  /* Virtual CSR Registers */
>  static int read_vsstatus(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> @@ -1203,14 +1273,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_INSTRETH] =            { ctr,  read_instreth                       },
>  #endif
>
> -    /* User-level time CSRs are only available in linux-user
> -     * In privileged mode, the monitor emulates these CSRs */
> -#if defined(CONFIG_USER_ONLY)
> +    /* In privileged mode, the monitor will have to emulate TIME CSRs only if
> +     * rdtime callback is not provided by machine/platform emulation */
>      [CSR_TIME] =                { ctr,  read_time                           },
>  #if defined(TARGET_RISCV32)
>      [CSR_TIMEH] =               { ctr,  read_timeh                          },
>  #endif
> -#endif
>
>  #if !defined(CONFIG_USER_ONLY)
>      /* Machine Timers and Counters */
> @@ -1276,6 +1344,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
>      [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
>      [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
> +    [CSR_HTIMEDELTA] =          { hmode,   read_htimedelta,  write_htimedelta },
> +#if defined(TARGET_RISCV32)
> +    [CSR_HTIMEDELTAH] =         { hmode,   read_htimedeltah, write_htimedeltah},
> +#endif
>
>      [CSR_VSSTATUS] =            { hmode,   read_vsstatus,    write_vsstatus   },
>      [CSR_VSIP] =                { hmode,   NULL,     NULL,     rmw_vsip       },
> --
> 2.17.1
>
>

