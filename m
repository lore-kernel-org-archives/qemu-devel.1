Received: from eggs.gnu.org ([2001:4830:134:3::10]:41689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gWNQ5-0005Ey-Bu
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gWNQ4-0006ME-HN
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:24:29 -0500
References: <1543568126-727235-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1543568126-727235-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f7e23917-92ea-bdc9-09a4-9deafa7ee142@redhat.com>
Date: Mon, 10 Dec 2018 16:24:18 +0100
MIME-Version: 1.0
In-Reply-To: <1543568126-727235-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tM8YpzGHYT1EPzLmuipPvE1Pk1nHSToyA"
Subject: Re: [Qemu-devel] [PATCH v4 1/5] Discard blocks while copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tM8YpzGHYT1EPzLmuipPvE1Pk1nHSToyA
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Message-ID: <f7e23917-92ea-bdc9-09a4-9deafa7ee142@redhat.com>
Subject: Re: [PATCH v4 1/5] Discard blocks while copy-on-read
References: <1543568126-727235-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1543568126-727235-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1543568126-727235-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.11.18 09:55, Andrey Shinkevich wrote:
> Discards the block duplicated in an intermediate backing file
> after the block have been copied into the active layer during
> QMP block-stream operation.
> It saves the disk space while merging external snapshots.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/stream.c | 428 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
>  1 file changed, 413 insertions(+), 15 deletions(-)

I wonder why you aren't adding this functionality to the copy-on-read
filter driver; not just because it makes sense to have feature parity
between block-stream and that filter, but also because I imagine you
could use it as the filter node you're adding here.

I thought that block-stream could be rewritten to:
(1) Create a block-stream filter node on top of @device, with the
necessary parameters,
(2) Read everything that is allocated in (@base, @device), so that it is
copied to the target.

I think that can be done today.  There is no need for the COR filter to
support a base node parameter, as block-stream simply needs to take care
just to read things that are allocated above @base.

Max


--tM8YpzGHYT1EPzLmuipPvE1Pk1nHSToyA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwOhSIACgkQ9AfbAGHV
z0CnqAf/W+Zgp6F4Dqbx39kTMmioHRPQK2ydfs0KdqT9gNGewRUAthVtzS8lhfRF
2h6cYgyHTghjAPAlmHSNct1kUArpG7uHXRzTIRIDSQTthd2WCBLZac15TKymivyh
PqyxLjYg9firLFUy94KWuJt98rEwpU40RALHrf0odLncr4bXagQkTH5tj3mGhDvc
UsGbCjdCX+A0k2nzpZ15u9s9oh/kHQHuQOjHWNO2BLCkF5QLZ7PBYKe/gaNTQrph
oz72Q5gtb3M4e4nuaLVfARjeuDg2hrUuZrC6CjbIitDTBz0LOJJVqfmY3jo1kRET
9FPGRYVhOZeKDdrcq9PAs1QC4dWaqg==
=v8p9
-----END PGP SIGNATURE-----

--tM8YpzGHYT1EPzLmuipPvE1Pk1nHSToyA--
