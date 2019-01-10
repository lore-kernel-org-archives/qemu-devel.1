Received: from eggs.gnu.org ([209.51.188.92]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghbdF-0001Nw-My
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghbdE-0000QT-TL
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:48:29 -0500
References: <20190110071330.28136-1-eblake@redhat.com>
	<20190110071330.28136-6-eblake@redhat.com>
	<246062a9-2674-00e7-33ac-709c610efad6@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe413449-64d3-e5e8-919d-7140a6d65c84@redhat.com>
Date: Thu, 10 Jan 2019 08:48:21 -0600
MIME-Version: 1.0
In-Reply-To: <246062a9-2674-00e7-33ac-709c610efad6@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1SaFGQZoEUzxfnPRSShjI3c35mrwoAMqD"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] nbd: Merge nbd_export_bitmap into
 nbd_export_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1SaFGQZoEUzxfnPRSShjI3c35mrwoAMqD
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <fe413449-64d3-e5e8-919d-7140a6d65c84@redhat.com>
Subject: Re: [PATCH v2 5/6] nbd: Merge nbd_export_bitmap into nbd_export_new
References: <20190110071330.28136-1-eblake@redhat.com>
 <20190110071330.28136-6-eblake@redhat.com>
 <246062a9-2674-00e7-33ac-709c610efad6@virtuozzo.com>
In-Reply-To: <246062a9-2674-00e7-33ac-709c610efad6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 6:25 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.01.2019 10:13, Eric Blake wrote:
>> We only have one caller that wants to export a bitmap name,
>> which it does right after creation of the export. But there is
>> still a brief window of time where an NBD client could see the
>> export but not the dirty bitmap, which a robust client would
>> have to interpret as meaning the entire image should be treated
>> as dirty.  Better is to eliminate the window entirely, by
>> inlining nbd_export_bitmap() into nbd_export_new(), and refusing
>> to create the bitmap in the first place if the requested bitmap
>> can't be located.
>>
>> We also no longer need logic for setting a different bitmap
>> name compared to the bitmap being exported.
>>

>> +++ b/blockdev-nbd.c
>> @@ -175,7 +175,7 @@ void qmp_nbd_server_add(const char *device, bool h=
as_name, const char *name,
>>           writable =3D false;
>>       }
>>
>> -    exp =3D nbd_export_new(bs, 0, -1, name, NULL,
>> +    exp =3D nbd_export_new(bs, 0, -1, name, NULL, bitmap,
>=20
> bitmap is guaranteed to be NULL if has_bitmap is false? Or should we do=
 has_bitmap ? bitmap : NULL?

We fixed our QAPI generators to guarantee that has_foo =3D false implies
foo =3D=3D NULL, several years ago.  If you populate a QAPI struct by han=
d
instead of via the generated visitors, you should use g_malloc0() to
match the same guarantees.  So I don't need the ?:.

>=20
> if yes or with fixed:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--1SaFGQZoEUzxfnPRSShjI3c35mrwoAMqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw3WzUACgkQ3g5py3or
ov2wZAf/fCTtrNjz9MVjejmjGn4nyQMmz8Rpi30SXeLDSEDOtpJXAeo032y8B+yI
g9wdBQl96hfdEUKT+3a1XpZJ10xF9Z6ECdPUr+IBFE1MYCTBW8/txPOfSRaz3eOO
LCxWMssmLnG3Btb5rBz5RMcpAwEQY38ZZ9XzJJixCSNN3GgZykCLRJuM5WWL7JNj
Pu0WTYa1R2idD0LtQkusRN6Hj7Syc5BRpzRIsN67rmw+eC4zVZ46j+9cvVJTFsy6
wduiQxFopAieX3xN9IiuMt8T4YCdQqLeBh+Bs4gTtdmyiXGml5ClWD/9he2NhfCK
czy8MVB9PxcSHvEt6ut4eKmLdR6Ynw==
=Dyi/
-----END PGP SIGNATURE-----

--1SaFGQZoEUzxfnPRSShjI3c35mrwoAMqD--
