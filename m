Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405DDC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D2A2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="4LA0T3WY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D2A2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThcT-0000nh-VE
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh96-0004gl-Kc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh96-0002aF-4D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:28:40 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jTh94-0002Zl-5A; Wed, 29 Apr 2020 03:28:38 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 98DD896EF0;
 Wed, 29 Apr 2020 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588145316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ofjHj0c5nEZR0uYl7wcCbPxdQq+MqJ13HVGKC/04/Y=;
 b=4LA0T3WYqMdPZZZJk01pp8Ej06AyxWrOXwRQJ8mUjj8GkDkNMrkzOMIoXXdujvyRhJYL7P
 5+grQeTexaECcIsLP/NXjh8knAdH4huAnMY9uYZN/j3VfVp8AhSFXuPLuJ+qMUm9ajSxEV
 4yqMx958sllVb67bNJB5IcAWEY1/mPM=
Subject: Re: [PATCH v1 09/11] hw/arm: versal: Add support for the RTC
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-10-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <05b9a1f9-23fe-490f-359e-50a05cf0c642@greensocs.com>
Date: Wed, 29 Apr 2020 09:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-10-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588145316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ofjHj0c5nEZR0uYl7wcCbPxdQq+MqJ13HVGKC/04/Y=;
 b=1p0TE/QthTlQrIr6Ye8T/1aJfFU8PxaUvDSgDp9LmJ1DHAIQtxNy/VjHfOXG8xlq/3JeIp
 NA8eQylcn7UJg51eA3gnjdeeAbuQq74GEy4+sHDWRB6tc1zo3NNVt0D5fLXPC9tCE3oGR2
 w99xM5knp7LXgDo1GKcktGeSz5LuMNQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588145316; a=rsa-sha256; cv=none;
 b=XRTiYxipLhQQsdLYbFq8TWayKfXKhxgEYYgqKtpGXqmvCVUGHd1ZSD31TGsxt92njX1nMR
 n/P8/Wp+LrFVfnAQjynDkW40vZQV+JKLEQiEorDWj6uwdxFOs9eszKXhm0aqyonxRY8dSC
 OochW3ApUim/t5q9x/9ihgoi/bkm8pU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:23:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 8:16 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> hw/arm: versal: Add support for the RTC.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal.c         | 21 +++++++++++++++++++++
>  include/hw/arm/xlnx-versal.h |  8 ++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index e263bdf77a..321171bcce 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -240,6 +240,26 @@ static void versal_create_sds(Versal *s, qemu_irq *pic)
>      }
>  }
>  
> +static void versal_create_rtc(Versal *s, qemu_irq *pic)
> +{
> +    SysBusDevice *sbd;
> +    MemoryRegion *mr;
> +
> +    sysbus_init_child_obj(OBJECT(s), "rtc", &s->pmc.rtc, sizeof(s->pmc.rtc),
> +                          TYPE_XLNX_ZYNQMP_RTC);
> +    sbd = SYS_BUS_DEVICE(&s->pmc.rtc);
> +    qdev_init_nofail(DEVICE(sbd));
> +
> +    mr = sysbus_mmio_get_region(sbd, 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_PMC_RTC, mr);
> +
> +    /*
> +     * TODO: Connect the ALARM and SECONDS interrupts once our RTC model
> +     * supports them.
> +     */
> +    sysbus_connect_irq(sbd, 1, pic[VERSAL_RTC_APB_ERR_IRQ]);
> +}
> +
>  /* This takes the board allocated linear DDR memory and creates aliases
>   * for each split DDR range/aperture on the Versal address map.
>   */
> @@ -323,6 +343,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_sds(s, pic);
> +    versal_create_rtc(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index e11693e29d..9c9f47ba9d 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -19,6 +19,7 @@
>  #include "hw/char/pl011.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/net/cadence_gem.h"
> +#include "hw/rtc/xlnx-zynqmp-rtc.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
> @@ -65,6 +66,8 @@ typedef struct Versal {
>          struct {
>              SDHCIState sd[XLNX_VERSAL_NR_SDS];
>          } iou;
> +
> +        XlnxZynqMPRTC rtc;
>      } pmc;
>  
>      struct {
> @@ -89,7 +92,10 @@ typedef struct Versal {
>  #define VERSAL_GEM1_IRQ_0          58
>  #define VERSAL_GEM1_WAKE_IRQ_0     59
>  #define VERSAL_ADMA_IRQ_0          60
> +#define VERSAL_RTC_APB_ERR_IRQ     121
>  #define VERSAL_SD0_IRQ_0           126
> +#define VERSAL_RTC_ALARM_IRQ       142
> +#define VERSAL_RTC_SECONDS_IRQ     143
>  
>  /* Architecturally reserved IRQs suitable for virtualization.  */
>  #define VERSAL_RSVD_IRQ_FIRST 111
> @@ -143,4 +149,6 @@ typedef struct Versal {
>  #define MM_PMC_SD0_SIZE             0x10000
>  #define MM_PMC_CRP                  0xf1260000U
>  #define MM_PMC_CRP_SIZE             0x10000
> +#define MM_PMC_RTC                  0xf12a0000
> +#define MM_PMC_RTC_SIZE             0x10000
>  #endif
> 

