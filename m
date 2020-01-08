Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1480C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C5A20643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuxuYoC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C5A20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42573 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9q1-0005k0-In
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ip9pN-0005K6-OW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ip9pL-0005AO-CV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:48:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ip9pL-00059M-1n
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578484122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8rJvRqYVgDvLE05usFP0vbalGdKow6QXQ8rgaZaEZI=;
 b=FuxuYoC0Q7Re9N776EFOZoTf+2yGiXmstmV7BaitQUhI49wWmhCnOduF78H32V6uEhS8Nw
 eOtoAAtiBAhU0tS8u0AMgsgKk7uvbU6VluEo6hOG5XO4A0ov/3rqKglch7F5kXK85m85zL
 Gedj+1DapQSQY6jtbjpiCmxzntGChT0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-A8Rkl1qHPM6kXqWERaBNIw-1; Wed, 08 Jan 2020 06:48:40 -0500
Received: by mail-wm1-f70.google.com with SMTP id t17so329016wmi.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 03:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HFw6zospllBaTm/v3GbfR9rfBj4zYiIh8lVnok+VfMw=;
 b=icVHduP/RyKf8Lr0NqWgpbBUy2Eib6LigbrzsCo/50xCypXY4rt8spZjdxlWh8rbjC
 6c7LZEItLM2n+mXk0IVUNmK4o4FANfWvoJSZqpsdmXWgNUwqEbcQnx4yrTf6enUB9Guk
 VNTTMNsaRapGJUqaU9V41KUEj0hLz3NVTiZjoMEYwQ8/Ak2guG1PWatVEaQ6Bds4n6YZ
 I7U2xG3NFG0cvnLrCEyWHqqEB/oajletcM9SIrqpXLGxygAT+v93oL2a7cBV7AR+9J4T
 BpOwq9TEJDDHKwXS/Kxw9yEVqdZT16E/FkMDEUM9Jab4dMY6zn20DdUN0kWmUQ6USOHB
 dN9g==
X-Gm-Message-State: APjAAAXH2qV3ZiDtf0aslIHzvH/xe9M7SfJqTn7kvaQVdAhc2uUDk/n2
 WSZzWOxn2GpzaAbnQvnZDcDb/YyTlrRCWh3Zr3JCMfBvBe3d2kOI/L8qRvFFCeBGIZDZeCfXh5C
 xgeAi/add1iUmh5E=
X-Received: by 2002:a05:600c:22d1:: with SMTP id
 17mr3541734wmg.23.1578484119638; 
 Wed, 08 Jan 2020 03:48:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqweAYNlWa9dy7mbaGKz1JtCydaHpMQ1icZIY0LrDyOxMloRvanqB5MDWd/BEpJw90ynYpzFlg==
X-Received: by 2002:a05:600c:22d1:: with SMTP id
 17mr3541712wmg.23.1578484119339; 
 Wed, 08 Jan 2020 03:48:39 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b10sm4025878wrt.90.2020.01.08.03.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 03:48:38 -0800 (PST)
Subject: Re: [PATCH v4] display/gtk: get proper refreshrate
To: pavlica.nikola@gmail.com, qemu-devel@nongnu.org
References: <20200108112041.24447-1-pavlica.nikola@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9fb2ea1c-5d51-a0bf-7681-1dbc44a29cda@redhat.com>
Date: Wed, 8 Jan 2020 12:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108112041.24447-1-pavlica.nikola@gmail.com>
Content-Language: en-US
X-MC-Unique: A8Rkl1qHPM6kXqWERaBNIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 12:20 PM, pavlica.nikola@gmail.com wrote:
> From: Nikola Pavlica <pavlica.nikola@gmail.com>

Assuming Gerd can

[cut this ...

>=20
> Hi,
> QEMU mailing list.
>=20
> This is the fourth revision of the patch involving the GTK display
> output getting the proper refresh rate for your particular display
> output.

... until here]

>=20
> Because some VMs in QEMU can get GPU virtualization (using technologies
> such as iGVT-g, as mentioned previously), they could produce a video
> output that had a higher display refresh rate than of what the GTK
> display was displaying. (fxp. Playing a video game inside of a Windows
> VM at 60 Hz, while the output stood locked at 33 Hz because of defaults
> set in include/ui/console.h)
>=20
> Since QEMU does indeed have internal systems for determining frame
> times as defined in ui/console.c.
> The code checks for a variable called update_interval that it later
> uses for time calculation. This variable, however, isn't defined
> anywhere in ui/gtk.c and instead ui/console.c just sets it to
> GUI_REFRESH_INTERVAL_DEFAULT which is 30
>=20
> update_interval represents the number of milliseconds per display
> refresh, and by doing some math we get that 1000/30 =3D 33.33... Hz
>=20
> This creates the mentioned problem and what this patch does is that it
> checks for the display refresh rate reported by GTK itself (we can take
> this as a safe value) and just converts it back to a number of
> milliseconds per display refresh.

[And cut this...

>=20
> Explinations of each revision:
> v1: initial patch
> v2: moved code to a more appropriate place and reduced overhead and
> memory usage (by not creating a new GdkDisplay)
> v3: removed magic value and turned it into something more readable and
> added checks for an error state where GTK was unable to get the refresh
> rate, in which case we use the already existing default
> v4: fixed wrapping and repositioned variable names

... until here]

Then:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
> ---
>   include/ui/gtk.h |  2 ++
>   ui/gtk.c         | 10 ++++++++++
>   2 files changed, 12 insertions(+)
>=20
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index d9eedad976..d1b230848a 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -28,6 +28,8 @@
>   #include "ui/egl-context.h"
>   #endif
>  =20
> +#define MILLISEC_PER_SEC 1000000
> +
>   typedef struct GtkDisplayState GtkDisplayState;
>  =20
>   typedef struct VirtualGfxConsole {
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 692ccc7bbb..eb0efc70ee 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1966,6 +1966,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, =
VirtualConsole *vc,
>                                 GSList *group, GtkWidget *view_menu)
>   {
>       bool zoom_to_fit =3D false;
> +    int refresh_rate_millihz;
> +    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
> +    GdkWindow *win =3D gtk_widget_get_window(s->window);
> +    GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win);
>  =20
>       vc->label =3D qemu_console_get_label(con);
>       vc->s =3D s;
> @@ -2026,6 +2030,12 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, =
VirtualConsole *vc,
>  =20
>       vc->gfx.kbd =3D qkbd_state_init(con);
>       vc->gfx.dcl.con =3D con;
> +
> +    refresh_rate_millihz =3D gdk_monitor_get_refresh_rate(monitor);
> +    if (refresh_rate_millihz) {
> +        vc->gfx.dcl.update_interval =3D MILLISEC_PER_SEC / refresh_rate_=
millihz;
> +    }
> +
>       register_displaychangelistener(&vc->gfx.dcl);
>  =20
>       gd_connect_vc_gfx_signals(vc);
>=20


