Received: from eggs.gnu.org ([2001:4830:134:3::10]:53503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5zYe-00056W-1A
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5zYc-0003tj-TR
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:03:28 -0400
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-8-eblake@redhat.com>
	<106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79b8213b-2664-5c2f-5fc8-654c67f4d0bb@redhat.com>
Date: Wed, 3 May 2017 14:03:16 -0500
MIME-Version: 1.0
In-Reply-To: <106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mjk6mobg21pu04Vup8xqXl5wC6dN2HqAM"
Subject: Re: [Qemu-devel] [PATCH v11 7/9] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mjk6mobg21pu04Vup8xqXl5wC6dN2HqAM
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <79b8213b-2664-5c2f-5fc8-654c67f4d0bb@redhat.com>
Subject: Re: [PATCH v11 7/9] blkdebug: Simplify override logic
References: <20170429191419.30051-1-eblake@redhat.com>
 <20170429191419.30051-8-eblake@redhat.com>
 <106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
In-Reply-To: <106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 01:59 PM, Max Reitz wrote:
> On 29.04.2017 21:14, Eric Blake wrote:
>> Rather than store into a local variable, then copy to the struct
>> if the value is valid, then reporting errors otherwise, it is
>> simpler to just store into the struct and report errors if the
>> value is invalid.  This however requires that the struct store
>> a 64-bit number, rather than a narrower type.  Likewise, setting
>> a sane errno value in ret prior to the sequence of parsing and
>> jumping to out: on error makes it easier for the next patch to
>> add a chain of similar checks.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---

>> @@ -387,20 +386,17 @@ static int blkdebug_open(BlockDriverState *bs, Q=
Dict *options, int flags,
>>          bs->file->bs->supported_write_flags;
>>      bs->supported_zero_flags =3D (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) =
&
>>          bs->file->bs->supported_zero_flags;
>> +    ret =3D -EINVAL;
>>
>>      /* Set request alignment */
>> -    align =3D qemu_opt_get_size(opts, "align", 0);
>> -    if (align < INT_MAX && is_power_of_2(align)) {
>> -        s->align =3D align;
>> -    } else if (align) {
>> -        error_setg(errp, "Invalid alignment");
>> -        ret =3D -EINVAL;
>> +    s->align =3D qemu_opt_get_size(opts, "align", 0);
>> +    if (s->align && (s->align >=3D INT_MAX || !is_power_of_2(s->align=
))) {
>> +        error_setg(errp, "Cannot meet constraints with align %" PRIu6=
4,
>> +                   s->align);
>=20
> Why don't you just keep the ret =3D -EINVAL here and not add it above?
> It's not wrong, I just think it makes the code a bit weird to read.

Because the next patch would then have to add a 'ret =3D -EINVAL;' prior
to ever other added 'goto out;'.  It's easier to prep ret once, have a
bunch of intermediate gotos, and then have the final...

>=20
> Max
>=20
>>          goto out;
>>      }
>>
>>      ret =3D 0;
>> -    goto out;
>> -
>>  out:

=2E..'ret =3D 0' reachable only on success, but it takes repeating the
pattern in the next patch to see that.

>>      if (ret < 0) {
>>          g_free(s->config_file);
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mjk6mobg21pu04Vup8xqXl5wC6dN2HqAM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCil0AAoJEKeha0olJ0NqXdEH/AkJuK+rCDtQsd7NMT9c3FFR
SX3Xluc0+49sGOb1wFOSbzEtf4QAAJ5c17l/VlQLOZ1OwE3m4GKPqFwDcm0ql5uj
2vZTzOwTv5m2Zr1SZqJOOi6c8JE9bHPk1s8nvySLrTe8YoWQIaI3qxhTxV6/UmW3
mRlFVUY4MQ5rDvtJJ5APBh0F9LUsqZ/m8UQfW7CkTNxleHJwxg1kvKUjAeEEo5dR
0uxEjOsYQC7GLfqy2lPHwUY7K33BI4kiSKiCjHqVonJq96Z+aq4TCX4fqHK/WLY5
DInIdzpKMZW5uygphu+1Hpi5evEG4dG21d34XOJr3k1nvtyuwZYPcy3bD/u8zKQ=
=SQGc
-----END PGP SIGNATURE-----

--mjk6mobg21pu04Vup8xqXl5wC6dN2HqAM--
