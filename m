Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7189DC34034
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B50D21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG3dPi+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B50D21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yGl-000793-Ej
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 03:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3yGB-0006jj-Oc
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3yGA-00063I-0r
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:29:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56753
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3yG9-000630-Nw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582014576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLL96ywG+9iWTtKSqDm96g1jso/bu+9RH37uqqDGlE8=;
 b=PG3dPi+pNNdQMI2TS7KdQYqFc9CO1/soRKcaDht90mdm5LJvkEGzgPFhO0B0Cq5x8HUduv
 /+qAB8kOi0enZXmAyvekaKEzd22LWxw3wdftKX3WYpGEPffowdx8OeelqfYwx8RisCPnvV
 LImiu25eDKLyGHxyNDpayPmpJHlc0sk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-2wzABskONQWVurGtjgc-mA-1; Tue, 18 Feb 2020 03:29:22 -0500
Received: by mail-wm1-f70.google.com with SMTP id o24so717705wmh.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 00:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kLL96ywG+9iWTtKSqDm96g1jso/bu+9RH37uqqDGlE8=;
 b=JmuX0F7jqYLOTqfFEVH0RlfUDxNcMo7R6LUdOFsNL2fQJYvL8pVA1iOlsiwpAjuI2x
 dysIND7rFQx8FUV37rH2h1vBk+QKgIKYPCK8afa6h43govCrqDLH3wpfyqTlhR9YTqe8
 jo8dfKZzazTjsesmprF1q+eZSRv/yTWkoBjP4+hTrCvFmKOoO3ErCWKMaVloo1//bc/I
 l3BXxz6lLThMM5WIN1UZ3WPitM5vY6QrV4ersP0UZFtI4cZTb6ATzK9z+lREmOpybYBy
 m81GggYnVp9mXo+5q7NBWzrKxa9W8u3QQ43NrqOrLs/CguJvxs/kpSdurVsqz/Rhc2Kh
 dX5A==
X-Gm-Message-State: APjAAAVM2vlrMC0ahRRlr1tAJS83NdWeeE2WCV6VeSuvRhTQp43uRPlZ
 iWH+IzMeCWfGzcy58nK3hFBVzZijdNr9rvWD2ZhzL0V0EFupZYqHHkaAWpPn3f3Jk7RJNurfDhs
 LuLLUo6eJ/zYfhRw=
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr1728497wmb.38.1582014560932; 
 Tue, 18 Feb 2020 00:29:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzV++KYtL8eDTVXo9hobZ3JU2SJva+Wbtv9KpXt/kdGxdJIOjMVB0q1jXrCslUfw0gFSXuEvQ==
X-Received: by 2002:a1c:65d6:: with SMTP id z205mr1728458wmb.38.1582014560585; 
 Tue, 18 Feb 2020 00:29:20 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id j15sm5216496wrp.9.2020.02.18.00.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 00:29:20 -0800 (PST)
Subject: Re: [PULL v3 04/11] hppa: add emulation of LASI PS2 controllers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200124232009.12928-1-richard.henderson@linaro.org>
 <20200124232009.12928-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6e093940-3439-4e66-86db-01eea375a183@redhat.com>
Date: Tue, 18 Feb 2020 09:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124232009.12928-5-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 2wzABskONQWVurGtjgc-mA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, deller@gmx.de, svens@stackframe.org,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Eduardo/Markus.

