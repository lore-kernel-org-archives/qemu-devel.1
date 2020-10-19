Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED3C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130CC2240C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="uxCjtOYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130CC2240C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeRk-00079p-Uu
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kUePX-0005oA-Av
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:17:51 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kUePU-0008IN-VC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:17:50 -0400
Received: by mail-pl1-x644.google.com with SMTP id r10so615529plx.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=hA+27Q2vReqYv1jlnDD4pvZhqdJ9WeiZrgd/5Mu/hbw=;
 b=uxCjtOYghLkgFsJd4/xfLKHiWRkaUwRQ7B2QzOKnQ60IywamXLfsdlLfai/ZSZ9Ovo
 CKavYsIgJPUO1NHy32IKf87BuMkjgjOCfVNPTNGLuMl+/L7ovtiQe+kr0NHD+lZ4jMA5
 YB2PXOqozMnWFzGMB+r3siI1asg44FFrpVX6MuX3Tq3hHnPwM8BOKcHIUvQ5W88rFsi/
 VErzAklupbPhUAYITTJ9T+OW7G8p6aF6rdRz+XxAzQ7PUow4NvxRd+LC9BQgAmfJWvhy
 da4XJDxIwQOVEAyekrXjGrHho7OYc78xmjWjpDWALsobqrjVh67x/riFmG4tYXUzAFn0
 2HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=hA+27Q2vReqYv1jlnDD4pvZhqdJ9WeiZrgd/5Mu/hbw=;
 b=dhnOb8h+exxYK8znaPoa4SDMcEPJV98KwbItwOO7RzEz/r/K+aRPhdM50qg/JxLQFu
 r98IOlROyhcsAy73iixs91lKzTlXrnc+SPTss2DNidMSzD+IkZWZzrfdl6UoLGdmAIJU
 i0ejJ6kwXTPmRewvDGO8I5XVMUCluuOXzW/4MdKyIuR3F5x9ZxgqYJbPmwdDGzvwx6IP
 WimRwBvaIeIZfK6Cg7z2M1O6RsDI5N+H7rds3lFy6hGxPR1k/fXahM0zYEErsoxd5Z5n
 Rof9TWnnYNi1l1ZGha7p17FiiDTYmO//37zU2V8SdWl5YtH5sgraJiG9vun3tNAiFkim
 QycA==
X-Gm-Message-State: AOAM533yY71FhSdTCgb7JH4+PMYUxNF1h6wCeI3CqxC0LfL/Y2qBb1gV
 j8C7oIeL4w5ffu0gSjUsF94CidjzSPfpSQ==
X-Google-Smtp-Source: ABdhPJzO0dL23IUE9MxxqxcDhV6mxllYts9spK0g854w0mIw+vZHJ65zx5WIVFnlCVzC1q4xBSuPfg==
X-Received: by 2002:a17:902:8bc6:b029:d3:d1ff:91b6 with SMTP id
 r6-20020a1709028bc6b02900d3d1ff91b6mr6287plo.30.1603149466582; 
 Mon, 19 Oct 2020 16:17:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id 63sm61056pfv.25.2020.10.19.16.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 16:17:45 -0700 (PDT)
Date: Mon, 19 Oct 2020 16:17:45 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Oct 2020 14:38:22 PDT (-0700)
Subject: Re: [PATCH v2 1/4] hw/riscv: sifive_u: Allow specifying the CPU
In-Reply-To: <b8412086c8aea0eff30fb7a17f0acf2943381b6a.1602634524.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-2988cebd-17b2-49a9-a23e-1309589c1455@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=palmer@dabbelt.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, bmeng.cn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Oct 2020 17:17:25 PDT (-0700), Alistair Francis wrote:
> Allow the user to specify the main application CPU for the sifive_u
> machine.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>  include/hw/riscv/sifive_u.h |  1 +
>  hw/riscv/sifive_u.c         | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 22e7e6efa1..a9f7b4a084 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -48,6 +48,7 @@ typedef struct SiFiveUSoCState {
>      CadenceGEMState gem;
>
>      uint32_t serial;
> +    char *cpu_type;
>  } SiFiveUSoCState;
>
>  #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 6ad975d692..5f3ad9bc0f 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -424,6 +424,8 @@ static void sifive_u_machine_init(MachineState *machine)
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
>      object_property_set_uint(OBJECT(&s->soc), "serial", s->serial,
>                               &error_abort);
> +    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
> +                             &error_abort);
>      qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
>
>      /* register RAM */
> @@ -590,6 +592,11 @@ static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
>      mc->init = sifive_u_machine_init;
>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
>      mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> +#if defined(TARGET_RISCV32)
> +    mc->default_cpu_type = TYPE_RISCV_CPU_SIFIVE_U34;
> +#elif defined(TARGET_RISCV64)
> +    mc->default_cpu_type = TYPE_RISCV_CPU_SIFIVE_U54;
> +#endif
>      mc->default_cpus = mc->min_cpus;
>
>      object_class_property_add_bool(oc, "start-in-flash",
> @@ -618,7 +625,6 @@ type_init(sifive_u_machine_init_register_types)
>
>  static void sifive_u_soc_instance_init(Object *obj)
>  {
> -    MachineState *ms = MACHINE(qdev_get_machine());
>      SiFiveUSoCState *s = RISCV_U_SOC(obj);
>
>      object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
> @@ -636,10 +642,6 @@ static void sifive_u_soc_instance_init(Object *obj)
>
>      object_initialize_child(OBJECT(&s->u_cluster), "u-cpus", &s->u_cpus,
>                              TYPE_RISCV_HART_ARRAY);
> -    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
> -    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
> -    qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
> -    qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
>
>      object_initialize_child(obj, "prci", &s->prci, TYPE_SIFIVE_U_PRCI);
>      object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
> @@ -661,6 +663,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      int i;
>      NICInfo *nd = &nd_table[0];
>
> +    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
> +    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
> +    qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", s->cpu_type);
> +    qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
> +
>      sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->u_cpus), &error_abort);
>      /*
> @@ -792,6 +799,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>
>  static Property sifive_u_soc_props[] = {
>      DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
> +    DEFINE_PROP_STRING("cpu-type", SiFiveUSoCState, cpu_type),
>      DEFINE_PROP_END_OF_LIST()
>  };

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

