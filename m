Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE2C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EE4206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTTUu1fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EE4206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0o6-0006yQ-Aw
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 12:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ia0n0-0006A6-Ef
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ia0mx-000520-Ow
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:07:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ia0mx-000515-9n
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574874458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mG1LLk1qYeA/3gKItcoVRlyWV144DjjgKMQ2BWX7qrc=;
 b=hTTUu1fgUjL1waN2PuB+r9HVU8yPt8+6OVkunT/qRfUifXYQZnobtE9n6no/Wp4cpPq9Sm
 7ICm+z5kwz3ZbNe5MURLchcxBOjvJzRqQtcB7dFuDI062qQzLMuXebgszGwOSR+oQhPGEP
 O7tVz2YrlN2D0T7XlyQv23h0mexg430=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-yleiqpldP1W5wAGLoDDCHg-1; Wed, 27 Nov 2019 12:07:36 -0500
Received: by mail-wm1-f69.google.com with SMTP id y125so1483786wmg.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mG1LLk1qYeA/3gKItcoVRlyWV144DjjgKMQ2BWX7qrc=;
 b=TqzAfl/a0fmQrB/NOyXBCbvpQtD0FQEfJ3W6qZLs++UHPrapgHyRbCgWfyQIUwvYm5
 /pykHQURUzpadZemOiltg5bP9EuP42B7FFB3vz0Vr1hvHU9NmPUG4H79ixVKAMHgj1Ql
 10sMoU7C8rU+38JIJquDN3kS5f8Nj8dqEKE/pT3aQ2XXK7AcDKgWc3dhIqsaJNh4pdkL
 VWhV7en9crCnZqcjMavQKT3KLfXOfXG6OhtyzNga7qASH4PygcfdsU8GZf8v0tFxJYXK
 8jbOgpcBaD25DKMXd7xl4DpDkdZ8UUzRyyuxBP9To83i+Wh7W1Me/bm1TNIKCE9iolfn
 cROQ==
X-Gm-Message-State: APjAAAUugP82vmFpg0SJXfssjiFLmM6SSIbsU+fxU4YS85oQAUoDluFH
 QBOy8aFZXrTCXFM19cRLfyBnmHguRIEreRSrbT/U5O3A3WF334vwPr6CBFCjYxsZhc6PTgy0nI8
 3jpVs95gklZZlem0=
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr41696276wrj.168.1574874455710; 
 Wed, 27 Nov 2019 09:07:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7xdRkMNVzlrQFGy+tkSMTzf5jQ2g8lC8VV1ZGynswBgmEo4kOJYd04llQVHRwG3JqS+2W1g==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr41696247wrj.168.1574874455463; 
 Wed, 27 Nov 2019 09:07:35 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x13sm7185171wmc.19.2019.11.27.09.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 09:07:34 -0800 (PST)
Subject: Re: [PATCH v36 11/17] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-12-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81b62c00-243e-b76e-f52c-4f681b47b727@redhat.com>
Date: Wed, 27 Nov 2019 18:07:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191124050225.30351-12-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: yleiqpldP1W5wAGLoDDCHg-1
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
Cc: thuth@redhat.com, richard.henderson@linaro.org,
 Sarah Harris <S.E.Harris@kent.ac.uk>, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/24/19 6:02 AM, Michael Rolnik wrote:
> From: Sarah Harris <S.E.Harris@kent.ac.uk>
> 
> These were designed to facilitate testing but should provide enough function to be useful in other contexts.
> Only a subset of the functions of each peripheral is implemented, mainly due to the lack of a standard way to handle electrical connections (like GPIO pins).
> 
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> ---
>   include/hw/char/avr_usart.h    |  97 ++++++
>   include/hw/misc/avr_mask.h     |  47 +++
>   include/hw/timer/avr_timer16.h |  97 ++++++
>   hw/char/avr_usart.c            | 324 ++++++++++++++++++
>   hw/misc/avr_mask.c             | 112 ++++++
>   hw/timer/avr_timer16.c         | 605 +++++++++++++++++++++++++++++++++
>   hw/char/Kconfig                |   3 +
>   hw/char/Makefile.objs          |   1 +
>   hw/misc/Kconfig                |   3 +
>   hw/misc/Makefile.objs          |   2 +
>   hw/timer/Kconfig               |   3 +
>   hw/timer/Makefile.objs         |   2 +
>   12 files changed, 1296 insertions(+)
>   create mode 100644 include/hw/char/avr_usart.h
>   create mode 100644 include/hw/misc/avr_mask.h
>   create mode 100644 include/hw/timer/avr_timer16.h
>   create mode 100644 hw/char/avr_usart.c
>   create mode 100644 hw/misc/avr_mask.c
>   create mode 100644 hw/timer/avr_timer16.c
> 
> diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
> new file mode 100644
> index 0000000000..8e9ee88bbd
> --- /dev/null
> +++ b/include/hw/char/avr_usart.h
> @@ -0,0 +1,97 @@
> +/*
> + * AVR USART
> + *
> + * Copyright (c) 2018 University of Kent
> + * Author: Sarah Harris
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
> +#ifndef HW_AVR_USART_H
> +#define HW_AVR_USART_H
> +
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"
> +#include "hw/hw.h"
> +
> +/* Offsets of registers. */
> +#define USART_DR   0x06
> +#define USART_CSRA  0x00
> +#define USART_CSRB  0x01
> +#define USART_CSRC  0x02
> +#define USART_BRRH 0x05
> +#define USART_BRRL 0x04
> +
> +/* Relevant bits in regiters. */
> +#define USART_CSRA_RXC    (1 << 7)
> +#define USART_CSRA_TXC    (1 << 6)
> +#define USART_CSRA_DRE    (1 << 5)
> +#define USART_CSRA_MPCM   (1 << 0)
> +
> +#define USART_CSRB_RXCIE  (1 << 7)
> +#define USART_CSRB_TXCIE  (1 << 6)
> +#define USART_CSRB_DREIE  (1 << 5)
> +#define USART_CSRB_RXEN   (1 << 4)
> +#define USART_CSRB_TXEN   (1 << 3)
> +#define USART_CSRB_CSZ2   (1 << 2)
> +#define USART_CSRB_RXB8   (1 << 1)
> +#define USART_CSRB_TXB8   (1 << 0)
> +
> +#define USART_CSRC_MSEL1  (1 << 7)
> +#define USART_CSRC_MSEL0  (1 << 6)
> +#define USART_CSRC_PM1    (1 << 5)
> +#define USART_CSRC_PM0    (1 << 4)
> +#define USART_CSRC_CSZ1   (1 << 2)
> +#define USART_CSRC_CSZ0   (1 << 1)

The previous definitions can go into hw/char/avr_usart.c.

> +#define TYPE_AVR_USART "avr-usart"
> +#define AVR_USART(obj) \
> +    OBJECT_CHECK(AVRUsartState, (obj), TYPE_AVR_USART)
> +
> +typedef struct {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */
> +    MemoryRegion mmio;
> +
> +    CharBackend chr;
> +
> +    bool enabled;
> +
> +    uint8_t data;
> +    bool data_valid;
> +    uint8_t char_mask;
> +    /* Control and Status Registers */
> +    uint8_t csra;
> +    uint8_t csrb;
> +    uint8_t csrc;
> +    /* Baud Rate Registers (low/high byte) */
> +    uint8_t brrh;
> +    uint8_t brrl;
> +
> +    /* Receive Complete */
> +    qemu_irq rxc_irq;
> +    /* Transmit Complete */
> +    qemu_irq txc_irq;
> +    /* Data Register Empty */
> +    qemu_irq dre_irq;
> +} AVRUsartState;

Please rename to AvrUsartState (see 'Naming' section of CODING_STYLE.rst).

[...]


