Received: from eggs.gnu.org ([2001:4830:134:3::10]:45110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Zpz-0008Mq-F0
	for qemu-devel@nongnu.org; Wed, 10 May 2017 18:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8Zpy-0004g2-A7
	for qemu-devel@nongnu.org; Wed, 10 May 2017 18:12:03 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-18-eblake@redhat.com>
	<ada8b8e3-aa6e-b06a-d2bf-6f7e994f0e7d@redhat.com>
	<1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58112f40-ab0d-7545-d7aa-27377ea0aafa@redhat.com>
Date: Wed, 10 May 2017 17:11:47 -0500
MIME-Version: 1.0
In-Reply-To: <1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5uGeG897jD0DbN4plSi0QN0bHOqBqMSgN"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 17/17] block: Make
 bdrv_is_allocated_above() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Fam Zheng <famz@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5uGeG897jD0DbN4plSi0QN0bHOqBqMSgN
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Changlong Xie <xiecl.fnst@cn.fujitsu.com>,
 Fam Zheng <famz@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <58112f40-ab0d-7545-d7aa-27377ea0aafa@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 17/17] block: Make
 bdrv_is_allocated_above() byte-based
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-18-eblake@redhat.com>
 <ada8b8e3-aa6e-b06a-d2bf-6f7e994f0e7d@redhat.com>
 <1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
In-Reply-To: <1bdb54f9-87d4-74a8-e097-c0918dc53fd9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2017 08:48 PM, Eric Blake wrote:

>>
>>
>>> -            n =3D psectors_inter;
>>> +             offset + pnum_inter < (intermediate->total_sectors *
>>> +                                    BDRV_SECTOR_SIZE))) {
>>
>> Naive question: not worth using either bdrv_getlength for bytes, or th=
e
>> bdrv_nb_sectors helpers?
>=20
> bdrv_getlength(intermediate) should indeed be the same as
> intermediate->total_sectors * BDRV_SECTOR_SIZE (for now - ultimately it=

> would be nice to track a byte length rather than a sector length for
> images). I can make that cleanup for v2.

This one's tricky.  Calling bdrv_nb_sectors()/bdrv_getlength() (the two
are identical other than scale) guarantees that you have a sane answer
for a variably-sized BDS, but can fail with -ENOMEDIUM.  Which, given
the position in the 'if' clause, makes it a difficult rewrite to
properly catch.  On the other hand, since we just barely called
bdrv_is_allocated(intermediate), which in turn called
bdrv_co_get_block_status(), and that calls bdrv_nb_sectors(), we are
assured that intermediate->total_sectors has not changed in the meantime.=


So my options are to either add a big comment stating why we are safe,
or to use bdrv_getlength() anyways but with proper error checking.  Best
done as a separate patch from the conversion in scale; so I'll do that
for v2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5uGeG897jD0DbN4plSi0QN0bHOqBqMSgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE5AjAAoJEKeha0olJ0NqlSAH/3DtZs/D1P9HZ7BaSrV1BatA
UNbX/omo3njyl9JrK/ClT1osM7KMdYemOQSGpKXPDsPWGxKQoG/gX8N4OuAsdScY
3227NRQcypmJfcD6GOHHbe3zjZfmuFrnsxLg5odmD3ezORmQX96+VZlZrz4MvyJ9
Vy1kCfX7C2lSQPpGxovhwtgbi8dHrIZLs5QSmV4etYntHVOyUP6A+9Y29o+UmeZo
vGpuZFufZSNb25ndBM/cPyevhnt2xJbcPDmVe4r7MnYx5PrQuJNwXyGtpm3uPNKE
LOGchibyiuME0f2m+firpPPVojZ/WsRQIhahTRTTbuSjrBJWG900ZDpCn4wqThM=
=QOPY
-----END PGP SIGNATURE-----

--5uGeG897jD0DbN4plSi0QN0bHOqBqMSgN--
