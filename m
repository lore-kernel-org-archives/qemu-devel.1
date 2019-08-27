Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4145AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C86220578
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Pbw28nsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C86220578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dfR-0000P5-8h
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1i2deL-0007s9-CN
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1i2deJ-0002hI-LE
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:44:49 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1i2deJ-0002gw-Ed
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:44:47 -0400
Received: by mail-io1-xd43.google.com with SMTP id t6so47402725ios.7
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UarSeKdjXeP1aEn4NbIhtQ+AJ2Bkzel/hw44s/Uvjb8=;
 b=Pbw28nsf1wDO2DEFCpbvd/AE6rM+HdspTqOrFKRGbaeui28q3al6z+W+1/dCRR8Aup
 4H2+i946vNFAmh0YmKzkVVAUXAliFkON67gdac7IjFrZotuFIcJOFBEqeNzAneJWgRej
 7tzp/3YwUNwlH3aEQEsTBbh9wKvMoOhJwhKGRjdjW+stbguAJqYXoGT4Mh6zkOZQ9TMz
 Q46NLkMnCAc/XJQwDKdVtiH4q2twitYb6O1Gom4KjqtkU9773z7/fQ2ZlVPEbBGgdKvh
 C0BjeiHlsifb537WoB9ziNCYoD1dKXBBFLY2yGBZ6UAO0boMwAE92vHDAMm6lmF4dt8z
 d3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UarSeKdjXeP1aEn4NbIhtQ+AJ2Bkzel/hw44s/Uvjb8=;
 b=b/Rph4Qh9A4cbFp4IKzo/RKrNLtoFYJSZ7pRhSc2yx4nRqtxAhL8ZzqXlJOFWX9k/S
 mCin3N+3GI5KTkT8vLRJmgwy1FVK8p1KTS4dYQxMzqcWYQQyaKRP/TPDs9LVRBb9/IG5
 VoPVYHhVLacN1stTAWlMKfl5ZYurr+vu3g+1C+QDLNMnDmnDvH6meIbk2HoU9FkZbGRA
 JNLOw3Rqduiooeyezs1sd0ujDMMiHEiT6CrnL5BQfTnc6m4zrHORBBRNAvlCg6NlFVTH
 Z/U8P00ABDWj3/5wxXso4ofezMz1ZllcUnURRRsvI4y8UNk/h0YBqXheJGuExYlVH/Sk
 maYA==
X-Gm-Message-State: APjAAAVXiqqiZDKCF5x2h7o/IfoLPjfDIdMSsVKo41EYghpV60rZ2r/S
 wTCOXbaBOmqV+bf7x9HDRqNjZxGlScHw93r1c/KvVA==
X-Google-Smtp-Source: APXvYqxPZ3feSA3jyOqNui6ns2lLucOERcjLwPVojkTQUNRMPtAIpyvJwlEs+TNXNot2LToimQG+1mxq32yLnTBZi68=
X-Received: by 2002:a5e:a70b:: with SMTP id b11mr1302609iod.286.1566920686428; 
 Tue, 27 Aug 2019 08:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566603412.git.alistair.francis@wdc.com>
 <1c1d359caa6633349158debc38e07156a10b63e8.1566603412.git.alistair.francis@wdc.com>
In-Reply-To: <1c1d359caa6633349158debc38e07156a10b63e8.1566603412.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 27 Aug 2019 23:44:35 +0800
Message-ID: <CAEiOBXUeKnPyZd7i5Aqw5+G2G9M-OeWxsBqTsF0MTV_abkDe5A@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v1 02/28] target/riscv: Add
 the virtulisation mode
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

On Sat, Aug 24, 2019 at 7:41 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h        |  4 ++++
>  target/riscv/cpu_bits.h   |  6 ++++++
>  target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7f54fb8c87..0ef1ecb0e0 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -117,6 +117,8 @@ struct CPURISCVState {
>
>  #ifndef CONFIG_USER_ONLY
>      target_ulong priv;
> +    /* This contains QEMU specific information about the virt state. */
> +    target_ulong virt;
>      target_ulong resetvec;
>
>      target_ulong mhartid;
> @@ -257,6 +259,8 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t
> *buf, int reg);
>  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
> +bool riscv_cpu_virt_enabled(CPURISCVState *env);
> +void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e99834856c..1fbde516be 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -422,6 +422,12 @@
>  #define PRV_H 2 /* Reserved */
>  #define PRV_M 3
>
> +/* Virtulisation modes */
> +#define VIRT_OFF            0
> +#define VIRT_ON             1
> +#define VIRT_MODE_SHIFT     0
> +#define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
> +
>
 /* RV32 satp CSR field masks */
>  #define SATP32_MODE         0x80000000
>  #define SATP32_ASID         0x7fc00000
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 225e407cff..7b0bb14c01 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -81,6 +81,29 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
>      return false;
>  }
>
> +bool riscv_cpu_virt_enabled(CPURISCVState *env)
> +{
> +    bool tmp;
> +
> +    if (!riscv_has_ext(env, RVH)) {
> +        return false;
> +    }
> +
> +    tmp = (env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT;
> +
> +    return tmp == VIRT_ON;
> +}
> +
> +void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
> +{
> +    if (!riscv_has_ext(env, RVH)) {
> +        return;
> +    }
> +
> +    env->virt &= ~VIRT_MODE_MASK;
> +    env->virt |= enable << VIRT_MODE_SHIFT;
> +}
> +
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>  {
>      CPURISCVState *env = &cpu->env;
> --
> 2.22.0
>
> Why not to use get_field and set_field though it is not a real register
but an internal state

#define VIRT_ONOFF            0x01
#define VIRT_OFF             0
#define VIRT_ON             1

access
       get_field(env->virt, VIRT_ONOFF);
       set_field(env->virt, VIRT_ONOFF, enable);


chihmin
