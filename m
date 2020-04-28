Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E17C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B10A206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKZ6X9hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B10A206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLz9-0001Jn-Hs
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTLtk-0005C2-LT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTLNd-0007wZ-GK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:18:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKzI-0008CG-KD; Tue, 28 Apr 2020 03:49:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id b11so23425565wrs.6;
 Tue, 28 Apr 2020 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5LMSjzOiw3vS1NL0Rg/zXUc0FJFWZ1JtR/60p0SqsUE=;
 b=vKZ6X9hnOYJJghdjbd7+OtZGMpKy+YrZiakBHcRQlJce+asDu7KQduSOAiAiTB3RLk
 I1c6U+PQwl49xldynjCgM1AG4LRHs8Vls25ScZL9Y3wtKgkFyhqFhIBCSLEaO99tjthL
 8A1J+IahMC53DJOz/eF5/xGbIfbv/oDCs0N0XJtC65YMmkXSqPe4TY4Mq08cqsfYZ4Js
 8omEV2lyhSTUvYo3JHkvGSFU/Gw4qFf57V77p/a2g3H5IEafOJF9vfnF/VkvQYfjf5Qh
 OZzgqzspuWheQYYLJgm5RjMd44YxilngmR8NYJifHkLavl8OZpZLSwOy3NZGOh+sm9Lx
 Q4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5LMSjzOiw3vS1NL0Rg/zXUc0FJFWZ1JtR/60p0SqsUE=;
 b=POxQTjOeLRor/x+IT8cpInp498XW+NLEwjcNDClJalVom1A8WGNA0z5t0ETIj7yisa
 /H0v6nAqdv0afq850awS2Blv28Lc3PXlfuHvF+Ztika/dNFzjvtO7hfeIUUF93NnwGAf
 tqCySdABhaZT5r7ycrhIWFB1MCu5NczwHtqkUfpqMW6HO9knes5vW8LYOfnz+mmO/5Su
 0khR/uOjbu6kgbZ/dWWrV1QRvnkEGD907gHnMrYouqXB5UaYnOWU8FgzYszHInhY1TeR
 BouKe2uI7ZX5fTZ+Al/IkuQmmD+KYQZtqVrZeNhWKJkpeCQA2ORJpU6kdvm4ywUkNrU3
 1g2Q==
X-Gm-Message-State: AGi0Pub1K5N6w8Zv28Y61q7vNAHEwUGIMUQssTcJXwQuBKUBlTxNl6ou
 6YCM02FSwuWKvKrUAiDuy5U=
X-Google-Smtp-Source: APiQypJuJmDZ8xt88jZjIunyu4JC8xm4qWfUOz7FKWE6GqWu8LYvkbMcEAUouN6Q6mNs4vklYpsOCQ==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr31202654wru.405.1588060142969; 
 Tue, 28 Apr 2020 00:49:02 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id i25sm2128824wml.43.2020.04.28.00.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 00:49:02 -0700 (PDT)
Subject: Re: [PATCH v1 06/11] hw/arm: versal: Embedd the ADMAs into the SoC
 type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-7-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <76784018-ddd2-fa05-7ae1-5b6a474a501d@amsat.org>
Date: Tue, 28 Apr 2020 09:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-7-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 8:16 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Embedd the ADMAs into the SoC type.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/arm/xlnx-versal.c         | 14 +++++++-------
>  include/hw/arm/xlnx-versal.h |  3 ++-
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index e424aa789e..ebd2dc51be 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -203,18 +203,18 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
>          DeviceState *dev;
>          MemoryRegion *mr;
>  
> -        dev = qdev_create(NULL, "xlnx.zdma");
> -        s->lpd.iou.adma[i] = SYS_BUS_DEVICE(dev);
> -        object_property_set_int(OBJECT(s->lpd.iou.adma[i]), 128, "bus-width",
> -                                &error_abort);
> -        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
> +        sysbus_init_child_obj(OBJECT(s), name,
> +                              &s->lpd.iou.adma[i], sizeof(s->lpd.iou.adma[i]),
> +                              TYPE_XLNX_ZDMA);
> +        dev = DEVICE(&s->lpd.iou.adma[i]);
> +        object_property_set_int(OBJECT(dev), 128, "bus-width", &error_abort);
>          qdev_init_nofail(dev);
>  
> -        mr = sysbus_mmio_get_region(s->lpd.iou.adma[i], 0);
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->mr_ps,
>                                      MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE, mr);
>  
> -        sysbus_connect_irq(s->lpd.iou.adma[i], 0, pic[VERSAL_ADMA_IRQ_0 + i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_ADMA_IRQ_0 + i]);
>          g_free(name);
>      }
>  }
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 01da736a5b..94b7826fd4 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -16,6 +16,7 @@
>  #include "hw/arm/boot.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/char/pl011.h"
> +#include "hw/dma/xlnx-zdma.h"
>  #include "hw/net/cadence_gem.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
> @@ -53,7 +54,7 @@ typedef struct Versal {
>          struct {
>              PL011State uart[XLNX_VERSAL_NR_UARTS];
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
> -            SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
> +            XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>          } iou;
>      } lpd;
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

