Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9FFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CB920657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTDJWs/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CB920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUmA-0004Bt-0q
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUlQ-0003AL-6P
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:28:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUlP-0001UG-1Z
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589527689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwGp930KlXtSfC5ixSvIYg1PEUrPhwOEn10FnTfe2JY=;
 b=hTDJWs/MND09ycLoRHew49B6AWb6b99sM/vUU+QYR+JnOgIJx7mzRItATMV6/se6SM/3EB
 mwgmHjGzaauhzRghW+n9IGa918O+z6SM2dy6Ye3ai43dY4kOp1uReNQJxcaltAjnYapZs+
 rWjlcizf17CWtcGY9HuolhLKNnG3+VA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Di6zcDQMMCePk29tK4_PtQ-1; Fri, 15 May 2020 03:28:08 -0400
X-MC-Unique: Di6zcDQMMCePk29tK4_PtQ-1
Received: by mail-wm1-f69.google.com with SMTP id t82so475170wmf.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 00:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qwGp930KlXtSfC5ixSvIYg1PEUrPhwOEn10FnTfe2JY=;
 b=f6xF5jZY6Zoh88Ns7PoXoZV5U2f14F9V1gw1ggz0CFfAxfp5kWOqQAzVAvskIiDbCx
 uRPh+DQOD+A16cMlP9Rv7VhpRmu0Qr9ag3SEIO2YiXAA6rPacbENn8rlsEQaV/uesNn1
 cyRC3/1fGrOa0bp/d5DDbNjaLV82MpMdjinf4H0ldV15+OMazkSFUfo+SAbhYrDBSKL4
 0ASxwFjJqDdgalwTP6AxlLICmwaqD3IiIOqPqor3fJ5xo2wtNklENqTwpiFIpZdz+oZD
 ih19zJG2RzwRNXt6ftnr7ztUZHiDmD5ed/EiD44QtttFfDnPijNgluDiw6YAx5JwG6Z3
 mo+g==
X-Gm-Message-State: AOAM532hvyYCSLEHSuIPU8dHNFYetvgjSNodQH4CsLRM4ixCuUVZ4Eks
 jwgnBbNntTYrfSAmOpyNsUshaq/+mGWfRTzhTIHzjngnJq4grg6iVdb2dF52JCGG4P7Mh6zuKu+
 YHsqTT0fCNJKHrkE=
X-Received: by 2002:adf:a3c5:: with SMTP id m5mr2839974wrb.390.1589527686837; 
 Fri, 15 May 2020 00:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAligpPtVrcSC1fMU+5XUUL2faNetrxN96QYmnO2dWvpi5v1xtZZbzkNXtM+veBHQdinrLKQ==
X-Received: by 2002:adf:a3c5:: with SMTP id m5mr2839908wrb.390.1589527686021; 
 Fri, 15 May 2020 00:28:06 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g6sm2211223wrp.75.2020.05.15.00.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 00:28:05 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] hw/char: Initial commit of Ibex UART
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <11b8f3cd28fd52b10caefe21a7b70444b85792f8.1588878756.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eddc757b-db7f-f658-4417-f3ad65e52b13@redhat.com>
Date: Fri, 15 May 2020 09:28:04 +0200
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
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

If possible setup scripts/git.orderfile to ease review (avoid scrolling).

