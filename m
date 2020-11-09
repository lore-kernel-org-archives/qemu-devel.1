Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC2BC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C5220674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyqNpwNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C5220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc86Q-0003Rk-5Z
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc7wl-0000HU-Nm
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:15:03 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc7wj-0004L2-8I
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:15:03 -0500
Received: by mail-wr1-x444.google.com with SMTP id b8so8853197wrn.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KqwmONtg6/Lh/zKnkGWQXGjMx+Lf6gMyRGqdtoy9wYQ=;
 b=HyqNpwNQ0QMWT9DQokdk1jGix/rCVrtb2oUYapC67Q35RMLaO/mxJ1eLFod56LrSoF
 8uEW+sqRC8FR4TqQjVoKS/CPShHYOxi5lGc3XGFPjWUOxxVfqPTINPSzHwZmoQe5EdWQ
 Gvsff/7C0AaHj46t/HfFUIOwiDpI5ulEsUPFd73NhoF+VXpuzjj89qqsoxQuXmMSsXi6
 /QqzRxgmyfzAxS8qA91pRl8GFt4Sih/wBY2pVNyVBeF6FKc8nUdyjOjqex0ZT5Pd87W0
 nMG5P6nLxdc+H6HxWomRSdAb6XLG9gw2q3yll5tJMxxiRW4+J7EsX5AVyrz/99hh6USa
 Xs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KqwmONtg6/Lh/zKnkGWQXGjMx+Lf6gMyRGqdtoy9wYQ=;
 b=Aeh5Q0XjBr/JcsWMSN5PMOZbJDIso7ayaXazL9pjgfut3IxQdAyYrR3G1n88Wx8CxQ
 PUh4g192tt6WVj4pNl8WCOcAa0dj/LqW4bHU70WA3q4mCGz0N8quvVbvOeAwZMmk5AWX
 8ymYnh/j8TigPfuj8IO5JiCSY1t8lUPYv1K9+cYBxkvVjKAUMwiG2bEYRx3f+3uj4fp8
 385Mu00bnCx4ox38wwYg/+maeFwJPSQE9UQczqX/JzvTV7Tmst6tkxDyJLiTNv/xXSPj
 iROXI67QeayvxPkVApKCNch+DzDCkjhJ2+InstlZvPFx42mPigHD8LEZURvfoy3sFtwP
 EHGw==
X-Gm-Message-State: AOAM533Cl+KkjrEFqIz0hE5WKKII2rz5RfTUmReHSuPl+ljpJ2+VsS2y
 JxmiAh4zMYl3YZzFRbzOnsg=
X-Google-Smtp-Source: ABdhPJz/zYWJe9QXrqKs384zMoVuAsSF1h4bdUpIZmpg2WAN7GmzvnpRF/nuhD6FFXsH+7Tlzg99+Q==
X-Received: by 2002:a05:6000:36f:: with SMTP id
 f15mr18085829wrf.78.1604931299644; 
 Mon, 09 Nov 2020 06:14:59 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t12sm13513642wrm.25.2020.11.09.06.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:14:58 -0800 (PST)
Subject: Re: [PATCH 2/2] hw/m68k/q800.c: Make the GLUE chip an actual QOM
 device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106235109.7066-1-peter.maydell@linaro.org>
 <20201106235109.7066-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b957ada3-cbc7-d1fa-750d-f201c3bef2c6@amsat.org>
