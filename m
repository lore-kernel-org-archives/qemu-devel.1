Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8A8C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5319B205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIrTP2Zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5319B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imI9k-0000Lv-21
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 09:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imHt4-000417-Ap
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imHt2-000892-Mp
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:48:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imHt2-00083s-Gr
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577800119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4mkWOUZKanlkIdelBw/jDAOox7si7fwieDC0lyjC24=;
 b=BIrTP2ZbqlvoOP59OdqnYGW3jWH1Robk1Frk2YST0zADjlF7HGoGchbY3LPmK4n5mzFtqq
 9pcy5EIK62VkxLgrHUzB0E7mhNfV7JydtmBNu5acSzecj4nEQ72D1VHtUYooOrGccZZ3RX
 vv6e0Rku8RokkfxVXevjZrNQvCIzvB0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-qzfghV82OjmfbHiHVcFahA-1; Tue, 31 Dec 2019 08:48:36 -0500
Received: by mail-wr1-f72.google.com with SMTP id z15so1261381wrw.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 05:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YFV7K0yOooebkHlsnA6IPMrvAkv/VpytN4JCDQiyRMY=;
 b=lLAK6cCLpBFdz9gH3+f515IXCwmmGtQlRAS6TrgkR+gV0WUTBW6pOxhMLeAk2r2o0h
 y1PWmS42HpR4bvvYiy9v7Q017i0UnCTGvEouDA+RQTuZhGi06OztdxdvzAea0EZ81VJ0
 pbm4HaDiei67Ay36vSJeFUWNFwW1RZJiHYpaMckGZ5SAdMYoJHbTpEOwYMdPXQiMu7Zb
 rWOQxkfcKKFOBYzd9qr6AVD1x7MPgWCOqebx0755CRdFeI4bwqP4S+LSJVIlFZU1iJZM
 fVsCcG+gu18wP4ggvUjoWZjAkxvua98Dr3TKNiec+D6aPHwmvDusm+0yJk5XFe4GcvtI
 0otw==
X-Gm-Message-State: APjAAAXhf6i50pzLjZfIwY2V9G5dKwEh50ibsLO2jPVdXSXUuNZyiznO
 WhixzfteO4P9rNhgQepPVU+uYo+eHNJidKFBUaJDUfAsTaX6rNA58yDTacU6oI3ekHmTa3DtOgX
 ApUdar4+I3+GoVfk=
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr4488218wml.50.1577800115481; 
 Tue, 31 Dec 2019 05:48:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqwr9mlgM8FyAjF/KwAu41kAR7VQ7cYrg68yx5M9Yt3YS3MCoRqBaZD8oYxfxZtEpiY4nWog==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr4488201wml.50.1577800115263; 
 Tue, 31 Dec 2019 05:48:35 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-140-248.w86-222.abo.wanadoo.fr.
 [86.222.91.248])
 by smtp.gmail.com with ESMTPSA id p18sm2638410wmg.4.2019.12.31.05.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 05:48:34 -0800 (PST)
Subject: Re: [PATCH] display/gtk: get proper refreshrate
To: Nikola Pavlica <pavlica.nikola@gmail.com>
References: <8531e41f28df7f4bebe4db257ff95e92f5145afc.camel@gmail.com>
 <dc998ea3-4fbe-8ecb-65f5-0af59ddd0d6f@redhat.com>
 <2ee36cb0103b60a4a0655a4c127469e6f49f8d46.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d54f2c09-4636-2c65-6aa9-6a7b62066702@redhat.com>
Date: Tue, 31 Dec 2019 14:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2ee36cb0103b60a4a0655a4c127469e6f49f8d46.camel@gmail.com>
Content-Language: en-US
X-MC-Unique: qzfghV82OjmfbHiHVcFahA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: kraxel@redhat.com, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Nikola,

Cc'ing the qemu-devel list.

