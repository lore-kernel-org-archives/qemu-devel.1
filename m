Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA2AC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 19:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF20206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 19:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="N7ibSaiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF20206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imN19-0001SH-Jv
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 14:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1imMzx-0000SF-NG
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 14:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1imMzv-0003BT-6N
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 14:16:08 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1imMzu-00037y-Lo
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 14:16:07 -0500
Received: by mail-ot1-x344.google.com with SMTP id p8so14856756oth.10
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 11:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Kh1ysNyPAOV3r5UKC7kdow7bOabWpyJz9AxcLd/CeYI=;
 b=N7ibSaiAgm+AWNusvn/AVoX/ejw3L0jxP02D2CRg+2kKIABZS8blKqkFmjrPYmXwKA
 W4rlch/iv0QKu6MFFs6WfH5vpxpwa9Hj72xRFdd0OtFPUutc17SwF/yGVs3u/+0lH0SH
 M08vaWBhqF5747A/byl/FrYKrDxvV3tphIovIJh2SQInZZA8qrWwSgLpdzIIFF1+i5Rq
 sqcKw2TO72Y+3FTy3Ggw7kF9YyP4Ni637xGIZ5ea0CG5aK5UK0IbIHoPCJoy8PVZsbqf
 zJAusQW8KM0K14T5RIWhMlksssyHLX0oQhiAtKemtm0wgXDVP+uQ1tqokDrJhkA++Umt
 93LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=Kh1ysNyPAOV3r5UKC7kdow7bOabWpyJz9AxcLd/CeYI=;
 b=uGP2ao+Y0KQK9w5qwEsxNKdIwJv6PBJU/TT6lEipUuLP1c77+G68oqodqm+rYPZ6pe
 6ZH2bqTReUsH62AOjmOEBfOSE6eLYtEK0XailCrLTUBzhO8MsHh5yRYI55ZZWEyEkEQh
 4sdAHPY1X3w42NWyNqKOoh1HmR04oiJFTppv0QHnRKe22s7LBoJ+ScpllGyYoZBhf7Yy
 97Fw83HaSX42dh3GNses/jtyQej0+93mw8WyyA3qNnBXpwXo5ZACiJx4recgKATWd75q
 nOytKLKcL59/IINzAqKgvG+tgIpRxkjJjKoeePa0C8py5qiVePxNTrP6ot3jztSOf17F
 Wb5Q==
X-Gm-Message-State: APjAAAXCsn74lj+K3uM2cwbt0lFMrIcD+6q/MLmQKfEZLRLnX1e57ULO
 beFHsF+k1eM94wSD1IBvhUMAyA==
X-Google-Smtp-Source: APXvYqyETdr19ICFqi5OT9NXmHYk/KM7TIIwVykHN6sWmDZa9rEs/QlCeuEf62tZKSErHxE1Ssca+A==
X-Received: by 2002:a05:6830:1481:: with SMTP id
 s1mr64982802otq.66.1577819763825; 
 Tue, 31 Dec 2019 11:16:03 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:7026:9184:fc4e:6328])
 by smtp.gmail.com with ESMTPSA id h1sm11703720otn.6.2019.12.31.11.16.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 31 Dec 2019 11:16:02 -0800 (PST)
Date: Tue, 31 Dec 2019 13:16:00 -0600
From: Corey Minyard <cminyard@mvista.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 05/14] hw/i2c/Kconfig: Add an entry for the SMBus
Message-ID: <20191231191600.GB6497@minyard.net>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191231183216.6781-6-philmd@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Reply-To: cminyard@mvista.com
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 31, 2019 at 07:32:07PM +0100, Philippe Mathieu-Daudé wrote:
> The System Management Bus is more or less a derivative of the I2C
> bus, thus the Kconfig entry depends of I2C.
> Not all boards providing an I2C bus support SMBus.
> Use two different Kconfig entries to be able to select I2C without
> selecting SMBus.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Corey Minyard <cminyard@mvista.com>
> ---
>  default-configs/mips-softmmu-common.mak | 1 +
>  hw/i2c/Kconfig                          | 8 ++++++--
>  hw/i2c/Makefile.objs                    | 3 ++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
> index da29c6c0b2..ac76d944b8 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -37,6 +37,7 @@ CONFIG_R4K=y
>  CONFIG_MALTA=y
>  CONFIG_PCNET_PCI=y
>  CONFIG_MIPSSIM=y
> +CONFIG_SMBUS=y

Why is the above necessary?  Wouldn't CONFIG_ACPI_SMBUS=y below cause
this to be done?

>  CONFIG_ACPI_SMBUS=y
>  CONFIG_SMBUS_EEPROM=y
>  CONFIG_TEST_DEVICES=y
> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index 2bbd395813..09642a6dcb 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -1,9 +1,13 @@
>  config I2C
>      bool
>  
> +config SMBUS
> +    bool
> +    select I2C
> +
>  config SMBUS_EEPROM
>      bool
> -    depends on I2C
> +    select SMBUS
>  
>  config VERSATILE_I2C
>      bool
> @@ -11,7 +15,7 @@ config VERSATILE_I2C
>  
>  config ACPI_SMBUS
>      bool
> -    select I2C
> +    select SMBUS
>  
>  config BITBANG_I2C
>      bool
> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> index d7073a401f..cbbc8507a3 100644
> --- a/hw/i2c/Makefile.objs
> +++ b/hw/i2c/Makefile.objs
> @@ -1,4 +1,5 @@
> -common-obj-$(CONFIG_I2C) += core.o smbus_slave.o smbus_master.o
> +common-obj-$(CONFIG_I2C) += core.o
> +common-obj-$(CONFIG_SMBUS) += smbus_slave.o smbus_master.o
>  common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
>  common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
>  common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o

There is some messiness with ICH, but it appears that everything will
work correctly there and this patch is not the right place to fix it.

This looks fine and avoids including smbus code when it is not
necessary.  With the MIPS config item removed (assuming it is not
necessary):

Reviewed-by: Corey Minyard <cminyard@mvista.com>

I can take it into my tree if you like.

Thanks,

-corey

> -- 
> 2.21.0
> 

