Received: from eggs.gnu.org ([209.51.188.92]:43007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghz8A-0005Tz-1w
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghz86-0005a9-3r
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:53:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghz83-0005UG-Vh
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:53:52 -0500
Received: by mail-wm1-x341.google.com with SMTP id y139so2826766wmc.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:53:45 -0800 (PST)
Date: Fri, 11 Jan 2019 15:53:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190111155342.GA14776@stefanha-x1.localdomain>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190110102551.GD19025@stefanha-x1.localdomain>
	<CAONzpcYgVWUFg1uSHOLzOS5en2vHP_=oNXQvWQEZd9FdYi2uxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <CAONzpcYgVWUFg1uSHOLzOS5en2vHP_=oNXQvWQEZd9FdYi2uxA@mail.gmail.com>
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


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 06:59:27PM +0800, Yongji Xie wrote:
> On Thu, 10 Jan 2019 at 18:25, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Wed, Jan 09, 2019 at 07:27:21PM +0800, elohimes@gmail.com wrote:
> > > From: Xie Yongji <xieyongji@baidu.com>
> > >
> > > This patchset is aimed at supporting qemu to reconnect
> > > vhost-user-blk backend after vhost-user-blk backend crash or
> > > restart.
> > >
> > > The patch 1 uses exisiting wait/nowait options to make QEMU not
> > > do a connect on client sockets during initialization of the chardev.
> > >
> > > The patch 2 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> > > and VHOST_USER_SET_INFLIGHT_FD to support providing shared
> > > memory to backend.
> >
> > Can you describe the problem that the inflight I/O shared memory region
> > solves?
> >
>=20
> The backend need to get inflight I/O and do I/O replay after restart.
> Now we can only get used_idx in used_ring. It's not enough. Because we
> might not process descriptors in the same order which they have been
> made available sometimes. A simple example:
> https://patchwork.kernel.org/cover/10715305/#22375607. So we need a
> shared memory to track inflight I/O.

The inflight shared memory region is something that needs to be
discussed in detail to make sure it is correct not just for vhost-blk
but also for other vhost-user devices in the future.

Please expand the protocol documentation so that someone can implement
this feature without looking at the code.  Explain the reason for the
inflight shared memory region and how exactly it used.

After a quick look at the shared memory region documentation I have a
few questions:

1. The avail ring only contains "head" indices, each of which may chain
   non-head descriptors.  Does the inflight memory region track only the
   heads?

2. Does the inflight shared memory region preserve avail ring order?
   For example, if the guest submitted 5 2 4, will the new vhost-user
   backend keep that order or does it see 2 4 5?

3. What are the exact memory region size requirements?  Imagine a device
   with a large virtqueue.  Or a device with multiple virtqueues of
   different sizes.  Can your structure hand those cases?

I'm concerned that this approach to device recovery is invasive and hard
to test.  Instead I would use VIRTIO's Device Status Field
DEVICE_NEEDS_RESET bit to tell the guest driver that a reset is
necessary.  This is more disruptive - drivers either have to resubmit or
fail I/O with EIO - but it's also simple and more likely to work
correctly (it only needs to be implemented correctly in the guest
driver, not in the many available vhost-user backend implementations).

Stefan

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcOLwGAAoJEJykq7OBq3PIPDAIALmWnMr95QAMUz0X5V6gj7qL
FGZgFv07N4Chwox7T2Vt/FYluWmkCpvATtX+hSuyHKV7DEePY7K4e4wNDBLH4N4g
WWifZ2YJ9kGkQ6i0yJKImPAA9c+Xeg3nsh/SWQYxrQk6D0RlM0b+L8s78SgIo89w
JNohYBrR/xCGTL+Ns+oIwXGvTyRwZLjR6kUdn6yxTT3Cz7DJYm68oceIQyocEj4N
aAkDcbiqq0TA9mVU9AiZ+/eJMN89CgmCrLYyDJrIk7GwBSerZSrh82Xblm2jgOz3
44WhFozK+vUvNBmvCNImpLzS6usBPJ3F/8LZvxisLR3lGfI9RsyTaboghpF9VBY=
=4r9+
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
