Received: from eggs.gnu.org ([208.118.235.92]:32906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfCJD-0003HF-MB
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfCJC-0003hs-4X
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:21:51 -0500
References: <20181221093529.23855-1-jsnow@redhat.com>
	<20181221093529.23855-5-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a803d155-daa4-89f6-bee0-98ac89ee2333@redhat.com>
Date: Thu, 3 Jan 2019 17:21:19 -0600
MIME-Version: 1.0
In-Reply-To: <20181221093529.23855-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YRVvypSgIjCn68PFQLu03tEQMmu1AGCex"
Subject: Re: [Qemu-devel] [PATCH v6 04/11] block: remove 'x' prefix from
 experimental bitmap APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YRVvypSgIjCn68PFQLu03tEQMmu1AGCex
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <a803d155-daa4-89f6-bee0-98ac89ee2333@redhat.com>
Subject: Re: [PATCH v6 04/11] block: remove 'x' prefix from experimental
 bitmap APIs
References: <20181221093529.23855-1-jsnow@redhat.com>
 <20181221093529.23855-5-jsnow@redhat.com>
In-Reply-To: <20181221093529.23855-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/21/18 3:35 AM, John Snow wrote:
> The 'x' prefix was added because I was uncertain of the direction we'd
> take for the libvirt API. With the general approach solidified, I feel
> comfortable committing to this API for 4.0.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  blockdev.c             | 22 +++++++++++-----------
>  qapi/block-core.json   | 34 +++++++++++++++++-----------------
>  qapi/transaction.json  | 12 ++++++------
>  tests/qemu-iotests/223 |  4 ++--
>  4 files changed, 36 insertions(+), 36 deletions(-)

Misses the conversion of x-nbd-server-add-bitmap in qapi/block.json
(could be a separate patch), but that's also one of the commands that
libvirt will need to use alongside all the bitmap changes.

Speaking of x-nbd-server-add-bitmap, does it actually have to be a
separate command, or should it just be an additional parameter to the
existing nbd-server-add?  There are two directions this could go:

As a single command, it enforces that there is no window of time where
the export is available without the dirty bitmap. However, it also means
we can only export at most one bitmap, unless we make the parameter take
an array of bitmaps to export.  Fewer commands also means less roll-back
scenarios in libvirt (no need to worry about the export being added but
the bitmap failing).

As a separate command, we could in the future allow the server to export
multiple bitmaps at once by calling the add-bitmap command more than
once; but right now, the code base does not allow multiple bitmap
exports (a second bitmap export attempt fails).

I'm leaning towards the former (drop x-nbd-server-add-bitmap altogether,
and instead add a bitmap parameter to nbd-server-add).  Also, I'm
leaning towards locking in that we only ever export one
qemu:dirty-bitmap:FOO bitmap per export, and thus not worry about an
array.  Besides, if we make the command take an array now but enforce
that the array has at most one element, then later relax it to take more
than one element, there is no way to introspect that change; but if we
make the command take a single string now, and later have a strong
reason why exporting more than one bitmap at once makes sense, we could
still maintain backcompat by using a QAPI alternate type between a
string and an array, which would be introspectible.

I guess I should propose a patch for that, then...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YRVvypSgIjCn68PFQLu03tEQMmu1AGCex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwumO8ACgkQ3g5py3or
ov3Newf/ZCVdkfj4EQRJQRAMPNoYWgxcaaAqutktlh8L4Okt/r4A97ggtpGQMopj
w9wiZJoVgatAurXS/yG7xmjib/ffJ8Act4K5JNKgUzDiV79cWVnTfQzp0iArAcuZ
Ap7o0JeM0qLeyrJiscis302QjDRaJyd+poxbca3Y6WyEK/zhIeb6mShzloiqJcc6
SnE20IW4dPW+F3q+jP8gU2/+9rXhlFrCIGABXxneRK/9ihCAw6zPAH/ZZW+tTNJF
pyO6U8i7d1mMgdkX91PvrGXe6M9j7Px7axRPopQrOYZF7SHVXFSxQRXzVVBa7iXt
zSlQywAe7S+DZe1UMtgd5+0OHkgJ6Q==
=ng7t
-----END PGP SIGNATURE-----

--YRVvypSgIjCn68PFQLu03tEQMmu1AGCex--
