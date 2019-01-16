Received: from eggs.gnu.org ([209.51.188.92]:57589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjmBG-0004bv-RE
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjmBE-0002kA-TE
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:28:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gjmBD-0002d5-An
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:28:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id m1so2197725wml.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 06:28:29 -0800 (PST)
Date: Wed, 16 Jan 2019 14:28:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190116142825.GG16898@stefanha-x1.localdomain>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190110102551.GD19025@stefanha-x1.localdomain>
	<CAONzpcYgVWUFg1uSHOLzOS5en2vHP_=oNXQvWQEZd9FdYi2uxA@mail.gmail.com>
	<20190111155342.GA14776@stefanha-x1.localdomain>
	<CAONzpca7NEzX-GZ4W5J328njEW_NpUXJphTNwzgqfXOS-f54-Q@mail.gmail.com>
	<20190114102231.GB7038@stefanha-x1.localdomain>
	<CAONzpcbomC21=7irxFEYEfA9=EGUUfNUZVNxZXRA0Rwb5MWMMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <CAONzpcbomC21=7irxFEYEfA9=EGUUfNUZVNxZXRA0Rwb5MWMMg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 0/7] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, nixun@baidu.com, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 06:55:40PM +0800, Yongji Xie wrote:
> On Mon, 14 Jan 2019 at 18:22, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Sat, Jan 12, 2019 at 12:50:12PM +0800, Yongji Xie wrote:
> > > On Fri, 11 Jan 2019 at 23:53, Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> > > >
> > > > On Thu, Jan 10, 2019 at 06:59:27PM +0800, Yongji Xie wrote:
> > > > > On Thu, 10 Jan 2019 at 18:25, Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
> > > > > >
> > > > > > On Wed, Jan 09, 2019 at 07:27:21PM +0800, elohimes@gmail.com wr=
ote:
> > > > I'm concerned that this approach to device recovery is invasive and=
 hard
> > > > to test.  Instead I would use VIRTIO's Device Status Field
> > > > DEVICE_NEEDS_RESET bit to tell the guest driver that a reset is
> > > > necessary.  This is more disruptive - drivers either have to resubm=
it or
> > > > fail I/O with EIO - but it's also simple and more likely to work
> > > > correctly (it only needs to be implemented correctly in the guest
> > > > driver, not in the many available vhost-user backend implementation=
s).
> > > >
> > >
> > > So you mean adding one way to notify guest to resubmit inflight I/O. I
> > > think it's a good idea. But would it be more flexible to implement
> > > this in backend. We can support old guest. And it will be easy to fix
> > > bug or add feature.
> >
> > There are trade-offs with either approach.  In the long run I think it's
> > beneficial minimize non-trivial logic in vhost-user backends.  There
> > will be more vhost-user backend implementations and therefore more bugs
> > if we put the logic into the backend.  This is why I think a simple
> > mechanism for marking the device as needing a reset will be more
> > reliable and less trouble.
> >
>=20
> I agree. So is it possible to implement both? In the long run,
> updating guest driver to support this is better. And at that time, the
> logic in backend can be only used to support legacy guest driver.

Yes, in theory both approaches could be available.

Stefan

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPz+JAAoJEJykq7OBq3PIrSEH/A0YQHXCM0TOU6GxvfGAdD1m
fZmflgqMofoRJDfpL+ZYCNTp9Wt7WvgxVsEhIySb1rQj08Apzw59lGKc/CaMBGc3
LNcBszD2TGa0k2D9NjxxEibkG+TF7ID/WsIEcsvoe8vqHIRDZy09Cs7T9VRUlMos
kTPvKfGwf3otnhPEfREZTBDPpZ5zbOFx46g79BEfT0VBhJFi58J+CGADdvzTlwtg
2O2KyfT2UAaLxRZsmidVHVaFyWCe4778rY6p0b1XJ7Djy1I3tVydD+tZ7X2COMn2
d9DFrsy8S1qbUMt+/XYJQLfTNegf+f9mK/EkcuFB+WIwqHCHgZlXcAA0LZeNm64=
=PuoL
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
