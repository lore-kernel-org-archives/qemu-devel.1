Received: from eggs.gnu.org ([209.51.188.92]:35603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkLHC-0002tC-7J
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 22:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkLHB-0006Tx-3n
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 22:57:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gkLHA-0006Iw-RN
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 22:57:01 -0500
Date: Thu, 17 Jan 2019 22:56:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190117225538-mutt-send-email-mst@kernel.org>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
	<ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
	<CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
	<a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
	<CAONzpcb-TrxZVBtfP=3PCqq-3r1NwX93C4xSd9MsM4DCTZMguA@mail.gmail.com>
	<ed0dc117-89f6-5fd6-a5f6-91f781a6b09e@redhat.com>
	<CAONzpcYS7Knf3-uMCjX47KjWJ315SqXWxJKQ9SDNt0P6jP7axw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAONzpcYS7Knf3-uMCjX47KjWJ315SqXWxJKQ9SDNt0P6jP7axw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 4/7] libvhost-user: Support
 tracking inflight I/O in shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Fri, Jan 18, 2019 at 11:32:03AM +0800, Yongji Xie wrote:
> On Thu, 17 Jan 2019 at 17:57, Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2019/1/15 =E4=B8=8B=E5=8D=8810:51, Yongji Xie wrote:
> > >> Well, this may work but here're my points:
> > >>
> > >> 1) The code want to recover from backed crash by introducing extra=
 space
> > >> to store inflight data, but it still depends on the backend to set=
/get
> > >> the inflight state
> > >>
> > >> 2) Since the backend could be killed at any time, the backend must=
 have
> > >> the ability to recover from the partial inflight state
> > >>
> > >> So it looks to me 1) tends to be self-contradictory and 2) tends t=
o be
> > >> recursive. The above lines show how tricky could the code looks li=
ke.
> > >>
> > >> Solving this at vhost-user level through at backend is probably wr=
ong.
> > >> It's time to consider the support from virtio itself.
> > >>
> > > I agree that supporting this in virtio level may be better. For
> > > example, resubmitting inflight I/O once DEVICE_NEEDS_RESET is set i=
n
> > > Stefan's proposal. But I still think QEMU should be able to provide
> > > this ability too. Supposed that one vhost-user backend need to supp=
ort
> > > multiple VMs. We can't enable reconnect ability until all VMs' gues=
t
> > > driver support the new feature. It's limited.
> >
> >
> > That's the way virtio evolves.
> >
> >
> > >   But if QEMU have the
> > > ability to store inflight buffer, the backend could at least have a
> > > chance to support this case.
> >
> >
> > The problem is, you need a careful designed protocol described somewh=
ere
>=20
> That's what we should discuss in detail in this series.
>=20
> > (is vhost-user.txt a good place for this?). And this work will be
> > (partial) duplicated for the future support from virtio spec itself.
> >
>=20
> I think the duplicated code is to maintain the inflight descriptor
> list which should be in backend. That's not main work in this series.
> And backend could choose to include it or not.
>=20
> Thanks,
> Yongji

It would be if someone volunteered to rewrite the vhost user informal
description that we have in qemu and make it a full spec.
So far a text + implementation in contrib seems plenty to me.

--=20
MST
