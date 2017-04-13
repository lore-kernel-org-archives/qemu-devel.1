Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cySwH-000757-W9
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cySwG-0003wU-Pm
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 20:48:46 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-9-eblake@redhat.com>
	<3eaa3c7a-1581-8d2d-a385-3400d434b3fe@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d2709ed-bb61-254e-9dc0-4049e61c8722@redhat.com>
Date: Wed, 12 Apr 2017 19:48:25 -0500
MIME-Version: 1.0
In-Reply-To: <3eaa3c7a-1581-8d2d-a385-3400d434b3fe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9j7KSJEvIcLtxXGHJhNRqUU1HRccRTkOh"
Subject: Re: [Qemu-devel] [PATCH 08/12] dirty-bitmap: Change
 bdrv_get_dirty() to take bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9j7KSJEvIcLtxXGHJhNRqUU1HRccRTkOh
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <3d2709ed-bb61-254e-9dc0-4049e61c8722@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/12] dirty-bitmap: Change bdrv_get_dirty()
 to take bytes
References: <20170412174920.8744-1-eblake@redhat.com>
 <20170412174920.8744-9-eblake@redhat.com>
 <3eaa3c7a-1581-8d2d-a385-3400d434b3fe@redhat.com>
In-Reply-To: <3eaa3c7a-1581-8d2d-a385-3400d434b3fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 07:25 PM, John Snow wrote:

>> +++ b/migration/block.c
>> @@ -537,8 +537,7 @@ static int mig_save_device_dirty(QEMUFile *f, BlkM=
igDevState *bmds,
>>          } else {
>>              blk_mig_unlock();
>>          }
>> -        if (bdrv_get_dirty(bs, bmds->dirty_bitmap, sector)) {
>> -
>> +        if (bdrv_get_dirty(bs, bmds->dirty_bitmap, sector * BDRV_SECT=
OR_SIZE)) {
>=20
> This one is a little weirder now though, isn't it? We're asking for the=

> dirty status of a single byte, technically. In practice, the scaling
> factor will always cover the entire sector, but it reads a lot jankier =
now.
>=20
>>              if (total_sectors - sector < BDRV_SECTORS_PER_DIRTY_CHUNK=
) {
>>                  nr_sectors =3D total_sectors - sector;
>>              } else {
>>
>=20
> Oh well, it was always janky...

True. Think of it as "is the granularity (which may be a sector, a
cluster, or even some other size) that contains 'offset' dirty?".  I
really think migration/block.c will be easier to read once converted to
byte operations everywhere, but have not yet tackled it (it was hard
enough tackling mirror, backup, commit, and stream in parallel for the
previous series).

>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

Thanks for the reviews, by the way, even if the prerequisite patches
still haven't been fully reviewed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9j7KSJEvIcLtxXGHJhNRqUU1HRccRTkOh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7srZAAoJEKeha0olJ0NqfSoIAIayX3UPYO5rgY4UV1XUwAot
unBaVz54WjvqJcwcqigWC8usCF5Fedizk2ddQIfdQ8iL3t8Vu3isnS6M8pOe3CMh
J+Kua8YmJD1MFLYNSODSPqXp8OK3r6Gy4DzuiBJhCIo23ruWCp55VJNTp81qmJRE
PrGE8kEc5LvST9oHmdI1E45H2AXqXjuse8rbC5p8eSG51r2Eb4lAdaFA/4YRd5K0
F0hQYXUZ5ehHTkSf1/ZCi3el3jpZ4/VcPlf6r31IE6yuLyll4xp9AZXuOjrAHUOn
SgNQfU11FeitFoId96br+NaeJVr2V3xU37Jclq+Bkn2KSjexBOPimkqIX8ypH6E=
=lldV
-----END PGP SIGNATURE-----

--9j7KSJEvIcLtxXGHJhNRqUU1HRccRTkOh--
