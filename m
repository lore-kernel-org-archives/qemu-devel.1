Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B5C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2789220661
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI1mLPFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2789220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTKWl-0004mo-77
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:19:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKUl-0002WT-A8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKLN-0005wN-Vf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:12:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKLN-0005w6-J6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:07:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id f13so23254681wrm.13
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 00:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3qKXpRO89vcsZbrKPdm5MDIoPq8CyVIGMiVlLeEIR1o=;
 b=fI1mLPFesA/F80Wic9Og3UJkSgfT3JISUxPO+J45Vwvk6G3SR+zm2AyAyRrp/3K9U6
 0jBoPtK/RA4+r936a2iMqhCjOm72gHFDD+MYJjXM5C5MR5zFxyAiiWQueOMYkVy1NYnK
 7knrlGFDuPaq3gyB/rip3caSmXlPW6KZWdmibf7RdOcr4skIj13AwUm6qWMmIPvK+wv6
 WjlYaL8jPZvJO21TwToSq6Ykr8ysZcj+wVnQ00woqeHIvnf1MgraEnsez5jF4o7uBv9V
 l7vrZ3skhwkjdUkzu/u+EvFQadTirc8YzgLbDooT9/L0W2cS3dSXXCMwLDcDzloqPf/T
 dtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3qKXpRO89vcsZbrKPdm5MDIoPq8CyVIGMiVlLeEIR1o=;
 b=Igseqt/T6sPPImW6yokt18gXlOJJACluj9OKH/52njgx32KuAsKqkVUG4EbdnUD8j/
 hID1XjZ5M2tMJwA7S/RuYNUkOSh4krWjGw3VcqTW4qUVHlcE6we6uYBzhFsaCOsQ9sRO
 jl/QGBDybHznzYzFGM3PlMxqNPR4yVgCo1ZNEZlhRdk6walyyY0IMRHJmvH9bWZNDYyH
 Zf5LTHopzxrgAt5WoFnlLYEUsE0ZXR/fNA2VyhHnU/op7ohslVW6ouELkn//UibF/i6D
 adTq1qSgZnvsteLYeM8MRT6MIW2lKnJeOv5T6vVEuSJWxlpiAXrQVPCo6fTddH/lU90Q
 4Tnw==
X-Gm-Message-State: AGi0PuZXTaJkbZx72GnbBalfYLjTnnOck98airDXDcxNMxnfRWkHNwgd
 y4J4aosIkMXlY81lt+wqK1jOTwj/MII=
X-Google-Smtp-Source: APiQypJxG0J+22eg+lJHcO9lYhZtFJUe6ldJzU6OFJbW9Rj/YXtUlteuKCTCk922TJgzGsAt1Rzswg==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr30363997wrt.382.1588057667736; 
 Tue, 28 Apr 2020 00:07:47 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id f2sm25439113wro.59.2020.04.28.00.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 00:07:46 -0700 (PDT)
Subject: Re: [PATCH v4 6/7] wire in the dwc-hsotg (dwc2) USB host controller
 emulation
To: Paul Zimmerman <pauldzim@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200428022232.18875-1-pauldzim@gmail.com>
 <20200428022232.18875-7-pauldzim@gmail.com>
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
Message-ID: <17715aac-dbb0-f1dd-abe9-2f2b4524935d@amsat.org>
Date: Tue, 28 Apr 2020 09:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428022232.18875-7-pauldzim@gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 4:22 AM, Paul Zimmerman wrote:
> Wire the dwc-hsotg (dwc2) emulation into Qemu
> 
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> ---
>  hw/arm/bcm2835_peripherals.c         | 21 ++++++++++++++++++++-
>  include/hw/arm/bcm2835_peripherals.h |  3 ++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 5e2c832d95..3b554cfac0 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -128,6 +128,13 @@ static void bcm2835_peripherals_init(Object *obj)
>      sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
>                            TYPE_BCM2835_MPHI);
>  
> +    /* DWC2 */
> +    sysbus_init_child_obj(obj, "dwc2", &s->dwc2, sizeof(s->dwc2),
> +                          TYPE_DWC2_USB);
> +
> +    object_property_add_const_link(OBJECT(&s->dwc2), "dma-mr",
> +                                   OBJECT(&s->gpu_bus_mr), &error_abort);
> +
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
>                                     OBJECT(&s->sdhci.sdbus), &error_abort);
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
> @@ -385,6 +392,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>          qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
>                                 INTERRUPT_HOSTPORT));
>  
> +    /* DWC2 */
> +    object_property_set_bool(OBJECT(&s->dwc2), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->peri_mr, USB_OTG_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dwc2), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->dwc2), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
> +                               INTERRUPT_USB));
> +
>      create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
>      create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
>      create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
> @@ -398,7 +418,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>      create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
>      create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
>      create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
> -    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
>      create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
>  }
>  
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index 7a7a8f6141..48a0ad1633 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -27,6 +27,7 @@
>  #include "hw/sd/bcm2835_sdhost.h"
>  #include "hw/gpio/bcm2835_gpio.h"
>  #include "hw/timer/bcm2835_systmr.h"
> +#include "hw/usb/hcd-dwc2.h"
>  #include "hw/misc/unimp.h"
>  
>  #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
> @@ -67,7 +68,7 @@ typedef struct BCM2835PeripheralState {
>      UnimplementedDeviceState ave0;
>      UnimplementedDeviceState bscsl;
>      UnimplementedDeviceState smi;
> -    UnimplementedDeviceState dwc2;
> +    DWC2State dwc2;
>      UnimplementedDeviceState sdramc;
>  } BCM2835PeripheralState;
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

