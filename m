Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10775C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4A220657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jROg/PRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4A220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZIAX-0000j4-Pk
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZI9O-0007z2-BQ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:00:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZI9N-0004zi-6x
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589479203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6u+EQomKA3fAx30W7MJ5PJOr2y4zIumN8td25R0lRoo=;
 b=jROg/PRwIDABnPlqUMiAUOZbsTXFOf123kgwQZgY+euG8n7WeTQ2SId2aoZdcn9Sk4CraX
 hbT4RyR/XvXKwuH8JZ67DaysfqoBgi5D22NTR6bfw3DysUkVTdRlY4wcSqM5GOH+Rykv0l
 lUyRbADW6UWqsCcqTD2kXcy8BfjxCO4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-PCdSs-sFODy8F5X3Z-rJvA-1; Thu, 14 May 2020 13:59:59 -0400
X-MC-Unique: PCdSs-sFODy8F5X3Z-rJvA-1
Received: by mail-wr1-f71.google.com with SMTP id p8so1950510wrj.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 10:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6u+EQomKA3fAx30W7MJ5PJOr2y4zIumN8td25R0lRoo=;
 b=XqBHS6+Pw34PHP3qqybml35cdmzKvbiZ0CGwrMSsElJGVBCFJWXaQR9+O4iD7oME4N
 7LVBkzV/BNpIIkPxpY18KbkL85qg8Xo8yyAvXovUDRc2KSAmPipVHoYvXhfkErDTgViM
 lt0w0tPqZNQF26GmaQ6bXvTXvtZafrZ6UBI5vJew1TAK3Mjc+kHVxbeQxu8PC6Rw6WF8
 DbwWt/EEBqP5n7c/ZbXQnnOO8TiYQppVztpEKoF0wKoVzxnjZaWYZYxSh8dQBsRDgwo4
 ZnLmGyuzIoJEahghaukZ51SL3p3ZkyI7iAiqUyMZYFG9RlOlea1JFwlKggGlQKdTmBP6
 ieCg==
X-Gm-Message-State: AOAM532u5w0HDlZjj0lD98V3Y+AWUrmPtWnwdE+a+EppAwslQvdvhs1A
 MROpYtwQGmTBQ2wHMI3J+YATvcijdnVArs4lWeAxH0OYJ2C7625XTh1GGZjyVSNt9z1jNd2MAes
 ikfyyEV4uDM1o9MU=
X-Received: by 2002:adf:f981:: with SMTP id f1mr6616284wrr.244.1589479198514; 
 Thu, 14 May 2020 10:59:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzwlOZhwqJLf2Z7jqKDgdl0dFUpRFKlhAuuh9FusNhF6yEBryfoZTEd7CNkhNkihO+rJ37FA==
X-Received: by 2002:adf:f981:: with SMTP id f1mr6616264wrr.244.1589479198237; 
 Thu, 14 May 2020 10:59:58 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id o15sm4387930wrw.65.2020.05.14.10.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 10:59:57 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] hw/char: Initial commit of Ibex UART
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <11b8f3cd28fd52b10caefe21a7b70444b85792f8.1588878756.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <44285916-1542-5ba3-eb39-48f9728c1e8d@redhat.com>
Date: Thu, 14 May 2020 19:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <11b8f3cd28fd52b10caefe21a7b70444b85792f8.1588878756.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:31:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 5/7/20 9:13 PM, Alistair Francis wrote:
> This is the initial commit of the Ibex UART device. Serial TX is
> working, while RX has been implemeneted but untested.
> 
> This is based on the documentation from:
> https://docs.opentitan.org/hw/ip/uart/doc/
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   MAINTAINERS                 |   2 +
>   hw/char/Makefile.objs       |   1 +
>   hw/char/ibex_uart.c         | 490 ++++++++++++++++++++++++++++++++++++
>   hw/riscv/Kconfig            |   4 +
>   include/hw/char/ibex_uart.h | 110 ++++++++
>   5 files changed, 607 insertions(+)
>   create mode 100644 hw/char/ibex_uart.c
>   create mode 100644 include/hw/char/ibex_uart.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3d77f0861..d3d47564ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1236,7 +1236,9 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
>   L: qemu-riscv@nongnu.org
>   S: Supported
>   F: hw/riscv/opentitan.c
> +F: hw/char/ibex_uart.c
>   F: include/hw/riscv/opentitan.h
> +F: include/hw/char/ibex_uart.h
>   
>   
>   SH4 Machines
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 9e9a6c1aff..633996be5b 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -12,6 +12,7 @@ common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
>   common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
>   common-obj-$(CONFIG_XEN) += xen_console.o
>   common-obj-$(CONFIG_CADENCE) += cadence_uart.o
> +common-obj-$(CONFIG_IBEX) += ibex_uart.o
>   
>   common-obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
>   common-obj-$(CONFIG_COLDFIRE) += mcf_uart.o
> diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> new file mode 100644
> index 0000000000..f6215ae23d
> --- /dev/null
> +++ b/hw/char/ibex_uart.c
> @@ -0,0 +1,490 @@
> +/*
> + * QEMU lowRISC Ibex UART device
> + *
> + * Copyright (c) 2020 Western Digital
> + *
> + * For details check the documentation here:
> + *    https://docs.opentitan.org/hw/ip/uart/doc/
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
> +
> +#include "qemu/osdep.h"
> +#include "hw/char/ibex_uart.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +static void ibex_uart_update_irqs(IbexUartState *s)
> +{
> +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_WATERMARK) {
> +        qemu_set_irq(s->tx_watermark, 1);
> +    } else {
> +        qemu_set_irq(s->tx_watermark, 0);
> +    }
> +
> +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_WATERMARK) {
> +        qemu_set_irq(s->rx_watermark, 1);
> +    } else {
> +        qemu_set_irq(s->rx_watermark, 0);

I wonder if having both bit separate can't lead to odd pulse behavior 
(this function should have the same result if you invert the RX/TX 
processing here). I'd be safer using a local 'raise_watermark' boolean 
variable, then call qemu_set_irq() once.

> +    }
> +
> +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_EMPTY) {
> +        qemu_set_irq(s->tx_empty, 1);
> +    } else {
> +        qemu_set_irq(s->tx_empty, 0);
> +    }
> +
> +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_OVERFLOW) {
> +        qemu_set_irq(s->rx_overflow, 1);
> +    } else {
> +        qemu_set_irq(s->rx_overflow, 0);
> +    }
> +}
[...]


