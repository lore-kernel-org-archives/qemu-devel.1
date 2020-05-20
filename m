Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8137BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322E62088E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="bgIySXLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322E62088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbXtj-0003gB-FQ
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jbXpd-0000fE-4b
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:09:01 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1jbXpc-00019i-4i
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:09:00 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t40so2081654pjb.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=wnGc4bt7aIHsiLHFRQ+JGJANNW/8Vj0o0EBAtJLTYN8=;
 b=bgIySXLeCDzFQV3EDnZn0VMwoAYuCxMH033dxUF6cJB6luss/BihUFSj+VMTnt6Pam
 rNWbNBzOBu6gaAImDrkyID/Q1p8VNKuTOPh8b8i0lko5bN64y2x+K/TTbGt9QWedzetO
 IFhFzsrBbY7aN/p1O62P57yL0BGWvP8xh4PCwuvhHBqiBgJjj9W/VmFDpsw26MhwccFM
 6tutS520bieNXPqGUwAZ+yzwx3M8i4G+N3Oz6yNnSnB+3hNHM2EBfza2TcRrzYNxb7ze
 RUg8y1T1ws3iY1PJw1ksOyBkrzZlLCc7E1XWCyeTHD8rGafe9z2CWR/8aMM9WGaOLMFo
 cmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=wnGc4bt7aIHsiLHFRQ+JGJANNW/8Vj0o0EBAtJLTYN8=;
 b=XQyC4PfRech+KiJ84/1MARoaGVbBBhQgkzYR6Nd/nT151unU+p3ytLrPqQ6cMuRIvX
 SwsbxhbcFtf51143XAJinXe0zcAujJtCJumk953BY9Eu5gxyi77uhMKoatk0rOCPGqTp
 IgGn4OlCmX5hSh9BjpUEi6h+dIXX0oqmz/7DF63L/zW5nXSi5sm8otKMRK0Lw8TX3Zpb
 M/JYkzGpDDV+7sCpNlmQoBpbkG6d9TCsGG0SYZTr/lJQqmymKXIFh9p8yArxIZgPv88P
 WO6HOpjiNgd2uQK92fPDLvIBlO1A7qpTMOgVsLOOnPLE5K3+L0J/ru/i+9D2qEiXvHjh
 pCsQ==
X-Gm-Message-State: AOAM530Ah78lAfyZtxN11IjTv1uRkybCG6DitdTM/1jvOu2rN9NZg5Rg
 Lg0eEwo/L4+ZNN+Njf6apvjpuBsgpBqV9w==
X-Google-Smtp-Source: ABdhPJy1ImvA9wKwwUoTL+0Km4oEm+KNZjAkVNX7vGHAtBE83pmEt2RhovgBj71dkbvv5ctczAU7Ng==
X-Received: by 2002:a17:90a:4802:: with SMTP id
 a2mr8214221pjh.66.1590016137681; 
 Wed, 20 May 2020 16:08:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id 7sm2954921pfc.203.2020.05.20.16.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:08:56 -0700 (PDT)
Date: Wed, 20 May 2020 16:08:56 -0700 (PDT)
X-Google-Original-Date: Wed, 20 May 2020 16:04:10 PDT (-0700)
Subject: Re: [PATCH v1 1/2] riscv: sifive_e: Manually define the machine
In-Reply-To: <da77b1e0a31f2f8fb18117b20a1493ab1ec0471f.1589489213.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-ca9ba779-53fd-4eae-b04b-e6c921d8333f@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=palmer@dabbelt.com; helo=mail-pj1-x1043.google.com
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 13:47:07 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_e.c         | 41 +++++++++++++++++++++++++++----------
>  include/hw/riscv/sifive_e.h |  4 ++++
>  2 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index b53109521e..472a98970b 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -79,7 +79,7 @@ static void riscv_sifive_e_init(MachineState *machine)
>  {
>      const struct MemmapEntry *memmap = sifive_e_memmap;
>
> -    SiFiveEState *s = g_new0(SiFiveEState, 1);
> +    SiFiveEState *s = RISCV_E_MACHINE(machine);
>      MemoryRegion *sys_mem = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      int i;
> @@ -115,6 +115,35 @@ static void riscv_sifive_e_init(MachineState *machine)
>      }
>  }
>
> +static void sifive_e_machine_instance_init(Object *obj)
> +{
> +}
> +
> +static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "RISC-V Board compatible with SiFive E SDK";
> +    mc->init = riscv_sifive_e_init;
> +    mc->max_cpus = 1;
> +    mc->default_cpu_type = SIFIVE_E_CPU;
> +}
> +
> +static const TypeInfo sifive_e_machine_typeinfo = {
> +    .name       = MACHINE_TYPE_NAME("sifive_e"),
> +    .parent     = TYPE_MACHINE,
> +    .class_init = sifive_e_machine_class_init,
> +    .instance_init = sifive_e_machine_instance_init,
> +    .instance_size = sizeof(SiFiveEState),
> +};
> +
> +static void sifive_e_machine_init_register_types(void)
> +{
> +    type_register_static(&sifive_e_machine_typeinfo);
> +}
> +
> +type_init(sifive_e_machine_init_register_types)
> +
>  static void riscv_sifive_e_soc_init(Object *obj)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> @@ -214,16 +243,6 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          &s->xip_mem);
>  }
>
> -static void riscv_sifive_e_machine_init(MachineClass *mc)
> -{
> -    mc->desc = "RISC-V Board compatible with SiFive E SDK";
> -    mc->init = riscv_sifive_e_init;
> -    mc->max_cpus = 1;
> -    mc->default_cpu_type = SIFIVE_E_CPU;
> -}
> -
> -DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
> -
>  static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 25ce7aa9d5..414992119e 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -47,6 +47,10 @@ typedef struct SiFiveEState {
>      SiFiveESoCState soc;
>  } SiFiveEState;
>
> +#define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")
> +#define RISCV_E_MACHINE(obj) \
> +    OBJECT_CHECK(SiFiveEState, (obj), TYPE_RISCV_E_MACHINE)
> +
>  enum {
>      SIFIVE_E_DEBUG,
>      SIFIVE_E_MROM,

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

