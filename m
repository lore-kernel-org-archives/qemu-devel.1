Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609DFC2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 23:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238F9206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 23:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHFHqBk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238F9206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im41f-0008Cb-58
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 18:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1im40b-0007ip-97
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 17:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1im40Y-0000P3-8j
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 17:59:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1im40Y-0000IF-2N
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 17:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577746768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOBSoYSqiWQjBrUtAcV/qem+ibiygU+Pte2uOxw+L1c=;
 b=HHFHqBk4MaqWt07UlBnvgrjXy+Xj4FwxGzOc2Uu3aOsMpjRUE045XYb5wNomEoyyJzmxCl
 YeyTH3mnvfyT6qUQmv+gPKrP9Yjj4BTi8UdRXByEtjE3/PL+DnfBuOkuBmcFkVsWAgSx+H
 vHwyev7hbZcB21L5KB7ZYTRV5ennaxM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-ouVrUqxqPU-QwM1yfk7shA-1; Mon, 30 Dec 2019 17:59:23 -0500
Received: by mail-wr1-f71.google.com with SMTP id k18so17277821wrw.9
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 14:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pOBSoYSqiWQjBrUtAcV/qem+ibiygU+Pte2uOxw+L1c=;
 b=reDZXj9FxKOFDi6AQjNNQtLs/WZ7mUCwYT3nfNi/ALI4Or5oV9RD7MHHmMNuxUrqJ9
 Enr4qM3HnWuoZGtbsPhtAFaolVr+42bwd1FGEZF38LbeQyXUbBv2idgRDANnvxUvMmMM
 ofDNHScP5itpd2fs7/DRErPl7eQjw+LAlBkxIUUV1lZTP9dDezX7aLX7zUBBdt3ALGBH
 f16Ms1kNDMUrgRassrF3w6mze1nmkepkAHoUTZWvO+d5PnReEVtD02ALHSvXY0B4dKhm
 UOgw/qLijRH3ENlvqilFtde7+pn51hdFCK9muKTQ2Toq0QMv2dlzyivlgomCE17jVKJ6
 x9Uw==
X-Gm-Message-State: APjAAAV8ReGgvftYiorPevzmMexEyh8CV2BNpFoDeehvU2Qnzxl8exKZ
 8uERE6ShQiE+YfHHBYcaxl+cFqnPBfRQu4pvjo5rBdT6BxKzLm/yczVYyRQV7Nu4Jm4Bu8dl3m5
 FnWUQjJg625scm+Y=
X-Received: by 2002:a5d:404b:: with SMTP id w11mr71920011wrp.171.1577746762506; 
 Mon, 30 Dec 2019 14:59:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxHoDjfiWd983ESjr+aYkxq5u0glUtsj1zuAb8fDxXS2Cv7mri1y/O7CpCbjwMX4q9BBhhboA==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr71920001wrp.171.1577746762238; 
 Mon, 30 Dec 2019 14:59:22 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id w8sm812099wmm.0.2019.12.30.14.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2019 14:59:21 -0800 (PST)
Subject: Re: [PATCH] display/gtk: get proper refreshrate
To: Nikola Pavlica <pavlica.nikola@gmail.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <8531e41f28df7f4bebe4db257ff95e92f5145afc.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc998ea3-4fbe-8ecb-65f5-0af59ddd0d6f@redhat.com>
Date: Mon, 30 Dec 2019 23:59:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8531e41f28df7f4bebe4db257ff95e92f5145afc.camel@gmail.com>
Content-Language: en-US
X-MC-Unique: ouVrUqxqPU-QwM1yfk7shA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Nikola,

Thanks for your patch!

On 12/30/19 6:28 PM, Nikola Pavlica wrote:
>  From 70c95b18fa056b2dd0ecc202ab517bc775b986da Mon Sep 17 00:00:00 2001
> From: Nikola Pavlica <pavlica.nikola@gmail.com>
> Date: Mon, 30 Dec 2019 18:17:35 +0100
> Subject: [PATCH] display/gtk: get proper refreshrate

Can you describe here the problem you encountered, and how your patch 
fixes it?

> 
> Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
> ---
>   ui/gtk.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 692ccc7bbb..7a041457f2 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2259,6 +2259,11 @@ static void gtk_display_init(DisplayState *ds,
> DisplayOptions *opts)
>           opts->u.gtk.grab_on_hover) {
>           gtk_menu_item_activate(GTK_MENU_ITEM(s->grab_on_hover_item));
>       }
> +
> +    GdkDisplay *display = gdk_display_get_default();

Can we use window_display declared earlier instead?

     window_display = gtk_widget_get_display(s->window);

If you look at the CODING_STYLE.rst file referenced here:
https://wiki.qemu.org/Contribute/SubmitAPatch#Use_the_QEMU_coding_style
It states:

   Declarations
   ============

   Mixed declarations (interleaving statements and declarations
   within blocks) are generally not allowed; declarations should
   be at the beginning of blocks.

So you should move the declaration of both display/monitor variables 
earlier, around line 2192.

> +    GdkMonitor *monitor = gdk_display_get_primary_monitor(display);
> +    vc->gfx.dcl.update_interval = 1000000 /
> +        gdk_monitor_get_refresh_rate(monitor);

Now looking at this line, I think this should be done in the 
gd_vc_gfx_init() function (line 2029, before the 
register_displaychangelistener() call).

>   }
>   
>   static void early_gtk_display_init(DisplayOptions *opts)
> 

As suggested on IRC, your patch have more chances to get reviewed if you 
Cc its maintainers. See this help here:
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer

In this case we get:

$ ./scripts/get_maintainer.pl -f ui/gtk.c
Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
qemu-devel@nongnu.org (open list:All patches CC here)

I'm Cc'ing Gerd for you.

Regards,

Phil.


