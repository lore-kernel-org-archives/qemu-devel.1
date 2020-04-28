Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C2CC83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0942206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2zQh373"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0942206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTM2h-0000U1-S8
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTLw3-00032U-OS
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTLvF-0004YM-PJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:49:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKyh-0008AR-40; Tue, 28 Apr 2020 03:48:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id v8so1650816wma.0;
 Tue, 28 Apr 2020 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tXtUX+4HU5O6O3aW9+EvxcIT8n5DFd6Hbo5TC8dBG3E=;
 b=g2zQh373DvieWOQ5YWPC0pMzFCObYUlUBY5Wia0nmrY0WRUM2TziUVu5Ku3/1sk8ss
 Gidwo2b+zTN90On1DQekxW+DQijEY/yErAync9ZIRBRAxS6Gn170XeB/J3jUSsRnEpX9
 uEY6fCmJXk4KAq6qOp1rkZQp46r+Xw/th8RQdJ13WMBG4grjJldhCe/85yHxkDcP3I/l
 iiq0O7/SkWbb2reH5QKvr/5p8FYruV20KzKEa9q2gaHYzf7Gml4k7O8RipmkIcIp6EC/
 1nAnAc5mRC/4egmhRG9MzE6jJoN/LFp7UNGotGim7exsI0gharsULUi7J0E+yl61xGL2
 xMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tXtUX+4HU5O6O3aW9+EvxcIT8n5DFd6Hbo5TC8dBG3E=;
 b=f5BlIv7/Lkr/p6VKpbyy5huJhCDiqFOI/rXFi2ldlQ0ol0N6zNe8QrWqk1mv1Zf4kA
 543O1WyA5BigEOcGOoHLpF6tjsO6DOknzcy9C4JMIQFWpT4dwPFrFbVguo8aR69zIkUa
 TI2t+1o6ThqO+jm+P7DXcBYVluEVoE4tE3O7md17iXVWPNsTQ0rg0pDGjoDc/Mc6gSBr
 R7EFrvPY7TzOQDP2pZoCHT55xi/7QxCryySqlO3sOIL54likECabq/g2Jx2Ivvwrpg7e
 7Q2zHyFlx7pCXZ8EeXmqNNg52chjI2Tm8sUHXPmlljNExbJHQFGJ7Mur7KU7HBaYxU/w
 Xelw==
X-Gm-Message-State: AGi0PuaXcQ6aeOOWQq9aQ9QFgpnPhqNsnacRENy7d57qUTAiDmdYJ32i
 rv1dUGTtV8LGlC2v6ftVkQE=
X-Google-Smtp-Source: APiQypJW6w24MZ8IN9rkO9EB2LG9xbMmUvuzQGaYbROoagN4Gl78xCMqZGJJy2AFB3vyTPwtOVTRhg==
X-Received: by 2002:a05:600c:2341:: with SMTP id
 1mr2924988wmq.153.1588060105311; 
 Tue, 28 Apr 2020 00:48:25 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id 60sm25128908wrr.7.2020.04.28.00.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 00:48:23 -0700 (PDT)
Subject: Re: [PATCH v1 05/11] hw/arm: versal: Embedd the GEMs into the SoC type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-6-edgar.iglesias@gmail.com>
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
Message-ID: <690a9a61-0385-b804-1370-64268384d7ef@amsat.org>
Date: Tue, 28 Apr 2020 09:48:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-6-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
> Embedd the GEMs into the SoC type.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/arm/xlnx-versal.c         | 15 ++++++++-------
>  include/hw/arm/xlnx-versal.h |  3 ++-
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index dbde03b7e6..e424aa789e 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -170,25 +170,26 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
>          DeviceState *dev;
>          MemoryRegion *mr;
>  
> -        dev = qdev_create(NULL, "cadence_gem");
> -        s->lpd.iou.gem[i] = SYS_BUS_DEVICE(dev);
> -        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
> +        sysbus_init_child_obj(OBJECT(s), name,
> +                              &s->lpd.iou.gem[i], sizeof(s->lpd.iou.gem[i]),
> +                              TYPE_CADENCE_GEM);
> +        dev = DEVICE(&s->lpd.iou.gem[i]);
>          if (nd->used) {
>              qemu_check_nic_model(nd, "cadence_gem");
>              qdev_set_nic_properties(dev, nd);
>          }
> -        object_property_set_int(OBJECT(s->lpd.iou.gem[i]),
> +        object_property_set_int(OBJECT(dev),
>                                  2, "num-priority-queues",
>                                  &error_abort);
> -        object_property_set_link(OBJECT(s->lpd.iou.gem[i]),
> +        object_property_set_link(OBJECT(dev),
>                                   OBJECT(&s->mr_ps), "dma",
>                                   &error_abort);
>          qdev_init_nofail(dev);
>  
> -        mr = sysbus_mmio_get_region(s->lpd.iou.gem[i], 0);
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
>  
> -        sysbus_connect_irq(s->lpd.iou.gem[i], 0, pic[irqs[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
>          g_free(name);
>      }
>  }
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index a3dfd064b3..01da736a5b 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -16,6 +16,7 @@
>  #include "hw/arm/boot.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/char/pl011.h"
> +#include "hw/net/cadence_gem.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
> @@ -51,7 +52,7 @@ typedef struct Versal {
>  
>          struct {
>              PL011State uart[XLNX_VERSAL_NR_UARTS];
> -            SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
> +            CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
>          } iou;
>      } lpd;
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

