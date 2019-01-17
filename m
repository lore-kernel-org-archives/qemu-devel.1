Received: from eggs.gnu.org ([209.51.188.92]:59409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gk9Df-0002lY-L7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gk9Dd-0006xS-R8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:04:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gk9Dd-0006ur-Jo
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:04:33 -0500
Date: Thu, 17 Jan 2019 10:04:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190117095957-mutt-send-email-mst@kernel.org>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
	<ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
	<CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
	<a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
	<20190115105548-mutt-send-email-mst@kernel.org>
	<3ead48a9-9cf9-33f6-b258-7068265c1a99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ead48a9-9cf9-33f6-b258-7068265c1a99@redhat.com>
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
Cc: Yongji Xie <elohimes@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, Jan 17, 2019 at 06:01:16PM +0800, Jason Wang wrote:
>=20
> On 2019/1/15 =E4=B8=8B=E5=8D=8811:58, Michael S. Tsirkin wrote:
> > On Tue, Jan 15, 2019 at 03:52:21PM +0800, Jason Wang wrote:
> > > Well, this may work but here're my points:
> > >=20
> > > 1) The code want to recover from backed crash by introducing extra =
space to
> > > store inflight data, but it still depends on the backend to set/get=
 the
> > > inflight state
> > >=20
> > > 2) Since the backend could be killed at any time, the backend must =
have the
> > > ability to recover from the partial inflight state
> > >=20
> > > So it looks to me 1) tends to be self-contradictory and 2) tends to=
 be
> > > recursive. The above lines show how tricky could the code looks lik=
e.
> > This is a well studied field. Basically you make sure you commit with=
 an
> > atomic write.  Restartable sequences allow accelerating this even
> > further.
>=20
>=20
> I'm not sure I get this. But the issue is to exactly deduce all the inf=
light
> descriptors even if backend could be killed when doing the logging. If =
we
> could not be 100% accurate, it's have much less value.


I agree. But why discuss theoretical issues?
Can you point out a problem in the contrib/ code
included here?

If yes it must be fixed I think.

I personally think it's not too hard.
Consider packed ring for example - just maintain a list of the inflight
descriptors, as the last step write out the flags atomically.




>=20
> >=20
> > > Solving this at vhost-user level through at backend is probably wro=
ng. It's
> > > time to consider the support from virtio itself.
> > >=20
> > > Thanks
> > I think both approaches have their space.
>=20
>=20
> But there will be a lot of duplicated work if we decide to support it f=
rom
> virtio.
>=20
> Thanks
>=20
>=20
> >=20
> > -- MST
