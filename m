Received: from eggs.gnu.org ([2001:4830:134:3::10]:59831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emFqV-0001rZ-R3
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emFqS-0002un-Nf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:28:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1emFqS-0002uf-Hh
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:28:48 -0500
Date: Thu, 15 Feb 2018 09:28:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180215092831.GB23321@stefanha-x1.localdomain>
References: <20180213142102.14450-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20180213142102.14450-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] block: fix blk_aio_*() segfault
 when blk->root == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, mark.kanda@oracle.com, Kevin Wolf <kwolf@redhat.com>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 02:20:58PM +0000, Stefan Hajnoczi wrote:
> v2:
>  * Introduce AIO_WAIT_WHILE() since aio_poll(ctx, true) is not allowed [P=
aolo]
>=20
> Using bdrv_inc_in_flight(blk_bs(blk)) doesn't work since BlockBackend->ro=
ot may
> be NULL.
>=20
> This patch series solves the issue by adding an BlockBackend->in_flight c=
ounter
> so requests can be tracked even when there is no BlockDriverState.
>=20
> This should fix the IDE and virtio-blk segfaults that have been encounter=
ed
> when there is no BlockDriverState.
>=20
> The patch is based on work by Kevin Wolf.
>=20
> Kevin Wolf (1):
>   block: test blk_aio_flush() with blk->root =3D=3D NULL
>=20
> Stefan Hajnoczi (3):
>   block: extract AIO_WAIT_WHILE() from BlockDriverState
>   block: add BlockBackend->in_flight counter
>   Revert "IDE: Do not flush empty CDROM drives"
>=20
>  tests/Makefile.include     |   2 +
>  util/Makefile.objs         |   2 +-
>  include/block/aio-wait.h   | 116 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/block/block.h      |  40 +++-------------
>  include/block/block_int.h  |   7 ++-
>  block.c                    |   7 ++-
>  block/block-backend.c      |  60 ++++++++++++++++++++---
>  block/io.c                 |  10 +---
>  hw/ide/core.c              |  10 +---
>  tests/test-block-backend.c |  82 ++++++++++++++++++++++++++++++++
>  util/aio-wait.c            |  40 ++++++++++++++++
>  11 files changed, 313 insertions(+), 63 deletions(-)
>  create mode 100644 include/block/aio-wait.h
>  create mode 100644 tests/test-block-backend.c
>  create mode 100644 util/aio-wait.c

Eric has posted R-b for all patches.

Kevin or Paolo: Are you happy with this series?

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahVK/AAoJEJykq7OBq3PIqYkIAIWLaYph6bM3fdb14//zJxOV
ri54yDkTPYTwnFMG59teJLwIVlWotwaRgA2no2swgMQlMJVVzb6UAy4AcLZDvCF/
n4FRL0A4eRyJyw94DB7Eoxtnbk500iyc07Zqhyp/muvohoEJEbLgpFwMWvDnZQTd
YEepq+mfxumvtHUwkY4kMEP35R4Hpn8rUhZ2OGpUkAaGda3Z6EINYPgHhsJGSOvD
ppFv4oz1o9v0LpVPoiB3Fd42m78evq/7eU8QpGnvKuf9XmvkGaUDuT387ZEowl3I
IR9iyCtOgHq+qlswHYnD+fUELHClBms7Bs5HBInY1vQLvPVq6xVHTvH0qaGrcmc=
=ZctX
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
