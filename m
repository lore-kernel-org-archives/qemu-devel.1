Received: from eggs.gnu.org ([209.51.188.92]:46969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grov4-0002Rd-Fz
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grov2-0008EF-E4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:01:06 -0500
References: <20190114162605.5330-1-eblake@redhat.com>
	<20190114162605.5330-20-eblake@redhat.com>
	<CAFEAcA83L0jFLVDK8ebF2pxtAqoM+YsTU2vYUx2y7-PbSuEW9g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60feac5a-d45e-bfd0-b0c8-45e16aa95e6b@redhat.com>
Date: Thu, 7 Feb 2019 13:00:53 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83L0jFLVDK8ebF2pxtAqoM+YsTU2vYUx2y7-PbSuEW9g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="055l6Wi9knkrQwwznhTEY1mGBvAft121N"
Subject: Re: [Qemu-devel] [PULL 19/20] nbd: Merge nbd_export_bitmap into
 nbd_export_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--055l6Wi9knkrQwwznhTEY1mGBvAft121N
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <60feac5a-d45e-bfd0-b0c8-45e16aa95e6b@redhat.com>
Subject: Re: [Qemu-devel] [PULL 19/20] nbd: Merge nbd_export_bitmap into
 nbd_export_new
References: <20190114162605.5330-1-eblake@redhat.com>
 <20190114162605.5330-20-eblake@redhat.com>
 <CAFEAcA83L0jFLVDK8ebF2pxtAqoM+YsTU2vYUx2y7-PbSuEW9g@mail.gmail.com>
In-Reply-To: <CAFEAcA83L0jFLVDK8ebF2pxtAqoM+YsTU2vYUx2y7-PbSuEW9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 12:40 PM, Peter Maydell wrote:

>=20
>>  NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off=
_t size,
>>                            const char *name, const char *description,
>> -                          uint16_t nbdflags, void (*close)(NBDExport =
*),
>> -                          bool writethrough, BlockBackend *on_eject_b=
lk,
>> -                          Error **errp)
>> +                          const char *bitmap, uint16_t nbdflags,
>> +                          void (*close)(NBDExport *), bool writethrou=
gh,
>> +                          BlockBackend *on_eject_blk, Error **errp)
>>  {
>>      AioContext *ctx;
>>      BlockBackend *blk;
>> @@ -1507,6 +1507,43 @@ NBDExport *nbd_export_new(BlockDriverState *bs,=
 off_t dev_offset, off_t size,
>>      }
>>      exp->size -=3D exp->size % BDRV_SECTOR_SIZE;
>>
>> +    if (bitmap) {
>> +        BdrvDirtyBitmap *bm =3D NULL;
>> +        BlockDriverState *bs =3D blk_bs(blk);
>=20
> lgtm.com points out that this local variable 'bs' shadows
> the 'bs' argument to the function. Is this intentional?

No, I will fix.

> I think that the two can't ever be different, in which case
> you could just delete the variable declaration here, but
> I'm not an expert on the block layer APIs.

Yes, that looks right to me as well, since we just barely called
blk_insert_bs(blk, bs, errp) a few lines above.  (Someday, it would be
nice to turn -Wshadow on, to catch stuff like this sooner)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--055l6Wi9knkrQwwznhTEY1mGBvAft121N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcgGUACgkQp6FrSiUn
Q2o2twf/UoIEiMSsnW4SW5MFDasc09HQSIzwjNM9RASFbJ280bGN3nwtA5io97Ac
Vw+b8jIthnKZSzvE0po+b7ZzqPLDNAQB3VSiOghJ0BYRsvNuoSisT0ov3eX57A6S
aBTlpWyDowI8BKlRpOc4Hsi+sPlr7tgwKHX9E+fshUkgrGWTk+BZW5AqWslLY3gt
YW5qlQ/kCas0osydy1oCP7zmbhudpZLe/WiSsPCo2xr+eSSwbBGn4yL8Afuu9Nps
0TAJkNie71zOW8bx2rBQ4v+faOrpufXLiId2BgSHhc1LZcvK220VamspmudKLkzV
wHyU9/CyijSN69G8dhAaHbn6Q7CC7w==
=J8xe
-----END PGP SIGNATURE-----

--055l6Wi9knkrQwwznhTEY1mGBvAft121N--