On 12/31/19 1:38 AM, Nikola Pavlica wrote:
> On Mon, 2019-12-30 at 23:59 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Nikola,
>>
>> Thanks for your patch!
>>
>> On 12/30/19 6:28 PM, Nikola Pavlica wrote:
>>>   From 70c95b18fa056b2dd0ecc202ab517bc775b986da Mon Sep 17 00:00:00
>>> 2001
>>> From: Nikola Pavlica <pavlica.nikola@gmail.com>
>>> Date: Mon, 30 Dec 2019 18:17:35 +0100
>>> Subject: [PATCH] display/gtk: get proper refreshrate
>>
>> Can you describe here the problem you encountered, and how your
>> patch
>> fixes it?
>>
>>> Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
>>> ---
>>>    ui/gtk.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/ui/gtk.c b/ui/gtk.c
>>> index 692ccc7bbb..7a041457f2 100644
>>> --- a/ui/gtk.c
>>> +++ b/ui/gtk.c
>>> @@ -2259,6 +2259,11 @@ static void gtk_display_init(DisplayState
>>> *ds,
>>> DisplayOptions *opts)
>>>            opts->u.gtk.grab_on_hover) {
>>>            gtk_menu_item_activate(GTK_MENU_ITEM(s-
>>>> grab_on_hover_item));
>>>        }
>>> +
>>> +    GdkDisplay *display =3D gdk_display_get_default();
>>
>> Can we use window_display declared earlier instead?
>>
>>       window_display =3D gtk_widget_get_display(s->window);
>>
>> If you look at the CODING_STYLE.rst file referenced here:
>> https://wiki.qemu.org/Contribute/SubmitAPatch#Use_the_QEMU_coding_style
>> It states:
>>
>>     Declarations
>>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>     Mixed declarations (interleaving statements and declarations
>>     within blocks) are generally not allowed; declarations should
>>     be at the beginning of blocks.
>>
>> So you should move the declaration of both display/monitor variables
>> earlier, around line 2192.
>>
>>> +    GdkMonitor *monitor =3D
>>> gdk_display_get_primary_monitor(display);
>>> +    vc->gfx.dcl.update_interval =3D 1000000 /
>>> +        gdk_monitor_get_refresh_rate(monitor);
>>
>> Now looking at this line, I think this should be done in the
>> gd_vc_gfx_init() function (line 2029, before the
>> register_displaychangelistener() call).
>>
>>>    }
>>>   =20
>>>    static void early_gtk_display_init(DisplayOptions *opts)
>>>
>>
>> As suggested on IRC, your patch have more chances to get reviewed if
>> you
>> Cc its maintainers. See this help here:
>> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
>>
>> In this case we get:
>>
>> $ ./scripts/get_maintainer.pl -f ui/gtk.c
>> Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
>> qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> I'm Cc'ing Gerd for you.
>>
>> Regards,
>>
>> Phil.
>>

This patch is hard to review because it follows another patch...
See:=20
https://wiki.qemu.org/Contribute/SubmitAPatch#Do_not_send_as_an_attachment

This is v2, next time post a v3 as a new thread please.

>  From f4934509ac2da1bbb747422990587433ecc44a0b Mon Sep 17 00:00:00 2001
> From: Nikola Pavlica <pavlica.nikola@gmail.com>
> Date: Tue, 31 Dec 2019 01:12:42 +0100
> Subject: [PATCH v2] display/gtk: get proper refreshrate

<here goes the description of problem and fix>

> Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
> ---
>   ui/gtk.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 692ccc7bbb..2055dcc03d 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1967,6 +1967,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState
> *s, VirtualConsole *vc,
>   {
>       bool zoom_to_fit =3D false;
>  =20
> +    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
> +    GdkWindow *win =3D gtk_widget_get_window(s->window);
> +    GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
> +
>       vc->label =3D qemu_console_get_label(con);
>       vc->s =3D s;
>       vc->gfx.scale_x =3D 1.0;
> @@ -2026,6 +2030,8 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s,
> VirtualConsole *vc,
>  =20
>       vc->gfx.kbd =3D qkbd_state_init(con);
>       vc->gfx.dcl.con =3D con;
> +    vc->gfx.dcl.update_interval =3D 1000000 /
> +        gdk_monitor_get_refresh_rate(monitor);

 From the documentation of gdk_monitor_get_refresh_rate():

   The value is in milli-Hertz, so a refresh rate of 60Hz is
   returned as 60000.

   Returns

     the refresh rate in milli-Hertz, or 0

Watch out we don't want to crash on division by zero. Maybe we don't=20
want to set the update_interval if the refresh rate is null.

Also, I'd try to avoid the magic value and define something more obvious=20
to review, such:

   #define MSEC_PER_MILLIHZ 1000000

   ...

   int refresh_rate_millihz;

   ...

   refresh_rate_millihz =3D gdk_monitor_get_refresh_rate()
   if (refresh_rate_millihz) {
       vc->gfx.dcl.update_interval =3D MSEC_PER_MILLIHZ /=20
refresh_rate_millihz;
   }

>       register_displaychangelistener(&vc->gfx.dcl);
>  =20
>       gd_connect_vc_gfx_signals(vc);
>=20


