Received: from eggs.gnu.org ([2001:4830:134:3::10]:57210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSjeW-0007jN-Ez
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSjeV-0006LF-HB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:43:32 -0400
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
	<20170704084059.6278-2-el13635@mail.ntua.gr>
	<20170704094417.GA4253@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d04ba821-25a5-8cc8-9645-af667cf59dc3@redhat.com>
Date: Wed, 5 Jul 2017 07:43:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170704094417.GA4253@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KaxJAvcD51unSJbhG0lfa8QMXSQ4otiwW"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] block: Pass bdrv_* methods to
 bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KaxJAvcD51unSJbhG0lfa8QMXSQ4otiwW
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <d04ba821-25a5-8cc8-9645-af667cf59dc3@redhat.com>
Subject: Re: [PATCH v3 1/4] block: Pass bdrv_* methods to bs->file by default
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
 <20170704084059.6278-2-el13635@mail.ntua.gr>
 <20170704094417.GA4253@noname.str.redhat.com>
In-Reply-To: <20170704094417.GA4253@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 04:44 AM, Kevin Wolf wrote:
> Am 04.07.2017 um 10:40 hat Manos Pitsidianakis geschrieben:
>> The following functions fail if bs->drv does not implement them:
>>

>> @@ -511,6 +513,8 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGe=
ometry *geo)
>> =20
>>      if (drv && drv->bdrv_probe_geometry) {
>>          return drv->bdrv_probe_geometry(bs, geo);
>> +    } else if (drv && bs->file && bs->file->bs) {
>> +        return bdrv_probe_geometry(bs->file->bs, geo);
>>      }
>> =20
>>      return -ENOTSUP;
>=20
> The probed geometry would refer to the physical image file, not to the
> actually presented image. So propagating this to bs->file is wrong for
> image formats.
>=20
> Possibly checking .is_filter in addition would be enough.

In fact, this made me think: if we define .is_filter as an enum instead
of a bool, we could implement 0 for no filter, 1 for file filter, and 2
for backing filter.  Then instead of having to have 2 separate default
bdrv_get_block_status_for_*() generic functions in patch 4, we could
instead patch bdrv_co_get_block_status() to check .is_filter, and
automatically fall back to bs->file or bs->backing according to the enum
value stored in .is_filter.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KaxJAvcD51unSJbhG0lfa8QMXSQ4otiwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXN7pAAoJEKeha0olJ0Nq7RIH/2APlBb+J3Kj+yKPCUQgQ+/B
TlGWzpPbPNWS0OQjFUr+vZTA80rX1hjZ1pgXVqpG1W3DURzHF0i2vVyCmJvguzr5
VHmvbA4C1HU2w21162OVt2htCLTtNWpq0TT63w0A3y2aXabfME3Pi9dJv+8ZLWts
F6uIjn9E12hG/XZ60vXJ7iNOZpVxbC+QeesM00u3ZtpZP5xSaePw4y5RPuU6/KQD
0wkYcHM5astD+vKEsee9C3q2g3Jpvptm4KDl3n/wm+3zG5NK/SG9uFLT5+6AfVO7
5SHbh4BTJpvXUP92YplrCGaKyujH8cnZPEQavZTmHUVXJuEOTz28bSc+lT9y1YQ=
=QLfI
-----END PGP SIGNATURE-----

--KaxJAvcD51unSJbhG0lfa8QMXSQ4otiwW--
