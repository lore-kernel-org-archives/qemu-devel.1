Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D631C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF82921D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTo98tjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF82921D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inGGW-0000Lj-2I
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 01:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inGFc-0008N5-Kj
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inGFY-00062S-Qn
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:15:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inGFY-0005yr-3d
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578032155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwaJWtNKiukXww2ksbPMvvWvrIiK6CQhQTdMWKzxuZU=;
 b=MTo98tjghKfvLUu7eJpem4ZktB5XqXtz9TpaEXBBE2JDCS3/3s1PzDPtR3O2QkpfbpuvWm
 nBXWRrfYV4xm7ITZP6FYNk+SN/bV2aSChctk0kdmeyC5ps4sdcIuWUOGX7vCQn7+0PUExc
 4fAtJyO8B85rU9+wNmMPGqF7ZNzTGow=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-0P5MhAAONp2fxHmHYgb9Mg-1; Fri, 03 Jan 2020 01:15:52 -0500
Received: by mail-wr1-f69.google.com with SMTP id y7so22722752wrm.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 22:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OwaJWtNKiukXww2ksbPMvvWvrIiK6CQhQTdMWKzxuZU=;
 b=BwpxCiC6ztEG+OItk2HZw3ZtXIfByJYao/l1uvTJF2Qo5hvXo5xNFTd5Dz9EjaOVRa
 onKR7LYsrDo7BGuNOSj9Y+imf1jxiM88jcq5O7kuRqzTTL7Ri76i9PGZebOZL0n6LNdV
 VNwJ7C07e5edIbyyAZsKcTIqS+6SX9LZS/L8svhA+hJvQLns/0duyc365RhiaZ3CAECF
 B7pCPYNDRzbr5yShX0HCT0S+ex1LtPtMG3ajFR9xlPaT66HxoCZaBkp1rk7VFb7jOEH2
 M1I2iMTiGp0jCUetXFwJl0MgOeWFnJz/dPAoEFm5U38DHMhNIDC4wlx1kQJfBhymV8uA
 OTiw==
X-Gm-Message-State: APjAAAVQILbIL0Z1rVga5O2ry2NKnVzCDFzf3z9CVOPWgTlke5Ryyh0w
 1ow3TF4PwrX43/tmRKWoJkCNP0TixubpMtX/8Z/BrFsh/Tl/xeOAaWyqz8lKafC/+G/7ihuLqn0
 4LbKk+4MMzZttyms=
X-Received: by 2002:a1c:61c1:: with SMTP id
 v184mr17512447wmb.160.1578032151291; 
 Thu, 02 Jan 2020 22:15:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLKN8rocfGnFgpyTTnaAM2GVaB5U8Ol9I+OwwyVo15wAYtOO3G92yaUAxpXWmsqFFoChZg6Q==
X-Received: by 2002:a1c:61c1:: with SMTP id
 v184mr17512424wmb.160.1578032151032; 
 Thu, 02 Jan 2020 22:15:51 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x11sm61085776wre.68.2020.01.02.22.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 22:15:50 -0800 (PST)
Subject: Re: [PATCH v5 4/6] hppa: add emulation of LASI PS2 controllers
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-5-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8eff8c1b-1d56-19a1-a8dd-743517716007@redhat.com>
Date: Fri, 3 Jan 2020 07:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220211512.3289-5-svens@stackframe.org>
Content-Language: en-US
X-MC-Unique: 0P5MhAAONp2fxHmHYgb9Mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sven,

On 12/20/19 10:15 PM, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/hppa/Kconfig            |   1 +
>   hw/hppa/lasi.c             |  10 +-
>   hw/input/Kconfig           |   3 +
>   hw/input/Makefile.objs     |   1 +
>   hw/input/lasips2.c         | 289 +++++++++++++++++++++++++++++++++++++
>   hw/input/ps2.c             |   5 +
>   hw/input/trace-events      |   5 +
>   include/hw/input/lasips2.h |  16 ++
>   include/hw/input/ps2.h     |   1 +
>   9 files changed, 330 insertions(+), 1 deletion(-)
>   create mode 100644 hw/input/lasips2.c
>   create mode 100644 include/hw/input/lasips2.h
> 
> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
> index 2a7b38d6d6..7f9be7f25c 100644
> --- a/hw/hppa/Kconfig
> +++ b/hw/hppa/Kconfig
> @@ -11,3 +11,4 @@ config DINO
>       select MC146818RTC
>       select LSI_SCSI_PCI
>       select LASI_82596
> +    select LASIPS2

