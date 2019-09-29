Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F6C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 07:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262B420863
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 07:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7V7dNkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262B420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iETLJ-0004Xe-7O
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 03:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iETKL-0003md-6K
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 03:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iETKJ-0001JY-Mt
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 03:09:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iETKJ-0001Hk-Ds; Sun, 29 Sep 2019 03:09:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id o18so7417064wrv.13;
 Sun, 29 Sep 2019 00:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=s7i94r9jVLYBrEfAacu+dnXrhslHQJNgnVnCHgloqlU=;
 b=p7V7dNkK2XirgogQ4/lWeB7DtNNo03EOn6mp5ubYguMUhoEjnEiNBRnZEl78/apJSg
 DAalM/fJ1Ouuc6sPNr0gorx8vXQoc5KK1cG7CsgHLTa2vnTXsEAu/ahfzyhmX7WoqajH
 o97yv3umuuUCrIgCczNeyfj/7aKs39u0FFDtc9hlMUsJcQcintmJhpwYU1LkI9gGm1zu
 qutolXKlqpxROrMjKGDlYz07+z093Tj/12BghgzacKDavy8xwEqD1sO24Qi5CKNTGOeQ
 1otcUmGocjMdmYHDWDXteJdNQ5Pmgj/qM1O8VLLhlnRvPv4foITuctePb5TrtxBt6VJv
 Vz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=s7i94r9jVLYBrEfAacu+dnXrhslHQJNgnVnCHgloqlU=;
 b=fI+7/pFrbqpBUqdyPhUR26aJ9oDYV6dfZSzJecpjACIBP8EBGAVKIGEG+tGC1mCu1Z
 +SWWvPKYAzNuFuZ3w5WKLhyU8gZhxPltpGxLm5Ueei9zm6GXrik3X4nS5oylbRVjxB2i
 CZJNydjkaoRQZBa6mRRQPLTLt+kpRx821+23pLmEPTd9wDHQqNEH/rWHDJlOP8NddAfW
 bwBRDF1MpaHl9FBrS8Xd7ltxLl22rHeIUABRLu01A9p4JVXRhPtLU7qxZ7jcxBQVByp4
 eGDez9Kt1pZ0Owbw9fecKxqTqojdV4wOalbEHD37EB3v5PzBaERUqAM6sXYCaevihGHA
 jjtQ==
X-Gm-Message-State: APjAAAVCy37vo5DPe9u7NBqFkvv/q2aU4do0ZhWZuXS8cuB6r/M/b1H7
 ZxIuQ7hZdg7uhkU6AZWaaGE=
X-Google-Smtp-Source: APXvYqw1XyUr26W8WNOnPvHbdrkX9/h8Jd78XgAWbq4BnB3l82uD+d8wdyrPlHNH/05eHiboUuQl3w==
X-Received: by 2002:adf:de08:: with SMTP id b8mr8636502wrm.200.1569740942163; 
 Sun, 29 Sep 2019 00:09:02 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:b200:7a70:bbc8:8101:45be?
 ([2a01:c22:b04f:b200:7a70:bbc8:8101:45be])
 by smtp.gmail.com with ESMTPSA id n22sm10005278wmk.19.2019.09.29.00.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2019 00:09:01 -0700 (PDT)
Message-ID: <d8f7c131cad2590ff2faf48076df510705090f54.camel@gmail.com>
Subject: Re: [PATCH 05/14] hw/arm/bcm2835_peripherals: Name various address
 spaces
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Baumann
 <Andrew.Baumann@microsoft.com>,  qemu-devel@nongnu.org, Pekka Enberg
 <penberg@iki.fi>,  =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>
Date: Sun, 29 Sep 2019 09:08:51 +0200
In-Reply-To: <20190904171315.8354-6-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-6-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mié, 04-09-2019 a las 19:13 +0200, Philippe Mathieu-Daudé escribió:
> Various address spaces from the BCM2835 are reported as
> 'anonymous' in memory tree:
> 
>   (qemu) info mtree
> 
>   address-space: anonymous
>     0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
>       0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
>       0000000000000080-000000000000008f (prio 0, i/o): bcm2835-
> property
> 
>   address-space: anonymous
>     0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
>       0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-
> peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
> 
>   [...]
> 
> Since the address_space_init() function takes a 'name' argument,
> set it to correctly describe each address space:
> 
>   (qemu) info mtree
> 
>   address-space: bcm2835-mbox-memory
>     0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
>       0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
>       0000000000000080-000000000000008f (prio 0, i/o): bcm2835-
> property
> 
>   address-space: bcm2835-fb-memory
>     0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
>       0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-
> peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
> 
>   address-space: bcm2835-property-memory
>     0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
>       0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-
> peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
> 
>   address-space: bcm2835-dma-memory
>     0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
>       0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-
> peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
>       00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-
> gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/display/bcm2835_fb.c    | 2 +-
>  hw/dma/bcm2835_dma.c       | 2 +-
>  hw/misc/bcm2835_mbox.c     | 2 +-
>  hw/misc/bcm2835_property.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
> index 8f856878cd..85aaa54330 100644
> --- a/hw/display/bcm2835_fb.c
> +++ b/hw/display/bcm2835_fb.c
> @@ -425,7 +425,7 @@ static void bcm2835_fb_realize(DeviceState *dev,
> Error **errp)
>      s->initial_config.base = s->vcram_base + BCM2835_FB_OFFSET;
>  
>      s->dma_mr = MEMORY_REGION(obj);
> -    address_space_init(&s->dma_as, s->dma_mr, NULL);
> +    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_FB "-
> memory");
>  
>      bcm2835_fb_reset(dev);
>  
> diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
> index 6acc2b644e..1e458d7fba 100644
> --- a/hw/dma/bcm2835_dma.c
> +++ b/hw/dma/bcm2835_dma.c
> @@ -383,7 +383,7 @@ static void bcm2835_dma_realize(DeviceState *dev,
> Error **errp)
>      }
>  
>      s->dma_mr = MEMORY_REGION(obj);
> -    address_space_init(&s->dma_as, s->dma_mr, NULL);
> +    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_DMA "-
> memory");
>  
>      bcm2835_dma_reset(dev);
>  }
> diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
> index 7690b9afaf..77285624c9 100644
> --- a/hw/misc/bcm2835_mbox.c
> +++ b/hw/misc/bcm2835_mbox.c
> @@ -311,7 +311,7 @@ static void bcm2835_mbox_realize(DeviceState
> *dev, Error **errp)
>      }
>  
>      s->mbox_mr = MEMORY_REGION(obj);
> -    address_space_init(&s->mbox_as, s->mbox_mr, NULL);
> +    address_space_init(&s->mbox_as, s->mbox_mr, TYPE_BCM2835_MBOX "-
> memory");
>      bcm2835_mbox_reset(dev);
>  }
>  
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index ab66d3572e..3dff5a7157 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -417,7 +417,7 @@ static void bcm2835_property_realize(DeviceState
> *dev, Error **errp)
>      }
>  
>      s->dma_mr = MEMORY_REGION(obj);
> -    address_space_init(&s->dma_as, s->dma_mr, NULL);
> +    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_PROPERTY
> "-memory");
>  
>      /* TODO: connect to MAC address of USB NIC device, once we
> emulate it */
>      qemu_macaddr_default_if_unset(&s->macaddr);

Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>



