Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C90C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF2C20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2WKMIui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF2C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iebQq-0000kd-NU
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 04:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iebPs-00008W-5T
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iebPr-0000DD-4k
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:02:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45424
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iebPq-0000Cw-Um
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575968565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSMkijIZic98gZLxBN70ZWl3l2+XsDo4BdCYlb0skis=;
 b=H2WKMIuiUYHAN+c9nwNhyctccZZN0whmZJ41fwuCVqSUcvPaDJoUfanNaLBhOqlvnM7jYo
 Si3Z8V32HZ87I0SR/uUC+55bGosFxX2Ys0L3tsyzZo702O4RGYbgAnbWOyGsqPrGoZeKk9
 KVDg+pDRWi6PWDkdypYLSqHl1+muKDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-kvyXYazhMMOnN0juOr1Lwg-1; Tue, 10 Dec 2019 04:02:44 -0500
Received: by mail-wm1-f70.google.com with SMTP id n4so379555wmd.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 01:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vSMkijIZic98gZLxBN70ZWl3l2+XsDo4BdCYlb0skis=;
 b=sH+2bX+vw27IIvDL83slmUk5fcvH6umtI8chTTWcHESMqzKNBBYSpZTndwVJRAep3n
 asmxPVgcoXR+8qb4CdyRn5AF1MMBjt3JSZ4k0/13MNP3F4MPymfi0rDVOYIcxT1uHi7r
 +kZ+bTKBN1l8w+177ZaN4LpwiWM568Glxs1AEoRlwu9eMwvjWdkAt4U6IqS0xDJH38jb
 5/chqVEeSPaxdlHrv9Omf2kLyfJYR73hGCHRJf5Ukcvht4Qub7CPIaKZ4ixqtLUoXP5y
 d901zgWwEwQW25yAQVEw+NzkcQMRHqWKIg1QCzPj/qdPs60ZdqA0xGnJWSWe/CMGN2Sg
 tEfA==
X-Gm-Message-State: APjAAAVPjodir64y2MytHAhqSyC6/7IJ/ZoCDA1aGyXoZ5m8gIF5Hw35
 3DdjF9xv5kpCuOaOv5pg6KefdJRV+ADOUHkUilselfszKt5lFa6wf7z7w0Fez0USzRlgXqp8y7x
 TV3xD6999GgS+XYU=
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr1888466wrr.98.1575968563719; 
 Tue, 10 Dec 2019 01:02:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzE2I8PzvNqy9PeTYyk0iy6OBtzfR1eCTN6H6e5NpMzsvYKJOQxBRaTWMsK8p5t4henQt7EGQ==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr1888444wrr.98.1575968563501; 
 Tue, 10 Dec 2019 01:02:43 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id g2sm2477083wrw.76.2019.12.10.01.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 01:02:43 -0800 (PST)
Subject: Re: [PATCH 01/10] hw: arm: add Allwinner H3 System-on-Chip
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-2-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <70e9d4e8-49fb-02f9-23b4-d7cbf6e55eac@redhat.com>
Date: Tue, 10 Dec 2019 10:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-2-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: kvyXYazhMMOnN0juOr1Lwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> The Allwinner H3 is a System on Chip containing four ARM Cortex A7
> processor cores. Features and specifications include DDR2/DDR3 memory,
> SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and
> various I/O modules. This commit adds support for the Allwinner H3
> System on Chip.
> 
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
[...]
> +
> +    /* UART */
> +    if (serial_hd(0)) {

As the uart0 is always mapped in the SoC, don't use 'if serial_hd()', 
instead map it regardless a console is connected.

> +        serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
> +                       s->irq[AW_H3_GIC_SPI_UART0], 115200, serial_hd(0),
> +                       DEVICE_NATIVE_ENDIAN);
> +    }
> +
> +    /* Unimplemented devices */
> +    create_unimplemented_device("display-engine", AW_H3_DE_BASE, AW_H3_DE_SIZE);
> +    create_unimplemented_device("dma", AW_H3_DMA_BASE, AW_H3_DMA_SIZE);
> +    create_unimplemented_device("lcd0", AW_H3_LCD0_BASE, AW_H3_LCD0_SIZE);
> +    create_unimplemented_device("lcd1", AW_H3_LCD1_BASE, AW_H3_LCD1_SIZE);
> +    create_unimplemented_device("gpu", AW_H3_GPU_BASE, AW_H3_GPU_SIZE);
> +    create_unimplemented_device("hdmi", AW_H3_HDMI_BASE, AW_H3_HDMI_SIZE);
> +    create_unimplemented_device("rtc", AW_H3_RTC_BASE, AW_H3_RTC_SIZE);
> +    create_unimplemented_device("audio-codec", AW_H3_AC_BASE, AW_H3_AC_SIZE);


