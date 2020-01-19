Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583EFC33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 19:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218B120679
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 19:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFpiSK9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218B120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itFry-0002U1-Nk
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 14:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itFph-00012e-4g
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itFpf-00015Q-Fe
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:02:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itFpf-000152-CJ
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579460518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IzTTHVQqgsptuvAIgaz11UGzYkZ0gYHctxJHwZrm4LE=;
 b=aFpiSK9zmLmmGLuWTFPkRmT4UiwKq0HmeSVcABIN/PL/up3XxGUW/CoVW6UJBQjQk1Qy2/
 F76pKoLC5Gvj4fVDPDaZpk7tEqztxEljYNCYWnjEAow02SaxSTrwow5w/wz1IxM7VAhqn8
 xnIIrPIyBNDD9A0CTRv9gzsSgVOoCKI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-fmR1_JMYMHO5PM4C5KrD8g-1; Sun, 19 Jan 2020 14:01:55 -0500
Received: by mail-wr1-f69.google.com with SMTP id f10so13129916wro.14
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 11:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YzVnPmTQlEX2jbH2xwE0zJpBepDUB8pA2HIxAP69GOk=;
 b=d1z7aW0aUvSUwJd/RkzbePq6lIP9btVVKj6mPXDK65+Z1BZepLfoRuGDT1Y96sUcsZ
 S/nNpsjgNNZ7bLj3yjxn5+PczPEOVv6AvXOhC+A7K3RhBI2D3olAx0lZWaVS0tyYFaW0
 7sxlpQscf0GCoAWyFkxyngdgHPXKtahofY2ormHLSeT18oHQeGvaT+PMJrxEGZIuIxgV
 ZGeZ/HLcdNeKfsA9fQODGboKOT53ULhtUjD0kpZOdLifKuiGXw/XbFcmhgJVlAuCSBRo
 lKoboqyJ3Ac3yn2JY+u/xVXCPMxrt8Y0fvZfuET5tpoXOPUv4HdI58jMyYIKvKm+3xSx
 Wq4g==
X-Gm-Message-State: APjAAAX/p9qtmE7dOzGqpEuTEa+sw/eFHLH40Cf8rwjjhKv8TjVcTchi
 o1FH/VjTm7Z4KjPIgY8OCi/RVfWuflm7YItBMVdsaQE0SPlzrpGbq72ee24TSvl068chJoEcr+a
 x3j39PJTlH5mvpJk=
X-Received: by 2002:a5d:484d:: with SMTP id n13mr14162012wrs.420.1579460514297; 
 Sun, 19 Jan 2020 11:01:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrwyJn10h7D8k/CRZd9qAZYm1wH2x6CmWfpUig4n2tUpo1IRxiCoyDjW5+GF7cRvdYiis+DA==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr14162004wrs.420.1579460514105; 
 Sun, 19 Jan 2020 11:01:54 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id e16sm44263684wrs.73.2020.01.19.11.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 11:01:53 -0800 (PST)
Subject: Re: [PATCH v4 08/20] hw/arm/allwinner: add SD/MMC host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-9-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e9c31386-d471-159a-6cb0-7e621cb3bc83@redhat.com>
Date: Sun, 19 Jan 2020 20:01:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200119005102.3847-9-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: fmR1_JMYMHO5PM4C5KrD8g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> The Allwinner System on Chip families sun4i and above contain
> an integrated storage controller for Secure Digital (SD) and
> Multi Media Card (MMC) interfaces. This commit adds support
> for the Allwinner SD/MMC storage controller with the following
> emulated features:
>=20
>   * DMA transfers
>   * Direct FIFO I/O
>   * Short/Long format command responses
>   * Auto-Stop command (CMD12)
>   * Insert & remove card detection
>=20
> The following boards are extended with the SD host controller:
>=20
>   * Cubieboard (hw/arm/cubieboard.c)
>   * Orange Pi PC (hw/arm/orangepi.c)
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   include/hw/arm/allwinner-a10.h   |   2 +
>   include/hw/arm/allwinner-h3.h    |   3 +
>   include/hw/sd/allwinner-sdhost.h | 135 +++++
>   hw/arm/allwinner-a10.c           |  11 +
>   hw/arm/allwinner-h3.c            |  15 +-
>   hw/arm/cubieboard.c              |  15 +
>   hw/arm/orangepi.c                |  16 +
>   hw/sd/allwinner-sdhost.c         | 848 +++++++++++++++++++++++++++++++
>   hw/sd/Makefile.objs              |   1 +
>   hw/sd/trace-events               |   7 +
>   10 files changed, 1052 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/sd/allwinner-sdhost.h
>   create mode 100644 hw/sd/allwinner-sdhost.c

Failure at build if configured with --without-default-devices:

   CC      arm-softmmu/hw/sd/allwinner-sdhost.o
   CC      arm-softmmu/hw/arm/orangepi.o
   CC      arm-softmmu/hw/arm/allwinner-h3.o
   LINK    arm-softmmu/qemu-system-arm
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function=20
`allwinner_sdhost_send_command':
hw/sd/allwinner-sdhost.c:239: undefined reference to `sdbus_do_command'
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function `allwinner_sdhost_read':
hw/sd/allwinner-sdhost.c:517: undefined reference to `sdbus_data_ready'
/usr/bin/ld: hw/sd/allwinner-sdhost.c:518: undefined reference to=20
`sdbus_read_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.c:519: undefined reference to=20
`sdbus_read_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.c:520: undefined reference to=20
`sdbus_read_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.c:521: undefined reference to=20
`sdbus_read_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function=20
`allwinner_sdhost_process_desc':
hw/sd/allwinner-sdhost.c:340: undefined reference to `sdbus_read_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.c:334: undefined reference to=20
`sdbus_write_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function `allwinner_sdhost_write'=
:
hw/sd/allwinner-sdhost.c:651: undefined reference to `sdbus_write_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.c:652: undefined reference to=20
`sdbus_write_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.c:653: undefined reference to=20
`sdbus_write_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.c:654: undefined reference to=20
`sdbus_write_data'
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function `allwinner_sdhost_dma':
hw/sd/allwinner-sdhost.c:372: undefined reference to `sdbus_data_ready'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:206: qemu-system-arm] Error 1

Fixed by:

-- >8 --
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index bb75c1de17..086241354c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -302,6 +302,9 @@ config ALLWINNER_H3
      select ARM_TIMER
      select ARM_GIC
      select UNIMP
      select USB_OHCI
      select USB_EHCI_SYSBUS
+    select SD

  config RASPI
      bool
---


