Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02D7C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA318206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdgkc4E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA318206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCk1-0003r5-RK
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipCjP-0003Nk-Dv
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipCjN-0004c6-Te
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:54:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59182
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipCjN-0004bd-QE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578495284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKMFwHwcp3S4teaTvF5S1W76ib2em1IlING8Bv+AlrE=;
 b=Wdgkc4E4qzCicQ1dFfIc2ipUpu2Z7K76nQWYvvvas1lEkj6QxAmI1ckugRZki0iOxMZf7e
 L/0wFOAjPVJku/PkCAcW/vx86vZpS8DEDl2pq4BEhNS6cNm+qUy/LBhN4hGfswlY09RqUw
 0NL5Gm6L9cBStmSm/g4BW8s5S5B7zzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-auEnwYjkN_CoQEWB2yvevQ-1; Wed, 08 Jan 2020 09:54:43 -0500
Received: by mail-wm1-f69.google.com with SMTP id t17so456584wmi.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 06:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IRnOR3h18LwvqVjiwUt+1p8pdr8Nc3iMzfbu1+teEjs=;
 b=QN/HqMb3dJhFEpaRFGKyu5iqnmeJ0noT68iJsNWagTioxpY9jK/jQzCZZtoJBhHmo9
 IyMPEWT3z6I7wtoZg/LnYy/+tkK8rG2HiLsnv+cDWxHX2ugMBWs4fMp1Slp3vv7YVlJd
 p1H51zorZk1JhHD7Ez8LYfRQ1m/3x8A8zjBolQ6KoVaf2FQ8MLzPsoSu0KXudUBJBWsm
 jQet7grV0EhzuCtcsjqcFCAH3C+9yzDYfy10AWGQtWt3/H+Kl5NyQCLQq+TGvyvjGdtN
 R1vibmWHT4IrfbNAMUdU7GJ0Z5IoJUsfQBQaQpDw4szHbSTnMO+2Xkehqd5zVTCsD6fn
 yM5A==
X-Gm-Message-State: APjAAAWHSOIHzDmO7d0pkGgYVE3QpE+YraPMvf+46emDfmxTK8B3yUQ3
 R/gEvIx52jtz0R9qk73JBdeQgm7N4CAufhttL1IBhvPQDbkqCG8N1ReehzLFWpetfhsv5UwbGtP
 nwW0dkgdVPihvNek=
X-Received: by 2002:a05:600c:298:: with SMTP id
 24mr4140833wmk.141.1578495282218; 
 Wed, 08 Jan 2020 06:54:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzginRqJtnaAwNtacobE8QKSjLjbkXihLohXcZs6kaSqMFSIsY2r9Ip4WJyW35gj9PYiZZfLQ==
X-Received: by 2002:a05:600c:298:: with SMTP id
 24mr4140817wmk.141.1578495282025; 
 Wed, 08 Jan 2020 06:54:42 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u22sm4462709wru.30.2020.01.08.06.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:54:41 -0800 (PST)
Subject: Re: [PATCH v5] display/gtk: get proper refreshrate
To: pavlica.nikola@gmail.com, qemu-devel@nongnu.org
References: <20200108121342.29597-1-pavlica.nikola@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <34341431-40ea-6bab-e93d-5be15c7aa5da@redhat.com>
Date: Wed, 8 Jan 2020 15:54:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108121342.29597-1-pavlica.nikola@gmail.com>
Content-Language: en-US
X-MC-Unique: auEnwYjkN_CoQEWB2yvevQ-1
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

On 1/8/20 1:13 PM, pavlica.nikola@gmail.com wrote:
> From: Nikola Pavlica <pavlica.nikola@gmail.com>
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
>=20
> Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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


