Received: from eggs.gnu.org ([209.51.188.92]:53136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjSJc-0007By-Ca
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjSJb-00085l-ED
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:15:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjSJb-00083k-5H
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:15:51 -0500
Date: Tue, 15 Jan 2019 17:15:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190115171541.GS16157@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190110132443.GM2178@redhat.com>
	<CAONzpcZ5HXP2-9PEZW=RwunviAcPL3kYosJhUWB0g09j=pf0oQ@mail.gmail.com>
	<20190110141125.GP2178@redhat.com>
	<CAONzpcY8LdzEEqourAjw5mZR9fjtjv20HqvyOvaWVoriD4Cbjg@mail.gmail.com>
	<20190110164125.GS2178@redhat.com>
	<CAONzpcb4hk87JhF0Cuz4xWDto5EOaKQSVPvegiUVF+2TbYGouw@mail.gmail.com>
	<20190111083237.GA18491@redhat.com>
	<CAONzpcaB=JVG2nkPMUUFLkGM14j=pZGSA8hyTBQ-+syL5J_WgA@mail.gmail.com>
	<20190115153921.GD16157@redhat.com>
	<2208121547571231@iva8-f16495710718.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2208121547571231@iva8-f16495710718.qloud-c.yandex.net>
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
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Yongji Xie <elohimes@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, "zhangyu31@baidu.com" <zhangyu31@baidu.com>, "chaiwen@baidu.com" <chaiwen@baidu.com>, "nixun@baidu.com" <nixun@baidu.com>, "lilin24@baidu.com" <lilin24@baidu.com>, Xie Yongji <xieyongji@baidu.com>

On Tue, Jan 15, 2019 at 07:53:51PM +0300, Yury Kotov wrote:
> 15.01.2019, 18:39, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
> > On Fri, Jan 11, 2019 at 04:36:11PM +0800, Yongji Xie wrote:
> >> =C2=A0On Fri, 11 Jan 2019 at 16:32, Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> >> =C2=A0>
> >> =C2=A0> On Fri, Jan 11, 2019 at 03:50:40PM +0800, Yongji Xie wrote:
> >> =C2=A0> > On Fri, 11 Jan 2019 at 00:41, Daniel P. Berrang=C3=A9 <ber=
range@redhat.com> wrote:
> >> =C2=A0> > >
> >> =C2=A0> > > We need to fix qemu_chr_fe_wait_connected so that it doe=
s explicit
> >> =C2=A0> > > synchronization wrt to any ongoing background connection=
 process.
> >> =C2=A0> > > It must only return once all TLS/telnet/websock handshak=
es have
> >> =C2=A0> > > completed. If we fix that correctly, then I believe it w=
ill also
> >> =C2=A0> > > solve the problem you're trying to address.
> >> =C2=A0> > >
> >> =C2=A0> >
> >> =C2=A0> > Yes, I think this should be the right way to go. To fix it=
, my thought
> >> =C2=A0> > is to track the async QIOChannelSocket in SocketChardev. T=
hen we can
> >> =C2=A0> > easily get the connection progress in qemu_chr_fe_wait_con=
nected(). Do
> >> =C2=A0> > you have any suggestion?
> >> =C2=A0>
> >> =C2=A0> I've got a few patches that refactor the code to fix this. I=
'll send them
> >> =C2=A0> today and CC you on them.
> >> =C2=A0>
> >>
> >> =C2=A0That would be great! Thank you.
> >
> > It took me rather longer than expected to fully debug all scenarios, =
but
> > I've finally sent patches:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.html
>=20
> I didn't do a deep review and may be wrong, but I think the race is sti=
ll
> possible in the hotplug case.
>=20
> Example:
> 1. User adds a chardev (qmp: chardev-add) with 'reconnect' option;
> 2. Some main-loop iterations...
> 3. Reconnect timer triggers and starts connection thread;
> 4. User adds a vhost-user-blk (qmp: device-add): device realize -> wait=
_connected.
>=20
> Here, there is a chance that we are in the wait_connected and the conne=
ction
> thread is still running.

Hmm, dealing with device-add is tricky. tcp_chr_wait_connect rather
assumes no main loop is running. I'll have to think about how we could
possibly handle hotplug safely.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
