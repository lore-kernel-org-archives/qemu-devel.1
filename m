Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC9C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0325420578
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nZYmXg1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0325420578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dhP-0001YK-6J
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1i2dg3-0000xd-1C
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1i2dg1-0003sS-8h
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:46:34 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:39381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1i2dg1-0003s8-3N
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:46:33 -0400
Received: by mail-io1-xd2e.google.com with SMTP id l7so47442587ioj.6
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q2R1DiCbYnDpdIdAhfvngz7BvHBfQBnxrwDisd5sO3A=;
 b=nZYmXg1gMP0+b5uOCX1X9VHHHHS+DVjHQ1+zEw0j9cC25ixT4bbdc8R20Gv0XurJkS
 t7pyA1zw+9vsDUSfvOprGcZmrQAlXuUX+sv7dBG7ds7hBf6QCMV51729x/v3n91lxD35
 zPjUz0V6RGbQMLeHi92qTeoN2X/LjyYtlmOZJSIgjGOzIHO6jBZvdxm8vwYvSelxjnMP
 FFU9YAH7smnvTyR3ccRSJ9jPrdOVvc/ruhHplswsZEDWhR1pPP5JyL/jaGfK9LUrRRn6
 i/Vs5cWMIOYlff9FZne4kwNhVlCImF83IjcOruRgtp7cCPGuCISV4x286Dzb1PDGmEQ5
 7ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q2R1DiCbYnDpdIdAhfvngz7BvHBfQBnxrwDisd5sO3A=;
 b=VgwXfNDedp/ViKgzrnYBcAYIDep2K5wAZAkmUiAmd2eHcg3oOioW6DUJVkdXjnbWoD
 G1ktqOvOv2+IGaTKSSdQjQIDpR2KVndODUaLfAyhwKmt3v0X7UdgQRTGRdxVX2AKI/4j
 bJbtlqGc8BfFXSf1GlzWpduYvk0Xmg8lex9bBMw4Y/TXCBPDc5WKl/rZCcRjMMsUfSXp
 65p6YKg2kKwG+9PhBLEnN0eSrzIjeHbq749Vig8BFAWSFVPSnxw4YkKxobRI6uA7tktK
 C2NPg6cexDydxp8uJ2EBfGjRNs9vGncsYXSCXwYjIti3kxHHOiQXH/hjBTMZUjWD+bFG
 gvag==
X-Gm-Message-State: APjAAAVk5HwtLyjVkWy+M3Z2Gv/28vMUSQNtbbDnEa2d3BOvm2S2X533
 VDRl7wJNASfcDGCB6c2LTt8vXHEIL4zVnCf8H0Vx2w==
X-Google-Smtp-Source: APXvYqzKfwf4LiMpAoC/x2IJlpdXgrSW6gZfn23cN1hSSkXmjIk3NH9wZDRlUUhQTpfxgLob1tQjpKTz5qCWD1RteHg=
X-Received: by 2002:a02:cb51:: with SMTP id k17mr22947498jap.4.1566920792106; 
 Tue, 27 Aug 2019 08:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566603412.git.alistair.francis@wdc.com>
 <9db2403d223b3e6d2d20086176a975dffabb175b.1566603412.git.alistair.francis@wdc.com>
In-Reply-To: <9db2403d223b3e6d2d20086176a975dffabb175b.1566603412.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 27 Aug 2019 23:46:21 +0800
Message-ID: <CAEiOBXWOFV6jv0HffF4QEtYRhBuNBt9qfTPN6kiN3Pm5uvH__Q@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2e
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 03/28] target/riscv: Add the force HS
 exception mode
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup.Patel@wdc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish.Patra@wdc.com, Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 24, 2019 at 7:50 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h        |  2 ++
>  target/riscv/cpu_bits.h   |  6 ++++++
>  target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0ef1ecb0e0..3a95c41428 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -261,6 +261,8 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int
> interrupt_request);
>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
>  bool riscv_cpu_virt_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
> +bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
> +void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 1fbde516be..204d9d9a79 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -428,6 +428,12 @@
>  #define VIRT_MODE_SHIFT     0
>  #define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
>
> +/* HS-level exception modes */
> +#define CLEAR_HS_EXCEP        0
> +#define FORCE_HS_EXCEP        1
> +#define FORCE_HS_EXCEP_SHIFT  1
> +#define FORCE_HS_EXCEP_MASK   (1 << FORCE_HS_EXCEP_SHIFT)
> +
>  /* RV32 satp CSR field masks */
>  #define SATP32_MODE         0x80000000
>  #define SATP32_ASID         0x7fc00000
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7b0bb14c01..5bcfc2e090 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -104,6 +104,29 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env,
> bool enable)
>      env->virt |= enable << VIRT_MODE_SHIFT;
>  }
>
> +bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env)
> +{
> +    bool tmp;
> +
> +    if (!riscv_has_ext(env, RVH)) {
> +        return false;
> +    }
> +
> +    tmp = (env->virt & FORCE_HS_EXCEP_MASK) >> FORCE_HS_EXCEP_SHIFT;
> +
> +    return tmp == FORCE_HS_EXCEP;
> +}
> +
> +void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
> +{
> +    if (!riscv_has_ext(env, RVH)) {
> +        return;
> +    }
> +
> +    env->virt &= ~FORCE_HS_EXCEP_MASK;
> +    env->virt |= enable << FORCE_HS_EXCEP_SHIFT;
> +}
> +
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>  {
>      CPURISCVState *env = &cpu->env;
> --
> 2.22.0
>
>
> I have the same option as [PATCH 2/28].  Why not to use get_field and
set_field ?

chihmin
