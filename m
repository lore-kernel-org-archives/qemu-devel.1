Received: from eggs.gnu.org ([2001:4830:134:3::10]:54436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTtgM-0003k5-9U
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTtgL-0004Jm-AN
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:05:58 -0500
From: Max Reitz <mreitz@redhat.com>
References: <A73A3E8EE466CD4E9D22E0AD8ADEE009493878FB@DGGEMA503-MBX.china.huawei.com>
Message-ID: <5aa42c4a-6e0c-2d5d-46b0-3ec2e99d1eac@redhat.com>
Date: Wed, 18 Jan 2017 18:05:49 +0100
MIME-Version: 1.0
In-Reply-To: <A73A3E8EE466CD4E9D22E0AD8ADEE009493878FB@DGGEMA503-MBX.china.huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CMsFoUj1fGV2D7oFaGxvSlHXTp3HEmIwk"
Subject: Re: [Qemu-devel] [Qemu-block] Question: any suggestions about
 zero-filled image grow of raw format files ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "fuweiwei (C)" <fuweiwei2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CMsFoUj1fGV2D7oFaGxvSlHXTp3HEmIwk
From: Max Reitz <mreitz@redhat.com>
To: "fuweiwei (C)" <fuweiwei2@huawei.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <5aa42c4a-6e0c-2d5d-46b0-3ec2e99d1eac@redhat.com>
Subject: Re: [Qemu-block][Qemu-devel] Question: any suggestions about
 zero-filled image grow of raw format files ?
References: <A73A3E8EE466CD4E9D22E0AD8ADEE009493878FB@DGGEMA503-MBX.china.huawei.com>
In-Reply-To: <A73A3E8EE466CD4E9D22E0AD8ADEE009493878FB@DGGEMA503-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 16.01.2017 07:20, fuweiwei (C) wrote:
> Dear all:
>=20
> =20
>=20
> I have a question. In qemu-kvm platforms, raw format virtual images hav=
e
> several preallocation options,
>=20
> such as thin (sparse, no preallocation), falloc and full (zero-filled
> preallocation). However, if one resize
>=20
> a full-allocated image to a larger volume, the additional part of the
> image is thin-allocated. This may
>=20
> introduce some diskspace management problems.

Adding something like preallocation=3Dfull would probably not be too
difficult, because qemu-img can just fill the space itself.

But adding preallocation=3Dfalloc for resize would probably require some
yet missing infrastructure in qemu. Currently, bdrv_truncate() is just a
function that takes the new size as an option and that's it.

> So I wonder if we could introduce zero-filled image grow (resize) for
> raw images. For offline image grow,
>=20
> could we add addition options (-p) to specify the preallocation method
> for the additional part of image,
>=20
> just like image creation:
>=20
> =20
>=20
> qemu-img resize -f raw test.img [-p full] +1G
>=20
> =20
>=20
> this will fill zeroes in the range of [original size, original size +
> 1G] in the file.

Well, for raw images you can just use fallocate afterwards manually; or,
if you want full preallocation, that shouldn't be too difficult to
implement.

> Online zero-filled image grow is the primary problem, because filling
> zeroes is time-consuming while
>=20
> qmp_block_resize is a synchronized function, which may block the qemu
> main process. Is there any solutions?

The thing that comes to mind is doing the resize and then writing zeroes
in the guest.

Another thing that I can imagine, but which is probably strongly
disadvisable (because of several reasons of which I can only imagine a
few right now), is:

(0) modify the null block driver so that it can return BDRV_BLOCK_DATA
from null_co_get_block_status()

(1) resize the volume using block_resize; let size_old be the old size
and size_new be the new size
(2) blockdev-add a null-co block driver with read-zeroes=3Dtrue,
size=3D$((new_size - old_size)), and the option so that it will return
BDRV_BLOCK_DATA
(3) blockdev-add a raw block driver on top of the original volume with
offset=3Dold_size,size=3D$((new_size - old_size))
(4) blockdev-mirror from the null-co node to the new raw node

And you're done.

But as I said, that is a bad hack.

Maybe it would make sense to have a dedicated write-zeroes block job
that can write a range of zeroes to some offset of a block device.

This wouldn't help you if you wanted to use fallocate, but that is again
something that would need to be implemented for bdrv_truncate() and thus
exposed over block_resize.

Max




--CMsFoUj1fGV2D7oFaGxvSlHXTp3HEmIwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh/oG0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AifAIAL0eg1rGa8HfWRA2uWXBQ2gQzAUyGHyC
N7X/jbrY/qmcpn+Roe7utHhUB+K8ueGbooLUc4BEhFJj3okZY5OsdEnTxWBvRsoO
KYcc/zyfe+lcZzrnKm6tmzavroMh8tIYq2EiazfEHqzbBNETHzmf9LqNa+MqV+eI
2T6u2eaIsu/xB8yo5ODUZORSmOWUNQ3bBRrjDPLfxFKHifqlNmEBVHZVNZ+4yJa5
jg2TOomgUqKLoWTsZNU610AF6/VgUZgg3tlqeD1h/BC7u0+8a6o969kQiOvmUDzF
uOqRQAeNFJBSlMsoZMlnBW2BMpCeCP0NI+F2pJEa1zg58OIDUbtBL8k=
=uy3A
-----END PGP SIGNATURE-----

--CMsFoUj1fGV2D7oFaGxvSlHXTp3HEmIwk--
