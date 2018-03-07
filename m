Received: from eggs.gnu.org ([2001:4830:134:3::10]:40701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etdHO-0001XL-N1
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etdHN-00027q-SP
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:55:06 -0500
References: <20180306130121.30243-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cec0f674-b25a-9c7c-e12c-49513e0060d0@redhat.com>
Date: Wed, 7 Mar 2018 18:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180306130121.30243-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kV971HavYPnVlvlBdNn9O0hUWn7Z2gR5a"
Subject: Re: [Qemu-devel] [PATCH v4] iotests: Tweak 030 in order to trigger
 a race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kV971HavYPnVlvlBdNn9O0hUWn7Z2gR5a
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <cec0f674-b25a-9c7c-e12c-49513e0060d0@redhat.com>
Subject: Re: [PATCH v4] iotests: Tweak 030 in order to trigger a race
 condition with parallel jobs
References: <20180306130121.30243-1-berto@igalia.com>
In-Reply-To: <20180306130121.30243-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-06 14:01, Alberto Garcia wrote:
> This patch tweaks TestParallelOps in iotest 030 so it allocates data
> in smaller regions (256KB/512KB instead of 512KB/1MB) and the
> block-stream job in test_stream_commit() only needs to copy data that
> is at the very end of the image.
>=20
> This way when the block-stream job is awakened it will finish right
> away without any chance of being stopped by block_job_sleep_ns(). This
> triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f and
> 1a63a907507fbbcfaee3f622907ec24 and is therefore a more useful test
> case for parallel block jobs.
>=20
> After this patch the aforementiond bug can also be reproduced with the
> test_stream_parallel() test case.
>=20
> Since with this change the stream job in test_stream_commit() finishes
> early, this patch introduces a similar test case where both jobs are
> slowed down so they can actually run in parallel.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Cc: John Snow <jsnow@redhat.com>
> ---
>=20
> v4: Mention that commit 1a63a907507fbbcfaee3f622907ec24 also
>     contributes to solve the original bug (both commits need to
>     reverted in order to reproduce this bug reliably).
>=20
>     Rewrite the loop that writes data into the images to make it more
>     readable.

Thanks!  Applied to my block tree:

https://github.com/XanClic/qemu/commits/block

(Still took me a couple of attempts to get it to fail both commits
reverted, though...)

Max


--kV971HavYPnVlvlBdNn9O0hUWn7Z2gR5a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgJ2sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AbeAH/3enDqKqAMiPTTzFSaYLsNkJDIa3KaNm
FFe2TCRR96GG7+Zsp48B7ZMca+NnAnphZVdgbEc529F+Am5j8tXOH9NaHMG4TCJ/
6m4uwkXKklVY0gJ3U0Yu8g4LhpYZTo6mEaZcFf5C0fcbPTq1V887GrbpHhFqnk0I
UnPBOX6Iw5OZh1RByTbyKCCAam9Ft5WODiAXmPkG464GGEnxWje3Qycx5lBcScfd
NlaIwBfvhm6CKLaXyWw4g8YfR9xCFVICIaQJYIfnlr+SMHvYrxgEhz9fyg2WloqH
jDJuCOSi6Ug3r/m+uxMsm1kE19u33JU+KZrYHEDFoGJOmlaUVwHOuf4=
=+l8O
-----END PGP SIGNATURE-----

--kV971HavYPnVlvlBdNn9O0hUWn7Z2gR5a--
