Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DAB2065C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/YioOWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DAB2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUk4-0002H9-9a
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUjM-0001pU-VX
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:26:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUjL-0001Hi-6I
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589527562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDYzldhojeL3etjgUCh0zGSDgjteeUn7rV+aPmdj3y4=;
 b=E/YioOWOeyxRfVErFLag0sr+AxAIbNopww1fAKIj2AHgEVQ6e2mwJCIzDsl5UALhct1Ysk
 V3KMaDMrVEd971vMG4/kwhAFbqwecHlpJetVtCR0VSLyOTQ8al5HNwatpc3+498cTa4pnf
 o86g9wIricG/zmrqX6Z292GSj+lnix0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-zThJt-rAPpySR1kJJvK0WA-1; Fri, 15 May 2020 03:25:58 -0400
X-MC-Unique: zThJt-rAPpySR1kJJvK0WA-1
Received: by mail-wm1-f69.google.com with SMTP id x11so563152wmc.9
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 00:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UDYzldhojeL3etjgUCh0zGSDgjteeUn7rV+aPmdj3y4=;
 b=VQzygxh17YaPJjC1/L471Khym621/6nNDvxTD2+vwhR4W/Mjshen+8PpzkDyDA2wL6
 2iWM2gCC1GooDLmlYvRn1wzBu9iTYzzZjUwWu6BN5lZbao7zWBK35PoGWAa794kI5L5m
 pMi9ULV0JdT/NmqcVcH3aTlQl9FCXvNO4yOHWNLo0A1ORX2BS3KFEn6j7bgIfzTqkLqt
 rpAycGL3AxK3qH6ULfBrY7Bsw7C3Wr3+W19DG5kAVs7jo7yRA84ysOeR5o9LMmoDG4sO
 Tc59rb8NVmZ1pP43qpuN02AZB66ek8D4Yqx9IQbCxWwcX10tuxnHRm94Zfojn8LWx7YE
 5A9A==
X-Gm-Message-State: AOAM53154BGe0Cmt5zlLSR6VDobpCkgktPeOVFwKep29Wo2SaXb20YfX
 FpbPClaVmUP1fiOQIUNF7vOOErHmEk7p4L7nHSu2GcOjh2VQSMCAaGlGZuXuxw62abJqMIJvXL3
 kUu84OxIJuZNhPVY=
X-Received: by 2002:a05:600c:1006:: with SMTP id
 c6mr2570685wmc.133.1589527557495; 
 Fri, 15 May 2020 00:25:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOS8UM5U3pvYZZHFcRmQ/kOE4dr3JdGEhrCYO9Lq81zE7Zfxa6BhAYwUBqJ7fH9Xq7xv5HOQ==
X-Received: by 2002:a05:600c:1006:: with SMTP id
 c6mr2570637wmc.133.1589527557025; 
 Fri, 15 May 2020 00:25:57 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 10sm2244447wmw.26.2020.05.15.00.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 00:25:56 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] hw/char: Initial commit of Ibex UART
To: Alistair Francis <alistair23@gmail.com>
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <11b8f3cd28fd52b10caefe21a7b70444b85792f8.1588878756.git.alistair.francis@wdc.com>
 <44285916-1542-5ba3-eb39-48f9728c1e8d@redhat.com>
 <CAKmqyKPuv=jFOfO-Vgub1x1ddoLkmkZTgd2ZbSxNKMv7ySMBFQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cbf21ed0-3b2d-8af0-9c1f-c18efe81b713@redhat.com>
