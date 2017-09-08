Received: from eggs.gnu.org ([2001:4830:134:3::10]:38090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqJZ5-0002oq-UE
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dqJZ2-0006ax-R6
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:43:21 -0400
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-15-eblake@redhat.com>
	<20170908131518.GI3283@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0afaa754-a5a1-2c0a-af5d-4ba5bd152d17@redhat.com>
Date: Fri, 8 Sep 2017 08:43:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170908131518.GI3283@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RvSmAoT4oU9dFcKPhLOBX7XlFmwjUbB3d"
Subject: Re: [Qemu-devel] [PATCH v6 14/18] qcow2: Switch qcow2_measure() to
 byte-based iteration
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
--RvSmAoT4oU9dFcKPhLOBX7XlFmwjUbB3d
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <0afaa754-a5a1-2c0a-af5d-4ba5bd152d17@redhat.com>
Subject: Re: [PATCH v6 14/18] qcow2: Switch qcow2_measure() to byte-based
 iteration
References: <20170830210542.2153-1-eblake@redhat.com>
 <20170830210542.2153-15-eblake@redhat.com>
 <20170908131518.GI3283@localhost.localdomain>
In-Reply-To: <20170908131518.GI3283@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2017 08:15 AM, Kevin Wolf wrote:
> Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
>> This is new code, but it is easier to read if it makes passes over
>> the image using bytes rather than sectors (and will get easier in
>> the future when bdrv_get_block_status is converted to byte-based).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>

>> -                int nb_sectors =3D MIN(ssize / BDRV_SECTOR_SIZE - sec=
tor_num,
>> -                                     BDRV_REQUEST_MAX_SECTORS);
>> +            for (offset =3D 0; offset < ssize;
>> +                 offset +=3D pnum * BDRV_SECTOR_SIZE) {
>> +                int nb_sectors =3D MIN(ssize - offset,
>> +                                     INT_MAX) / BDRV_SECTOR_SIZE;
>=20
> Shouldn't this be BDRV_REQUEST_MAX_BYTES? (Which is close to INT_MAX,
> but rounded down to sector alignment.)

The division rounds down to sector alignment after the MIN(), for the
same result in nb_sectors either way.  But you are correct that an
absolutely literal translation of the pre-patch version would feed
BDRV_REQUEST_MAX_BYTES instead of INT_MAX into the MIN().

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RvSmAoT4oU9dFcKPhLOBX7XlFmwjUbB3d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmynmoACgkQp6FrSiUn
Q2qKDAf/XpswYiEiztyvxb9oEjFgEFND+CdxyM6LC0UpPnxhFOoc9PJ/5p8SAWzr
UgjzOP89Qq/CzdUhf8biqcXTGtS81dsqUYc6ZC5kHjcbEBROJSLXtz2Pesi+J+3D
e3Y1i5kn3h0fcOrqJIjpTCrAQMqND9QzRLyqdyXnAfyVEJQ+QRYPgx0evEnDLDFp
3sHXJQrpVTzO0GXigyg5KK71dOLWOSuVngtGlqQmsZnrPkl3UCMBbmmsP8lsrbKH
ZwAXslmR5KEwuOkFSEEdtHj7yJRQVodNw/tCXpQBrWvF8onYb/jAVmrKTB8zYYbU
wQ8x8jWHB8rHRrd/cewTQgLtvCobXA==
=q8/k
-----END PGP SIGNATURE-----

--RvSmAoT4oU9dFcKPhLOBX7XlFmwjUbB3d--
