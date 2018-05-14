Received: from eggs.gnu.org ([2001:4830:134:3::10]:43215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIIUc-0002fV-V3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIIUc-00078I-1P
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:46:43 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-26-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e79b53e7-3907-9c45-c22c-c79e0507f89e@redhat.com>
Date: Mon, 14 May 2018 20:46:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-26-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rbysHaxMYJeSvlglBr7C5M5q3lQcujgRO"
Subject: Re: [Qemu-devel] [PATCH 25/42] job: Move single job finalisation to
 Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rbysHaxMYJeSvlglBr7C5M5q3lQcujgRO
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <e79b53e7-3907-9c45-c22c-c79e0507f89e@redhat.com>
Subject: Re: [PATCH 25/42] job: Move single job finalisation to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-26-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-26-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves the finalisation of a single job from BlockJob to Job.
>=20
> Some part of this code depends on job transactions, and job transaction=
s
> call this code, we introduce some temporary calls from Job functions to=

> BlockJob ones. This will be fixed once transactions move to Job, too.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     |   9 ---
>  include/block/blockjob_int.h |  36 -----------
>  include/qemu/job.h           |  53 +++++++++++++++-
>  block/backup.c               |  22 +++----
>  block/commit.c               |   2 +-
>  block/mirror.c               |   2 +-
>  blockjob.c                   | 142 ++++++++---------------------------=
--------
>  job.c                        | 100 +++++++++++++++++++++++++++++-
>  qemu-img.c                   |   2 +-
>  tests/test-blockjob.c        |  10 +--
>  10 files changed, 194 insertions(+), 184 deletions(-)

[...]

> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 1b4397f9a1..12edb822d8 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -29,6 +29,7 @@
>  #include "qapi/qapi-types-block-core.h"
>  #include "qemu/queue.h"
>  #include "qemu/coroutine.h"
> +#include "block/aio.h"
> =20
>  typedef struct JobDriver JobDriver;
> =20
> @@ -105,6 +106,15 @@ typedef struct Job {
>      /** True if this job should automatically dismiss itself */
>      bool auto_dismiss;
> =20
> +    /** ret code passed to block_job_completed. */
> +    int ret;

While there is no such function yet, you might not want to mention a
block_job_* function here anyway.

Apart from that, as far as I can see, this comment remains unchanged
even later in this series when block_job_completed() is removed.

So something needs to be changed somewhere, so here is an anticipating

Reviewed-by: Max Reitz <mreitz@redhat.com>


--rbysHaxMYJeSvlglBr7C5M5q3lQcujgRO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr52YUACgkQ9AfbAGHV
z0C5IAf+O+ETF4/ABksIh8aO6vgMQ4DGt8spK3OqWn1hZ3W4zlJSrLD//XO1wnv0
lFFppJXlbHAVQVI7fFzVvL7DG2fsIaT+Ng/QMSrS1c7fXKCXNNyFqeF93hfAqUbX
sllT4aFcuSu3s0BWdfiWFlFzoytc67QdXhJnmAvrbkxnR5JmJVznHHPlaJTWS/da
4ED4BrFSInhKWnCQy8CtpMgi0XObbQ1off9t5Woreu0UQMXNUogOSH3RxBmBD3hU
pjmQC5p9QBsLR3GXYUnyudLx83UwWp3gub37yps4litbpN1pWcAD63lnS0YgMzFK
lDnn/AaRHnYEP6z653bKVezubgzzkg==
=/K7W
-----END PGP SIGNATURE-----

--rbysHaxMYJeSvlglBr7C5M5q3lQcujgRO--
