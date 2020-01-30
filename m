Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B509C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A203206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="BOzGiHIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A203206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBfa-00009S-Jl
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1ixBeP-0007BZ-Ba
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1ixBeN-0007Hj-Ok
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:22:37 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1ixBeN-0007Fb-E1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:22:35 -0500
Received: by mail-wr1-x443.google.com with SMTP id k11so4507910wrd.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l+9LlP1V7rxhqpS0IVSbcKS+t4YkINeVy+JG01FPSP0=;
 b=BOzGiHIcTBp2XG02/GZEHXOxTvHAfac28UQtT1r3w5mqhajDHTraLdp1BwsxzT6UmR
 6iNottyra9jpdDrvWDbWFgLJ7/FB9NIUFg7vPWkpWkcQEL5Xpm276EtjFoWL3J1doDQe
 i27zs9krHN8FfIcISahWO08IbPQApgDB9YcXONJijPXvkAr5efRY8GTm+CffmNxlEKTs
 FJ5V+OJCIaW5GYvdYQ/wKCEXMPXmMF4ar2HfS4TgLMW/Gk6axd7V3pvxdqpKUH6KJejr
 Oqgxb2Nw3z4fqRtxYJzHsJMHZ4A/94pETk2qX5z2FXmz2oUazsbXycGAM2wtJn+wAyVD
 fBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l+9LlP1V7rxhqpS0IVSbcKS+t4YkINeVy+JG01FPSP0=;
 b=td6SB3HKh6Ip5gsHgb7kQdVGF+CW+jw5gExIOOt7ujXOEumi/vW8GAbEZAd7Pg34XT
 5/gGmy6aPgcjqYuXu/9gcYD2kTaMrZqpWi2DcZ+irxhjD3ooDJv7lgIKW/Gc7CcOdIf1
 XBHqrUGGjsOSXP9v1pHxz+Z/Ap+lmQyQ+2RCTr3dtg7FETS7nEFyG2PI05ObO+jJy1ib
 jrMl9XMORrMtkLkn4IoFrlFrmDcL9cj5KBI71OLR6x2f5hKpZWwa8qcrpVuzqiBKa5Gk
 aO0fTUAb9RiGyTarx/6Tk5ct2g5YStl/814Yn6SgRI0TYaIhQolvRi9TeubR9V206KuB
 6opQ==
X-Gm-Message-State: APjAAAUgvcaYss3jo59UwT+xizc8tCdPz3NR9rfTVpyKI9WA1DCvgTuq
 FaY/j9X7M+q7zRQ38Y8nxw8dW92MupCmBRdEqqtn0A==
X-Google-Smtp-Source: APXvYqw0vtk6AD5oNsYvup9iWTb0SFWQdEiMKyKLeiqier2f3nYCm7kkaelOe8yAZFOBpACKqf3271chvUsj3+av8Ls=
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr5881485wrx.381.1580397753457; 
 Thu, 30 Jan 2020 07:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20200122112952.94284-1-anup.patel@wdc.com>
 <20200122112952.94284-2-anup.patel@wdc.com>
 <mhng-917b8eb4-84ed-4b93-836d-186c70d302e0@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-917b8eb4-84ed-4b93-836d-186c70d302e0@palmerdabbelt-glaptop1>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 30 Jan 2020 20:52:21 +0530