Date: Mon, 9 Nov 2020 15:14:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106235109.7066-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 11/7/20 12:51 AM, Peter Maydell wrote:
> The handling of the GLUE (General Logic Unit) device is
> currently open-coded. Make this into a proper QOM device.
> 
> This minor piece of modernisation gets rid of the free
> floating qemu_irq array 'pic', which Coverity points out
> is technically leaked when we exit the machine init function.
> (The replacement glue device is not leaked because it gets
> added to the sysbus, so it's accessible via that.)
> 
> Fixes: Coverity CID 1421883
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/q800.c | 82 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index dc13007aaf2..05bb372f958 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -47,6 +47,7 @@
>  #include "sysemu/qtest.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/reset.h"
> +#include "migration/vmstate.h"
>  
>  #define MACROM_ADDR     0x40800000
>  #define MACROM_SIZE     0x00100000
> @@ -94,10 +95,14 @@
>   * CPU.
>   */
>  
> -typedef struct {
> +#define TYPE_GLUE "q800-glue"
> +OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
> +
> +struct GLUEState {
> +    SysBusDevice parent_obj;
>      M68kCPU *cpu;
>      uint8_t ipr;
> -} GLUEState;
> +};
>  
>  static void GLUE_set_irq(void *opaque, int irq, int level)
>  {
> @@ -119,6 +124,58 @@ static void GLUE_set_irq(void *opaque, int irq, int level)
>      m68k_set_irq_level(s->cpu, 0, 0);
>  }
>  
> +static void glue_reset(DeviceState *dev)
> +{
> +    GLUEState *s = GLUE(dev);
> +
> +    s->ipr = 0;
> +}
> +
> +static const VMStateDescription vmstate_glue = {
> +    .name = "q800-glue",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(ipr, GLUEState),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +/*
> + * If the m68k CPU implemented its inbound irq lines as GPIO lines
> + * rather than via the m68k_set_irq_level() function we would not need
> + * this cpu link property and could instead provide outbound IRQ lines
> + * that the board could wire up to the CPU.
> + */
> +static Property glue_properties[] = {
> +    DEFINE_PROP_LINK("cpu", GLUEState, cpu, TYPE_M68K_CPU, M68kCPU *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void glue_init(Object *obj)
> +{
> +    DeviceState *dev = DEVICE(obj);
> +
> +    qdev_init_gpio_in(dev, GLUE_set_irq, 8);
> +}
> +
> +static void glue_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_glue;
> +    dc->reset = glue_reset;

Don't we need a realize() handler checking s->cpu is non-NULL?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    device_class_set_props(dc, glue_properties);
> +}
> +
> +static const TypeInfo glue_info = {
> +    .name = TYPE_GLUE,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(GLUEState),
> +    .instance_init = glue_init,
> +    .class_init = glue_class_init,
> +};
> +
>  static void main_cpu_reset(void *opaque)
>  {
>      M68kCPU *cpu = opaque;
> @@ -178,8 +235,7 @@ static void q800_init(MachineState *machine)
>      SysBusDevice *sysbus;
>      BusState *adb_bus;
>      NubusBus *nubus;
> -    GLUEState *irq;
> -    qemu_irq *pic;
> +    DeviceState *glue;
>      DriveInfo *dinfo;
>  
>      linux_boot = (kernel_filename != NULL);
> @@ -213,10 +269,9 @@ static void q800_init(MachineState *machine)
>      }
>  
>      /* IRQ Glue */
> -
> -    irq = g_new0(GLUEState, 1);
> -    irq->cpu = cpu;
> -    pic = qemu_allocate_irqs(GLUE_set_irq, irq, 8);
> +    glue = qdev_new(TYPE_GLUE);
> +    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
>  
>      /* VIA */
>  
> @@ -228,8 +283,10 @@ static void q800_init(MachineState *machine)
>      sysbus = SYS_BUS_DEVICE(via_dev);
>      sysbus_realize_and_unref(sysbus, &error_fatal);
>      sysbus_mmio_map(sysbus, 0, VIA_BASE);
> -    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0, pic[0]);
> -    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1, pic[1]);
> +    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0,
> +                                qdev_get_gpio_in(glue, 0));
> +    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1,
> +                                qdev_get_gpio_in(glue, 1));
>  
>  
>      adb_bus = qdev_get_child_bus(via_dev, "adb.0");
> @@ -270,7 +327,7 @@ static void q800_init(MachineState *machine)
>      sysbus_realize_and_unref(sysbus, &error_fatal);
>      sysbus_mmio_map(sysbus, 0, SONIC_BASE);
>      sysbus_mmio_map(sysbus, 1, SONIC_PROM_BASE);
> -    sysbus_connect_irq(sysbus, 0, pic[2]);
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, 2));
>  
>      /* SCC */
>  
> @@ -292,7 +349,7 @@ static void q800_init(MachineState *machine)
>      qdev_realize_and_unref(escc_orgate, NULL, &error_fatal);
>      sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
>      sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
> -    qdev_connect_gpio_out(DEVICE(escc_orgate), 0, pic[3]);
> +    qdev_connect_gpio_out(DEVICE(escc_orgate), 0, qdev_get_gpio_in(glue, 3));
>      sysbus_mmio_map(sysbus, 0, SCC_BASE);
>  
>      /* SCSI */
> @@ -457,6 +514,7 @@ static const TypeInfo q800_machine_typeinfo = {
>  static void q800_machine_register_types(void)
>  {
>      type_register_static(&q800_machine_typeinfo);
> +    type_register_static(&glue_info);
>  }
>  
>  type_init(q800_machine_register_types)
> 


