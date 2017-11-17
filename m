Received: from eggs.gnu.org ([2001:4830:134:3::10]:54269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFjCW-0003f4-KJ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFjCV-00017H-HF
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:09:08 -0500
References: <20171110172545.32609-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5effaf53-cd83-b74d-e68b-78faae56ce26@redhat.com>
Date: Fri, 17 Nov 2017 17:08:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171110172545.32609-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kfPf7xAWcFxotAXHxlKC5Ptkv5jm2bPuu"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] block: Make bdrv_next() keep
 strong references
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kfPf7xAWcFxotAXHxlKC5Ptkv5jm2bPuu
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <5effaf53-cd83-b74d-e68b-78faae56ce26@redhat.com>
Subject: Re: [PATCH v2 for-2.11] block: Make bdrv_next() keep strong
 references
References: <20171110172545.32609-1-mreitz@redhat.com>
In-Reply-To: <20171110172545.32609-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 18:25, Max Reitz wrote:
> On one hand, it is a good idea for bdrv_next() to return a strong
> reference because ideally nearly every pointer should be refcounted.
> This fixes intermittent failure of iotest 194.
>=20
> On the other, it is absolutely necessary for bdrv_next() itself to keep=

> a strong reference to both the BB (in its first phase) and the BDS (at
> least in the second phase) because when called the next time, it will
> dereference those objects to get a link to the next one.  Therefore, it=

> needs these objects to stay around until then.  Just storing the pointe=
r
> to the next in the iterator is not really viable because that pointer
> might become invalid as well.
>=20
> Both arguments taken together means we should probably just invoke
> bdrv_ref() and blk_ref() in bdrv_next().  This means we have to assert
> that bdrv_next() is always called from the main loop, but that was
> probably necessary already before this patch and judging from the
> callers, it also looks to actually be the case.
>=20
> Keeping these strong references means however that callers need to give=

> them up if they decide to abort the iteration early.  They can do so
> through the new bdrv_next_cleanup() function.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2: Instead of keeping the strong reference in bdrv_drain_all_*() only,=

>     have them for all callers of bdrv_next() [Fam, Kevin]
>     (Completely different patch now, so no git-backport-diff included
>      here)
> ---
>  include/block/block.h |  1 +
>  block.c               |  3 +++
>  block/block-backend.c | 48 +++++++++++++++++++++++++++++++++++++++++++=
+++--
>  block/snapshot.c      |  6 ++++++
>  migration/block.c     |  1 +
>  5 files changed, 57 insertions(+), 2 deletions(-)

Due to one supporter and otherwise lack of resistance: Applied to my
block branch (https://github.com/XanClic/qemu/commits/block).

Max


--kfPf7xAWcFxotAXHxlKC5Ptkv5jm2bPuu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloPCYQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AH6AH/RB9QpUZrN8Q11V2qClRfa5NeslIWHF3
OtWQgYtA1cVMoSSolM+dioOgZ5Y/cVy0FpDOYOiCReDmmPXvzi0vzf9uQPKt61iV
Pmjp+X8AXVNadyxa8ojZ9PhCd9XlPq3apM/0rtspqyRYWgY5UGlegibFSTQ5QwkK
EKvHTOQYxGDnRxqQMHRVoFSlcub8aCvKDdGvN/OUK4Wi3w5SD4UbwHjnXeH4bOlM
eSRU7dh/3SvObQCcXtK+Jy8pA31d96QIKSalWCNBODMqouV1cp79RNmUwlFNctNQ
GhnAb4zdARQUx4wB1sBJXHmBTNM/zygZDiY/AsAIVG3PL5kYTHpVjwY=
=TwmC
-----END PGP SIGNATURE-----

--kfPf7xAWcFxotAXHxlKC5Ptkv5jm2bPuu--
