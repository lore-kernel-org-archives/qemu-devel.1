Received: from eggs.gnu.org ([2001:4830:134:3::10]:60290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYCD-0007om-B1
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYCC-0003FU-CZ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:28:05 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-9-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <32b9a0be-dad2-d26e-1db4-8cb0e06d55be@redhat.com>
Date: Wed, 7 Feb 2018 23:27:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-9-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V0rjGlWb3JGt4MG0q7kKE74rj0anp75SQ"
Subject: Re: [Qemu-devel] [PATCH v2 08/13] allow block_job_relax to return
 -ECANCELED
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
--V0rjGlWb3JGt4MG0q7kKE74rj0anp75SQ
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <32b9a0be-dad2-d26e-1db4-8cb0e06d55be@redhat.com>
Subject: Re: [PATCH v2 08/13] allow block_job_relax to return -ECANCELED
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-9-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-9-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> This is just an optimization for callers who are likely going to
> want to check quite close to this call if the job was canceled or
> not anyway.

But jobs are =E2=80=9Ccancelled=E2=80=9D and not =E2=80=9Ccanceled=E2=80=9D=
=2E

!!!

>=20
> Along the same lines, add the return to block_job_pause_point and
> block_job_sleep_ns, so we don't have to re-check it quite so
> excessively.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockjob.c                   | 28 +++++++++++++++++-----------
>  include/block/blockjob_int.h |  8 +++++---
>  2 files changed, 22 insertions(+), 14 deletions(-)

[...]

> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.=
h
> index 5f1520fab7..1ceb47e1e6 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -147,7 +147,7 @@ void *block_job_create(const char *job_id, const Bl=
ockJobDriver *driver,
>   * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will immediate=
ly
>   * interrupt the wait.
>   */
> -void block_job_sleep_ns(BlockJob *job, int64_t ns);
> +int block_job_sleep_ns(BlockJob *job, int64_t ns);
> =20
>  /**
>   * block_job_yield:
> @@ -167,8 +167,10 @@ void block_job_yield(BlockJob *job);
>   * If delay_ns is 0, yield if it has been SLICE_TIME
>   * nanoseconds since the last yield. Otherwise, check
>   * if we need to yield for a pause event.
> + *
> + * returns ECANCELED if the job has been canceled.

-ECANCELED, please.

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>   */
> -void block_job_relax(BlockJob *job, int64_t delay_ns);
> +int block_job_relax(BlockJob *job, int64_t delay_ns);
> =20
>  /**
>   * block_job_pause_all:
> @@ -217,7 +219,7 @@ bool block_job_is_cancelled(BlockJob *job);
>   * Pause now if block_job_pause() has been called.  Block jobs that pe=
rform
>   * lots of I/O must call this between requests so that the job can be =
paused.
>   */
> -void coroutine_fn block_job_pause_point(BlockJob *job);
> +int coroutine_fn block_job_pause_point(BlockJob *job);
> =20
>  /**
>   * block_job_enter:
>=20



--V0rjGlWb3JGt4MG0q7kKE74rj0anp75SQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7fVgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+R8IAIPCAtJT2KZTJiPXQUTllZj7K/EuOcJv
WWh5M+n/eR75eaKFRLmG3z5QKGcxI3QCCDAfWphYthofaNf5bvzyHXOvpj+Zjdhi
/x/A/z8C4DL4HtpkoRIIOMKT0goQ4YgmQLHt4J5lkEUqeNbpuUlwRXKH5eUzGYXG
oyeIjX1YUP3OkNEP59QDXsPTJuxLxpVfuyFmnnSnzfhwPlO6CSHes1xrNSNoiFge
rSRpTOpxaV1kEGBnyaAkHOC9yrKs9iI8Mzy5xH5xYUwaDLGfRqklhQoWi95Oo70N
8+Zrlt+E3yGYo2ZKUeQ0gp9d6eYBNH+MajuA0Wg2/jH3RO5sl7nFD9Y=
=4h+S
-----END PGP SIGNATURE-----

--V0rjGlWb3JGt4MG0q7kKE74rj0anp75SQ--
