Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E915BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CCD207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="tjF98riX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CCD207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrdA-0006d7-VX
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jbrcA-00051R-Jq
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:16:26 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jbrc9-0003fZ-5b
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:16:26 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ci23so3782560pjb.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=jr5/31X31VRbl+io4/+HePw23gY1Eg6X7jLbJoD9A9o=;
 b=tjF98riXmLzfLe//3hsFzPG3NpQq7R3BU6Fg97G341L3TwVN816aFVDTgeeI5Dj70V
 9gXO+mrWkNUDm/cT+YHhxV+E9FyiRibN8WIRtvxK74jslGAE4N508CouVyBrO20+rj50
 TUBLT286rcsOUE8TibkQRYka7l3VY9gYtMw4xGpB7U4AnP5eLMaaoAKsEgcEQn5mkGgn
 tqxPg+9BajLakS1wgKumVGmsmXLWhgs9JZsOGx7McviLgZHm68ff05Sox0Vir3HfWDgf
 PFKUKqWy23+1VE/QjIRyO1fnRJ/0kUPVWZL52Un8J0F+2PzSZYIqW8eWXiTtoaP7msDp
 S5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=jr5/31X31VRbl+io4/+HePw23gY1Eg6X7jLbJoD9A9o=;
 b=plqp8K/v/7gSuab2nDqLwo+ebr+XTFwrIEMvHP87f3flYkMlbN0p9ToQoMy8U4BJQG
 Jxr9m5zSTLHVx2sTJmplvEwm9NlB6POSkOwPlJ6P1hD+nniUJp22yzHcbHzCYk3/yU7R
 aCXWYKTNYgqL3IuGMY09cgi9HzfQ5jQgCRQIUb8ELmEKFKdTmp6KUKpEHCkG9pXeC+Kf
 Nq+zrFS3QiEA441SeXTRBYJObN4ekjjWhC8ESzy2tWtfBhNwcGkIWkd/Jf8bGHT7QwNt
 5hAQsokQnAhVA6AzkmqQSTCfQvbJJd8F7zZKPFGA0EDVN/n7Dt0RdP7zhrghxeTwbCV0
 IdaQ==
X-Gm-Message-State: AOAM531q4xBjcvqfcf5st6t9viL4bezliUprDLu9qPfEM7okFlkAcXtj
 SkKvNASpTHbRZyAAtGgRe/P0Iw==
X-Google-Smtp-Source: ABdhPJyQD5B+811k8QXsZhRdmxBVNI2FBEWUxalNS4qGFE0sGrnkdmgYiXVjUc+Du/BKieFsATGjWA==
X-Received: by 2002:a17:90a:154b:: with SMTP id
 y11mr289443pja.158.1590092183021; 
 Thu, 21 May 2020 13:16:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id h16sm5230807pfq.56.2020.05.21.13.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:16:21 -0700 (PDT)
