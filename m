Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6AFC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778B62076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ykEn1vR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778B62076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThTP-0007ff-Fd
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh8G-0002w7-Hd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh8F-0000ux-OY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:27:48 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jTh8B-0000rI-0s; Wed, 29 Apr 2020 03:27:43 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 824BB96EF0;
 Wed, 29 Apr 2020 07:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588145261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRPxFcTt97/CgfBx4Hwtkr2YGSp9F9XZKDpY5xF9yco=;
 b=ykEn1vR+m2e5To4Yyd4MeoPUbQILA5/5X4ALLUOtbqu6tNdT420Ak/OEIyyGgnWOTGRvYV
 G/UZAz2yfUZJ+Bxvn5vTMXDVAi/bMXYVTTTFz1SvmXmHRfCZqE2/s7NZ48U8DR0BRwEjg2
 A6RsrnyQ78RgeE+Y28oewoiUrSpdkVg=
Subject: Re: [PATCH v1 04/11] hw/arm: versal: Embedd the UARTs into the SoC
 type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-5-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <47568156-f9f1-ac9d-3d8f-8ccf98ba934f@greensocs.com>
Date: Wed, 29 Apr 2020 09:27:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-5-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588145261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRPxFcTt97/CgfBx4Hwtkr2YGSp9F9XZKDpY5xF9yco=;
 b=mFB8aVRllB/diCe0uZJdliT5HOQNA6AqQG+o49n7BUoiihcKOLlN8FSvRKyjT46wQNz9re
 ldghKGA3iF0o5n52E6CyzFX8AAHOvgpQoUGm7pfzIgLwK95PscVOcABFcEcpcm8adi3hb8
 m/Qk/5YxNyIvRj89M8RxBUj/rulGx7M=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588145261; a=rsa-sha256; cv=none;
 b=OFQLJ3f7cGTBBPEvbHLypRr0jz6xzRYQc4Z0nsuJtLVTWX94xhSrfi6YG8B7YBZrPLV37Y
 aRT6KkCXjWiESgbqMkhwMQlUgJbrBwAvg9k8ix/HPKms/fd1tXg+6sURPXsMk8mmcYSEra
 AjaQ+lK063vhNP2TKqa4QCxlVtgRDgM=
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
> Embedd the UARTs into the SoC type.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Hi Edgar,

Just a small thing, I find it easier to review when you have

[diff]
    orderFile = scripts/git.orderfile

in your QEMU's .git/config. This way header files come first in the patches.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal.c         | 12 ++++++------
>  include/hw/arm/xlnx-versal.h |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index cc696e44c0..dbde03b7e6 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -21,7 +21,6 @@
>  #include "kvm_arm.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/arm/xlnx-versal.h"
> -#include "hw/char/pl011.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define GEM_REVISION        0x40070106
> @@ -144,16 +143,17 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
>          DeviceState *dev;
>          MemoryRegion *mr;
>  
> -        dev = qdev_create(NULL, TYPE_PL011);
> -        s->lpd.iou.uart[i] = SYS_BUS_DEVICE(dev);
> +        sysbus_init_child_obj(OBJECT(s), name,
> +                              &s->lpd.iou.uart[i], sizeof(s->lpd.iou.uart[i]),
> +                              TYPE_PL011);
> +        dev = DEVICE(&s->lpd.iou.uart[i]);
>          qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> -        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
>          qdev_init_nofail(dev);
>  
> -        mr = sysbus_mmio_get_region(s->lpd.iou.uart[i], 0);
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
>  
> -        sysbus_connect_irq(s->lpd.iou.uart[i], 0, pic[irqs[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
>          g_free(name);
>      }
>  }
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 6c0a692b2f..a3dfd064b3 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -15,6 +15,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/arm/boot.h"
>  #include "hw/intc/arm_gicv3.h"
> +#include "hw/char/pl011.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
> @@ -49,7 +50,7 @@ typedef struct Versal {
>          MemoryRegion mr_ocm;
>  
>          struct {
> -            SysBusDevice *uart[XLNX_VERSAL_NR_UARTS];
> +            PL011State uart[XLNX_VERSAL_NR_UARTS];
>              SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
>              SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
>          } iou;
> 

