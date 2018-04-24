Received: from eggs.gnu.org ([2001:4830:134:3::10]:35759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB5x3-0001Ki-2M
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB5x2-0003Sh-0n
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:58:17 -0400
References: <20180424152515.25664-1-kwolf@redhat.com>
	<20180424152515.25664-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2668fdc-6baa-2e18-dc01-4af82db07eb3@redhat.com>
Date: Tue, 24 Apr 2018 16:57:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180424152515.25664-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bkPiWN9A7n0sxOQFlgbdOPGv8TNmPh5nO"
Subject: Re: [Qemu-devel] [RFC PATCH 04/33] blockjob: Introduce
 block_job_ratelimit_get_delay()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bkPiWN9A7n0sxOQFlgbdOPGv8TNmPh5nO
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <d2668fdc-6baa-2e18-dc01-4af82db07eb3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 04/33] blockjob: Introduce
 block_job_ratelimit_get_delay()
References: <20180424152515.25664-1-kwolf@redhat.com>
 <20180424152515.25664-5-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:24 AM, Kevin Wolf wrote:
> This gets us rid of more direct accesses to BlockJob fields from the
> job drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/include/block/blockjob_int.h
> @@ -166,6 +166,14 @@ void block_job_sleep_ns(BlockJob *job, int64_t ns)=
;
>  void block_job_yield(BlockJob *job);
> =20
>  /**
> + * block_job_ratelimit_get_delay:
> + *
> + * Calculate and return delay for the next request in ns. See the docu=
emntation

s/docuemntation/documentation/

> + * of ratelimit_calculate_delay() for details.
> + */
> +int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n);

Signed return type matches ratelimit_calculate_delay, but what does a
negative return really mean?  Hmm, it looks like it can't actually
return a negative, other than if qemu_clock_get_ns() returns a negative
on some sort of error (which appears to be unlikely - we don't even
bother checking for it, even though it would mess things up if it did
happen) - all other return paths are 0 or a subtraction between time
values that can't overflow a 64-bit integer in our lifetime.  Should we
audit the source to flip the callers to use an unsigned value, perhaps
as a separate cleanup?

> +
> +/**
>   * block_job_pause_all:
>   *
>   * Asynchronously pause all jobs.
> diff --git a/block/backup.c b/block/backup.c
> index 8468fd9f94..3f3ec6e408 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -325,21 +325,17 @@ static void backup_complete(BlockJob *job, void *=
opaque)
> =20
>  static bool coroutine_fn yield_and_check(BackupBlockJob *job)
>  {
> +    uint64_t delay_ns;
> +
>      if (block_job_is_cancelled(&job->common)) {
>          return true;
>      }
> =20
> -    /* we need to yield so that bdrv_drain_all() returns.
> -     * (without, VM does not reboot)
> -     */
> -    if (job->common.speed) {
> -        uint64_t delay_ns =3D ratelimit_calculate_delay(&job->common.l=
imit,
> -                                                      job->bytes_read)=
;
> -        job->bytes_read =3D 0;
> -        block_job_sleep_ns(&job->common, delay_ns);
> -    } else {
> -        block_job_sleep_ns(&job->common, 0);
> -    }
> +    /* we need to yield even for delay_ns =3D 0 so that bdrv_drain_all=
() returns.
> +     * (without it, the VM does not reboot) */

As long as you are touching this, is it worth further improving the gramm=
ar?

/* We need to yield even for delay_ns =3D 0 so that bdrv_drain_all() can
return; without a yield, the VM would not reboot. */

> +    delay_ns =3D block_job_ratelimit_get_delay(&job->common, job->byte=
s_read);
> +    job->bytes_read =3D 0;
> +    block_job_sleep_ns(&job->common, delay_ns);
> =20
>      if (block_job_is_cancelled(&job->common)) {
>          return true;

With typo fixes,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bkPiWN9A7n0sxOQFlgbdOPGv8TNmPh5nO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfqGcACgkQp6FrSiUn
Q2pePggAgcDy+1DPKLc/M0Mhp1yTnpp/Rncb/A/JXNKBzHy31UDe0dJmn5EJjOjN
xzUJVL/E0DoL+ltlMCRGxQL4u9PLO8eYA5UesSS4BQux3ilaGw7Q1YvaktxK4ly5
TLHtMcSz3/wlL9BlV0arTZ+Ug7pzZHrZdUowe5eglPSa6TZm1ESlfPuwTHjnHrWc
RVUKbBMUCjrUr3/nyZimDpbM0q7lKCxkSVwV0nk9iCS6ngHgKE/rCKW3o9v3ladd
cuQuq/IEzjjEUK0o6QgaYbLIzGYKATArZk2RIaw9SD2UeXTPjh1vGWYX4iA69zlk
5HRTT45MlcbBusVy30rmaqM0uShWyw==
=Z0wM
-----END PGP SIGNATURE-----

--bkPiWN9A7n0sxOQFlgbdOPGv8TNmPh5nO--
