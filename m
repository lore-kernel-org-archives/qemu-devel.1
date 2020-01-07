Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4904AC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2EA20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tc2315Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2EA20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotfT-00054Y-Pw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1iotak-0007js-1r
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1iotai-0003XC-Pr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:33 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1iotai-0003WA-Kf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:32 -0500
Received: by mail-pf1-x442.google.com with SMTP id q8so270852pfh.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=83W6ZA3gNbLCplWGe/dUqMvuWMBcJAboATXE1vGpk4A=;
 b=tc2315Qa7M/Fllb8RfmPNbGngBGybQSPK7WgmmdchKvr+bGH7NfULv7XzMmRtp6VQH
 wMDKDdrX+6NOYNrgCzL33WnMRk0a1LrBqanCTwj/EZKDmaZLY73/xIs/BVTovGDxZPk0
 /dMU5WR19FljT3wdsZlNU2KdQK8cdhwcvPouxBKctJBiqw+Ji/Ggy/W6jzC1Si1Zl0bY
 VCGUC5Hwlkh7oVjqHJJirjIqsCZzGpqhHWaKei7NtqaSkwdFt/AV/2aPkczj+AMWELQf
 xGlwUzoyElXcSA4v/jyBhm/lWqus6OyGUdpKozECPdgMUG/66Ry6vTE6BNxc0TqJ240K
 uFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=83W6ZA3gNbLCplWGe/dUqMvuWMBcJAboATXE1vGpk4A=;
 b=eIDCBRENZno+hVm0/4rYhqES5k/lXEslzICl2N6JCgYNf78PNpZZI7X+uTeWWR0o54
 2teZ4Wm3zG9zSXSScQ5Nb1LCWqD45YFXM8GWBw8qL8fd8vS7yUBM32TplDrAPMOlsLdt
 y21cOrn65aLn9DHJ4YUNG+9yLt49yEDfALhc26nfIaP8rSiRhIQFqjrrx4pGmxD8so6g
 /vNEbxlLmo3p5st1NvVi1JgsJPiJWGpQNSULb926TaL6EkBig8/0vbmFjfcsaEQook4b
 O9g32TjJEFJE48afupqlOaUKtIXRAd0pqL+5XaRVRmbejK0fblgKW8x2OLlKqHoby+nw
 pXeg==
X-Gm-Message-State: APjAAAUMoVTp79B/9q+SCWIOQh4jrfhfrI9A6Fj7f43UU34j+cVjuY5d
 2T7iMoT7/wuSxxTboeLwU6snBiXDJLc=
X-Google-Smtp-Source: APXvYqzLvuBGpUUvGgiEw4wdbP9GYH1byYrvGktLwnChsz2pHR1E515egoyjaIC9B7TzEht1bs3JCQ==
X-Received: by 2002:a63:9d4e:: with SMTP id i75mr783281pgd.231.1578421711043; 
 Tue, 07 Jan 2020 10:28:31 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id y21sm226935pfm.136.2020.01.07.10.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 10:28:30 -0800 (PST)
Date: Tue, 07 Jan 2020 10:28:30 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 10:28:07 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 07/36] target/riscv: Add the virtulisation mode
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <ee07ff556701bfdf0173e73d9ac393273a07d2ce.1575914822.git.alistair.francis@wdc.com>
References: <ee07ff556701bfdf0173e73d9ac393273a07d2ce.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-0d25d117-c97d-4643-9904-fc11f821eeee@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 09 Dec 2019 10:10:58 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h        |  4 ++++
>  target/riscv/cpu_bits.h   |  3 +++
>  target/riscv/cpu_helper.c | 18 ++++++++++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index bab938103d..a73292cd20 100644
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
> @@ -269,6 +271,8 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
> +bool riscv_cpu_virt_enabled(CPURISCVState *env);
> +void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index eeaa03c0f8..2cdb0de4fe 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -430,6 +430,9 @@
>  #define PRV_H 2 /* Reserved */
>  #define PRV_M 3
>
> +/* Virtulisation Register Fields */
> +#define VIRT_ONOFF          1
> +
>  /* RV32 satp CSR field masks */
>  #define SATP32_MODE         0x80000000
>  #define SATP32_ASID         0x7fc00000
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c201919c54..046f3549cc 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -82,6 +82,24 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
>      return false;
>  }
>
> +bool riscv_cpu_virt_enabled(CPURISCVState *env)
> +{
> +    if (!riscv_has_ext(env, RVH)) {
> +        return false;
> +    }
> +
> +    return get_field(env->virt, VIRT_ONOFF);
> +}
> +
> +void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
> +{
> +    if (!riscv_has_ext(env, RVH)) {
> +        return;
> +    }
> +
> +    env->virt = set_field(env->virt, VIRT_ONOFF, enable);
> +}
> +
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>  {
>      CPURISCVState *env = &cpu->env;

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

