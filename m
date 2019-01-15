Received: from eggs.gnu.org ([209.51.188.92]:49427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjS36-0004WN-Ih
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjS35-0007XK-9m
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:58:48 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-5-eblake@redhat.com>
	<3342cf43-21ba-60aa-4ca2-ed0e5b0ea4ae@virtuozzo.com>
	<8312fb33-1724-d0b0-c5af-763963250ced@redhat.com>
	<cc3a5366-cc5c-8aa0-2a9a-12d82e39e29b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c05f5620-1cc5-8d4d-a62e-3b56af45e9b1@redhat.com>
Date: Tue, 15 Jan 2019 10:58:24 -0600
MIME-Version: 1.0
In-Reply-To: <cc3a5366-cc5c-8aa0-2a9a-12d82e39e29b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t71wCSqDiX5lkOZesh1uThf3YDNUaWkfI"
Subject: Re: [Qemu-devel] [PATCH v3 04/19] nbd/server: Hoist length check to
 qemp_nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t71wCSqDiX5lkOZesh1uThf3YDNUaWkfI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <c05f5620-1cc5-8d4d-a62e-3b56af45e9b1@redhat.com>
Subject: Re: [PATCH v3 04/19] nbd/server: Hoist length check to
 qemp_nbd_server_add
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-5-eblake@redhat.com>
 <3342cf43-21ba-60aa-4ca2-ed0e5b0ea4ae@virtuozzo.com>
 <8312fb33-1724-d0b0-c5af-763963250ced@redhat.com>
 <cc3a5366-cc5c-8aa0-2a9a-12d82e39e29b@virtuozzo.com>
In-Reply-To: <cc3a5366-cc5c-8aa0-2a9a-12d82e39e29b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> @size is not size of the image, but size of the export, so it may be =
less than dev_offset
>>> (qemu-nbd.c do "fd_size -=3D dev_offset" before "nbd_export_new(bs, d=
ev_offset, fd_size, "
>>
>> But the assert is fine because patch 3/19 fixed qemu-nbd.c to never pa=
ss
>> in dev_offset larger than size (it fails up front if dev_offset is out=

>> of bounds, whether from the -o command line option or from what it rea=
d
>> from the partition header with the -P command line option).
>>
>=20
> Don't follow =3D(
>=20
> Assume, image size 3M, and we have offset 2M, i.e. -o 2M.
>=20
> than in qemu-nbd.c, we have
>=20
> fd_size =3D blk_getlength(blk); # 3M
> ...
> fd_size -=3D dev_offset; # 1M
> ...
> export =3D nbd_export_new(bs, dev_offset, fd_size # bs, 2M, 1M
>=20
> in nbd_export_new:
>=20
> assert(dev_offset <=3D size); # 2M <=3D 1M
>=20
> fail.

Ouch, you are right. I don't need the assertion in server.c at all;
because all callers pass in a validated size, but the validated size has
no comparable relation to dev_offset.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--t71wCSqDiX5lkOZesh1uThf3YDNUaWkfI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+ETEACgkQp6FrSiUn
Q2qSQAf/YCkAwaJrqapfLgr6Go6Q4rmcdLhgghw4/ogD4KO63hIoaS2yKX6Q6IcD
kMAUP8pFOoyqu7pjPyvtN521gzwYcS247xJe5qkETNWpTZNI+DvL0G0IJbV4ea5g
w+XQIWx/WkWOe+eEpv63pD2wisOwI2ICn6RMfMx+87NQtxIjqEqd3Wm8Q2k9axZm
OtY6FLVepHteWVtHU9QDnKBzKxyKSzebuYA7wTDgF3bA2AzGDIgqkYS6cW4bLVyn
r2S57ekqT7eZ5plreMxXVPFA9V1wsnM1WBq/wptRlX3qI6oh4LqlXRSpvXjl8ogP
ThmDXQCiKVHH/rm1su/mnPRup5tLsw==
=w7s3
-----END PGP SIGNATURE-----

--t71wCSqDiX5lkOZesh1uThf3YDNUaWkfI--
