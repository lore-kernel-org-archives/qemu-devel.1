Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FBCC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020BF20704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POpiGvSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020BF20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTkhO-0006nw-Tu
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 07:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTkgX-0006Fz-6O
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 07:47:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTkgV-0005XD-Dw
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 07:47:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id b127so8151768wmb.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NJzCXnhIa+dW7oJxSivbPZX34UE3Q2odgbVJFBGquzw=;
 b=POpiGvSBbReFdr1wu7Fffs3pIox5p59Dnhl9YSli59J1WMqaa4JhYDKwGLuOXSV1KC
 467UJ3KqCoBLb7ti+FYb+GIEaaoxh9rLycMFwmo7j94tixVcdfV3JeejEKtg4RpEXVLS
 sSM/SkVLblNCANw9HL9mD2hcN/pRJEG1yrd8qCIs3Az47D3lYrn0rfAJsZIKeEgH6iVV
 7V6W7Lx7hfadh14igPsjYhBOazYjQ2bWnMiF5JDQo5c2XHBdIzWl8DCnoIR0lJAGVHzM
 9fvQedwlMN/R6gYSedvmLYovq4IXmsJJs6u+VATDEsRqKqg45SSXrWcPv4w5AcSaRLC4
 GsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NJzCXnhIa+dW7oJxSivbPZX34UE3Q2odgbVJFBGquzw=;
 b=l4+moof9gGyKP1f0Ib/vUKYGezC3glohS1885MrcJE9upTZW913+OEQYHese4XAt0J
 QqIpS21HJrMlZGQbYHr0SpTxKeUbx3eGXc2iutvF5Pgvm/Ods7ZJ9g2SiSXa9hRq6fJF
 dLZoUpGZOnc27xt2rOjaCm8AbCvKvmLJMmtsF2O2yG+Sjc0ZU38vO2/DmMZig+yrZtyx
 OowAxoL4cmsY3iPXbli5NhQmxHL1GMEoxOFgi9D3E08jiLn31Gxv6Rb4XOUHDLxdeEJ7
 jaf4+uO/wch2E9C7eZuFs2xiSFp8CHyO90CXYtJ/xlxAhRfgmmgS3fJVia5BY0QC1ST9
 jIhA==
X-Gm-Message-State: AOAM532CrLXLcW/klWUqsyIYt46gbiCM0DD82XrUWYgGJxUqVt/IVHGs
 WbK/QfH0yTmcv8XdnFfTPQw=
X-Google-Smtp-Source: ABdhPJwdSxp42v7ySOltjVGUCbYfg8ThJqNmkFCKSMff1i8+ZZZMnpDNGxx2E+Ltt1kAgxfRQxc+Sg==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr8175465wmd.79.1602935257280; 
 Sat, 17 Oct 2020 04:47:37 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id e11sm2423150wrj.75.2020.10.17.04.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 04:47:36 -0700 (PDT)
Subject: Re: [PULL 09/31] hw/core/clock: introduce clock object
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Damien Hedde <damien.hedde@greensocs.com>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
 <20200430115142.13430-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f295c99f-0405-1c26-6f58-12abdec8bd3d@amsat.org>
Date: Sat, 17 Oct 2020 13:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200430115142.13430-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Damien, Peter,

On 4/30/20 1:51 PM, Peter Maydell wrote:
> This object may be used to represent a clock inside a clock tree.
> 
> A clock may be connected to another clock so that it receives update,
> through a callback, whenever the source/parent clock is updated.
> 
> Although only the root clock of a clock tree controls the values
> (represented as periods) of all clocks in tree, each clock holds
> a local state containing the current value so that it can be fetched
> independently. It will allows us to fullfill migration requirements
> by migrating each clock independently of others.
> 
> This is based on the original work of Frederic Konrad.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Message-id: 20200406135251.157596-2-damien.hedde@greensocs.com
> [PMM: Use uint64_t rather than unsigned long long in trace events;
>   the dtrace backend can't handle the latter]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/Makefile.objs |   1 +
>   include/hw/clock.h    | 216 ++++++++++++++++++++++++++++++++++++++++++
>   hw/core/clock.c       | 130 +++++++++++++++++++++++++
>   hw/core/trace-events  |   7 ++
>   4 files changed, 354 insertions(+)
>   create mode 100644 include/hw/clock.h
>   create mode 100644 hw/core/clock.c
> 
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 6215e7c2085..1d9b0aa2057 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -7,6 +7,7 @@ common-obj-y += hotplug.o
>   common-obj-y += vmstate-if.o
>   # irq.o needed for qdev GPIO handling:
>   common-obj-y += irq.o
> +common-obj-y += clock.o
>   
>   common-obj-$(CONFIG_SOFTMMU) += reset.o
>   common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> new file mode 100644
> index 00000000000..82a7f3c6982
> --- /dev/null
> +++ b/include/hw/clock.h
> @@ -0,0 +1,216 @@
> +/*
> + * Hardware Clocks
> + *
> + * Copyright GreenSocs 2016-2020
> + *
> + * Authors:
> + *  Frederic Konrad
> + *  Damien Hedde
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_HW_CLOCK_H
> +#define QEMU_HW_CLOCK_H
> +
> +#include "qom/object.h"
> +#include "qemu/queue.h"
> +
> +#define TYPE_CLOCK "clock"
> +#define CLOCK(obj) OBJECT_CHECK(Clock, (obj), TYPE_CLOCK)
> +
> +typedef void ClockCallback(void *opaque);
> +
> +/*
> + * clock store a value representing the clock's period in 2^-32ns unit.
> + * It can represent:
> + *  + periods from 2^-32ns up to 4seconds
> + *  + frequency from ~0.25Hz 2e10Ghz
> + * Resolution of frequency representation decreases with frequency:
> + * + at 100MHz, resolution is ~2mHz
> + * + at 1Ghz,   resolution is ~0.2Hz
> + * + at 10Ghz,  resolution is ~20Hz
> + */
> +#define CLOCK_SECOND (1000000000llu << 32)
> +
> +/*
> + * macro helpers to convert to hertz / nanosecond
> + */
> +#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_SECOND / 1000000000llu))
> +#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_SECOND / 1000000000llu))
> +#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_SECOND / (hz) : 0u)

I'm having Floating Point Exception using a frequency of 1GHz.

Using frequency >=1GHz we have CLOCK_PERIOD_FROM_HZ(hz) > 0x100000000.

Then CLOCK_PERIOD_TO_NS(0x100000000) = 0.

So for frequency >=1GHz clock_get_ns() returns 0.

> +#define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_SECOND / (per) : 0u)
> +
[...]

