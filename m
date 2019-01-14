Received: from eggs.gnu.org ([209.51.188.92]:49129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gizOJ-0005UJ-HQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gizOF-0003lW-Kq
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:22:47 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gizOC-0003a5-Fi
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:22:41 -0500
Received: by mail-wm1-x344.google.com with SMTP id a62so8285992wmh.4
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:22:35 -0800 (PST)
Date: Mon, 14 Jan 2019 10:22:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190114102231.GB7038@stefanha-x1.localdomain>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190110102551.GD19025@stefanha-x1.localdomain>
	<CAONzpcYgVWUFg1uSHOLzOS5en2vHP_=oNXQvWQEZd9FdYi2uxA@mail.gmail.com>
	<20190111155342.GA14776@stefanha-x1.localdomain>
	<CAONzpca7NEzX-GZ4W5J328njEW_NpUXJphTNwzgqfXOS-f54-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <CAONzpca7NEzX-GZ4W5J328njEW_NpUXJphTNwzgqfXOS-f54-Q@mail.gmail.com>
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


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 12, 2019 at 12:50:12PM +0800, Yongji Xie wrote:
> On Fri, 11 Jan 2019 at 23:53, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Thu, Jan 10, 2019 at 06:59:27PM +0800, Yongji Xie wrote:
> > > On Thu, 10 Jan 2019 at 18:25, Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> > > >
> > > > On Wed, Jan 09, 2019 at 07:27:21PM +0800, elohimes@gmail.com wrote:
> > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > >
> > > > > This patchset is aimed at supporting qemu to reconnect
> > > > > vhost-user-blk backend after vhost-user-blk backend crash or
> > > > > restart.
> > > > >
> > > > > The patch 1 uses exisiting wait/nowait options to make QEMU not
> > > > > do a connect on client sockets during initialization of the chard=
ev.
> > > > >
> > > > > The patch 2 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> > > > > and VHOST_USER_SET_INFLIGHT_FD to support providing shared
> > > > > memory to backend.
> > > >
> > > > Can you describe the problem that the inflight I/O shared memory re=
gion
> > > > solves?
> > > >
> > >
> > > The backend need to get inflight I/O and do I/O replay after restart.
> > > Now we can only get used_idx in used_ring. It's not enough. Because we
> > > might not process descriptors in the same order which they have been
> > > made available sometimes. A simple example:
> > > https://patchwork.kernel.org/cover/10715305/#22375607. So we need a
> > > shared memory to track inflight I/O.
> >
> > The inflight shared memory region is something that needs to be
> > discussed in detail to make sure it is correct not just for vhost-blk
> > but also for other vhost-user devices in the future.
> >
> > Please expand the protocol documentation so that someone can implement
> > this feature without looking at the code.  Explain the reason for the
> > inflight shared memory region and how exactly it used.
> >
>=20
> OK, will do it in v5.
>=20
> > After a quick look at the shared memory region documentation I have a
> > few questions:
> >
> > 1. The avail ring only contains "head" indices, each of which may chain
> >    non-head descriptors.  Does the inflight memory region track only the
> >    heads?
> >
>=20
> Yes, we only track the head in inflight region.

Okay, thanks.  That is useful information to include in the
specification.

> > 2. Does the inflight shared memory region preserve avail ring order?
> >    For example, if the guest submitted 5 2 4, will the new vhost-user
> >    backend keep that order or does it see 2 4 5?
> >
>=20
> Now we don't support to resubmit I/O in order. But I think we can add
> a timestamp
> for each inflight descriptor in shared memory to achieve that.

Great, the reason I think that feature is interesting is that other
device types may need to preserve order.  It depends on the exact
meaning of the device's requests...

> > I'm concerned that this approach to device recovery is invasive and hard
> > to test.  Instead I would use VIRTIO's Device Status Field
> > DEVICE_NEEDS_RESET bit to tell the guest driver that a reset is
> > necessary.  This is more disruptive - drivers either have to resubmit or
> > fail I/O with EIO - but it's also simple and more likely to work
> > correctly (it only needs to be implemented correctly in the guest
> > driver, not in the many available vhost-user backend implementations).
> >
>=20
> So you mean adding one way to notify guest to resubmit inflight I/O. I
> think it's a good idea. But would it be more flexible to implement
> this in backend. We can support old guest. And it will be easy to fix
> bug or add feature.

There are trade-offs with either approach.  In the long run I think it's
beneficial minimize non-trivial logic in vhost-user backends.  There
will be more vhost-user backend implementations and therefore more bugs
if we put the logic into the backend.  This is why I think a simple
mechanism for marking the device as needing a reset will be more
reliable and less trouble.

Stefan

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPGLnAAoJEJykq7OBq3PInRcH/Agqj/Xjx8yUmH5GwPJzJ+ES
+f+EOatXdOzaERYiauVZY9RL7Ytwyl0jjoJ2Rd9njnuRNaXkSygvF9B+RTKreGIT
gCxPBWgDm+fV9jNWzCJTV3Q65jNgEENcRzWdmxfzQ6S8D6iUs9/sNYPD5zpfOx7y
qtXklSP88S9EPfAyRAaPeKQ5PYIw+knCACxZjE5+NF5ESJh9BEEIzamrerra4aXW
cw3FT8dlSXU9KHbbggV1XrkJqnWrtaqPalvdX7CUOYphwffK8bE37ztki2DVj/Xo
KoOSDe9kWWmLQmiPBZvRQvI+lzJ3w9vm0S9UHN6s3J/VF3kE4Fgg5A10F8S70us=
=XH6b
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
