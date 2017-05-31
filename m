Received: from eggs.gnu.org ([2001:4830:134:3::10]:48512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG2Uu-0002EW-DY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG2Ut-0002F8-DY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:13:08 -0400
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-5-mreitz@redhat.com>
	<0f959146-af02-f219-8a48-3562b26b0493@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <39a66d27-7a79-a65b-4f49-8a9eaf042565@redhat.com>
Date: Wed, 31 May 2017 14:12:53 +0200
MIME-Version: 1.0
In-Reply-To: <0f959146-af02-f219-8a48-3562b26b0493@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wNBbiBCOiQJBwmJoJVX5uTxPPRupPFiMw"
Subject: Re: [Qemu-devel] [PATCH v3 04/16] qemu-img: Expose PreallocMode for
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wNBbiBCOiQJBwmJoJVX5uTxPPRupPFiMw
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <39a66d27-7a79-a65b-4f49-8a9eaf042565@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/16] qemu-img: Expose PreallocMode for
 resizing
References: <20170526165518.7580-1-mreitz@redhat.com>
 <20170526165518.7580-5-mreitz@redhat.com>
 <0f959146-af02-f219-8a48-3562b26b0493@redhat.com>
In-Reply-To: <0f959146-af02-f219-8a48-3562b26b0493@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-30 22:57, Eric Blake wrote:
> On 05/26/2017 11:55 AM, Max Reitz wrote:
>> Add a --preallocation command line option to qemu-img resize which can=

>> be used to set the PreallocMode parameter of blk_truncate().
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qemu-img.c    | 33 ++++++++++++++++++++++++++++++---
>>  qemu-img.texi |  7 ++++++-
>>  2 files changed, 36 insertions(+), 4 deletions(-)
>=20
>> @@ -3553,8 +3566,16 @@ static int img_resize(int argc, char **argv)
>>          goto out;
>>      }
>> =20
>> +    current_size =3D blk_getlength(blk);
>> +    if (current_size < 0) {
>> +        error_report("Failed to inquire current image length: %s",
>> +                     strerror(-current_size));
>> +        ret =3D -1;
>> +        goto out;
>> +    }
>> +
>>      if (relative) {
>> -        total_size =3D blk_getlength(blk) + n * relative;
>> +        total_size =3D current_size + n * relative;
>=20
> You snuck in a bug fix here (reporting failure, rather than using a
> bogus total_size, if querying the size fails).  Please mention that in
> the commit message.
>=20
>> @@ -541,6 +541,11 @@ After using this command to grow a disk image, yo=
u must use file system and
>>  partitioning tools inside the VM to actually begin using the new spac=
e on the
>>  device.
>> =20
>> +When growing an image, the @code{--preallocation} option may be used =
to specify
>> +how the additional image area should be allocated on the host.  See t=
he format
>> +description in the @code{NOTES} section which values are allowed.  Us=
ing this
>> +option may result in more data being allocated than necessary.
>=20
> Should we tone it down a bit by saying 'slightly more data'?  (We'd
> rather over-estimate than fall short, but our over-estimation will
> probably be < 1% off, and not something drastic like an order of
> magnitude off).

I wanted to be on the safe side for future updates for other formats
(where I'm not sure how well we can do this).

I somehow have the feeling that XFS preallocation may play its game,
too, although I can't seem to trigger it...

Anyway, as long as we can justify, say, ~10 % as "slightly", I'm OK with
adding it.

> With the improved commit message,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Will do, and as always: Thanks!

Max


--wNBbiBCOiQJBwmJoJVX5uTxPPRupPFiMw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLrNGEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKDm
B/sE5bcIkS+RzV0Qd1SK69d7I+X/htNaWIAnGmq6DwHuoIDQyKkSqXsuS4VjjoDK
GJXE9zFw+eNwUr8e3VuYM0HYAzCY888O41dnhHY2Lzqi4jT2QjvHcoRuwlKYUlSp
IlFhpje4w7DLPUfoHrT98RO4+0Sgqqy07KidquUeCwYGGG5lfQY1a39s5gCHaHXc
wEbLKfrTk7RFjMHCXokZ3vD4VLkfUEOwgSePGYQ3vu6vj9vHQLauKKQjY3Ja/EGN
/TJ3G1xPBdotse8bFyvHZHM6WBdFyYKpxso6uUB6a+ZyZ9BaUZUJ5ROxL7emT1tc
Fx9NTaOGpmxO5v2PQyciWDje
=lVt2
-----END PGP SIGNATURE-----

--wNBbiBCOiQJBwmJoJVX5uTxPPRupPFiMw--
