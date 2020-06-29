Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4812C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C2F20874
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2VVEnhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C2F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq1MO-0003jN-Q0
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jq1LH-0002Iz-O7; Mon, 29 Jun 2020 17:29:31 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jq1LG-0004qv-1L; Mon, 29 Jun 2020 17:29:31 -0400
Received: by mail-oi1-x244.google.com with SMTP id h17so15677152oie.3;
 Mon, 29 Jun 2020 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=mBNE6E08hnEj0By8Ae+kTRvz5JqjdtRpGofE4zSogY8=;
 b=J2VVEnhUxw8cAJtap/KrJNTN0zu4B6gtAEo4HQMhdQgqD3OZjpTXTQgZXfRhl60Qji
 L4kGkxRH1wOVDwWRDcaMhtGZxzBp9jqVUQU4Hx55VEFxMzQoQ/ZNsi9K+pKNcQiUaa+n
 q67vN2NB3LsdwC6qLng4zPqstZWi7UPiT3C1Ic9q6SpCVREZITbtDpQQF5BLfQ0Movh6
 wGuCvgrj4vPayxKc3CyQYjM7g9MCYLlO4Bbyq6DqD81Jgl5QHSiJJvU8rIKNcD/xJkZN
 iMdpV4+B8Yn/AQMExfAVET++EanN45MBsAzvQ6upp6yXN4TVCh8hF5Y/17bKln1m1aly
 e1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=mBNE6E08hnEj0By8Ae+kTRvz5JqjdtRpGofE4zSogY8=;
 b=IIFvxFyaZOv2d8PXFjDd9Uas2sWDdFJslDz/2N1fbuQJGrFbtMXWTzk7woPJXC/UqO
 TMzOlD+qE398b6nuzDp5T6NDMgMlHHlap5yIhbNhYE31CxjumxMYnWwPd/4uWkJEOFfW
 47je4AxQdFfqnqmzkCBEmMAfNDQh+txtuSV8dZKltJedLOfR0kDfXVFDWfW7UT2C2GFm
 fA4D3CuzAv8F2YroRASoU4QqZdY6+IU6PivyoG89O29Id8Lh3XNlDgszpuFFjaeFh43g
 tg18wN2dFl2FWtlxQ9+V0xB5HGKo+e2RZaEQqguc6lZBzTRYcOPkHfn0Uy1WxCvyWRJn
 anLQ==
X-Gm-Message-State: AOAM533V93dG7v+t1ZI7lpVjEyoM8sYIIUJqUx2GbxOyQjvg5S4xtpeT
 lX98Oz5yRR8qHk0j/hSggg==
X-Google-Smtp-Source: ABdhPJzGia309moSNYp4EAuMjt6hA3/hYbuJXY1vQ/USRLLHpd/dn/+lPoGbHCXWE/27H6e8Wc8odQ==
X-Received: by 2002:a05:6808:612:: with SMTP id
 y18mr9700835oih.63.1593466168137; 
 Mon, 29 Jun 2020 14:29:28 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
 by smtp.gmail.com with ESMTPSA id k2sm272354otn.56.2020.06.29.14.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 14:29:27 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9993:aaf8:7c5:309c])
 by serve.minyard.net (Postfix) with ESMTPSA id C7C4118003B;
 Mon, 29 Jun 2020 21:29:26 +0000 (UTC)
Date: Mon, 29 Jun 2020 16:29:25 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/5] hw/i2c: Rename i2c_try_create_slave() as
 i2c_slave_new()
Message-ID: <20200629212925.GR3235@minyard.net>
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629173821.22037-3-f4bug@amsat.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: minyard@acm.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 07:38:18PM +0200, Philippe Mathieu-Daudé wrote:
> We use "new" names for functions that allocate and initialize
> device objects: pci_new(), isa_new(), usb_new().
> Let's call this one i2c_slave_new(). Since we have to update
> all the callers, also let it return a I2CSlave object.

Reviewed-by: Corey Minyard <cminyard@mvista.com>


> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/i2c/i2c.h | 2 +-
>  hw/arm/aspeed.c      | 4 ++--
>  hw/i2c/core.c        | 9 ++++-----
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index d6e3d85faf..18efc668f1 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -79,8 +79,8 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
>  int i2c_send(I2CBus *bus, uint8_t data);
>  uint8_t i2c_recv(I2CBus *bus);
>  
> +I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
> -DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
>  bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
>  
>  /* lm832x.c */
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 1285bf82c0..54ca36e0b6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -513,7 +513,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>      /* Bus 3: TODO bmp280@77 */
>      /* Bus 3: TODO max31785@52 */
>      /* Bus 3: TODO dps310@76 */
> -    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
> +    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
>      qdev_prop_set_string(dev, "description", "pca1");
>      i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 3),
>                            &error_fatal);
> @@ -531,7 +531,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
>  
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
>                            eeprom_buf);
> -    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
> +    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
>      qdev_prop_set_string(dev, "description", "pca0");
>      i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 11),
>                            &error_fatal);
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index acf34a12d6..6eacb4a463 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -267,13 +267,13 @@ const VMStateDescription vmstate_i2c_slave = {
>      }
>  };
>  
> -DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
> +I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
>  {
>      DeviceState *dev;
>  
>      dev = qdev_new(name);
>      qdev_prop_set_uint8(dev, "address", addr);
> -    return dev;
> +    return I2C_SLAVE(dev);
>  }
>  
>  bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
> @@ -283,10 +283,9 @@ bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>  {
> -    DeviceState *dev;
> +    DeviceState *dev = DEVICE(i2c_slave_new(name, addr));
>  
> -    dev = i2c_try_create_slave(name, addr);
> -    i2c_realize_and_unref(dev, bus, &error_fatal);
> +    i2c_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
>  
>      return dev;
>  }
> -- 
> 2.21.3
> 
> 