>   5 files changed, 607 insertions(+)
>   create mode 100644 hw/char/ibex_uart.c
>   create mode 100644 include/hw/char/ibex_uart.h
> 
[...]
> +static void ibex_uart_write(void *opaque, hwaddr addr,
> +                                  uint64_t val64, unsigned int size)
> +{
> +    IbexUartState *s = opaque;
> +    uint32_t value = val64;
> +
> +    switch (addr) {
> +    case IBEX_UART_INTR_STATE:
> +        /* Write 1 clear */
> +        s->uart_intr_state &= ~value;
> +        ibex_uart_update_irqs(s);
> +        break;
> +    case IBEX_UART_INTR_ENABLE:
> +        s->uart_intr_enable = value;
> +        ibex_uart_update_irqs(s);
> +        break;
> +    case IBEX_UART_INTR_TEST:
> +        s->uart_intr_state |= value;
> +        ibex_uart_update_irqs(s);
> +        break;
> +
> +    case IBEX_UART_CTRL:
> +        s->uart_ctrl = value;
> +
> +        if (value & UART_CTRL_NF) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: UART_CTRL_NF is not supported\n", __func__);
> +        }
> +        if (value & UART_CTRL_SLPBK) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: UART_CTRL_SLPBK is not supported\n", __func__);
> +        }
> +        if (value & UART_CTRL_LLPBK) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: UART_CTRL_LLPBK is not supported\n", __func__);
> +        }
> +        if (value & UART_CTRL_PARITY_EN) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: UART_CTRL_PARITY_EN is not supported\n",
> +                          __func__);
> +        }
> +        if (value & UART_CTRL_PARITY_ODD) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: UART_CTRL_PARITY_ODD is not supported\n",
> +                          __func__);
> +        }
> +        if (value & UART_CTRL_RXBLVL) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: UART_CTRL_RXBLVL is not supported\n", __func__);
> +        }
> +        if (value & UART_CTRL_NCO) {
> +            uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
> +            baud *= 1000;
> +            baud /= 2 ^ 20;
> +
> +            s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
> +        }
> +        break;
> +    case IBEX_UART_STATUS:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: status is read only\n", __func__);
> +        break;
> +
> +    case IBEX_UART_RDATA:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: rdata is read only\n", __func__);
> +        break;
> +    case IBEX_UART_WDATA:
> +        uart_write_tx_fifo(s, (uint8_t *) &value, 1);
> +        break;
> +
> +    case IBEX_UART_FIFO_CTRL:
> +        s->uart_fifo_ctrl = value;
> +
> +        if (value & FIFO_CTRL_RXRST) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: RX fifos are not supported\n", __func__);
> +        }
> +        if (value & FIFO_CTRL_TXRST) {
> +            s->tx_level = 0;
> +        }
> +        break;
> +    case IBEX_UART_FIFO_STATUS:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: fifo_status is read only\n", __func__);
> +        break;
> +
> +    case IBEX_UART_OVRD:
> +        s->uart_ovrd = value;
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: ovrd is not supported\n", __func__);
> +        break;
> +    case IBEX_UART_VAL:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: val is read only\n", __func__);
> +        break;
> +    case IBEX_UART_TIMEOUT_CTRL:
> +        s->uart_timeout_ctrl = value;
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: timeout_ctrl is not supported\n", __func__);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> +    }
> +}
> +
> +static void fifo_trigger_update(void *opaque)
> +{
> +    IbexUartState *s = opaque;
> +
> +    if (s->uart_ctrl & UART_CTRL_TX_ENABLE) {
> +        ibex_uart_xmit(NULL, G_IO_OUT, s);
> +    }
> +}
> +
> +static const MemoryRegionOps ibex_uart_ops = {
> +    .read = ibex_uart_read,
> +    .write = ibex_uart_write,

As all registers are 32-bit, you want .impl min/max = 4 here.

Otherwise patch looks good.

> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
[...]
> diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
> new file mode 100644
> index 0000000000..2bec772615
> --- /dev/null
> +++ b/include/hw/char/ibex_uart.h
> @@ -0,0 +1,110 @@
> +/*
> + * QEMU lowRISC Ibex UART device
> + *
> + * Copyright (c) 2020 Western Digital
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
> +#ifndef HW_IBEX_UART_H
> +#define HW_IBEX_UART_H
> +
> +#include "hw/sysbus.h"
> +#include "chardev/char-fe.h"
> +#include "qemu/timer.h"
> +
> +#define IBEX_UART_INTR_STATE   0x00
> +    #define INTR_STATE_TX_WATERMARK (1 << 0)
> +    #define INTR_STATE_RX_WATERMARK (1 << 1)
> +    #define INTR_STATE_TX_EMPTY     (1 << 2)
> +    #define INTR_STATE_RX_OVERFLOW  (1 << 3)
> +#define IBEX_UART_INTR_ENABLE  0x04
> +#define IBEX_UART_INTR_TEST    0x08
> +
> +#define IBEX_UART_CTRL         0x0c
> +    #define UART_CTRL_TX_ENABLE     (1 << 0)
> +    #define UART_CTRL_RX_ENABLE     (1 << 1)
> +    #define UART_CTRL_NF            (1 << 2)
> +    #define UART_CTRL_SLPBK         (1 << 4)
> +    #define UART_CTRL_LLPBK         (1 << 5)
> +    #define UART_CTRL_PARITY_EN     (1 << 6)
> +    #define UART_CTRL_PARITY_ODD    (1 << 7)
> +    #define UART_CTRL_RXBLVL        (3 << 8)
> +    #define UART_CTRL_NCO           (0xFFFF << 16)
> +
> +#define IBEX_UART_STATUS       0x10
> +    #define UART_STATUS_TXFULL  (1 << 0)
> +    #define UART_STATUS_RXFULL  (1 << 1)
> +    #define UART_STATUS_TXEMPTY (1 << 2)
> +    #define UART_STATUS_RXIDLE  (1 << 4)
> +    #define UART_STATUS_RXEMPTY (1 << 5)
> +
> +#define IBEX_UART_RDATA        0x14
> +#define IBEX_UART_WDATA        0x18
> +
> +#define IBEX_UART_FIFO_CTRL    0x1c
> +    #define FIFO_CTRL_RXRST          (1 << 0)
> +    #define FIFO_CTRL_TXRST          (1 << 1)
> +    #define FIFO_CTRL_RXILVL         (7 << 2)
> +    #define FIFO_CTRL_RXILVL_SHIFT   (2)
> +    #define FIFO_CTRL_TXILVL         (3 << 5)
> +    #define FIFO_CTRL_TXILVL_SHIFT   (5)
> +
> +#define IBEX_UART_FIFO_STATUS  0x20
> +#define IBEX_UART_OVRD         0x24
> +#define IBEX_UART_VAL          0x28
> +#define IBEX_UART_TIMEOUT_CTRL 0x2c
> +
> +#define IBEX_UART_TX_FIFO_SIZE 16
> +
> +#define TYPE_IBEX_UART "ibex-uart"
> +#define IBEX_UART(obj) \
> +    OBJECT_CHECK(IbexUartState, (obj), TYPE_IBEX_UART)
> +
> +typedef struct {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */
> +    MemoryRegion mmio;
> +
> +    uint8_t tx_fifo[IBEX_UART_TX_FIFO_SIZE];
> +    uint32_t tx_level;
> +
> +    QEMUTimer *fifo_trigger_handle;
> +    uint64_t char_tx_time;
> +
> +    uint32_t uart_intr_state;
> +    uint32_t uart_intr_enable;
> +    uint32_t uart_ctrl;
> +    uint32_t uart_status;
> +    uint32_t uart_rdata;
> +    uint32_t uart_fifo_ctrl;
> +    uint32_t uart_fifo_status;
> +    uint32_t uart_ovrd;
> +    uint32_t uart_val;
> +    uint32_t uart_timeout_ctrl;
> +
> +    CharBackend chr;
> +    qemu_irq tx_watermark;
> +    qemu_irq rx_watermark;
> +    qemu_irq tx_empty;
> +    qemu_irq rx_overflow;
> +} IbexUartState;
> +#endif /* HW_IBEX_UART_H */
> 


