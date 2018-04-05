Received: from eggs.gnu.org ([2001:4830:134:3::10]:52642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f446N-0005vW-EK
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f446I-0005qf-D5
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:34:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f446I-0005qW-7Y
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:34:46 -0400
Date: Thu, 5 Apr 2018 13:34:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180405123431.GI32222@stefanha-x1.localdomain>
References: <20180403050115.6037-1-peterx@redhat.com>
	<20180404142220.GT4467@stefanha-x1.localdomain>
	<3d6c0d02-60ab-3501-611e-cd5f881d59e3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline
In-Reply-To: <3d6c0d02-60ab-3501-611e-cd5f881d59e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 10:07:34AM -0500, Eric Blake wrote:
> On 04/04/2018 09:22 AM, Stefan Hajnoczi wrote:
> > On Tue, Apr 03, 2018 at 01:01:15PM +0800, Peter Xu wrote:
> >> Eric Auger reported the problem days ago that OOB broke ARM when runni=
ng
> >> with libvirt:
> >>
> >> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
> >>
> >> This patch fixes the problem.
> >>
> >> It's not really needed now since we have turned OOB off now, but it's
> >> still a bug fix, and it'll start to work when we turn OOB on for ARM.
> >>
> >> The problem was that the monitor dispatcher bottom half was bound to
> >> qemu_aio_context, but that context seems to be for block only.
> >=20
> > No, it is not block-only.  iohandler_ctx is for the legacy
> > qemu_set_fd_handler() API only and modern code should use
> > qemu_aio_context.
> >=20
> > The difference between qemu_aio_context and iohandler_ctx is that
> > aio_poll(qemu_aio_context) does not process iohandler_ctx (since it's a
> > difference context).  That is the legacy behavior that
> > qemu_set_fd_handler() expects and it's implemented by keeping a separate
> > iohandler_ctx.
>=20
> Do I need to put a hold on my pull request while we come to a better
> understanding of root cause, or is this patch still okay to include?

The cover letter says this patch is not critical for 2.12:

"It's not really needed now since we have turned OOB off now, but it's
still a bug fix, and it'll start to work when we turn OOB on for ARM."

Please hold off until the nature of the bug is understood.

Thanks,
Stefan

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxhfWAAoJEJykq7OBq3PIeQkH/1bakMsUhgxpxaqGY+s+RNTJ
vdP8Txs6PVE30Sn8KNAOqYBaN+QQqz8zI7V5bMyu41KWCfv/zlSWTD0LUlw/LrDp
UX8KyBR2Uk9vTpFh7IN/f9L25O5GpiKHqR74ST1D0kJ2MqjEDXx+ko+n5mzzLfiO
pi/4VUvHls+70L/8l/OSGRjPu9RCHt2elIq1tTCvHLxTtYTPXb9qJTz/pMOySMj2
ncht3JRc+C0Xo54pRXRrBi/bMqtvtYVDc0KIO/EgQ7rUM/hUPAL98o5i+/GR6vbc
YF/FBAavhXx9poUj1DxC9A4q4SiWm9CC2pHhxSF8Dwrg1Tk/6CU8FxgdUdKhsaU=
=kSMr
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--
