Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6884AC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F62217D9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BKQJFdJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F62217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huWzB-0001ny-Am
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1huWyH-0001EZ-UX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1huWyG-0004m8-3L
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:59:53 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34]:43938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1huWyF-0004le-Pe
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:59:52 -0400
Received: by mail-io1-xd34.google.com with SMTP id k20so11892636ios.10
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i5Ww0ywp7+DtPeRbx/mmf4OPOEmvyp7sQtuYzya10vc=;
 b=BKQJFdJztHiOwhmWt0bg8OtyYDLAPFZBtSa1M9jtksEr7TEpQFqSafbtUdtPQTMSR7
 2B4p3IhzfEUfiltoMdzvJGUN3JxDSp2wyY7u8NMoqKDcqhDEbuPpXsLJ/LkF8XWaNpwB
 0vBFia6FCwaQwQkgJUFhVhDOn2HYsWS3LyPfu0jzBNHDaYjHwg962r+b+QMtDj1DGuJC
 5Nvyj1Cha86WHhdAVKc2w0rhN8QX548zEp+wfAzj7EAlvszpYjXnIR5S32g+X7fT58on
 i2EijpibF0NAqzUGAbaXBotu3UbnbiPieh2uIMYpYMJ2CLIgaZzYVnf1vfcOtWWsqQZP
 5D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i5Ww0ywp7+DtPeRbx/mmf4OPOEmvyp7sQtuYzya10vc=;
 b=Ir318OW0nyrPenqVj1CQ6C0s07R38YvcqBuyefvQxwwHX403zm/x0be83G8W/r6mTF
 M7bUZTShLhEKRMILgh7lLDGn5bw3WtSJdSLZ0bAikPhy8nMsKpxMVK1nWMzwyGUbRrnK
 qvqhedLuWIpz1ENn/A0rv/j9sZFPx9OaKhPaOFkRaCGaThFO7ZrV3m5O3mvaQ8ou19ZF
 OZSCtVpgCVH33pumsNtv0tleFn3Uyv7sWazjBTnfmE11uvSjl7UsmV9b4tMC98bg00x0
 GiZP3dxG3kDgYINATE7lfBVrkQimsN3Wmm1EjAfIlDCUcZCoTfRwTGy3gcz9MR3i7BdR
 Geuw==
X-Gm-Message-State: APjAAAV3s176hRIls1iD3qlxC7dnKgKBbkdyWput5zk4/VlRemR6iycv
 WmBpv9eUI/y3MmA8syR5sNDlK+ipp4/zuKY75OqX8A==
X-Google-Smtp-Source: APXvYqyIMTFxKGc6D1YXU0ndNirRhteuuYYCoUF36mBm/h8IlIwZCOCTMDZ/ArB6A6353FJn5yq83+oRs7iRVJJ6rks=
X-Received: by 2002:a5d:8ad0:: with SMTP id e16mr22566875iot.262.1564988390818; 
 Sun, 04 Aug 2019 23:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564529681.git.alistair.francis@wdc.com>
 <d35fb37b43115418a497bcb0bfea187a0c1c46bf.1564529681.git.alistair.francis@wdc.com>
In-Reply-To: <d35fb37b43115418a497bcb0bfea187a0c1c46bf.1564529681.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Mon, 5 Aug 2019 14:59:38 +0800
Message-ID: <CAEiOBXW4cHBfZY7w_RQJi57ranQ+FZ9r+E91HOYdUkk8X1iggw@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH-4.2 v2 3/5] target/riscv: Create function
 to test if FP is enabled
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 7:39 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> Let's create a function that tests if floating point support is
> enabled. We can then protect all floating point operations based on if
> they are enabled.
>
> This patch so far doesn't change anything, it's just preparing for the
> Hypervisor support for floating point operations.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  target/riscv/cpu.h        |  6 +++++-
>  target/riscv/cpu_helper.c | 10 ++++++++++
>  target/riscv/csr.c        | 20 +++++++++++---------
>  3 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f32..2dc9b17678 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -255,6 +255,7 @@ void riscv_cpu_do_interrupt(CPUState *cpu);
>  int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
> +bool riscv_cpu_fp_enabled(CPURISCVState *env);
>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> @@ -298,7 +299,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVStat=
e
> *env, target_ulong *pc,
>  #ifdef CONFIG_USER_ONLY
>      *flags =3D TB_FLAGS_MSTATUS_FS;
>  #else
> -    *flags =3D cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> +    *flags =3D cpu_mmu_index(env, 0);
> +    if (riscv_cpu_fp_enabled(env)) {
> +        *flags |=3D env->mstatus & MSTATUS_FS;
> +    }
>  #endif
>  }
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index f027be7f16..225e407cff 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -71,6 +71,16 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int
> interrupt_request)
>
>  #if !defined(CONFIG_USER_ONLY)
>
> +/* Return true is floating point support is currently enabled */
> +bool riscv_cpu_fp_enabled(CPURISCVState *env)
> +{
> +    if (env->mstatus & MSTATUS_FS) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>  {
>      CPURISCVState *env =3D &cpu->env;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e0d4586760..2789215b5e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -46,7 +46,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations
> *ops)
>  static int fs(CPURISCVState *env, int csrno)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>  #endif
> @@ -108,7 +108,7 @@ static int pmp(CPURISCVState *env, int csrno)
>  static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>  #endif
> @@ -119,7 +119,7 @@ static int read_fflags(CPURISCVState *env, int csrno,
> target_ulong *val)
>  static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>      env->mstatus |=3D MSTATUS_FS;
> @@ -131,7 +131,7 @@ static int write_fflags(CPURISCVState *env, int csrno=
,
> target_ulong val)
>  static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>  #endif
> @@ -142,7 +142,7 @@ static int read_frm(CPURISCVState *env, int csrno,
> target_ulong *val)
>  static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>      env->mstatus |=3D MSTATUS_FS;
> @@ -154,7 +154,7 @@ static int write_frm(CPURISCVState *env, int csrno,
> target_ulong val)
>  static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>  #endif
> @@ -166,7 +166,7 @@ static int read_fcsr(CPURISCVState *env, int csrno,
> target_ulong *val)
>  static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>      env->mstatus |=3D MSTATUS_FS;
> @@ -307,6 +307,7 @@ static int write_mstatus(CPURISCVState *env, int
> csrno, target_ulong val)
>  {
>      target_ulong mstatus =3D env->mstatus;
>      target_ulong mask =3D 0;
> +    int dirty;
>
>      /* flush tlb on mstatus fields that affect VM */
>      if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
> @@ -340,8 +341,9 @@ static int write_mstatus(CPURISCVState *env, int
> csrno, target_ulong val)
>
>      mstatus =3D (mstatus & ~mask) | (val & mask);
>
> -    int dirty =3D ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS) |
> -                ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
> +    dirty =3D (riscv_cpu_fp_enabled(env) &&
> +             ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS)) |
> +            ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
>      mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
>      env->mstatus =3D mstatus;
>
> --
> 2.22.0
>
>
> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
