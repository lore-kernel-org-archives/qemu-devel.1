Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5728C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B90C207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz+A5+ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B90C207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwaHa-0000Cm-OJ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 18:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iwaGp-0008AI-3k
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iwaGn-000225-Ud
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:27:46 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iwaGn-0001yO-NE; Tue, 28 Jan 2020 18:27:45 -0500
Received: by mail-lj1-x243.google.com with SMTP id y6so16562761lji.0;
 Tue, 28 Jan 2020 15:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4PKHUnAgCm58jfcKAD2lQvWlutxR+lsplLxYXjp+J8U=;
 b=iz+A5+ezpMUpgEllWqUgb2E1P8tEqSlGnLRkeKsJm4r8Y3SKGqi5HYqsBEHr+XmUxU
 Qky9dy/+XRH9cHyd74er74v6qNc3N9+GnL/GDSAHzkC6w+930PcjaELdtsbxbhYTlSqI
 JgEr/aWhaUtSeKNPUuA4T0Ta3s86RfZ3LHrDPVQPQ8bpZjHAxwkvHgPHA3NUULxZmGnt
 9nBcJQtJEzFqF8e573hDjDGk44yEEJ6xi8MwAhLtOI3/6tGRzZKkLTuYEjyLSx0hX76W
 OYaUsMNTCxorFU4zwVXLPuJIH7MzmCC9orfwrNEo6jrv1Ik7/LXt/9z64U0JH5A4iP9N
 3F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4PKHUnAgCm58jfcKAD2lQvWlutxR+lsplLxYXjp+J8U=;
 b=GJvefw0ul+lqnCpuKj+xysQAzAa6XmHeXxtTozyne4Nrh1b2cnuY5gD12yMSQyqjyx
 0V/DQCdPE2kNBPduPQ2jq3uByrvbahJXawyGlL39kxzIQiWg0QDJ/ExNJwzd8ZcfbBzL
 qzNQECgB7lgCoOaeYRlhpqPOLvGRoL/GRZPNUhAgI4UO0fuNY45zrIC4hFo4/8ZeEB7g
 DDRwXPv6/r/kitIQ3Jsk9ioOn+3Bap7GZY0qDYNrZ3NTW8fP5RSl0mBaj13aqvJDcc6O
 WVKqZ12JWXa5Y5TmdL+xchjQmoELUuKZvwBOIjYsEVLeyGz+KwwwMR+pEXP4mAtuRVqm
 YsNQ==
X-Gm-Message-State: APjAAAVL59otTwP7GPpVJbkaHm0nL8I3phhIj5YUXVFKLzu38D4up1r+
 VLw7BunnS3qXgnd3eyy4c06Mt/150nOWEFYkhfk=
X-Google-Smtp-Source: APXvYqwPiptIIYpFmtKZSLyA2wg4IdYhDO5bgU6Lj7/v8XcJrdhVJ6G4ewSZX2ni6k4U0IPspWVOyJaqja89g+wM6iw=
X-Received: by 2002:a2e:b4ac:: with SMTP id q12mr10001289ljm.285.1580254063352; 
 Tue, 28 Jan 2020 15:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20200128223955.464556-1-keithp@keithp.com>
In-Reply-To: <20200128223955.464556-1-keithp@keithp.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jan 2020 15:27:16 -0800
Message-ID: <CAKmqyKOpG1QYD_w1EHEUEs-8J1RAx=k8xMqxRZ5H0nD2N7q_+w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Separate FPU register size from core register size
 in gdbstub
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 2:40 PM Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> The size of the FPU registers is dictated by the 'f' and 'd' features,
> not the core processor register size. Processors with the 'd' feature
> have 64-bit FPU registers. Processors without the 'd' feature but with
> the 'f' feature have 32-bit FPU registers.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  configure              |  4 ++--
>  target/riscv/gdbstub.c | 18 +++++++++---------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/configure b/configure
> index a72a5def57..c21bff8d10 100755
> --- a/configure
> +++ b/configure
> @@ -7709,13 +7709,13 @@ case "$target_name" in
>      TARGET_BASE_ARCH=riscv
>      TARGET_ABI_DIR=riscv
>      mttcg=yes
> -    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
> +    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
>    ;;
>    riscv64)
>      TARGET_BASE_ARCH=riscv
>      TARGET_ABI_DIR=riscv
>      mttcg=yes
> -    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
> +    gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
>    ;;
>    sh4|sh4eb)
>      TARGET_ARCH=sh4
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 1a7947e019..c1803a5916 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -303,7 +303,10 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>  static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> -        return gdb_get_reg64(mem_buf, env->fpr[n]);
> +        if (env->misa & RVD)
> +            return gdb_get_reg64(mem_buf, env->fpr[n]);
> +        if (env->misa & RVF)
> +            return gdb_get_reg32(mem_buf, env->fpr[n]);

You need brackets around all if statements, besides that:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>      /* there is hole between ft11 and fflags in fpu.xml */
>      } else if (n < 36 && n > 32) {
>          target_ulong val = 0;
> @@ -403,23 +406,20 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> -#if defined(TARGET_RISCV32)
> -    if (env->misa & RVF) {
> +    if (env->misa & RVD) {
> +        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> +                                 36, "riscv-64bit-fpu.xml", 0);
> +    } else if (env->misa & RVF) {
>          gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
>                                   36, "riscv-32bit-fpu.xml", 0);
>      }
> -
> +#if defined(TARGET_RISCV32)
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                               240, "riscv-32bit-csr.xml", 0);
>
>      gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
>                               1, "riscv-32bit-virtual.xml", 0);
>  #elif defined(TARGET_RISCV64)
> -    if (env->misa & RVF) {
> -        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> -                                 36, "riscv-64bit-fpu.xml", 0);
> -    }
> -
>      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
>                               240, "riscv-64bit-csr.xml", 0);
>
> --
> 2.25.0
>
>

