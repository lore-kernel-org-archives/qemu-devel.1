Received: from eggs.gnu.org ([2001:4830:134:3::10]:40878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyg5W-0001ge-4Z
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyg5U-0006Li-Rz
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cyg5U-0006L2-Iv
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:51:08 -0400
Date: Thu, 13 Apr 2017 15:51:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170413145103.GF13387@stefanha-x1.localdomain>
References: <20170412135312.1686-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
In-Reply-To: <20170412135312.1686-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] migration: fix virtio-rng
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2017 at 03:53:10PM +0200, Laurent Vivier wrote:
> When post-copy migration is enabled, the destination
> guest can ask for memory from the source when the
> vmstate is restored.
>=20
> In the case of virtio, a part of the virtqueue
> is migrated by the vmstate structure (last_avail_idx)
> another part is migrated inside the RAM (used_idx).
> On the source side, the virtqueue can be modified
> whereas the vmstate is already migrated, and the destination
> side can ask for the value in RAM. In this case we have
> an inconsistency that can generate this kind of error:
>     "VQ 0 size 0x8 < last_avail_idx 0xa - used_idx 0"
> in hw/virtio/virtio.c:2180, virtio_load().
>=20
> This happens with virtio-rng as the chr_read()
> function which modifies the virqueue is called
> by the rng backend and the rng backend continues to
> run while the migration is running and the CPU is stopped.
>=20
> This series fixes this problem by ignoring chr_read()
> calls while the CPU is stopped. The first patch of the
> series fixes another problem triggered by this error
> case: a use-after-free case.
>=20
> The probability to have this problem is very low, as
> generally the post-copy phase is very short, so the window
> to modify the virtqueue while the vmstate has been sent
> is very small... except if you are doing trans-continental
> guest migration with high latency and post-copy phase that
> can be run for minutes.
>=20
> I've been able to reproduce the problem locally on a host,
> by adding network latency with "tc". Another condition is
> to have an rng daemon running in the guest to generate
> events in the virtio-rng device.
>=20
> v2:
> - add a vm state change handler to restart the virtio-rng
>   process when the CPU restarts (it also replaces
>   the post_load function).
>=20
> Laurent Vivier (2):
>   migration: don't close a file descriptor while it can be in use
>   virtio-rng: stop virtqueue while the CPU is stopped
>=20
>  hw/virtio/trace-events         |  3 +++
>  hw/virtio/virtio-rng.c         | 29 +++++++++++++++++++++++------
>  include/hw/virtio/virtio-rng.h |  2 ++
>  migration/migration.c          |  6 +++---
>  4 files changed, 31 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.9.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY75BXAAoJEJykq7OBq3PIUhAIAJ03BBw2j7v501kbB2oOYCZ2
IhQkbpJtXxVH0c959HegHNfFXnGIEmNhL/kpJluRI5YHrmmayyrALh6wI7wE6tTw
mzQgP7Qnlj1nXdahM/fTwY/iMfHpmaGUvN4sc/MbW3B0fxcKQMaY4jLpjZ7jTRSK
U8kdO1MzSUU6Beu0rHmH80QHQpSHXwQtBBbbKhRgeCAlfoLiH4oi0jx1YQNXkliZ
zZmPw8WTS/WF2Ew4k8qG1hEn4f2lIYakmK26/cLJSDn0kIYXqJDGZCl44KCcjUu2
Allx90lXaax9Pk+elmSTL/LeFvIovtouUMieBJPJbh1KTJYpb66FxuaYplAcsUs=
=Q+rE
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
