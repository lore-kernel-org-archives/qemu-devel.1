Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C2BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 18:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D25B208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpJuFwO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D25B208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSOwA-0002RM-HC
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 14:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSOvO-000207-Ia
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 14:21:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSOvL-0008SI-Ej
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 14:21:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id a72so571647wme.5
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CbdIQbGBM1rpiQE+pM1z/uQvV2MF/t381pw7jFhwrPY=;
 b=XpJuFwO88tu34hvZP+gNEfn1CVz/RdXYLXWG7qvT/KgsUMUFa8le2R/hA6OdG9aLLt
 SaQu5Fpbk747p81oNV1r/6hSzyjh8OTrvofC3sx7gVM/5f4ZD+2tIMJk/lDZ3iD5dUSX
 Y2i9cyohadJxOL8x0FYAsoMIM/P60h9IwkSFo2E236gZj1BX90JvW42gxxVTClKgcOYd
 tgMZHgP/uo0QL3LB3eRD25uOrlIV6TC7vPtAE3sr5/+3LKBcaQFXVQZPxbxvlx39xLux
 vlXjcKOscqkHwbtAfeEVczaKGu8IMPdyI6T0hdoAkslAoGTZij+J7hfQ/GHq0jICgU22
 dxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CbdIQbGBM1rpiQE+pM1z/uQvV2MF/t381pw7jFhwrPY=;
 b=p4dh7n0w7uxN6YJmB04Ci2kxwXz4+6AUGCR523/qgEHW48mLO4E7JnxASm9Qc7fqQF
 coT+gvn0ntD8p5yaYSav3ahojs0yWHq3EJFqn3ZH2bGNjZxjvsVFW2hSFLjf817Nh8Uo
 oCusg5oesIc2CVGUVkgNPzrW363xkDn03zs6Fvu0Sonh9eBir/um9TuwvSXRll/iERrM
 zKZ66wNZqUoaHTj/hbXEUQMUwM9dqFt4ef3OOV2/rm04ryhFnlQjL68OH7bB23XRj4aL
 H9T8B/EhE91+gsQrX3MFKPpKvvZI1NMdNaODLlNvog5ovireqY43XrM91f28GW1I8dDj
 vfAQ==
X-Gm-Message-State: AOAM531v5jPv2YTeNBhTDcJ9JOiGQoBfZvUeCZkop2TqlLQncWj1gC4f
 VLRKqijlDoYkaOPgrkP0HNXEq5+WQ5U=
X-Google-Smtp-Source: ABdhPJx+g8sT23bGCE9wYr8H6x6SnlwLqPSq1EjvTrJ9InucCv+eRSIlX5j+/AHOqX4QILkDGSbXkQ==
X-Received: by 2002:a1c:e283:: with SMTP id z125mr1165728wmg.154.1602613281400; 
 Tue, 13 Oct 2020 11:21:21 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w5sm596477wmg.42.2020.10.13.11.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 11:21:20 -0700 (PDT)
Subject: Re: [PATCH] mac_via: fix init() and realize() behaviour
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, ehabkost@redhat.com,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20201013162603.9485-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f23abfe8-b84c-7738-1424-9189e3e887fe@amsat.org>
Date: Tue, 13 Oct 2020 20:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013162603.9485-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 6:26 PM, Mark Cave-Ayland wrote:
> The mac_via device does not currently follow the rules for init() and realize() in
> regard to the mos6522 child devices. These child devices must be initialised using
> object_initialize_child() within the mac_via init() function and then realized as
> part of the mac_via realize() function. Move object_initialize_child() from
> realize() to init() which is where the iniitalisation of child devices should occur.

Typo "initialisation".

> 
> Similarly the realize() function creates alias properties to allow the VIA input
> and output IRQs to be wired up to the interrupt controller during machine init, but
> realize() should never alter object properties. Remove these aliases and instead
> use object_resolve_path_component() to access the child objects from the mac_via
> device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c    | 12 ++++++++----
>   hw/misc/mac_via.c | 36 ++++++++++++------------------------
>   2 files changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ce4b47c3e3..773d75c1f8 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -174,6 +174,7 @@ static void q800_init(MachineState *machine)
>       SysBusESPState *sysbus_esp;
>       ESPState *esp;
>       SysBusDevice *sysbus;
> +    MOS6522State *ms;

As we often use 'ms' for MachineState* variable, maybe name
this 'mos' or 'via'?
Also you can use simply a Object*.

