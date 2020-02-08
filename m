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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FCDC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 15:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EBB21741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 15:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OmfubS+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EBB21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0S24-0002vw-Dk
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 10:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@web.de>) id 1j0Rw9-0000vQ-ML
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 10:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1j0Rw8-000440-Fb
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 10:22:25 -0500
Received: from mout.web.de ([212.227.17.12]:58443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1j0Rw8-00043I-6z
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 10:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581175339;
 bh=6Upss95K2ZeGsmrFSRCHbGrXW/vVcHwxuwXbREHuvxk=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=OmfubS+xSKxToUQgvZeMUx/tcBwzq4UtPAN1egJG2IQVEm2hlxEJERKrW30rmhKms
 8Pm2IxLNUd44uoLozAOnRMTLU9yGUf/3vbFiFPcuVdu25oYPybXaYmi1X1b1OR7euO
 tPsveEF3EYesOZjrYcoJbEvXTO2SsZaB/wVdYLJI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LeLSr-1jJJkF3y3h-00qB2u; Sat, 08
 Feb 2020 16:22:19 +0100
Subject: Re: [PATCH] ui/gtk: Fix gd_refresh_rate_millihz() when using
 VirtualConsole
From: Jan Kiszka <jan.kiszka@web.de>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200208143008.6157-1-f4bug@amsat.org>
 <82618b0f-22ff-7282-c1bf-09d801166b7c@web.de>
Message-ID: <02c1d1cc-0ab7-c835-7d32-0bf876eeacc5@web.de>
Date: Sat, 8 Feb 2020 16:22:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <82618b0f-22ff-7282-c1bf-09d801166b7c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4htsD1T/oFvl361ANW4gI5I3/hMbP1Y+sV01vWd8XcTnrh89WU
 BCp15+3PI5qEh2WDivOBfXbk0hfDN4qi/pvkJvT3BQ2kgFd2j3I6DkZWj1snFOQeOZNSeL6
 iXS1WeNMf6hSr6NXBdRHW2slM0Q4HygfcfYFaadC3smsFaPYXRkcH8KVPZuqZIxaNrfDdLY
 mX9JbBoHUW8yRcTf2+cIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y0BvEa3+HJ8=:LQN9nQeGiOKRWVdGlL/fr2
 dXlKJO/oNj0wf1lVK7PI5MkSNMG899S2A0gevTMSew5n7Y3+OQCzO5o3VsKqalJK5+toI+vMn
 kVqjE2oHHezLf2//6HRXHcr1/ugnquV7MNfXkMp+YVkv9se98Z5kAt0w4sPUkuO7KcovNnCiQ
 ToiPgQoap4VG1Sjz+2zK1s0GE5oo6AxgUFE2f3+g6Qbze3m6I5RX57YzCbL0llfoVEv53KXQG
 f3oOO40n+kcVhn+qWSuldtdaoNh3qcwH+UDw91iVDs2+Yb23xXZjjNgrTPorJRCq/f1fMpLYs
 uBi4qyaPviaSjbS/gUDwc/hkkF4cs+7RoD7JwvqQsphanuITQ989A4RmoMYZ3k+Tqb8M0f22c
 yomLXPQGXaZxNGlKpYqf7ThwUMaEgQdQgxMqmM79LNe3H17gLa1wN3QrFqBwKAvKCUYbb1a2P
 NujMHbRjAdAWBHmn9bswWHBlhFfoK5fmdf/HODaTA55agkPdJAIRaHDpPD3OjYDmCz5QAWc2G
 CiouFbWz1peNBKrBVZTml/GMrExXV+JhBk84PdAX40xn3CDKBYxlDroohAAHUp02Lb5NEPs/B
 yxRBs97BuR7/qZKJw37b8+BUV3FjUc7kK8Y3Df2xaj2MxH7UGi3CCzg76hoUGNShEzQy4M0Ny
 zowhIZRi2z2tN6DGwEdk9Va66aUvzzTQRSZvu6FnT8GjP37v5IOO6IXqSA2HUN7SJ3eWgX1r9
 WN8kD0HgRpvpN7Xb1/qjJnj0JFOYrmuU857rJXE0GCMJDm9w9bTx9PT4SiFfZFx4fh7CfiXFx
 e6J0UJE1Z81XXzwmkXqbztcWlKzcTYsyPnCbd0LbuPBwUBFqL2g5i7HF2cxEVmaKcJIIeyKJr
 BjxIY+0aALJ9wxf8+aO8KSYBR6i1NgvXkMqW4AH6HESz876e3OZBBkN8FY2xC5MxTspyhh+m/
 4lFHS11zhlaMXWeQCYCnSgUmMWVOmadPzW0qfqArfaZvLsRwXBYWKe7S6HK/pqqquMIsLQBBd
 vOOdykquDGFRwYP3lsEzMjVEv9Rx3+fl4u8dMbjx3oFxuEy19ZiG/FhlWdng7eC4Oyz0Jc3Q0
 toJNlaMyW8KGWBP3L2pRVpps+baRK/rB7FtEjuVfG6Uvrlyt3jGVrAhMnTh2FCu4xP9lTE+tV
 zin5bPHamV+fvrS/8PSrtbW1W2Lk6WqlZx7VvuPbTMUCrbRdkzeaZn/FmCiLlPTIsG7Vy5TYB
 E7D7NTp50x3jiv08U
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

On 08.02.20 16:20, Jan Kiszka wrote:
> On 08.02.20 15:30, Philippe Mathieu-Daud=C3=A9 wrote:
>> Fix using virtual console under gtk 3.22.30 (mate 1.20.1):
>>
>> =C2=A0=C2=A0 qemu-system-x86_64: Gdk: gdk_window_get_origin: assertion
>> 'GDK_IS_WINDOW (window)' failed
>>
>> Fixes: c4c00922cc and 28b58f19d2 (display/gtk: get proper refreshrate)
>> Reported-by: Jan Kiszka <jan.kiszka@web.de>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> Cc: Nikola Pavlica <pavlica.nikola@gmail.com>
>> Report:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg678130.html
>> ---
>> =C2=A0 ui/gtk.c | 9 +++++----
>> =C2=A0 1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/ui/gtk.c b/ui/gtk.c
>> index d18892d1de..c59297ff4d 100644
>> --- a/ui/gtk.c
>> +++ b/ui/gtk.c
>> @@ -1965,11 +1965,11 @@ static GtkWidget
>> *gd_create_menu_machine(GtkDisplayState *s)
>> =C2=A0=C2=A0 * If available, return the refresh rate of the display in =
milli-Hertz,
>> =C2=A0=C2=A0 * else return 0.
>> =C2=A0=C2=A0 */
>> -static int gd_refresh_rate_millihz(GtkDisplayState *s)
>> +static int gd_refresh_rate_millihz(GtkWidget *window)
>> =C2=A0 {
>> =C2=A0 #ifdef GDK_VERSION_3_22
>> -=C2=A0=C2=A0=C2=A0 GdkDisplay *dpy =3D gtk_widget_get_display(s->windo=
w);
>> -=C2=A0=C2=A0=C2=A0 GdkWindow *win =3D gtk_widget_get_window(s->window)=
;
>> +=C2=A0=C2=A0=C2=A0 GdkDisplay *dpy =3D gtk_widget_get_display(window);
>> +=C2=A0=C2=A0=C2=A0 GdkWindow *win =3D gtk_widget_get_window(window);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GdkMonitor *monitor =3D gdk_display_get_=
monitor_at_window(dpy, win);
>
> Nope, no change. It's triggered right from ui/gtk.c:1973, the line above=
.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdk_monitor_get_refresh_rate(moni=
tor);
>> @@ -2045,7 +2045,8 @@ static GSList *gd_vc_gfx_init(GtkDisplayState
>> *s, VirtualConsole *vc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.kbd =3D qkbd_state_init(con);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.dcl.con =3D con;
>> -=C2=A0=C2=A0=C2=A0 refresh_rate_millihz =3D gd_refresh_rate_millihz(s)=
;
>> +=C2=A0=C2=A0=C2=A0 refresh_rate_millihz =3D gd_refresh_rate_millihz(vc=
->window ?
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 vc->window :
>> s->window);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refresh_rate_millihz) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->gfx.dcl.upda=
te_interval =3D MILLISEC_PER_SEC /
>> refresh_rate_millihz;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>
> Jan

Here is the full backtrace, just in case:

#0  0x00007ffff496cf70 in gdk_window_get_origin () from /usr/lib64/libgdk-=
3.so.0
#1  0x00007ffff49582a0 in gdk_display_get_monitor_at_window () from /usr/l=
ib64/libgdk-3.so.0
#2  0x0000555555bb73e2 in gd_refresh_rate_millihz (window=3D0x5555579d6280=
) at /data/qemu/ui/gtk.c:1973
#3  gd_vc_gfx_init (view_menu=3D0x5555579f0590, group=3D0x0, idx=3D0, con=
=3D<optimized out>, vc=3D0x5555579d4a90, s=3D0x5555579d49f0) at /data/qemu=
/ui/gtk.c:2048
#4  gd_create_menu_view (s=3D0x5555579d49f0) at /data/qemu/ui/gtk.c:2149
#5  gd_create_menus (s=3D0x5555579d49f0) at /data/qemu/ui/gtk.c:2188
#6  gtk_display_init (ds=3D<optimized out>, opts=3D0x55555661ed80 <dpy>) a=
t /data/qemu/ui/gtk.c:2256
#7  0x000055555583d5a0 in main (argc=3D<optimized out>, argv=3D<optimized =
out>, envp=3D<optimized out>) at /data/qemu/vl.c:4358

Jan

