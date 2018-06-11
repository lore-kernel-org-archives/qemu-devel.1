Received: from eggs.gnu.org ([2001:4830:134:3::10]:39287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSMu7-0003kO-OK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSMu6-0001fE-K8
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:30:39 -0400
References: <1528375581-29538-1-git-send-email-pl@kamp.de>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <db7a78de-7962-63ee-e550-f954f12a3586@redhat.com>
Date: Mon, 11 Jun 2018 15:30:29 +0200
MIME-Version: 1.0
In-Reply-To: <1528375581-29538-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mBmTpXa7ccbPtRAsOIeGwkxetbfJIhdw2"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: align is_allocated_sectors to 4k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mBmTpXa7ccbPtRAsOIeGwkxetbfJIhdw2
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <db7a78de-7962-63ee-e550-f954f12a3586@redhat.com>
Subject: Re: [PATCH] qemu-img: align is_allocated_sectors to 4k
References: <1528375581-29538-1-git-send-email-pl@kamp.de>
In-Reply-To: <1528375581-29538-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-07 14:46, Peter Lieven wrote:
> We currently don't enforce that the sparse segments we detect during co=
nvert are
> aligned. This leads to unnecessary and costly read-modify-write cycles =
either
> internally in Qemu or in the background on the storage device as nearly=
 all
> modern filesystems or hardware has a 4k alignment internally.
>=20
> As we per default set the min_sparse size to 4k it makes perfectly sens=
e to ensure
> that these sparse holes in the file are placed at 4k boundaries.
>=20
> The number of RMW cycles when converting an example image [1] to a raw =
device that
> has 4k sector size is about 4600 4k read requests to perform a total of=
 about 15000
> write requests. With this path the 4600 additional read requests are el=
iminated.
>=20
> [1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04=
-server-cloudimg-amd64-disk1.vmdk
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

I like the idea, but it doesn't seem guaranteed that
is_allocated_sectors() is called on aligned offsets, so this alignment
work may still leave things unaligned.

Furthermore, we should probably not blindly assume 4k but instead use
some block limit of the target, like pwrite_zeroes_alignment, or
pdiscard_alignment, depending on the case.  (Or probably still
min_sparse, if that's less.)

Since is_allocated_sectors_min() (the only caller of
is_allocated_sectors()) is called from just a single place, taking those
factors into account should be possible.

Max


--mBmTpXa7ccbPtRAsOIeGwkxetbfJIhdw2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlseeXUACgkQ9AfbAGHV
z0APqwf/Tctw9Wy8PK3Iz7+kwB74Ro2k8RBPfGiQZRNmy2ewBhDO0wQ+rIlhAd5b
s2sOp215805cH97ej2TP7+TNE3+MJIZgpeeQaBEfJRCBMkwotBfmRuMsFnvWxMLV
uGGKveten16n8JXB6C3SSaQ38Mmf3qqGy6aB/M9ec8JbkbP2GfCPLN1KoHZY4sB+
XFk/RVfZrqXAFCDhFgH/Hy97aLh1ZOmMzw76LuaQasMGVOi5fsp0rF+8IauUNLno
u6OrUFVL5ixj9Fv3Y3If5hcbUMWtG6Zk3si0tXo+c2vEXaoyQxdg5FZkKt0T3v8G
ayl8m8L0b52AZQ+L1i/4xJHC8yxzHA==
=TcjZ
-----END PGP SIGNATURE-----

--mBmTpXa7ccbPtRAsOIeGwkxetbfJIhdw2--
