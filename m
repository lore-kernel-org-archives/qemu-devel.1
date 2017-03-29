Received: from eggs.gnu.org ([2001:4830:134:3::10]:49716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJke-0001Kt-UU
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJkd-000833-SO
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:59:29 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-9-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
Date: Wed, 29 Mar 2017 21:59:18 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ae7b993c2UQabTKJqBXnflvEXjdoQcS3i"
Subject: Re: [Qemu-devel] [for-2.9 8/8] sheepdog: Fix blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ae7b993c2UQabTKJqBXnflvEXjdoQcS3i
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <a33b1054-201c-9f5e-2c0e-35a86b1262e1@redhat.com>
Subject: Re: [for-2.9 8/8] sheepdog: Fix blockdev-add
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 18:45, Markus Armbruster wrote:
> Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit
> d282f34 "sheepdog: Support blockdev-add" have different ideas on how
> the QemuOpts parameters for the server address are named.  Fix that.
> While there, rename BlockdevOptionsSheepdog member addr to server, for
> consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
> BlockdevOptionsNbd.
>=20
> Commit 831acdc's example becomes
>=20
>     --drive driver=3Dsheepdog,server.host=3Dfido,vdi=3Ddolly
>=20
> instead of
>=20
>     --drive driver=3Dsheepdog,host=3Dfido,vdi=3Ddolly
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c     | 18 +++++++++---------
>  qapi/block-core.json |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)

OK, so let me get this straight: Before this patch, @addr was advertised
as a runtime parameter that actually wasn't supported at all? (Because I
can't see any place in block/sheepdog.c where it would be parsed.)

This patch now renames @addr to @server and instead of actually parsing
the option, it just removes the so-far convenience[1] options @host,
@port, and @path and just fetches the from @server?

If that is true, I can't say I like it the least. I guess it works for
2.9, but there should be a FIXME somewhere in this patch.

Also, if you set any of server.* in bdrv_parse_filename(), you also have
to set server.type. It's a SocketAddressFlat, .type is a required field.
I know it's just for internal use, but that doesn't change the fact that
it's an invalid SocketAddressFlat object without.

Max


[1] Originally there were apparently introduced for
bdrv_parse_filename() -- but of course you can just use them in -drive
directly...


--ae7b993c2UQabTKJqBXnflvEXjdoQcS3i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcEhYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABvMH/j03kIpA9s1KJ09MRBLt8wGMamDPAwz3
nRqwewgSHEIqrwBVOcYOx59aakVj5b8Q6mDHomzcPy6pSOZAAPhcK4sc8VlAJF5k
yzUacucsYcUkjguM4vBjnG8HLgoiQmafT4Aft9tzlZ18dM21wtzDRYg1OKPSDEpM
vWm2Ca2YBEaqCFed5QbBC9p2x99kbJKFoq9q9we2M7azrnM40pB0OBJ6oZMqVElF
sxtg/0amYWg1SdsqOEsqLg9UDC2TEltHGUCtk8J1tF9tJuO8AUwwMvrJOThsiIcs
YBvAHBcrflzMnnfXTHtDuCwXDndrkhDXI6r2YRbc/e1zHQ2r0E7prBM=
=K6B6
-----END PGP SIGNATURE-----

--ae7b993c2UQabTKJqBXnflvEXjdoQcS3i--
