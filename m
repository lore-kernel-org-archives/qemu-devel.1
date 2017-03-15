Received: from eggs.gnu.org ([2001:4830:134:3::10]:34634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coIam-0008VU-Al
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 19:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coIal-0000KM-Et
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 19:44:32 -0400
References: <20170314111157.14464-2-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <79fadf20-791f-e30b-36e0-e5151a92a42f@redhat.com>
Date: Thu, 16 Mar 2017 00:44:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170314111157.14464-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3QQARU7TK4TmWqIJTD1pjlETkIoa2kONX"
Subject: Re: [Qemu-devel] [PATCH] block: quiesce AioContext when detaching
 from it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3QQARU7TK4TmWqIJTD1pjlETkIoa2kONX
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-block@nongnu.org
Message-ID: <79fadf20-791f-e30b-36e0-e5151a92a42f@redhat.com>
Subject: Re: [PATCH] block: quiesce AioContext when detaching from it
References: <20170314111157.14464-2-pbonzini@redhat.com>
In-Reply-To: <20170314111157.14464-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 14.03.2017 12:11, Paolo Bonzini wrote:
> While it is true that bdrv_set_aio_context only works on a single
> BlockDriverState subtree (see commit message for 53ec73e, "block: Use
> bdrv_drain to replace uncessary bdrv_drain_all", 2015-07-07), it works
> at the AioContext level rather than the BlockDriverState level.
>=20
> Therefore, it is also necessary to trigger pending bottom halves too,
> even if no requests are pending.
>=20
> For NBD this ensures that the aio_co_schedule of a previous call to
> nbd_attach_aio_context is completed before detaching from the old
> AioContext; it fixes qemu-iotest 094.  Another similar bug happens
> when the VM is stopped and the virtio-blk dataplane irqfd is torn down.=

> In this case it's possible that guest I/O gets stuck if notify_guest_bh=

> was scheduled but doesn't run.
>=20
> Calling aio_poll from another AioContext is safe if non-blocking; races=

> such as the one mentioned in the commit message for c9d1a56 ("block:
> only call aio_poll on the current thread's AioContext", 2016-10-28)
> are a concern for blocking calls.
>=20
> I considered other options, including:
>=20
> - moving the bs->wakeup mechanism to AioContext, and letting the caller=

> check.  This might work for virtio which has a clear place to wakeup
> (notify_place_bh) and check the condition (virtio_blk_data_plane_stop).=

> For aio_co_schedule I couldn't find a clear place to check the conditio=
n.
>=20
> - adding a dummy oneshot bottom half and waiting for it to trigger.
> This has the complication that bottom half list is LIFO for historical
> reasons.  There were performance issues caused by bottom half ordering
> in the past, so I decided against it for 2.9.
>=20
> Fixes: 99723548561978da8ef44cf804fb7912698f5d88
> Reported-by: Max Reitz <mreitz@redhat.com>
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Tested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--3QQARU7TK4TmWqIJTD1pjlETkIoa2kONX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljJ0dASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXL4H/0ODHxC4iWUacgZ/t6Wy4P4IIQXcO5t3
zEE5RuSv/XO15l1tguWySEwfJV1a/C6mJ3atJtx+gWvqIIN/v1XLBc9KYmVhd8GL
lMTMhaNV01+PF3Nua+jDYCeaONpkHhbrHMx59M17GMeNXVc6vYP8fgG8SBPHslsS
z0d7jLDyaULBkex+ZAq0lSgD9oB7oaDfov/18uoGyGdQc8el8PqmofT4evU66Whq
OEg6BIyAcq6SI/RsjxZzqCDgXtXK/3NXGYSsutDBZqDne0pQsgvEinM4lbdzZ+Yh
rC9rI1t9D5nK42Q4PHY23E0miY03KbYmqbU3US5oxfgnlQThicCKcyg=
=19g1
-----END PGP SIGNATURE-----

--3QQARU7TK4TmWqIJTD1pjlETkIoa2kONX--