If these components are part of the LASI chipset, you don't need an 
specific Kconfig entry for each, you can simply use the LASI one.

Add a LASI entry in hw/hppa/Kconfig such:

config LASI
     bool
     select I82596_COMMON
     select PS2

If you disagree, can you rename LASIPS2 -> LASI_PS2?

> diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
> index 51752589f3..d8d03f95c0 100644
> --- a/hw/hppa/lasi.c
> +++ b/hw/hppa/lasi.c
> @@ -22,6 +22,7 @@
>   #include "hw/net/lasi_82596.h"
>   #include "hw/char/parallel.h"
>   #include "hw/char/serial.h"
> +#include "hw/input/lasips2.h"
>   #include "exec/address-spaces.h"
>   #include "migration/vmstate.h"
>   
> @@ -324,6 +325,7 @@ DeviceState *lasi_init(MemoryRegion *address_space)
>                        lpt_irq, parallel_hds[0]);
>   
>       /* Real time clock (RTC), it's only one 32-bit counter @9000 */
> +
>       s->rtc = time(NULL);
>       s->rtc_ref = 0;
>   
> @@ -333,8 +335,14 @@ DeviceState *lasi_init(MemoryRegion *address_space)
>                   lasi_get_irq(LASI_UART_HPA));
>           serial_mm_init(address_space, LASI_UART_HPA + 0x800, 0,
>                   serial_irq, 8000000 / 16,
> -                serial_hd(1), DEVICE_NATIVE_ENDIAN);
> +                serial_hd(0), DEVICE_NATIVE_ENDIAN);
>       }
> +
> +    /* PS/2 Keyboard/Mouse */
> +    qemu_irq ps2kbd_irq = qemu_allocate_irq(lasi_set_irq, s,
> +            lasi_get_irq(LASI_PS2KBD_HPA));
> +    lasips2_init(address_space, LASI_PS2KBD_HPA,  ps2kbd_irq);
> +
>       return dev;
>   }
>   
> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
> index 287f08887b..25c77a1b87 100644
> --- a/hw/input/Kconfig
> +++ b/hw/input/Kconfig
> @@ -41,3 +41,6 @@ config VHOST_USER_INPUT
>   
>   config TSC210X
>       bool
> +
> +config LASIPS2
> +    select PS2
> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
> index a1bc502ed0..f98f635685 100644
> --- a/hw/input/Makefile.objs
> +++ b/hw/input/Makefile.objs
> @@ -15,3 +15,4 @@ common-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input.o
>   obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
>   obj-$(CONFIG_PXA2XX) += pxa2xx_keypad.o
>   obj-$(CONFIG_TSC210X) += tsc210x.o
> +obj-$(CONFIG_LASIPS2) += lasips2.o
> diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
> new file mode 100644
> index 0000000000..1943671d1e
> --- /dev/null
> +++ b/hw/input/lasips2.c
> @@ -0,0 +1,289 @@
> +/*
> + * QEMU HP Lasi PS/2 interface emulation
> + *
> + * Copyright (c) 2019 Sven Schnelle
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/hw.h"
> +#include "hw/input/ps2.h"
> +#include "hw/input/lasips2.h"
> +#include "hw/sysbus.h"
> +#include "exec/hwaddr.h"
> +#include "sysemu/sysemu.h"
> +#include "trace.h"
> +#include "exec/address-spaces.h"
> +#include "migration/vmstate.h"
> +#include "hw/irq.h"

<newline>

> +struct LASIPS2State;
> +typedef struct LASIPS2Port {
> +    struct LASIPS2State *parent;
> +    MemoryRegion reg;
> +    void *dev;
> +    uint8_t id;
> +    uint8_t control;
> +    uint8_t buf;
> +    bool loopback_rbne;
> +    bool irq;
> +} LASIPS2Port;
[...]


