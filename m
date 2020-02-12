Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0ABC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6525206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2srtWds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6525206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lKl-0005CC-RT
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1lJh-00047J-Gb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1lJg-0000gN-Cp
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:16:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1lJg-0000fs-9U
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581488167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xwy4C9U6DaV2vcMps8DhSCryfmgcAxIXNAFnnjj2qo4=;
 b=e2srtWds8zOg09nTHhC5STy4QaMpPPsHJucsVmJ62sdF7vo0My+vMGGs6ZnkceCC+ZZZaq
 p3YH8fQ7X237CEBTPaAlOEuMKhHMOZY9HMziHtf0WI78aXXXYcAtDtgYKdGADsl6YEWIdc
 +cOykXn3Szog0MUrt8dpHjIMyhsWwtA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-xCkG3baYMBu6Om-fNLgLwA-1; Wed, 12 Feb 2020 01:16:05 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so372786wrm.23
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 22:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xwy4C9U6DaV2vcMps8DhSCryfmgcAxIXNAFnnjj2qo4=;
 b=mwly/5A7hqEg8Kh6A0jY16Y7ZsVkGwYxfs2u8O5FWVpKq0Hm9dLh060QL6RoH01lrM
 1mQic61mCTw9RQcpJxBFB57TKjU5BcAakgn1VU1Ckm3wAKirLMl0oSRDQLBDolLO3xoo
 yAXazLF4WqAOf7IHSZZnPav+jEb7tPv1WAdnkg8BDGTnJH+W1ozU+5brGGp6R5QjlmCq
 +gB6jpnXvBMrE68IXeAaqZXWyIp4W5GmW62ll4u/MixsRta1xQMhHRLIbFPaZpWklinZ
 ypNyk64Xuo63bQJd3bTVQmm5ms50BQs+aOl/1shbhjDXMyv2GXqrBsQQS/i3FXBnW9Ue
 o87Q==
X-Gm-Message-State: APjAAAUFhcHZwC4Wtg3EtY3YwVIDv9I68ImUqrLY7t5N3CldGnr213WA
 /7VUHt4FZOIZzEPzcNd0f86akFVJN3XfHmcySY+3qIuhnVGCjDad+eZnkXlNn65aIYIT7Un/lxz
 MPzVkTnBMrf2ygKY=
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr10290031wmj.41.1581488164504; 
 Tue, 11 Feb 2020 22:16:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+HpsIe6+Z1q6ciB9lGFCueNILb7cqM3KM/G8wzRDXdG2O2tTf3a++nrpDUyzE1PlQTp/euw==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr10290006wmj.41.1581488164276; 
 Tue, 11 Feb 2020 22:16:04 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y8sm6683917wma.10.2020.02.11.22.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 22:16:03 -0800 (PST)
Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, i.mitsyanko@gmail.com,
 peter.maydell@linaro.org
References: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
Date: Wed, 12 Feb 2020 07:16:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-MC-Unique: xCkG3baYMBu6Om-fNLgLwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 4:36 AM, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
> 
> It's easy to reproduce as follow:
> virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-properties",
> "arguments":{"typename":"exynos4210.uart"}}'
> 
> ASAN shows memory leak stack:
>    #1 0xfffd896d71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
>    #2 0xaaad270beee3 in timer_new_full /qemu/include/qemu/timer.h:530
>    #3 0xaaad270beee3 in timer_new /qemu/include/qemu/timer.h:551
>    #4 0xaaad270beee3 in timer_new_ns /qemu/include/qemu/timer.h:569
>    #5 0xaaad270beee3 in exynos4210_uart_init /qemu/hw/char/exynos4210_uart.c:677
>    #6 0xaaad275c8f4f in object_initialize_with_type /qemu/qom/object.c:516
>    #7 0xaaad275c91bb in object_new_with_type /qemu/qom/object.c:684
>    #8 0xaaad2755df2f in qmp_device_list_properties /qemu/qom/qom-qmp-cmds.c:152
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
>   hw/char/exynos4210_uart.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index 25d6588e41..5048db5410 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -674,10 +674,6 @@ static void exynos4210_uart_init(Object *obj)
>       SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>       Exynos4210UartState *s = EXYNOS4210_UART(dev);
>   
> -    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                         exynos4210_uart_timeout_int, s);
> -    s->wordtime = NANOSECONDS_PER_SECOND * 10 / 9600;

Why are you moving s->wordtime from init() to realize()?

> -
>       /* memory mapping */
>       memory_region_init_io(&s->iomem, obj, &exynos4210_uart_ops, s,
>                             "exynos4210.uart", EXYNOS4210_UART_REGS_MEM_SIZE);
> @@ -691,6 +687,10 @@ static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
>   {
>       Exynos4210UartState *s = EXYNOS4210_UART(dev);
>   
> +    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                         exynos4210_uart_timeout_int, s);
> +    s->wordtime = NANOSECONDS_PER_SECOND * 10 / 9600;
> +
>       qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
>                                exynos4210_uart_receive, exynos4210_uart_event,
>                                NULL, s, NULL, true);
> 


