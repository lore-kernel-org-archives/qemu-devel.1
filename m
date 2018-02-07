Received: from eggs.gnu.org ([2001:4830:134:3::10]:36607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYYe-0004VS-PF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYYd-0002Ev-QH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:51:16 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-14-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cea05b0c-5a09-15ac-71ee-d33bea87b42d@redhat.com>
Date: Wed, 7 Feb 2018 23:50:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-14-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uj0bVBsbrUMXHwWAvOQuId96MyRdQaIe8"
Subject: Re: [Qemu-devel] [PATCH v2 13/13] blockjob: remove
 block_job_pause_point from interface
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
--uj0bVBsbrUMXHwWAvOQuId96MyRdQaIe8
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <cea05b0c-5a09-15ac-71ee-d33bea87b42d@redhat.com>
Subject: Re: [PATCH v2 13/13] blockjob: remove block_job_pause_point from
 interface
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-14-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-14-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> Remove the last call in block/mirror, using relax instead.
> relax may do nothing if we are canceled, so allow iteration to return
> prematurely and allow mirror_run to handle the cancellation logic.

Ah, now you write it with two l? ;-)

>=20
> This is a functional change to mirror that should have the effect of
> cancelled mirror jobs being able to respond to that request a little

??!??!  Such inconsistency.  Many l.

> sooner instead of launching new requests.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c               |  4 +++-
>  blockjob.c                   | 10 +++++++++-
>  include/block/blockjob_int.h |  9 ---------
>  3 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 192e03694f..8e6b5b25a9 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -345,7 +345,9 @@ static uint64_t coroutine_fn mirror_iteration(Mirro=
rBlockJob *s)
>          mirror_wait_for_io(s);
>      }
> =20
> -    block_job_pause_point(&s->common);
> +    if (block_job_relax(&s->common, 0)) {
> +        return 0;
> +    }

:c

> =20
>      /* Find the number of consective dirty chunks following the first =
dirty
>       * one, and wait for in flight requests in them. */
> diff --git a/blockjob.c b/blockjob.c
> index 40167d6896..27c13fdd08 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -60,6 +60,7 @@ static void __attribute__((__constructor__)) block_jo=
b_init(void)
>  static void block_job_event_cancelled(BlockJob *job);
>  static void block_job_event_completed(BlockJob *job, const char *msg);=

>  static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *jo=
b));
> +static int coroutine_fn block_job_pause_point(BlockJob *job);
> =20
>  /* Transactional group of block jobs */
>  struct BlockJobTxn {
> @@ -793,7 +794,14 @@ static void block_job_do_yield(BlockJob *job, uint=
64_t ns)
>      assert(job->busy);
>  }
> =20
> -int coroutine_fn block_job_pause_point(BlockJob *job)
> +/**
> + * block_job_pause_point:
> + * @job: The job that is ready to pause.
> + *
> + * Pause now if block_job_pause() has been called.  Block jobs that pe=
rform
> + * lots of I/O must call this between requests so that the job can be =
paused.

But jobs can't call this anymore, now.  This part of the comment should
either mention block_job_relax() instead or should be moved there
altogether.

Max

> + */
> +static int coroutine_fn block_job_pause_point(BlockJob *job)
>  {
>      assert(job && block_job_started(job));
> =20
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.=
h
> index c4891a5a9b..57327cbc5a 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -201,15 +201,6 @@ void block_job_completed(BlockJob *job, int ret);
>   */
>  bool block_job_is_cancelled(BlockJob *job);
> =20
> -/**
> - * block_job_pause_point:
> - * @job: The job that is ready to pause.
> - *
> - * Pause now if block_job_pause() has been called.  Block jobs that pe=
rform
> - * lots of I/O must call this between requests so that the job can be =
paused.
> - */
> -int coroutine_fn block_job_pause_point(BlockJob *job);
> -
>  /**
>   * block_job_enter:
>   * @job: The job to enter.
>=20



--uj0bVBsbrUMXHwWAvOQuId96MyRdQaIe8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7gswSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AGwUIAKtvK8ngPNz1pdll+0/hPPwj/aQL4JOr
W2wgvXGEnTG7lvoqeUGdcuF2CReED6PHvP8B7cf9DMaY0W7wWgyXclC1z6dNLkZN
W0pbrmZtVKXYZNYMUyFJ/dFFbR6w9C/9L4vZB8BpLzV7oEDDSq9WFSZoj/vFBQ9Z
zcZMTY5WwJ6Oo3bU7niA76Dkd71kbRcx/hu38ScbuFpyyCLqqidqcVYdQmlqfR6m
1s6in6I2IJWurL3uUdKzs/uWb+mWYrBLehtOcMQTyZ8LwwU3B9kKmEpqFZZdOyIH
jTNhs8jZZvRiPUO2kojPMLux+1JAc2Snb6zBA/pib+Q4ceiRrrzS5vg=
=gdAh
-----END PGP SIGNATURE-----

--uj0bVBsbrUMXHwWAvOQuId96MyRdQaIe8--
