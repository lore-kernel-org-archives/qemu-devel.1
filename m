Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A45C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E16020726
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHFZW5vA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E16020726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Pq3-00047b-Nt
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1j3PpA-0003DB-7Z
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1j3Pp8-0004yW-Sn
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:28 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1j3Pp8-0004wP-Ln
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:43:26 -0500
Received: by mail-ot1-x344.google.com with SMTP id j20so14086489otq.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 11:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=h9vhnO7seO983m/TDf+R0RkOa78hQ+qnMAUNnSLDHhQ=;
 b=eHFZW5vAcMZRIwXFGL13CG2+A3ljL3fkL27f2bZftIeEv2rHLkNrIqLrZiSH3c6m1n
 5h4hBd2eLVrsNwDSdZPQPOxDr+9z+o9+dyehpq6RO6njJwk295MlC3EaG8n3DfulC76q
 ngtWpen8vqyWt4HVkS8WLdLpuqCiC8O/bfQxF6tVuh5BB6Q9GxnPIGrngQpmm7Nl96sy
 +hfST52tQpzpEjE9XcWSmDgSDF5RwSKD19Vh+Zea7bBsB7WDzTLim42erbZw2pU9D6Rj
 hQnr25ExsdZ47A7eyA+SuAYZ2Um3ul0LAl2q1NVaImehJd3PczgKsH79Ib2c7IfwcSq5
 gwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=h9vhnO7seO983m/TDf+R0RkOa78hQ+qnMAUNnSLDHhQ=;
 b=jfstRLP0etN73h9dz11NRCGWbzGhstx3TT2fFqfuj1GiZ/+qdhds1SCZtstCHniufl
 D7I60xoGlCwYyJvOepOpRRRAY7BEzz9P94Bo3Ovf9GOHiab9uRL2DHXwlIMeAr4jmaty
 rH4Rk7/8EyQAT5xvi/boePOwlrC7D8BGEGhdHK+006+DS8P6Iy0pMm0Po20WNORTFJWM
 Bhh54AG8M8XkdQlBgdUPdMOphDI+miK62M+0F+NkTy+ErljARZEB+wdOza/Kz7TkTzHS
 4ZQFohOaUw+bj715m/PZ3OLbDD8ASJdyEWxNfjsUB3CU0/wbbLSibB9pf8PDA3+vJoNk
 W8Gg==
X-Gm-Message-State: APjAAAU0MKBK0Uzqr/Xg9eLtgXT7cuIpYCqNS9Ty2XvGneCnKsb7xNrR
 FWSu9VT6LNevFIQm/n/slA==
X-Google-Smtp-Source: APXvYqxq6RZOGF6Bf9+kU5B5ROSZ+6j8OTxpcOYDTYpbs3WAeY+ZN0RE4FspPHFy2YR13pkYm6gxng==
X-Received: by 2002:a05:6830:15c2:: with SMTP id
 j2mr9238538otr.351.1581882205146; 
 Sun, 16 Feb 2020 11:43:25 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id p24sm4482429otq.64.2020.02.16.11.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 11:43:24 -0800 (PST)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:f9a2:1f89:3451:7a63])
 by serve.minyard.net (Postfix) with ESMTPSA id 9A04E18016D;
 Sun, 16 Feb 2020 19:43:23 +0000 (UTC)
Date: Sun, 16 Feb 2020 13:43:22 -0600
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
Message-ID: <20200216194322.GA3704@minyard.net>
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200215154706.19837-2-philmd@redhat.com>
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
Reply-To: minyard@acm.org
Cc: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 15, 2020 at 04:47:05PM +0100, Philippe Mathieu-Daudé wrote:
> In commit f3a508eb4e the Euler Robot reported calling timer_new()
> in instance_init() can leak heap memory. The easier fix is to
> delay the timer creation at instance realize(). Similarly move
> timer_del() into a new instance unrealize() method.
> 
> This case was found with the following coccinelle script:
> 
>     @ match @
>     identifier instance_init;
>     typedef Object;
>     identifier obj;
>     expression val, scale;
>     identifier clock_type, callback, opaque;
>     position pos;
>     @@
>     static void instance_init(Object *obj)
>     {
>       <...
>     (
>       val = timer_new@pos(clock_type, scale, callback, opaque);
>     |
>       val = timer_new_ns@pos(clock_type, callback, opaque);
>     |
>       val = timer_new_us@pos(clock_type, callback, opaque);
>     |
>       val = timer_new_ms@pos(clock_type, callback, opaque);
>     )
>       ...>
>     }
> 
>     @ script:python @
>     f << match.instance_init;
>     p << match.pos;
>     @@
>     print "check %s:%s:%s in %s()" % (p[0].file, p[0].line, p[0].column, f)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

This looks ok to me:

Acked-by: Corey Minyard <cminyard@mvista.com>

I can take it into my tree, if you like.

-corey

> ---
> Cc: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/ipmi/ipmi_bmc_extern.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index f9a13e0a44..9144ac6c38 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -463,6 +463,15 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
>  
>      qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
>                               chr_event, NULL, ibe, NULL, true);
> +
> +    ibe->extern_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout, ibe);
> +}
> +
> +static void ipmi_bmc_extern_unrealize(DeviceState *dev, Error **errp)
> +{
> +    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
> +
> +    timer_del(ibe->extern_timer);
>  }
>  
>  static int ipmi_bmc_extern_post_migrate(void *opaque, int version_id)
> @@ -502,7 +511,6 @@ static void ipmi_bmc_extern_init(Object *obj)
>  {
>      IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(obj);
>  
> -    ibe->extern_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout, ibe);
>      vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
>  }
>  
> @@ -510,7 +518,6 @@ static void ipmi_bmc_extern_finalize(Object *obj)
>  {
>      IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(obj);
>  
> -    timer_del(ibe->extern_timer);
>      timer_free(ibe->extern_timer);
>  }
>  
> @@ -528,6 +535,7 @@ static void ipmi_bmc_extern_class_init(ObjectClass *oc, void *data)
>      bk->handle_reset = ipmi_bmc_extern_handle_reset;
>      dc->hotpluggable = false;
>      dc->realize = ipmi_bmc_extern_realize;
> +    dc->unrealize = ipmi_bmc_extern_unrealize;
>      device_class_set_props(dc, ipmi_bmc_extern_properties);
>  }
>  
> -- 
> 2.21.1
> 