>       BusState *adb_bus;
>       NubusBus *nubus;
>       GLUEState *irq;
> @@ -226,9 +227,11 @@ static void q800_init(MachineState *machine)
>       sysbus = SYS_BUS_DEVICE(via_dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       sysbus_mmio_map(sysbus, 0, VIA_BASE);
> -    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0, pic[0]);
> -    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1, pic[1]);
>   
> +    ms = MOS6522(object_resolve_path_component(OBJECT(via_dev), "via1"));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(ms), 0, pic[0]);
> +    ms = MOS6522(object_resolve_path_component(OBJECT(via_dev), "via2"));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(ms), 0, pic[1]);
>   
>       adb_bus = qdev_get_child_bus(via_dev, "adb.0");
>       dev = qdev_new(TYPE_ADB_KEYBOARD);
> @@ -300,11 +303,12 @@ static void q800_init(MachineState *machine)
>   
>       sysbus = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
> -    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in_named(via_dev,
> +    ms = MOS6522(object_resolve_path_component(OBJECT(via_dev), "via2"));
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in_named(DEVICE(ms),
>                                                            "via2-irq",
>                                                            VIA2_IRQ_SCSI_BIT));
>       sysbus_connect_irq(sysbus, 1,
> -                       qdev_get_gpio_in_named(via_dev, "via2-irq",
> +                       qdev_get_gpio_in_named(DEVICE(ms), "via2-irq",
>                                                 VIA2_IRQ_SCSI_DATA_BIT));
>       sysbus_mmio_map(sysbus, 0, ESP_BASE);
>       sysbus_mmio_map(sysbus, 1, ESP_PDMA);
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 6db62dab7d..7c2c943d3f 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -1016,40 +1016,21 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
>       struct tm tm;
>       int ret;
>   
> -    /* Init VIAs 1 and 2 */
> -    object_initialize_child(OBJECT(dev), "via1", &m->mos6522_via1,
> -                            TYPE_MOS6522_Q800_VIA1);
> -
> -    object_initialize_child(OBJECT(dev), "via2", &m->mos6522_via2,
> -                            TYPE_MOS6522_Q800_VIA2);
> -
> -    /* Pass through mos6522 output IRQs */
> -    ms = MOS6522(&m->mos6522_via1);
> -    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]");
> -    ms = MOS6522(&m->mos6522_via2);
> -    object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]");
> -
> +    /* Realize VIAs */
>       sysbus_realize(SYS_BUS_DEVICE(&m->mos6522_via1), &error_abort);
>       sysbus_realize(SYS_BUS_DEVICE(&m->mos6522_via2), &error_abort);
>   
> -    /* Pass through mos6522 input IRQs */
> -    qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
> -    qdev_pass_gpios(DEVICE(&m->mos6522_via2), dev, "via2-irq");
> -
>       /* VIA 1 */
> +    ms = MOS6522(&m->mos6522_via1);
>       m->mos6522_via1.one_second_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> -                                                     via1_one_second,
> -                                                     &m->mos6522_via1);
> -    m->mos6522_via1.VBL_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via1_VBL,
> -                                              &m->mos6522_via1);
> +                                                     via1_one_second, ms);
> +    m->mos6522_via1.VBL_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via1_VBL, ms);

Unrelated to your patch, but doesn't this belong
to mos6522_q800_via1_init()?

>   
>       qemu_get_timedate(&tm, 0);
>       m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
>   
>       adb_register_autopoll_callback(adb_bus, adb_via_poll, m);
> -    m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
> +    m->adb_data_ready = qdev_get_gpio_in_named(DEVICE(ms), "via1-irq",
>                                                  VIA1_IRQ_ADB_READY_BIT);
>   
>       if (m->blk) {
> @@ -1080,6 +1061,13 @@ static void mac_via_init(Object *obj)
>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>       MacVIAState *m = MAC_VIA(obj);
>   
> +    /* Init VIAs 1 and 2 */
> +    object_initialize_child(obj, "via1", &m->mos6522_via1,
> +                            TYPE_MOS6522_Q800_VIA1);
> +
> +    object_initialize_child(obj, "via2", &m->mos6522_via2,
> +                            TYPE_MOS6522_Q800_VIA2);
> +
>       /* MMIO */
>       memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
>       sysbus_init_mmio(sbd, &m->mmio);
> 


