Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A892CC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B6F2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="ngLuOiQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B6F2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfkzR-0002qI-Cm
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 08:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cminyard@mvista.com>) id 1hfkxr-00023u-UE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1hfkxn-0006RN-9Y
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:54:23 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1hfkxk-0006K3-Gs
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:54:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id a128so12454116oib.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=M0y6RtiYx1oiWXXDSRi0YOtiuN/WV9VqD9VA+YP6ozE=;
 b=ngLuOiQUulxuvA59eVvHUMR93hZ90GDBLBayEeuimrqEoB5+Dcz2Xjtnf4rPP2mufP
 zV1TpFLRQMXux4aKD6HQaZXdfJ3+g2SLfO8duoHIGGF/AoppPvrgZLBz+2dIXvV67q/q
 xBsRzqlUNZIPDVPf03DIZC4if46Nh3Qh2s28TBrfamszLZuql09s25eJCWgnO7G8AFy3
 wRiuTVHmAClkqsxel2CSg2sRxcenedoBvOu66aZ1sRXsPq4eUCSIefN+hyAR+doH7Do9
 y4yzLPOBE9QZba/0wSyjUV9ljo7qSUXMzLpKMIt/ncFQMHPfWZ4mfWLQps3xR0H+D4SD
 50UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=M0y6RtiYx1oiWXXDSRi0YOtiuN/WV9VqD9VA+YP6ozE=;
 b=DYCEr26NCWaaVRxBfB0axkVt6kd8YIe8Tk49fbi6E3mOpqWvr7m5Hrb2PPCNsDhZ1d
 5XVTAITLXa0POO8cX8dKoJ4Jrjf4YQOcLeQIPbRg46w+qpP3KyRRSaAjztJwUMZBEuZ5
 +MGliVOqLqWhaCyF6mrLgHiMvcG52kpk/KRF/CK2WI/OuuO93PCEeFOC0P5NVi8hq8DA
 5EoV9R7rSnQKEAYRB4BK5gfM2v/B3JZzUS2XzF9alO0qYBF/mSjbvEaFs2Y+hS77Fdvg
 kdQbaiOCi1YIeWmrfM3pPvhRum9R5hS8XtB6HKenAXlByR1NduQa6KUiI6Cy8RuwObFI
 9okg==
X-Gm-Message-State: APjAAAX4Pc3X2sbZNHeS3s5wp9st5CAiw3w4MBPJff85Dc9XcItHZkQm
 8+Uml7VSnZR47gq3w8KO0gXlqw==
X-Google-Smtp-Source: APXvYqxv51DkEmMsG32h7S9tnmk3+4DwUDDwfNGN4bwHiqVeBeiOwGUaObDc6rEgCUU1+B7t0IUSvw==
X-Received: by 2002:aca:4806:: with SMTP id v6mr14573399oia.133.1561467249163; 
 Tue, 25 Jun 2019 05:54:09 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:686e:97ca:5163:b01e])
 by smtp.gmail.com with ESMTPSA id s22sm5234416otk.0.2019.06.25.05.54.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 05:54:08 -0700 (PDT)
Date: Tue, 25 Jun 2019 07:54:06 -0500
From: Corey Minyard <cminyard@mvista.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20190625125406.GE5565@minyard.net>
References: <cover.1561028123.git.balaton@eik.bme.hu>
 <5d1fe4db846ab9be4b77ddb0d43cc74cd200a003.1561028123.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1fe4db846ab9be4b77ddb0d43cc74cd200a003.1561028123.git.balaton@eik.bme.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v5 1/2] i2c: Move bitbang_i2c.h to
 include/hw/i2c/
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 12:55:23PM +0200, BALATON Zoltan wrote:
> The bitbang i2c implementation is also useful for other device models
> such as DDC in display controllers. Move the header to include/hw/i2c/
> to allow it to be used from other device models and adjust users of
> this include. This also reverts commit 2b4c1125ac which is no longer
> needed.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

This change looks good to me.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/i2c/bitbang_i2c.c                 | 2 +-
>  hw/i2c/ppc4xx_i2c.c                  | 1 -
>  hw/i2c/versatile_i2c.c               | 2 +-
>  {hw => include/hw}/i2c/bitbang_i2c.h | 2 ++
>  include/hw/i2c/i2c.h                 | 2 --
>  include/hw/i2c/ppc4xx_i2c.h          | 2 +-
>  6 files changed, 5 insertions(+), 6 deletions(-)
>  rename {hw => include/hw}/i2c/bitbang_i2c.h (80%)
> 
> diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
> index 5dfc72d9d7..3cb0509b02 100644
> --- a/hw/i2c/bitbang_i2c.c
> +++ b/hw/i2c/bitbang_i2c.c
> @@ -12,7 +12,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "bitbang_i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index d606d3dbeb..5fb4f86c38 100644
> --- a/hw/i2c/ppc4xx_i2c.c
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -30,7 +30,6 @@
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/ppc4xx_i2c.h"
> -#include "bitbang_i2c.h"
>  
>  #define PPC4xx_I2C_MEM_SIZE 18
>  
> diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
> index e07be9890c..24b6e36b6d 100644
> --- a/hw/i2c/versatile_i2c.c
> +++ b/hw/i2c/versatile_i2c.c
> @@ -23,7 +23,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
> -#include "bitbang_i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  
> diff --git a/hw/i2c/bitbang_i2c.h b/include/hw/i2c/bitbang_i2c.h
> similarity index 80%
> rename from hw/i2c/bitbang_i2c.h
> rename to include/hw/i2c/bitbang_i2c.h
> index 9443021710..3a7126d5de 100644
> --- a/hw/i2c/bitbang_i2c.h
> +++ b/include/hw/i2c/bitbang_i2c.h
> @@ -3,6 +3,8 @@
>  
>  #include "hw/i2c/i2c.h"
>  
> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> +
>  #define BITBANG_I2C_SDA 0
>  #define BITBANG_I2C_SCL 1
>  
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 8e236f7bb4..75c5bd638b 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -81,8 +81,6 @@ uint8_t i2c_recv(I2CBus *bus);
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
>  
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
>  /* lm832x.c */
>  void lm832x_key_event(DeviceState *dev, int key, int state);
>  
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index aa2a2bf9de..8437bf070b 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -28,7 +28,7 @@
>  #define PPC4XX_I2C_H
>  
>  #include "hw/sysbus.h"
> -#include "hw/i2c/i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  
>  #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
>  #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_I2C)
> -- 
> 2.13.7
> 