Date: Thu, 21 May 2020 13:16:21 -0700 (PDT)
X-Google-Original-Date: Thu, 21 May 2020 13:01:03 PDT (-0700)
Subject: Re: [PATCH 1/4] hw/riscv: Allow creating multiple instances of CLINT
In-Reply-To: <20200516063746.18296-2-anup.patel@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-157717c7-bbd5-4338-9efd-015f3f6a6e28@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=palmer@dabbelt.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 23:37:43 PDT (-0700), Anup Patel wrote:
> We extend CLINT emulation to allow multiple instances of CLINT in
> a QEMU RISC-V machine. To achieve this, we remove first HART id
> zero assumption from CLINT emulation.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/riscv/sifive_clint.c         | 20 ++++++++++++--------
>  hw/riscv/sifive_e.c             |  2 +-
>  hw/riscv/sifive_u.c             |  2 +-
>  hw/riscv/spike.c                |  6 +++---
>  hw/riscv/virt.c                 |  2 +-
>  include/hw/riscv/sifive_clint.h |  7 ++++---
>  6 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index e933d35092..7d713fd743 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -78,7 +78,7 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
>      SiFiveCLINTState *clint = opaque;
>      if (addr >= clint->sip_base &&
>          addr < clint->sip_base + (clint->num_harts << 2)) {
> -        size_t hartid = (addr - clint->sip_base) >> 2;
> +        size_t hartid = clint->hartid_base + ((addr - clint->sip_base) >> 2);
>          CPUState *cpu = qemu_get_cpu(hartid);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
> @@ -91,7 +91,8 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
>          }
>      } else if (addr >= clint->timecmp_base &&
>          addr < clint->timecmp_base + (clint->num_harts << 3)) {
> -        size_t hartid = (addr - clint->timecmp_base) >> 3;
> +        size_t hartid = clint->hartid_base +
> +            ((addr - clint->timecmp_base) >> 3);
>          CPUState *cpu = qemu_get_cpu(hartid);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
> @@ -128,7 +129,7 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
>
>      if (addr >= clint->sip_base &&
>          addr < clint->sip_base + (clint->num_harts << 2)) {
> -        size_t hartid = (addr - clint->sip_base) >> 2;
> +        size_t hartid = clint->hartid_base + ((addr - clint->sip_base) >> 2);
>          CPUState *cpu = qemu_get_cpu(hartid);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
> @@ -141,7 +142,8 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
>          return;
>      } else if (addr >= clint->timecmp_base &&
>          addr < clint->timecmp_base + (clint->num_harts << 3)) {
> -        size_t hartid = (addr - clint->timecmp_base) >> 3;
> +        size_t hartid = clint->hartid_base +
> +            ((addr - clint->timecmp_base) >> 3);
>          CPUState *cpu = qemu_get_cpu(hartid);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
> @@ -185,6 +187,7 @@ static const MemoryRegionOps sifive_clint_ops = {
>  };
>
>  static Property sifive_clint_properties[] = {
> +    DEFINE_PROP_UINT32("hartid-base", SiFiveCLINTState, hartid_base, 0),
>      DEFINE_PROP_UINT32("num-harts", SiFiveCLINTState, num_harts, 0),
>      DEFINE_PROP_UINT32("sip-base", SiFiveCLINTState, sip_base, 0),
>      DEFINE_PROP_UINT32("timecmp-base", SiFiveCLINTState, timecmp_base, 0),
> @@ -226,13 +229,13 @@ type_init(sifive_clint_register_types)
>  /*
>   * Create CLINT device.
>   */
> -DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
> -    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
> -    bool provide_rdtime)
> +DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
> +    uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
> +    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime)
>  {
>      int i;
>      for (i = 0; i < num_harts; i++) {
> -        CPUState *cpu = qemu_get_cpu(i);
> +        CPUState *cpu = qemu_get_cpu(hartid_base + i);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
>              continue;
> @@ -246,6 +249,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
>      }
>
>      DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_CLINT);
> +    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
>      qdev_prop_set_uint32(dev, "num-harts", num_harts);
>      qdev_prop_set_uint32(dev, "sip-base", sip_base);
>      qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index b53109521e..1c3b37d0ba 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -163,7 +163,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          SIFIVE_E_PLIC_CONTEXT_STRIDE,
>          memmap[SIFIVE_E_PLIC].size);
>      sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
> -        memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
> +        memmap[SIFIVE_E_CLINT].size, 0, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
>      create_unimplemented_device("riscv.sifive.e.aon",
>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index bed10fcfa8..22997fbf13 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -601,7 +601,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
>          serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
>      sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
> -        memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
> +        memmap[SIFIVE_U_CLINT].size, 0, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
>
>      object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index d0c4843712..d5e0103d89 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -253,7 +253,7 @@ static void spike_board_init(MachineState *machine)
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
>          false);
>  }
>
> @@ -343,7 +343,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
>          false);
>  }
>
> @@ -452,7 +452,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
>          false);
>
>      g_free(config_string);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index daae3ebdbb..dcb8a83b35 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -596,7 +596,7 @@ static void riscv_virt_board_init(MachineState *machine)
>          VIRT_PLIC_CONTEXT_STRIDE,
>          memmap[VIRT_PLIC].size);
>      sifive_clint_create(memmap[VIRT_CLINT].base,
> -        memmap[VIRT_CLINT].size, smp_cpus,
> +        memmap[VIRT_CLINT].size, 0, smp_cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
>      sifive_test_create(memmap[VIRT_TEST].base);
>
> diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
> index 4a720bfece..9f5fb3d31d 100644
> --- a/include/hw/riscv/sifive_clint.h
> +++ b/include/hw/riscv/sifive_clint.h
> @@ -33,6 +33,7 @@ typedef struct SiFiveCLINTState {
>
>      /*< public >*/
>      MemoryRegion mmio;
> +    uint32_t hartid_base;
>      uint32_t num_harts;
>      uint32_t sip_base;
>      uint32_t timecmp_base;
> @@ -40,9 +41,9 @@ typedef struct SiFiveCLINTState {
>      uint32_t aperture_size;
>  } SiFiveCLINTState;
>
> -DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
> -    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
> -    bool provide_rdtime);
> +DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
> +    uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
> +    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime);
>
>  enum {
>      SIFIVE_SIP_BASE     = 0x0,

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

