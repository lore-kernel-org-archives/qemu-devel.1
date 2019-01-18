Received: from eggs.gnu.org ([209.51.188.92]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkLbR-00078a-DF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 23:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkLNa-0001BW-9t
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 23:03:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gkLNY-00012e-Ar
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 23:03:36 -0500
Date: Thu, 17 Jan 2019 23:03:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190117230121-mutt-send-email-mst@kernel.org>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
	<ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
	<CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
	<a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
	<CAONzpcb-TrxZVBtfP=3PCqq-3r1NwX93C4xSd9MsM4DCTZMguA@mail.gmail.com>
	<ed0dc117-89f6-5fd6-a5f6-91f781a6b09e@redhat.com>
	<CAONzpcYS7Knf3-uMCjX47KjWJ315SqXWxJKQ9SDNt0P6jP7axw@mail.gmail.com>
	<de4691ae-e8cb-eaa2-e25f-fb7630a9007b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de4691ae-e8cb-eaa2-e25f-fb7630a9007b@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <elohimes@gmail.com>, zhangyu31@baidu.com, Xie Yongji <xieyongji@baidu.com>, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, chaiwen@baidu.com, Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, nixun@baidu.com, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>

On Fri, Jan 18, 2019 at 11:59:50AM +0800, Jason Wang wrote:
>=20
> On 2019/1/18 =E4=B8=8A=E5=8D=8811:32, Yongji Xie wrote:
> > On Thu, 17 Jan 2019 at 17:57, Jason Wang <jasowang@redhat.com> wrote:
> > >=20
> > > On 2019/1/15 =E4=B8=8B=E5=8D=8810:51, Yongji Xie wrote:
> > > > > Well, this may work but here're my points:
> > > > >=20
> > > > > 1) The code want to recover from backed crash by introducing ex=
tra space
> > > > > to store inflight data, but it still depends on the backend to =
set/get
> > > > > the inflight state
> > > > >=20
> > > > > 2) Since the backend could be killed at any time, the backend m=
ust have
> > > > > the ability to recover from the partial inflight state
> > > > >=20
> > > > > So it looks to me 1) tends to be self-contradictory and 2) tend=
s to be
> > > > > recursive. The above lines show how tricky could the code looks=
 like.
> > > > >=20
> > > > > Solving this at vhost-user level through at backend is probably=
 wrong.
> > > > > It's time to consider the support from virtio itself.
> > > > >=20
> > > > I agree that supporting this in virtio level may be better. For
> > > > example, resubmitting inflight I/O once DEVICE_NEEDS_RESET is set=
 in
> > > > Stefan's proposal. But I still think QEMU should be able to provi=
de
> > > > this ability too. Supposed that one vhost-user backend need to su=
pport
> > > > multiple VMs. We can't enable reconnect ability until all VMs' gu=
est
> > > > driver support the new feature. It's limited.
> > >=20
> > > That's the way virtio evolves.
> > >=20
> > >=20
> > > >    But if QEMU have the
> > > > ability to store inflight buffer, the backend could at least have=
 a
> > > > chance to support this case.
> > >=20
> > > The problem is, you need a careful designed protocol described some=
where
> > That's what we should discuss in detail in this series.
>=20
>=20
> Well, I ask some questions for this patch, but it looks like they were =
still
> not answered. No?
>=20

Oh absolutely. I can't say I like the implementation,
I think it's both not the most robust and suboptimal.

> >=20
> > > (is vhost-user.txt a good place for this?). And this work will be
> > > (partial) duplicated for the future support from virtio spec itself=
.
> > >=20
> > I think the duplicated code is to maintain the inflight descriptor
> > list which should be in backend. That's not main work in this series.
> > And backend could choose to include it or not.
>=20
>=20
> You need to have a documentation to describe the protocol. Otherwise, i=
t
> would be very hard for other backend to implement.
>=20
> Thanks


Meaning how the inflight descriptors are saved in the buffer.
Yes I agree.

>=20
> >=20
> > Thanks,
> > Yongji
> >=20
