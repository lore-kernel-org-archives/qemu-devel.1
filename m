Received: from eggs.gnu.org ([2001:4830:134:3::10]:32837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYHr-00029e-LC
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYHq-0006dA-MT
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:33:55 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-10-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cf41be54-9b01-c6cd-e888-e6060dbcec38@redhat.com>
Date: Wed, 7 Feb 2018 23:33:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-10-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="asfN1FQFTfEnoAr3Xw1H3O5wRVXxPhilo"
Subject: Re: [Qemu-devel] [PATCH v2 09/13] block/backup: remove
 yield_and_check
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
--asfN1FQFTfEnoAr3Xw1H3O5wRVXxPhilo
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <cf41be54-9b01-c6cd-e888-e6060dbcec38@redhat.com>
Subject: Re: [PATCH v2 09/13] block/backup: remove yield_and_check
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-10-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> This is a respin of the same functionality as mirror_throttle,
> so trash this and replace it with the generic version.
>=20
> yield_and_check returned true if canceled, false otherwise.
> block_job_relax returns -ECANCELED if canceled, 0 otherwise.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index b4204c0ee4..0624c3b322 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -334,29 +334,17 @@ static void backup_complete(BlockJob *job, void *=
opaque)
>      g_free(data);
>  }
> =20
> -static bool coroutine_fn yield_and_check(BackupBlockJob *job)
> +static uint64_t get_delay_ns(BackupBlockJob *job)
>  {
>      uint64_t delay_ns =3D 0;
> =20
> -    if (block_job_is_cancelled(&job->common)) {
> -        return true;
> -    }
> -
> -    /* we need to yield so that bdrv_drain_all() returns.
> -     * (without, VM does not reboot)
> -     */
>      if (job->common.speed) {
>          delay_ns =3D ratelimit_calculate_delay(&job->limit,
>                                               job->bytes_read);
>          job->bytes_read =3D 0;
>      }
> =20
> -    block_job_relax(&job->common, delay_ns);
> -    if (block_job_is_cancelled(&job->common)) {
> -        return true;
> -    }
> -
> -    return false;
> +    return delay_ns;
>  }
> =20
>  static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
> @@ -369,7 +357,7 @@ static int coroutine_fn backup_run_incremental(Back=
upBlockJob *job)
>      hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
>      while ((cluster =3D hbitmap_iter_next(&hbi)) !=3D -1) {
>          do {
> -            if (yield_and_check(job)) {
> +            if (block_job_relax(&job->common, get_delay_ns(job))) {
>                  return 0;
>              }
>              ret =3D backup_do_cow(job, cluster * job->cluster_size,
> @@ -465,7 +453,7 @@ static void coroutine_fn backup_run(void *opaque)
>              bool error_is_read;
>              int alloced =3D 0;
> =20
> -            if (yield_and_check(job)) {
> +            if (block_job_relax(&job->common, get_delay_ns(job))) {
>                  break;
>              }
> =20
>=20

I'd very much prefer an explicit block_job_relax(...) =3D=3D -ECANCELED, =
I
have to say.

If you coerce me, I can give an R-b, but you'll have to wrest it from me
by force!

Max


--asfN1FQFTfEnoAr3Xw1H3O5wRVXxPhilo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7frsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATKAH/34xRg5DzTw8pmscT7T7MjnQsUymFCf7
2wvP8JzH7Y7Sakunh0G5xhz4D7EQmalhLo+G6QBiFmYIeXVykZx07wTNe1t51TFn
hpeUc4w6RO3XrwG6m4d4pe/94XZDUY0SNTr4+G+RTjSul9iAFLzXppAbyGbM5XX1
ysXkQkbptI8w5rTjtPrt06vtFoY015dBVoYOUcWmM43bKH7rAZYLl7VjgByNP2F2
ESa43TD5+dIoVpkU1PQ/mQRq2aNs/aphvPN+M4E4dQN/RGh5oaXvCxOtNNtoR1wi
6NY8YRHkapJHmGJZcfKs4FSdnrzSrVApIceJpgBiM4AMPHhz3MbYSbY=
=rYQj
-----END PGP SIGNATURE-----

--asfN1FQFTfEnoAr3Xw1H3O5wRVXxPhilo--
