Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB01AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729C0206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="iEBnVjPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729C0206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLa1-000141-Ml
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jiLZC-0000bL-UI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:28:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jiLZB-0007CW-EG
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:28:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id u13so306126wml.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QsxZEhQuCPhGKV5zrt5pgnxDcUMhK1rbdoQ6WUCT96U=;
 b=iEBnVjPfH7f0V+UMbhNBuGykiI3fP8Q45sPd5Befb6fHBkPoWCIMsAVh7yfESfkuvA
 YAgnLa16xro2o34Ja1k8t02lHkgfyPWi+KBLqmNBceAB25CgFN827tOXvTXqkfTKHWw1
 62rgkT9XhxLTDtFzWz1DO6jqiUYRjtzk3U8KBZ5YIYrvwIP17B+5p2SkPBAg4IPY2niD
 F6Xpzm9/oQI7NRP26sdYRbi937L9w84KRMxZrGVGCMvuZ4uZ/dPiNsxSnCKTkNd94V1C
 7hySh8pm+55iO3u2Gt9KHZvA6AXKPkn/DCbrZPzsiJHxXSSjrwwEE3Eg26EDxWW1RLfb
 QYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QsxZEhQuCPhGKV5zrt5pgnxDcUMhK1rbdoQ6WUCT96U=;
 b=FAd905o3bRLmBvczcAjnWww+c2K13y/6d93v3/ZzvsCdS8nHTnOdLWkFvzsjW5D6iC
 XQP5hYnHbLgboPI5ua1R9p1+HxNz/lzm8WUdHgWLZM1izrCycjbs0mW2NS0LBUY2gWro
 Qf3sBDKGls+Jgd4+oOQ6Q+JE6BHo7moasdThXE9jOfZ+owGKUQBGRH4mvm+pxWvUb5Ae
 /t0Piuv/o/VPPZKw+4qhTYiSsmp2/JMgEoZcKttXvm0hvzjzCJm2fakLu+w+aAsoORkT
 xe1ZOnZpawy2/gG6/whYaGK7iTvRDihscAq2F4wKjfqaaetGY32JJCT43BdU/XrCaNsq
 a5Ag==
X-Gm-Message-State: AOAM531ShXNq3lyrsSWlXpPnVe+FO/KoXm/mCPx7p2PgTBKehOOAJY34
 g25kSG5sZKkImohu0erxZVuUJQ==
X-Google-Smtp-Source: ABdhPJy4x7XdBB0UwHZ1XL4oW717RgcbMh3J8wNK1xufvKBmhJAxdL6XvYU51CXZEJRIXVN3Xd17Jg==
X-Received: by 2002:a1c:790f:: with SMTP id l15mr343257wme.161.1591637287451; 
 Mon, 08 Jun 2020 10:28:07 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id f71sm201520wmf.22.2020.06.08.10.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 10:28:06 -0700 (PDT)
Subject: Re: [PATCH 1/3] hw/sparc/leon3: Map the UART device unconditionally
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200608172144.20461-1-f4bug@amsat.org>
 <20200608172144.20461-2-f4bug@amsat.org>
From: Fred Konrad <konrad@adacore.com>
Message-ID: <696e124e-c709-7f7c-fdd0-d3d42db0ebb6@adacore.com>
Date: Mon, 8 Jun 2020 19:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608172144.20461-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=konrad@adacore.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 6/8/20 à 7:21 PM, Philippe Mathieu-Daudé a écrit :
> The UART is present on the chipset regardless there is a
> character device connected to it. Map it unconditionally.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/sparc/leon3.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 8f024dab7b..cc55117dec 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -339,16 +339,14 @@ static void leon3_generic_hw_init(MachineState *machine)
>                               0, LEON3_TIMER_IRQ, GRLIB_APBIO_AREA);
>   
>       /* Allocate uart */
> -    if (serial_hd(0)) {
> -        dev = qdev_create(NULL, TYPE_GRLIB_APB_UART);
> -        qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
> -        qdev_init_nofail(dev);
> -        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ]);
> -        grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
> -                                GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
> -                                LEON3_UART_IRQ, GRLIB_APBIO_AREA);
> -    }
> +    dev = qdev_create(NULL, TYPE_GRLIB_APB_UART);
> +    qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ]);
> +    grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
> +                            GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
> +                            LEON3_UART_IRQ, GRLIB_APBIO_AREA);
>   }
>   
>   static void leon3_generic_machine_init(MachineClass *mc)
> 

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

Thanks!

