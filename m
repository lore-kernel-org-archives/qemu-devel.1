Received: from eggs.gnu.org ([209.51.188.92]:56694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjpjz-0002dK-7B
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjpXg-0000I5-RT
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:03:57 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-5-eblake@redhat.com>
	<3342cf43-21ba-60aa-4ca2-ed0e5b0ea4ae@virtuozzo.com>
	<8312fb33-1724-d0b0-c5af-763963250ced@redhat.com>
	<cc3a5366-cc5c-8aa0-2a9a-12d82e39e29b@virtuozzo.com>
	<c05f5620-1cc5-8d4d-a62e-3b56af45e9b1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6364da7d-2194-ee43-be66-4ff4eadddfe9@redhat.com>
Date: Wed, 16 Jan 2019 12:03:49 -0600
MIME-Version: 1.0
In-Reply-To: <c05f5620-1cc5-8d4d-a62e-3b56af45e9b1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="z1FTGf9eWh2fCabdejV80gHygmZgZfkFl"
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
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "rjones@redhat.com" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z1FTGf9eWh2fCabdejV80gHygmZgZfkFl
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "rjones@redhat.com" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Message-ID: <6364da7d-2194-ee43-be66-4ff4eadddfe9@redhat.com>
Subject: Re: [PATCH v3 04/19] nbd/server: Hoist length check to
 qemp_nbd_server_add
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-5-eblake@redhat.com>
 <3342cf43-21ba-60aa-4ca2-ed0e5b0ea4ae@virtuozzo.com>
 <8312fb33-1724-d0b0-c5af-763963250ced@redhat.com>
 <cc3a5366-cc5c-8aa0-2a9a-12d82e39e29b@virtuozzo.com>
 <c05f5620-1cc5-8d4d-a62e-3b56af45e9b1@redhat.com>
In-Reply-To: <c05f5620-1cc5-8d4d-a62e-3b56af45e9b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 10:58 AM, Eric Blake wrote:
> On 1/15/19 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
>>>> @size is not size of the image, but size of the export, so it may be=
 less than dev_offset
>>>> (qemu-nbd.c do "fd_size -=3D dev_offset" before "nbd_export_new(bs, =
dev_offset, fd_size, "
>>>
>>> But the assert is fine because patch 3/19 fixed qemu-nbd.c to never p=
ass
>>> in dev_offset larger than size (it fails up front if dev_offset is ou=
t
>>> of bounds, whether from the -o command line option or from what it re=
ad
>>> from the partition header with the -P command line option).
>>>
>>
>> Don't follow =3D(
>>
>> Assume, image size 3M, and we have offset 2M, i.e. -o 2M.
>>
>> than in qemu-nbd.c, we have
>>
>> fd_size =3D blk_getlength(blk); # 3M
>> ...
>> fd_size -=3D dev_offset; # 1M
>> ...
>> export =3D nbd_export_new(bs, dev_offset, fd_size # bs, 2M, 1M
>>
>> in nbd_export_new:
>>
>> assert(dev_offset <=3D size); # 2M <=3D 1M
>>
>> fail.
>=20
> Ouch, you are right. I don't need the assertion in server.c at all;
> because all callers pass in a validated size, but the validated size ha=
s
> no comparable relation to dev_offset.

Here's what I'm considering using instead, merely asserting that the
inputs are non-negative and do not overflow 63 bits:

diff --git i/nbd/server.c w/nbd/server.c
index c9937ccdc2a..3ebcbddaa2c 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -1495,11 +1495,12 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
off_t dev_offset, off_t size,
     exp->refcount =3D 1;
     QTAILQ_INIT(&exp->clients);
     exp->blk =3D blk;
+    assert(dev_offset >=3D 0 && dev_offset <=3D INT64_MAX);
     exp->dev_offset =3D dev_offset;
     exp->name =3D g_strdup(name);
     exp->description =3D g_strdup(description);
     exp->nbdflags =3D nbdflags;
-    assert(dev_offset <=3D size);
+    assert(size >=3D 0 && size <=3D INT64_MAX - dev_offset);
     exp->size =3D QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);

     if (bitmap) {


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--z1FTGf9eWh2fCabdejV80gHygmZgZfkFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/cgUACgkQp6FrSiUn
Q2qoNQf9H4IAJ+wUofodqpoL9zhsDsayAFLjB5KCD14KvTvZrw1ERk43QbuVeGMh
0GM6yuGGNh48xSGEN0wtMUDLSCrudLXwraPRxF2OXok7E/WPlnemanPRo3gU8Ll2
THU6aZ87RvzOxDMOydXI7+c/TRSR2FHweT8LEMi1MCzW9OIkG8RQLiY9LtpJtwyE
iLPmf6Qjc0bvYRhP54As7Ma4q/BzD6lkVP9cgIUTYJPRT4CeNXIx20tcgOKLNo4O
Du+cxmsaR/FWe+H0OjHpDD0J5xgTKpi2TDXK/KScXF6ECF2KW/xR77LTdFNuu8gs
d500KDdl3ma4YoLf1Ce+2dsOcdQ6+w==
=qZKM
-----END PGP SIGNATURE-----

--z1FTGf9eWh2fCabdejV80gHygmZgZfkFl--
