Received: from eggs.gnu.org ([2001:4830:134:3::10]:58464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejY2I-0002PQ-29
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejY2H-00050q-4W
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:17:50 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-5-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a52bd130-d612-8141-1717-9095c8fc50c9@redhat.com>
Date: Wed, 7 Feb 2018 23:17:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8VNER1YSWSyyQaJqkWLs9YZpWggS3eC2U"
Subject: Re: [Qemu-devel] [PATCH v2 04/13] blockjob: allow
 block_job_throttle to take delay_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8VNER1YSWSyyQaJqkWLs9YZpWggS3eC2U
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <a52bd130-d612-8141-1717-9095c8fc50c9@redhat.com>
Subject: Re: [PATCH v2 04/13] blockjob: allow block_job_throttle to take
 delay_ns
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-5-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> Instead of only sleeping for 0ms when we've hit a timeout, optionally
> take a longer more explicit delay_ns that always forces the sleep.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c               |  4 ++--
>  blockjob.c                   |  9 ++++-----
>  include/block/blockjob_int.h | 10 +++++++---
>  3 files changed, 13 insertions(+), 10 deletions(-)

[...]

> diff --git a/blockjob.c b/blockjob.c
> index 6f2e709b51..51c0eb5d9e 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -906,12 +906,11 @@ void block_job_yield(BlockJob *job)
>      block_job_pause_point(job);
>  }
> =20
> -void block_job_relax(BlockJob *job)
> +void block_job_relax(BlockJob *job, int64_t delay_ns)
>  {
> -    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> -
> -    if (now - job->last_enter_ns > SLICE_TIME) {
> -        block_job_sleep_ns(job, 0);
> +    if (delay_ns || (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - \
> +                     job->last_enter_ns > SLICE_TIME)) {
> +        block_job_sleep_ns(job, delay_ns);

I can't say I like the readability of that any better...

(And I'd argue that if delay_ns > 0, the one superfluous call to
qemu_clock_get_ns() isn't going to harm performance.)

>      } else {
>          block_job_pause_point(job);
>      }
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.=
h
> index 553784d86f..5f1520fab7 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -160,11 +160,15 @@ void block_job_yield(BlockJob *job);
>  /**
>   * block_job_relax:
>   * @job: The job that calls the function.
> + * @delay_ns: The amount of time to sleep for
>   *
> - * Yield if it has been SLICE_TIME nanoseconds since the last yield.
> - * Otherwise, check if we need to pause, and yield if so.
> + * Sleep for delay_ns nanoseconds.
> + *
> + * If delay_ns is 0, yield if it has been SLICE_TIME
> + * nanoseconds since the last yield. Otherwise, check
> + * if we need to yield for a pause event.

That "Otherwise" now sounds as if it refers to the "If delay_ns is 0".

Code change is OK, but this comment needs some fixing.

Max

>   */
> -void block_job_relax(BlockJob *job);
> +void block_job_relax(BlockJob *job, int64_t delay_ns);
> =20
>  /**
>   * block_job_pause_all:
>=20



--8VNER1YSWSyyQaJqkWLs9YZpWggS3eC2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7ewASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgFoIAJSNM6fu9fUqLcHT0mcbcWi/0O0C5DZx
4UC498+vOhXz7k8ASNWqKiURdBGoZnTIy9OyfJ8K6B4Qd2v3I4Ln/69PVcwLk2YL
G6B2hDfB6iAxovq4ylJqunGZvIzDDfoQ9yknxRFot3v1Qjd98U2ukNTWLuYxNkSV
0LdBKU76doZs67RWbNXMkaspuqjEFeN2c2+6TZwj/Lq9uPurUVA3r/fxQv0SZjPs
ATs5GBXhYGqKutAdhI3BCT6g1b8ASUITOwe8uSpueBoRsu7ZL5XckcXq7tWt88QQ
hpyIC5DkhVri4xuKE86XBlzlh1SSqsyRAPBd9vaPvtiTkkvviPdVTYY=
=8SU0
-----END PGP SIGNATURE-----

--8VNER1YSWSyyQaJqkWLs9YZpWggS3eC2U--