Date: Fri, 15 May 2020 09:25:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPuv=jFOfO-Vgub1x1ddoLkmkZTgd2ZbSxNKMv7ySMBFQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 11:59 PM, Alistair Francis wrote:
> On Thu, May 14, 2020 at 11:00 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> Hi Alistair,
>>
>> On 5/7/20 9:13 PM, Alistair Francis wrote:
>>> This is the initial commit of the Ibex UART device. Serial TX is
>>> working, while RX has been implemeneted but untested.
>>>
>>> This is based on the documentation from:
>>> https://docs.opentitan.org/hw/ip/uart/doc/
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>    MAINTAINERS                 |   2 +
>>>    hw/char/Makefile.objs       |   1 +
>>>    hw/char/ibex_uart.c         | 490 ++++++++++++++++++++++++++++++++++++
>>>    hw/riscv/Kconfig            |   4 +
>>>    include/hw/char/ibex_uart.h | 110 ++++++++
>>>    5 files changed, 607 insertions(+)
>>>    create mode 100644 hw/char/ibex_uart.c
>>>    create mode 100644 include/hw/char/ibex_uart.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index c3d77f0861..d3d47564ce 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1236,7 +1236,9 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
>>>    L: qemu-riscv@nongnu.org
>>>    S: Supported
>>>    F: hw/riscv/opentitan.c
>>> +F: hw/char/ibex_uart.c
>>>    F: include/hw/riscv/opentitan.h
>>> +F: include/hw/char/ibex_uart.h
>>>
>>>
>>>    SH4 Machines
>>> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
>>> index 9e9a6c1aff..633996be5b 100644
>>> --- a/hw/char/Makefile.objs
>>> +++ b/hw/char/Makefile.objs
>>> @@ -12,6 +12,7 @@ common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
>>>    common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
>>>    common-obj-$(CONFIG_XEN) += xen_console.o
>>>    common-obj-$(CONFIG_CADENCE) += cadence_uart.o
>>> +common-obj-$(CONFIG_IBEX) += ibex_uart.o
>>>
>>>    common-obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
>>>    common-obj-$(CONFIG_COLDFIRE) += mcf_uart.o
>>> diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
>>> new file mode 100644
>>> index 0000000000..f6215ae23d
>>> --- /dev/null
>>> +++ b/hw/char/ibex_uart.c
>>> @@ -0,0 +1,490 @@
>>> +/*
>>> + * QEMU lowRISC Ibex UART device
>>> + *
>>> + * Copyright (c) 2020 Western Digital
>>> + *
>>> + * For details check the documentation here:
>>> + *    https://docs.opentitan.org/hw/ip/uart/doc/
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>>> + * of this software and associated documentation files (the "Software"), to deal
>>> + * in the Software without restriction, including without limitation the rights
>>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>>> + * copies of the Software, and to permit persons to whom the Software is
>>> + * furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>> + * THE SOFTWARE.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/char/ibex_uart.h"
>>> +#include "hw/irq.h"
>>> +#include "hw/qdev-properties.h"
>>> +#include "migration/vmstate.h"
>>> +#include "qemu/log.h"
>>> +#include "qemu/module.h"
>>> +
>>> +static void ibex_uart_update_irqs(IbexUartState *s)
>>> +{
>>> +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_WATERMARK) {
>>> +        qemu_set_irq(s->tx_watermark, 1);
>>> +    } else {
>>> +        qemu_set_irq(s->tx_watermark, 0);
>>> +    }
>>> +
>>> +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_WATERMARK) {
>>> +        qemu_set_irq(s->rx_watermark, 1);
>>> +    } else {
>>> +        qemu_set_irq(s->rx_watermark, 0);
>>
>> I wonder if having both bit separate can't lead to odd pulse behavior
>> (this function should have the same result if you invert the RX/TX
>> processing here). I'd be safer using a local 'raise_watermark' boolean
>> variable, then call qemu_set_irq() once.
> 
> I'm not sure what you mean. Are you worried that TX and RX will both
> go high/low at the same time?

Disregard my comment, it was late and I misread that rx/tx are different 
outgoing IRQs (I read this as a single watermark IRQ).

> 
> Alistair
> 
>>
>>> +    }
>>> +
>>> +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_EMPTY) {
>>> +        qemu_set_irq(s->tx_empty, 1);
>>> +    } else {
>>> +        qemu_set_irq(s->tx_empty, 0);
>>> +    }
>>> +
>>> +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_OVERFLOW) {
>>> +        qemu_set_irq(s->rx_overflow, 1);
>>> +    } else {
>>> +        qemu_set_irq(s->rx_overflow, 0);
>>> +    }
>>> +}
>> [...]
>>
> 