Message-ID: <CAAhSdy2AUB0wft1L72hqHVwvW1eVYovJD_dxDKEeXVr+ezHq5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Emulate TIME CSRs for privileged mode
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <Anup.Patel@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 8:14 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Wed, 22 Jan 2020 11:30:31 GMT (+0000), Anup Patel wrote:
> > Currently, TIME CSRs are emulated only for user-only mode. This
> > patch add TIME CSRs emulation for privileged mode.
> >
> > For privileged mode, the TIME CSRs will return value provided
> > by rdtime callback which is registered by QEMU machine/platform
> > emulation (i.e. CLINT emulation). If rdtime callback is not
> > available then the monitor (i.e. OpenSBI) will trap-n-emulate
> > TIME CSRs in software.
> >
> > We see 25+% performance improvement in hackbench numbers when
> > TIME CSRs are not trap-n-emulated.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.h        |  5 +++
> >  target/riscv/cpu_helper.c |  5 +++
> >  target/riscv/csr.c        | 86 +++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 92 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 53bc6af5f7..473e01da6c 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -169,6 +169,7 @@ struct CPURISCVState {
> >      target_ulong htval;
> >      target_ulong htinst;
> >      target_ulong hgatp;
> > +    uint64_t htimedelta;
> >
> >      /* Virtual CSRs */
> >      target_ulong vsstatus;
> > @@ -204,6 +205,9 @@ struct CPURISCVState {
> >      /* physical memory protection */
> >      pmp_table_t pmp_state;
> >
> > +    /* machine specific rdtime callback */
> > +    uint64_t (*rdtime_fn)(void);
> > +
> >      /* True if in debugger mode.  */
> >      bool debugger;
> >  #endif
> > @@ -325,6 +329,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
> >  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
> >  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
> >  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
> > +void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
> >  #endif
> >  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 7166e6199e..c85f44d933 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -250,6 +250,11 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
> >      return old;
> >  }
> >
> > +void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void))
> > +{
> > +    env->rdtime_fn = fn;
> > +}
> > +
> >  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
> >  {
> >      if (newpriv > PRV_M) {
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index b28058f9d5..44ff1d80ec 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -238,6 +238,32 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
> >
> >  #else /* CONFIG_USER_ONLY */
> >
> > +static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
> > +{
> > +    uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
> > +
> > +    if (!env->rdtime_fn) {
> > +        return -1;
> > +    }
> > +
> > +    *val = env->rdtime_fn() + delta;
> > +    return 0;
> > +}
> > +
> > +#if defined(TARGET_RISCV32)
> > +static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
> > +{
> > +    uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
> > +
> > +    if (!env->rdtime_fn) {
> > +        return -1;
> > +    }
> > +
> > +    *val = (env->rdtime_fn() + delta) >> 32;
> > +    return 0;
> > +}
> > +#endif
> > +
> >  /* Machine constants */
> >
> >  #define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
> > @@ -931,6 +957,56 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
> >      return 0;
> >  }
> >
> > +static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
> > +{
> > +    if (!env->rdtime_fn) {
> > +        return -1;
> > +    }
> > +
> > +#if defined(TARGET_RISCV32)
> > +    *val = env->htimedelta & 0xffffffff;
> > +#else
> > +    *val = env->htimedelta;
> > +#endif
> > +    return 0;
> > +}
> > +
> > +static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
> > +{
> > +    if (!env->rdtime_fn) {
> > +        return -1;
> > +    }
> > +
> > +#if defined(TARGET_RISCV32)
> > +    env->htimedelta = deposit64(env->htimedelta, 0, 32, (uint64_t)val);
> > +#else
> > +    env->htimedelta = val;
> > +#endif
> > +    return 0;
> > +}
>
> Oh, I guess I missed this when reading Alistair's H extension patches, but it
> looks like htimedelta is mandatory.  In other words, these writes should
> succeed regardless of whether or not rdtime is implemented.  I opened a
> question on the spec to make sure, but if that's the case then it should always
> be implemented: https://github.com/riscv/riscv-isa-manual/issues/481

The HTIMEDELTA CSR is tide with TIME CSR because it controls
TIME CSR value read from VS-mode and VU-mode.

TIME (VS-mode or VU-mode) = TIME (HS-mode or M-mode) + HTIMEDELTA

If HW does not implement TIME CSR then HW should not implement
HTIMEDELTA as well. In this case, OpenSBI will trap-n-emulate both
TIME CSR and HTIMEDELTA CSR. If HW implements TIME CSR then HW
has to implement HTIMEDELTA as well.

To summarize, TIME CSR is optional for HW hence HTIMEDELTA is
optional for HW as well. Also, HW designers should either implement
both CSRs or skip both.

Regards,
Anup

>
> > +
> > +#if defined(TARGET_RISCV32)
> > +static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
> > +{
> > +    if (!env->rdtime_fn) {
> > +        return -1;
> > +    }
> > +
> > +    *val = env->htimedelta >> 32;
> > +    return 0;
> > +}
> > +
> > +static int write_htimedeltah(CPURISCVState *env, int csrno, target_ulong val)
> > +{
> > +    if (!env->rdtime_fn) {
> > +        return -1;
> > +    }
> > +
> > +    env->htimedelta = deposit64(env->htimedelta, 32, 32, (uint64_t)val);
> > +    return 0;
> > +}
> > +#endif
> > +
> >  /* Virtual CSR Registers */
> >  static int read_vsstatus(CPURISCVState *env, int csrno, target_ulong *val)
> >  {
> > @@ -1203,14 +1279,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
> >      [CSR_INSTRETH] =            { ctr,  read_instreth                       },
> >  #endif
> >
> > -    /* User-level time CSRs are only available in linux-user
> > -     * In privileged mode, the monitor emulates these CSRs */
> > -#if defined(CONFIG_USER_ONLY)
> > +    /* In privileged mode, the monitor will have to emulate TIME CSRs only if
> > +     * rdtime callback is not provided by machine/platform emulation */
> >      [CSR_TIME] =                { ctr,  read_time                           },
> >  #if defined(TARGET_RISCV32)
> >      [CSR_TIMEH] =               { ctr,  read_timeh                          },
> >  #endif
> > -#endif
> >
> >  #if !defined(CONFIG_USER_ONLY)
> >      /* Machine Timers and Counters */
> > @@ -1276,6 +1350,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
> >      [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
> >      [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
> >      [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
> > +    [CSR_HTIMEDELTA] =          { hmode,   read_htimedelta,  write_htimedelta },
> > +#if defined(TARGET_RISCV32)
> > +    [CSR_HTIMEDELTAH] =         { hmode,   read_htimedeltah, write_htimedeltah},
> > +#endif
> >
> >      [CSR_VSSTATUS] =            { hmode,   read_vsstatus,    write_vsstatus   },
> >      [CSR_VSIP] =                { hmode,   NULL,     NULL,     rmw_vsip       },
> > --
> > 2.17.1

