Received: from eggs.gnu.org ([2001:4830:134:3::10]:46266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsS8a-0001VS-Ce
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsS8S-0003yj-KH
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:21:20 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-7-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ce27055e-4a00-348b-9234-05a5e0e0af13@redhat.com>
Date: Wed, 22 Aug 2018 14:20:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-7-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="onrmKow6r3bl4w4fppOWZgnPjz5PE5Wsd"
Subject: Re: [Qemu-devel] [PATCH 6/7] jobs: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--onrmKow6r3bl4w4fppOWZgnPjz5PE5Wsd
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <ce27055e-4a00-348b-9234-05a5e0e0af13@redhat.com>
Subject: Re: [PATCH 6/7] jobs: utilize job_exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-7-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
> Utilize the job_exit shim by not calling job_defer_to_main_loop, and
> where applicable, converting the deferred callback into the job_exit
> callback.
>=20
> This converts backup, stream, create, and the unit tests all at once.
> None of these jobs undergo and order of operations changes, so it shoul=
d
> be a mechanical change.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c            | 16 ----------------
>  block/create.c            | 14 +++-----------
>  block/stream.c            | 22 +++++++---------------
>  tests/test-bdrv-drain.c   |  6 ------
>  tests/test-blockjob-txn.c | 11 ++---------
>  tests/test-blockjob.c     | 10 ++++------
>  6 files changed, 16 insertions(+), 63 deletions(-)

[...]

> diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
> index 82cedee78b..ef29f35e44 100644
> --- a/tests/test-blockjob-txn.c
> +++ b/tests/test-blockjob-txn.c
> @@ -24,17 +24,11 @@ typedef struct {
>      int *result;
>  } TestBlockJob;
> =20
> -static void test_block_job_complete(Job *job, void *opaque)
> +static void test_block_job_exit(Job *job)
>  {
>      BlockJob *bjob =3D container_of(job, BlockJob, job);
>      BlockDriverState *bs =3D blk_bs(bjob->blk);
> -    int rc =3D (intptr_t)opaque;
> =20
> -    if (job_is_cancelled(job)) {
> -        rc =3D -ECANCELED;
> -    }
> -
> -    job_completed(job, rc);
>      bdrv_unref(bs);
>  }

That is a change in the order of operations, actually.  It's OK though
because the BDS is still owned by the block job's BlockBackend.

(So I'd give an R-b, but I'm still unsure about the .exit() interface.)

Max


--onrmKow6r3bl4w4fppOWZgnPjz5PE5Wsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9VSAACgkQ9AfbAGHV
z0DWUQf9F7ycbApxgnJSAbXLLT8Es7OfVaGiMCTgGIqnIuesuhmQOyxltB/SpRzH
H+ewnzk5Qy8Phk4jPM01QZmavxth4l9uGNBeUvTZo9V80d8fh/BA+MIJmwxRw44c
U/3/6YnEfQaQ37sRYsSpesXTqzjfJhyl7Ua90Irl7W/yMVEzRW/cX4aU2LFGfJ24
rXh46auOpRAJpaoJ26inTV/Pig3xvWW0C4uqq6D4VPmCyMZlwqeS+t7Vem3xm/pI
1QSLQi/mD7BFXrRO6EXaRCZ86RIs5/u+rUqT9Yc5zQfVEZHWpGE2VMtTSBEGWZvd
5YaO1WUXrNpPra+Qxcf7yzgVn/SbKw==
=ipmW
-----END PGP SIGNATURE-----

--onrmKow6r3bl4w4fppOWZgnPjz5PE5Wsd--