On 1/25/20 12:20 AM, Richard Henderson wrote:
> From: Sven Schnelle <svens@stackframe.org>
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Message-Id: <20191220211512.3289-5-svens@stackframe.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/input/lasips2.h |  16 ++
>   include/hw/input/ps2.h     |   1 +
>   hw/hppa/lasi.c             |  10 +-
>   hw/input/lasips2.c         | 291 +++++++++++++++++++++++++++++++++++++
>   hw/input/ps2.c             |   5 +
>   hw/hppa/Kconfig            |   1 +
>   hw/input/Kconfig           |   3 +
>   hw/input/Makefile.objs     |   1 +
>   hw/input/trace-events      |   5 +
>   9 files changed, 332 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/input/lasips2.h
>   create mode 100644 hw/input/lasips2.c
> 
> diff --git a/include/hw/input/lasips2.h b/include/hw/input/lasips2.h
> new file mode 100644
> index 0000000000..0cd7b59064
> --- /dev/null
> +++ b/include/hw/input/lasips2.h
> @@ -0,0 +1,16 @@
> +/*
> + * QEMU LASI PS/2 emulation
> + *
> + * Copyright (c) 2019 Sven Schnelle
> + *
> + */
> +#ifndef HW_INPUT_LASIPS2_H
> +#define HW_INPUT_LASIPS2_H
> +
> +#include "exec/hwaddr.h"
> +
> +#define TYPE_LASIPS2 "lasips2"
> +
> +void lasips2_init(MemoryRegion *address_space, hwaddr base, qemu_irq irq);
> +
> +#endif /* HW_INPUT_LASIPS2_H */
[...]
> +
> +void lasips2_init(MemoryRegion *address_space,
> +                  hwaddr base, qemu_irq irq)
> +{
> +    LASIPS2State *s;
> +
> +    s = g_malloc0(sizeof(LASIPS2State));

At the current QOM conversion rate, we should have all devices QOM'ified 
by 2027, so please do not introduce non-QOM devices...

Does anyone have an idea how we could refuse them using checkpatch?

> +
> +    s->irq = irq;
> +    s->mouse.id = 1;
> +    s->kbd.parent = s;
> +    s->mouse.parent = s;
> +
> +    vmstate_register(NULL, base, &vmstate_lasips2, s);
> +
> +    s->kbd.dev = ps2_kbd_init(ps2dev_update_irq, &s->kbd);
> +    s->mouse.dev = ps2_mouse_init(ps2dev_update_irq, &s->mouse);
> +
> +    memory_region_init_io(&s->kbd.reg, NULL, &lasips2_reg_ops, &s->kbd,
> +                          "lasips2-kbd", 0x100);
> +    memory_region_add_subregion(address_space, base, &s->kbd.reg);
> +
> +    memory_region_init_io(&s->mouse.reg, NULL, &lasips2_reg_ops, &s->mouse,
> +                          "lasips2-mouse", 0x100);
> +    memory_region_add_subregion(address_space, base + 0x100, &s->mouse.reg);
> +}
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 0b671b6339..f8746d2f52 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -192,6 +192,11 @@ static void ps2_reset_queue(PS2State *s)
>       q->count = 0;
>   }
>   
> +int ps2_queue_empty(PS2State *s)
> +{
> +    return s->queue.count == 0;
> +}
> +
>   void ps2_queue_noirq(PS2State *s, int b)
>   {
>       PS2Queue *q = &s->queue;
> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
> index 2a7b38d6d6..7f9be7f25c 100644
> --- a/hw/hppa/Kconfig
> +++ b/hw/hppa/Kconfig
> @@ -11,3 +11,4 @@ config DINO
>       select MC146818RTC
>       select LSI_SCSI_PCI
>       select LASI_82596
> +    select LASIPS2
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
> diff --git a/hw/input/trace-events b/hw/input/trace-events
> index cf072fa2f8..a2888fd10c 100644
> --- a/hw/input/trace-events
> +++ b/hw/input/trace-events
> @@ -53,3 +53,8 @@ tsc2005_sense(const char *state) "touchscreen sense %s"
>   
>   # virtio-input.c
>   virtio_input_queue_full(void) "queue full"
> +
> +# lasips2.c
> +lasips2_reg_read(unsigned int size, int id, uint64_t addr, const char *name, uint64_t val) "%u %d addr 0x%"PRIx64 "%s -> 0x%"PRIx64
> +lasips2_reg_write(unsigned int size, int id, uint64_t addr, const char *name, uint64_t val) "%u %d addr 0x%"PRIx64 "%s <- 0x%"PRIx64
> +lasips2_intr(unsigned int val) "%d"
> 


