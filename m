Received: from eggs.gnu.org ([2001:4830:134:3::10]:46417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqJyZ-0001AG-Nl
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqJyV-00027o-8G
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:09:43 -0400
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-17-eblake@redhat.com>
	<20170908132741.GJ3283@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e1edd8f-dcfa-561e-a5e1-99ef89b1ec81@redhat.com>
Date: Fri, 8 Sep 2017 09:09:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170908132741.GJ3283@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kKmBgP08dlBwqnI2oXeQTNGtfFdameNjB"
Subject: Re: [Qemu-devel] [PATCH v6 16/18] qcow2: Switch store_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kKmBgP08dlBwqnI2oXeQTNGtfFdameNjB
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <3e1edd8f-dcfa-561e-a5e1-99ef89b1ec81@redhat.com>
Subject: Re: [PATCH v6 16/18] qcow2: Switch store_bitmap_data() to byte-based
 iteration
References: <20170830210542.2153-1-eblake@redhat.com>
 <20170830210542.2153-17-eblake@redhat.com>
 <20170908132741.GJ3283@localhost.localdomain>
In-Reply-To: <20170908132741.GJ3283@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2017 08:27 AM, Kevin Wolf wrote:
> Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
>> Now that we have adjusted the majority of the calls this function
>> makes to be byte-based, it is easier to read the code if it makes
>> passes over the image using bytes rather than sectors.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>

>>
>> -    while ((sector =3D bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS)=
 !=3D -1) {
>> -        uint64_t cluster =3D sector / sbc;
>> +    while ((offset =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
>=20
> Don't you have to multiply both sides of the equation? This would be
> offset !=3D -512, which points out that the previous patch to convert
> bdrv_dirty_iter_next() to byte-based gave it a really awkward interface=
=2E

I think what I really need to do is change '!=3D -1' to '< 0', as that's
much easier to reason about when scaling is present.

>=20
>> +        uint64_t cluster =3D offset / limit;
>>          uint64_t end, write_size;
>>          int64_t off;
>>
>> -        sector =3D cluster * sbc;
>> -        end =3D MIN(bm_sectors, sector + sbc);
>> -        write_size =3D bdrv_dirty_bitmap_serialization_size(bitmap,
>> -            sector * BDRV_SECTOR_SIZE, (end - sector) * BDRV_SECTOR_S=
IZE);
>> +        offset =3D cluster * limit;
>=20
> You just had cluster =3D offset / limit, so in other words, align down
> offset? If so, this is how it should be written.

Thanks for the close reviews; looks like I have enough things to do a
respin.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kKmBgP08dlBwqnI2oXeQTNGtfFdameNjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmypJQACgkQp6FrSiUn
Q2oS4ggArTVjAg6QRtgUGxxfhHQWS+luIIKk906MgPcWUYKbWQmp6+3p5IICDL+x
B6HlSk2LQyaWe8R/FMQW/7uPIkMyPurwc+XyTes0ILwevITQkqmFMypEsCHUn1Jd
6ilnhcBwmdF4/kbZaNGQH6OHcluNzQ1oajDKaSrH8Dl7RW0Ppn4LiHNJQ6FxKaea
0K5hfnVlYP1rsRzZoZ0oJl8JqnXBISruOIALYmVhkieRA0+J+qWBDkzFJHnkswN1
mwf4ffLLKxXAw4tENKq2SIZZYfJJB0jPL6yy3kaxEww+LzeUd8U0DzrEzySdf4+o
sAziSLbqT+JAW4VpPzR00WRGa5AdjQ==
=ms8j
-----END PGP SIGNATURE-----

--kKmBgP08dlBwqnI2oXeQTNGtfFdameNjB--
