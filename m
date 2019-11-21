Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F6C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 22:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA38620692
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 22:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="tvCZONOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA38620692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXvCH-0001pR-SM
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 17:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iXvBB-000199-Gb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iXvB5-0005eL-S4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:44:00 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iXvB5-0005dO-5r
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:43:55 -0500
Received: by mail-oi1-x242.google.com with SMTP id n16so4804182oig.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 14:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=BkkLzhTGLvvWR8YyT9RE4Rw8elFkW5WmNdKvMfJQewQ=;
 b=tvCZONOLrNS4GBZ/Z8aXXgvHbwainuDUkMOVZO1AygyB16xOkGt9p1Dxp8jl25c1Fc
 dSMqu7hwAn4R5q0JBB8qV6xVJHFXSb9Hs5b0VDPDiUNikx3Je0fG7c5bJcOaUkH6Mj5j
 EA8MHg/gex+dgZNFM8SkkvEEHcoNpMhU8wnW1w0rqKXCZzgufwuFJX5V3CAtMGGd17Ff
 cZ3u64mLk1C6z8g9E3Io0cf7qaXw3A/DY+7tpMVKgqey5160J0YZQS26beVxtyctB0yV
 Dm5L/Z1vs1RAUgrVon0v5GRCSM79kVhSvMs6nLekohfYr+65tDdf0rP6bc2lSAAeGWDJ
 nNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=BkkLzhTGLvvWR8YyT9RE4Rw8elFkW5WmNdKvMfJQewQ=;
 b=aetu1apz6B7uVb90CaanMoMrJonrsNJ7PM8z5tNoI2SSz/m1RQd1cIywqfEd+GNbDZ
 vOzI97xmUqQ4aQpLtNts8th3pLtOVdmidKUbTQ5xJrl1qiTdOnT7U1KUBQgBPioCZoPF
 xWQTnnTWzEikG08LxOEyuC/hZqF2ezawBWD1WLfhppkZ/yvztvOcjWuqU4gGLFoaTxDp
 SK7bbivqexpStCARGKsxH7IG5i2OHH7R72zUmjZqSaXtV0qvQCfYElrZVnPP/BbxPQA+
 7Y+M13HTl5gSDewZq20vPnYnVY0mMZru3OkJErZmN57VfIfM42gCPrul4BS6j8RE9CwZ
 nkNg==
X-Gm-Message-State: APjAAAW/IQqltA0KiITuf3V4UwnPPZNNoPKXiaQV8ay6Z5cM9bXhv5OR
 7p6yE4FwqA/fbb0HoON6YYm8LA==
X-Google-Smtp-Source: APXvYqyexo4JqBz7E88NSUOX1/fRyNcFOiLcqU/dguFdowp95v9vm53dHeI4qsJemG5isDs64osPQw==
X-Received: by 2002:aca:4a0e:: with SMTP id x14mr9340136oia.123.1574376233648; 
 Thu, 21 Nov 2019 14:43:53 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id o2sm1399938oih.19.2019.11.21.14.43.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Nov 2019 14:43:53 -0800 (PST)
Date: Thu, 21 Nov 2019 16:43:51 -0600
From: Corey Minyard <cminyard@mvista.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 31/37] smbus-eeprom: remove PROP_PTR
Message-ID: <20191121224351.GN3556@minyard.net>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-32-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191120152442.26657-32-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 07:24:36PM +0400, Marc-André Lureau wrote:
> Instead, set the initial data field directly.
> 
> (the initial data is an array of 256 bytes. As I don't know if it may
> change over time, I keep the pointer to original buffer as is, but it
> might be worth to consider to copy it instead)

This looks ok to me, I can add it to my tree.  I think we are in hard
freeze now, so this will have to wait until that's done.

-corey

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/i2c/smbus_eeprom.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 54c86a0112..533c728b3b 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -44,7 +44,7 @@
>  typedef struct SMBusEEPROMDevice {
>      SMBusDevice smbusdev;
>      uint8_t data[SMBUS_EEPROM_SIZE];
> -    void *init_data;
> +    uint8_t *init_data;
>      uint8_t offset;
>      bool accessed;
>  } SMBusEEPROMDevice;
> @@ -129,14 +129,14 @@ static void smbus_eeprom_reset(DeviceState *dev)
>  
>  static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>  {
> +    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
> +
>      smbus_eeprom_reset(dev);
> +    if (eeprom->init_data == NULL) {
> +        error_setg(errp, "init_data cannot be NULL");
> +    }
>  }
>  
> -static Property smbus_eeprom_properties[] = {
> -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>      dc->reset = smbus_eeprom_reset;
>      sc->receive_byte = eeprom_receive_byte;
>      sc->write_data = eeprom_write_data;
> -    dc->props = smbus_eeprom_properties;
>      dc->vmsd = &vmstate_smbus_eeprom;
> -    /* Reason: pointer property "data" */
> +    /* Reason: init_data */
>      dc->user_creatable = false;
>  }
>  
> @@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
>  
>      dev = qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
>      qdev_prop_set_uint8(dev, "address", address);
> -    qdev_prop_set_ptr(dev, "data", eeprom_buf);
> +    SMBUS_EEPROM(dev)->init_data = eeprom_buf;
>      qdev_init_nofail(dev);
>  }
>  
> -- 
> 2.24.0
> 

