Received: from eggs.gnu.org ([209.51.188.92]:51697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gje1S-0000VQ-67
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gjdvH-0006SD-V9
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:39:33 -0500
Received: from mail-yw1-xc36.google.com ([2607:f8b0:4864:20::c36]:38850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gjdvF-0006OF-Me
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:39:30 -0500
Received: by mail-yw1-xc36.google.com with SMTP id d190so2043951ywb.5
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 21:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20190110124946.GL2178@redhat.com>
	<CAONzpcZCTqN3CN1DBd6WdjKoTSr257Y2vOCuLOh9LBb-5K_hpg@mail.gmail.com>
	<20190110132443.GM2178@redhat.com>
	<CAONzpcZ5HXP2-9PEZW=RwunviAcPL3kYosJhUWB0g09j=pf0oQ@mail.gmail.com>
	<20190110141125.GP2178@redhat.com>
	<CAONzpcY8LdzEEqourAjw5mZR9fjtjv20HqvyOvaWVoriD4Cbjg@mail.gmail.com>
	<20190110164125.GS2178@redhat.com>
	<CAONzpcb4hk87JhF0Cuz4xWDto5EOaKQSVPvegiUVF+2TbYGouw@mail.gmail.com>
	<20190111083237.GA18491@redhat.com>
	<CAONzpcaB=JVG2nkPMUUFLkGM14j=pZGSA8hyTBQ-+syL5J_WgA@mail.gmail.com>
	<20190115153921.GD16157@redhat.com>
In-Reply-To: <20190115153921.GD16157@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 16 Jan 2019 13:39:13 +0800
Message-ID: <CAONzpcYvnPg-tmXUY7ZEsgUVuD+T2+ShLjvp1KzgeCiTW0Kw4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 1/7] char-socket: Enable
 "nowait" option on client sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Tue, 15 Jan 2019 at 23:39, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Jan 11, 2019 at 04:36:11PM +0800, Yongji Xie wrote:
> > On Fri, 11 Jan 2019 at 16:32, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > On Fri, Jan 11, 2019 at 03:50:40PM +0800, Yongji Xie wrote:
> > > > On Fri, 11 Jan 2019 at 00:41, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > > > >
> > > > > We need to fix qemu_chr_fe_wait_connected so that it does explici=
t
> > > > > synchronization wrt to any ongoing background connection process.
> > > > > It must only return once all TLS/telnet/websock handshakes have
> > > > > completed.  If we fix that correctly, then I believe it will  als=
o
> > > > > solve the problem you're trying to address.
> > > > >
> > > >
> > > > Yes, I think this should be the right way to go. To fix it, my thou=
ght
> > > > is to track the async QIOChannelSocket in SocketChardev. Then we ca=
n
> > > > easily get the connection progress in qemu_chr_fe_wait_connected().=
 Do
> > > > you have any suggestion?
> > >
> > > I've got a few patches that refactor the code to fix this. I'll send =
them
> > > today and CC you on them.
> > >
> >
> > That would be great! Thank you.
>
> It took me rather longer than expected to fully debug all scenarios, but
> I've finally sent patches:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.html
>

I will test my series based on this. Thank you.

Thanks,
Yongji
