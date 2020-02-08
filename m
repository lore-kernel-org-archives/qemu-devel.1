Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B921C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 15:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E7521741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IBOhoDUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E7521741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Rx9-0000zF-Tg
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 10:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@web.de>) id 1j0Ru4-0006sc-44
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 10:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1j0Ru2-0008LL-Rs
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 10:20:16 -0500
Received: from mout.web.de ([212.227.17.12]:45417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1j0Ru2-0008HZ-FA
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 10:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581175207;
 bh=K7cubIuVIWT/r4V9g3Ve6xIrAVEUAjGQe9YQgMAxbTg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IBOhoDUYJSr5DusjfAdPTcKuYnYk3bFgJwMEX4rzaGI+1swo6P7leQ1f9WS34mgTm
 PuGbm49b4O7KQ09NPLbUfkOqDQAE+ZHxITGTfQJ96iogb/enUowyWTl9uHcUOYyaRB
 gbfymafO7/48xykMf7AQfP3/3gp8Tr2aOfSy/0xQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8bi-1j7ZRp2iBS-00S61R; Sat, 08
 Feb 2020 16:20:07 +0100
Subject: Re: [PATCH] ui/gtk: Fix gd_refresh_rate_millihz() when using
 VirtualConsole
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200208143008.6157-1-f4bug@amsat.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <82618b0f-22ff-7282-c1bf-09d801166b7c@web.de>
Date: Sat, 8 Feb 2020 16:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200208143008.6157-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gweKZB+gowtUT2SB3RQ4CWlR5+7LwJasaeAorIXD9zzDV8nbiwz
 zlczQiNyaxNvKHi22OWoPRSFW66ndZaxWtbwXpF8TNDDn87B/pNdNJNDb8ljlVS0+eRXrVa
 5VC5Xutfn94VfB02SVPwGwFEFrDJxjOGuKcTpXgiw+V3FEnPkCddkllvQfXb38wgcml44wD
 EgmeNjUJCB8jXycRdUBcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zxxpZUd1Mv0=:YsT3uCP1uEhVIZBz7wkcsA
 mW66e5U7yiElTDpOjmMe7vS2zw98c30hzNjtr+WFZ3QluldDrF2hF8i8i+NvUCBOOkuhIdGo4
 BZ+LYOrs/hEu9VwAUJ/fb1yiqLPDlc/aLCB4USGsM77QXmcYH38ZKVkeqwrbVfvF0Yl6Unvfm
 qpbDEehqdus7Nb9sMqL5hbXgfTeYZL+B8mQ3U3f2QCI2JioKP3x6Rr3/6zSEY4dMqqRv9U9Ii
 Xn5bzRgN9M2qqmqRBvAkHu6jVtjXq0k6zdt2Rhk2fiUdzy2rE9cp01WNNFG2MlVj1CssOtnhc
 6kLAmpMcY7uw7WTqYDx+sYoMOyJEcI0+hGwdwNCRLhCNFSZKH4xJ3ui6wXQBhmnJRhgmLc7xj
 snLXOCAbsoXdO4+pqlBfy05rZ2uuLQokEEXFo/x+iVlRpVt9s9bXZLIpB3k67BslWzeBmkTFP
 voVEleP2BD5MbQE+IGhas4Yv/U9k6eabkTh2CuPLxvmPF25V6hrUswsk/hGp7uQVxxIaLpqJc
 2PPmeC9yWbNxKlwW0fVVzZy0Eb+wvYFoPap+GegVxh2ppIIAijGjeSp1SaT07KVAOVmT18c0K
 8Kr2ZGnoeZKJn1XlU7rWFLx6INyVyBzd/ibhE8PPnf91HNX8YNAKoFo9/Jm88PfTcnUfkTRrE
 oV2jZQUAHHb+uK3MutSqcooP+MGafkHQI7dMk/ne4I63kuIY0E4yN2WbpIMJEkbkXHqbDRolP
 wgsUQcNQlXa3rA3xqm7PlCANlJ+CPpbU2GM16wGosLqBdvv+xfmgNVvJqp9HMEFEg51+axbeU
 9DinaNsrMhgNuwyCOC9uuEJXd4oxOcFGkX8yIUy0p0kaFTacKArfsT+klvrRsBMr4rtyZyhh5
 4Y2FUvNF7lOqCHDadi+6yBiEMOZUex9beYjIvOfHFo+syzmmvNHi8eVCet+GZx0EUVyEy4gHj
 i38jTKL/FoGzGZL8CgBGNnrTZyBNw+ALCJztse2eiQqaepNmpkM554QHNMPuz6ih1nfUmxUik
 hp2aUt6+SyLBkzt+WgkADYpNn9R9oJ7N+LbRhow/fNGMvXOzr9D5hr7OdOYP9wNZZAEzexDh+
 kZRQVw8UX1n/xZgFbyale2Awbruwhv2Q9czSP5TfZg+hPa7U7vn5jdfyJ9z3SjBDuOuUlFpcR
 3mmFslB4dSL2aA7Sd3p2K5OfnkqOYR2uDd2hjAytdatWZ78ZDgzWXm7B6SzOCqZBk51Z1ETze
 eMYTjHt1s8MFlUc0x
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.02.20 15:30, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix using virtual console under gtk 3.22.30 (mate 1.20.1):
>
>    qemu-system-x86_64: Gdk: gdk_window_get_origin: assertion 'GDK_IS_WIN=
DOW (window)' failed
>
> Fixes: c4c00922cc and 28b58f19d2 (display/gtk: get proper refreshrate)
> Reported-by: Jan Kiszka <jan.kiszka@web.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Cc: Nikola Pavlica <pavlica.nikola@gmail.com>
> Report:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg678130.html
> ---
>   ui/gtk.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index d18892d1de..c59297ff4d 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1965,11 +1965,11 @@ static GtkWidget *gd_create_menu_machine(GtkDisp=
layState *s)
>    * If available, return the refresh rate of the display in milli-Hertz=
,
>    * else return 0.
>    */
> -static int gd_refresh_rate_millihz(GtkDisplayState *s)
> +static int gd_refresh_rate_millihz(GtkWidget *window)
>   {
>   #ifdef GDK_VERSION_3_22
> -    GdkDisplay *dpy =3D gtk_widget_get_display(s->window);
> -    GdkWindow *win =3D gtk_widget_get_window(s->window);
> +    GdkDisplay *dpy =3D gtk_widget_get_display(window);
> +    GdkWindow *win =3D gtk_widget_get_window(window);
>       GdkMonitor *monitor =3D gdk_display_get_monitor_at_window(dpy, win=
);

Nope, no change. It's triggered right from ui/gtk.c:1973, the line above.

>
>       return gdk_monitor_get_refresh_rate(monitor);
> @@ -2045,7 +2045,8 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, =
VirtualConsole *vc,
>       vc->gfx.kbd =3D qkbd_state_init(con);
>       vc->gfx.dcl.con =3D con;
>
> -    refresh_rate_millihz =3D gd_refresh_rate_millihz(s);
> +    refresh_rate_millihz =3D gd_refresh_rate_millihz(vc->window ?
> +                                                   vc->window : s->wind=
ow);
>       if (refresh_rate_millihz) {
>           vc->gfx.dcl.update_interval =3D MILLISEC_PER_SEC / refresh_rat=
e_millihz;
>       }
>

Jan

