Received: from eggs.gnu.org ([209.51.188.92]:41712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGmwj-0002N7-FL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGmwi-0006T3-9v
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:58:01 -0400
References: <20190417154850.29110-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c4ec9ec-d76a-bcb1-4cc4-94480d88aec2@redhat.com>
Date: Wed, 17 Apr 2019 10:57:54 -0500
MIME-Version: 1.0
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3Ze7XvoicqEnr3kvoMXHVlatssZdKQDiw"
Subject: Re: [Qemu-devel] [PATCH] block: Fix AioContext switch for bs->drv
 == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Ze7XvoicqEnr3kvoMXHVlatssZdKQDiw
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com
Message-ID: <9c4ec9ec-d76a-bcb1-4cc4-94480d88aec2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix AioContext switch for bs->drv ==
 NULL
References: <20190417154850.29110-1-kwolf@redhat.com>
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 10:48 AM, Kevin Wolf wrote:
> Even for block nodes with bs->drv =3D=3D NULL, we can't just ignore a
> bdrv_set_aio_context() call. Leaving the node in its old context can
> mean that it's still in an iothread context in bdrv_close_all() during
> shutdown, resulting in an attempted unlock of the AioContext lock which=

> we don't hold.
>=20

Seems like an "interesting" bug to diagnose. At any rate, getting rid of
the short-circuiting makes sense, and it's nice that you did manage to
come up with a reliable reproducer.

> The reproducer I used is a qcow2 image on gluster volume, where the
> virtual disk size (4 GB) is larger than the gluster volume size (64M),
> so we can easily trigger an ENOSPC. This backend is assigned to a
> virtio-blk device using an iothread, and then from the guest a
> 'dd if=3D/dev/zero of=3D/dev/vda bs=3D1G count=3D1' causes the VM to st=
op
> because of an I/O error. qemu_gluster_co_flush_to_disk() sets
> bs->drv =3D NULL on error, so when virtio-blk stops the dataplane, the
> block nodes stay in the iothread AioContext. A 'quit' monitor command
> issued from this paused state crashes the process.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1631227
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--3Ze7XvoicqEnr3kvoMXHVlatssZdKQDiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3TQIACgkQp6FrSiUn
Q2pLDwf7BXLzr7TU5s7mqWWDeJVr11uYE+OhSFQxGLdWinPUPk5m3Ftz3XQBS5AY
jH57IliIx+w4fyvam5/Ovao4VYtTeCXFWuMWrgnvtc7obHWnKEhH1xlIZfvWYDhV
y0KlNhFyGpssoLhP8ERvqCfk3Duuo4zQCUFnyEmaBdCysvwiSREz8nY6LVL7dvX9
sVIVP/lk1KUJ6scWL3t4ZVWH6BdaAsNnJKwsY1lbiW68YQH6/orH4UwLo/1+qZQX
mmLChjI0ulOVKUS3TbiMBZ85/2fJ7Jr9Q4SC+iiqW3+YBDwWIcddc+RX21H8+WDC
Z3YZd8xIYjU5UCORtpc1nt3OxjZG0Q==
=A9FM
-----END PGP SIGNATURE-----

--3Ze7XvoicqEnr3kvoMXHVlatssZdKQDiw--
