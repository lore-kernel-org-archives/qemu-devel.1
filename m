Received: from eggs.gnu.org ([209.51.188.92]:48580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gjS0f-0002SX-B5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gjRyQ-0004oU-6I
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:53:59 -0500
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:53386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gjRyP-0004mG-Ix
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:53:58 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190115153921.GD16157@redhat.com>
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
MIME-Version: 1.0
Date: Tue, 15 Jan 2019 19:53:51 +0300
Message-Id: <2208121547571231@iva8-f16495710718.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, "zhangyu31@baidu.com" <zhangyu31@baidu.com>, "chaiwen@baidu.com" <chaiwen@baidu.com>, "nixun@baidu.com" <nixun@baidu.com>, "lilin24@baidu.com" <lilin24@baidu.com>, Xie Yongji <xieyongji@baidu.com>

15.01.2019, 18:39, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
> On Fri, Jan 11, 2019 at 04:36:11PM +0800, Yongji Xie wrote:
>> =C2=A0On Fri, 11 Jan 2019 at 16:32, Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>> =C2=A0>
>> =C2=A0> On Fri, Jan 11, 2019 at 03:50:40PM +0800, Yongji Xie wrote:
>> =C2=A0> > On Fri, 11 Jan 2019 at 00:41, Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
>> =C2=A0> > >
>> =C2=A0> > > We need to fix qemu_chr_fe_wait_connected so that it does =
explicit
>> =C2=A0> > > synchronization wrt to any ongoing background connection p=
rocess.
>> =C2=A0> > > It must only return once all TLS/telnet/websock handshakes=
 have
>> =C2=A0> > > completed. If we fix that correctly, then I believe it wil=
l also
>> =C2=A0> > > solve the problem you're trying to address.
>> =C2=A0> > >
>> =C2=A0> >
>> =C2=A0> > Yes, I think this should be the right way to go. To fix it, =
my thought
>> =C2=A0> > is to track the async QIOChannelSocket in SocketChardev. The=
n we can
>> =C2=A0> > easily get the connection progress in qemu_chr_fe_wait_conne=
cted(). Do
>> =C2=A0> > you have any suggestion?
>> =C2=A0>
>> =C2=A0> I've got a few patches that refactor the code to fix this. I'l=
l send them
>> =C2=A0> today and CC you on them.
>> =C2=A0>
>>
>> =C2=A0That would be great! Thank you.
>
> It took me rather longer than expected to fully debug all scenarios, bu=
t
> I've finally sent patches:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.html
>
> Regards,
> Daniel
> --
> |: https://berrange.com -o- https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org -o- https://fstop138.berrange.com :|
> |: https://entangle-photo.org -o- https://www.instagram.com/dberrange :=
|

I didn't do a deep review and may be wrong, but I think the race is still
possible in the hotplug case.

Example:
1. User adds a chardev (qmp: chardev-add) with 'reconnect' option;
2. Some main-loop iterations...
3. Reconnect timer triggers and starts connection thread;
4. User adds a vhost-user-blk (qmp: device-add): device realize -> wait_c=
onnected.

Here, there is a chance that we are in the wait_connected and the connect=
ion
thread is still running.

Regards,
Yury
