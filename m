Received: from eggs.gnu.org ([2001:4830:134:3::10]:52519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFMhP-0001Uk-6C
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFMhO-0007A8-6R
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:35:15 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-9-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9e1ff654-08b7-4863-0557-6cc4eb905f6f@redhat.com>
Date: Mon, 29 May 2017 17:34:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UgalKQUfOJDnLxIFiA4TThAch2HjAipTF"
Subject: Re: [Qemu-devel] [PATCH 08/25] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UgalKQUfOJDnLxIFiA4TThAch2HjAipTF
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <9e1ff654-08b7-4863-0557-6cc4eb905f6f@redhat.com>
Subject: Re: [PATCH 08/25] qcow2: add bitmaps extension
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> Add bitmap extension as specified in docs/specs/qcow2.txt.
> For now, just mirror extension header into Qcow2 state and check
> constraints. Also, calculate refcounts for qcow2 bitmaps, to not break
> qemu-img check.
>=20
> For now, disable image resize if it has bitmaps. It will be fixed later=
=2E
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/Makefile.objs    |   2 +-
>  block/qcow2-bitmap.c   | 439 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2-refcount.c |   6 +
>  block/qcow2.c          | 124 +++++++++++++-
>  block/qcow2.h          |  27 +++
>  5 files changed, 592 insertions(+), 6 deletions(-)
>  create mode 100644 block/qcow2-bitmap.c

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6a92d2ef3f..6028e9a149 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -2542,6 +2649,13 @@ static int qcow2_truncate(BlockDriverState *bs, =
int64_t offset)
>          return -ENOTSUP;
>      }
> =20
> +    /* cannot proceed if image has bitmaps */
> +    if (s->nb_bitmaps) {
> +        /* TODO: resize bitmaps in the image */
> +        error_report("Can't resize an image which has bitmaps");

Minor note: This needs to be error_setg(errp, ...); now...

> +        return -ENOTSUP;
> +    }
> +
>      /* shrinking is currently not supported */
>      if (offset < bs->total_sectors * 512) {
>          error_report("qcow2 doesn't support shrinking images yet");

=2E..as does this (which blocks the patch from being applicable).

(But please keep my R-b.)

Max


--UgalKQUfOJDnLxIFiA4TThAch2HjAipTF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLD+gEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOfk
CACzmx7w2H6l1lnC20guhbErYBljXJ985dvjAdMZJIsFBb6S/b/xsFP71c9XgudE
2S0GbaQvPX4ktbx4IeF/MUMFzn5hSeWshPhGjtDeJ/ccif4Ob3rF/oBT7k6beq34
XrFqp38JholaJ0qV4plMJF/Fi05AE7BiHKJ/JvxcmIP3LpsE+6XozQj2g/WxhUqK
uyMYimzx4YDvwY1RGwGrtj40OwGuWbYIq9p4adkq9nr7Ajlyk4fuX6nrweVGuuFC
eDfcnayjFnTN40yT0rAievaQO+fAi5KXvhFw49Qgr5tXA4YhRwT/JPcc/DLS1Yn+
1X0hyDTw6ouhbl+7vnG/v0G7
=QNkG
-----END PGP SIGNATURE-----

--UgalKQUfOJDnLxIFiA4TThAch2HjAipTF--
