Received: from eggs.gnu.org ([2001:4830:134:3::10]:48554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOi1e-0002vH-Ln
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOi1d-0003dN-Ai
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:15:18 -0400
References: <20180501165750.19242-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6e9ba185-ca93-cfdc-cf7a-518c431ffd91@redhat.com>
Date: Fri, 1 Jun 2018 13:15:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180501165750.19242-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pE3ExPeXjl77vtmszvvjLl9e8jwGbn6xh"
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-img: Special post-backing convert
 handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pE3ExPeXjl77vtmszvvjLl9e8jwGbn6xh
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6e9ba185-ca93-cfdc-cf7a-518c431ffd91@redhat.com>
Subject: Re: [PATCH 0/2] qemu-img: Special post-backing convert handle
References: <20180501165750.19242-1-mreitz@redhat.com>
In-Reply-To: <20180501165750.19242-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-01 18:57, Max Reitz wrote:
> This is the issue:
>=20
> $ qemu-img create -f qcow2 base.qcow2 512M
> Formatting 'base.qcow2', fmt=3Dqcow2 size=3D536870912 cluster_size=3D65=
536 lazy_refcounts=3Doff refcount_bits=3D16
> $ qemu-img create -f qcow2 -b base.qcow2 source.qcow2 1G
> Formatting 'source.qcow2', fmt=3Dqcow2 size=3D1073741824 backing_file=3D=
base.qcow2 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ qemu-img convert -O qcow2 -B base.qcow2 -o compat=3D0.10 \
>     source.qcow2 target.qcow2
> $ qemu-img info target.qcow2
> image: target.qcow2
> file format: qcow2
> virtual size: 1.0G (1073741824 bytes)
> disk size: 512M    <-------------------- this here
> cluster_size: 65536
> backing file: base.qcow2
> Format specific information:
>     compat: 0.10
>     refcount bits: 16
> $ qemu-img map target.qcow2
> Offset          Length          Mapped to       File
> 0x20000000      0x20000000      0x50000         target.qcow2
>=20
> So qemu-img convert sees that source.qcow2 contains only zeroes past th=
e
> end of base.qcow2 -- but that is not the backing file, so it will
> explicitly write zeroes to target.qcow2.  But that file is compat=3D0.1=
0,
> so it does not support efficient zero writes and will actually fill tha=
t
> area with real zeroes.  Hence the mapping, hence the disk size.
>=20
> However, we don't need to write zeroes to an image when it is
> initialized to zeroes -- which the current qemu-img code says doesn't
> happen for target images with backing files.  But it does happen when
> the target backing file is shorter than the target image, then the area=

> past the end of the backing file may indeed read as zeroes and we don't=

> need to write anything there.
>=20
> So the first patch in this series makes qemu-img convert detect that
> case and handle zeroes past the end of the backing file as "fall back t=
o
> the backing file" (because that means zeroes, at least if unallocated
> areas read as zeroes (which I presume they have to for formats
> supporting backing files, but better be safe than sorry)), and the
> second adds an iotest.
>=20
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1527898
>=20
>=20
> Max Reitz (2):
>   qemu-img: Special post-backing convert handling
>   iotests: Test post-backing convert target behavior
>=20
>  qemu-img.c                 | 26 +++++++++++++++++++++++++-
>  tests/qemu-iotests/122     | 42 ++++++++++++++++++++++++++++++++++++++=
++++
>  tests/qemu-iotests/122.out | 18 ++++++++++++++++++
>  3 files changed, 85 insertions(+), 1 deletion(-)

Applied to my block branch.

Max


--pE3ExPeXjl77vtmszvvjLl9e8jwGbn6xh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsRKrgACgkQ9AfbAGHV
z0AyowgAkpuVGchaCWY76ZPlWivSFts40Q6KEbIOlzRZ3vlmpd30b6QrynltQqA0
b3C1j+smZb2jwkZen2iECjpIrGO8cw0fFHHQuIJMDwNEJ+PNe2XzXD4l7JZQ9oyn
Ik1+wanZpTsbavcU2/Nc475ieCTgrtdwampQOxNZN//8GreOxrvSNaJCLW4rxkdu
gd3BwawLnQu+tYJDoOyKsYXkmz7q44K416al+esPLcBo8hoR4Rd0KDpWURx0wdOH
dS4GYTDf9Kulzw07QcrBb9CD2nfus9IVDTb7xEBLWBatvSoPjmUeen5W7kWitUiQ
JoHtPjhfiifrmAdEhKbrqmsHiQSZCQ==
=FkKC
-----END PGP SIGNATURE-----

--pE3ExPeXjl77vtmszvvjLl9e8jwGbn6xh--
