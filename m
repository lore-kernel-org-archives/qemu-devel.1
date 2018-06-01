Received: from eggs.gnu.org ([2001:4830:134:3::10]:35109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOgpi-0005bW-UA
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOgpi-00079M-35
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:58:55 -0400
Date: Fri, 1 Jun 2018 10:58:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180601095843.GE8687@stefanha-x1.localdomain>
References: <20180531023445.5923-1-famz@redhat.com>
	<20180531023445.5923-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <20180531023445.5923-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 10:34:45AM +0800, Fam Zheng wrote:
> The implementation is similar to the 'qemu-img convert'. In the
> beginning of the job, offloaded copy is attempted. If it fails, further
> I/O will go through the existing bounce buffer code path.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/backup.c     | 93 +++++++++++++++++++++++++++++++++++-------------=
------
>  block/trace-events |  1 +
>  2 files changed, 62 insertions(+), 32 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 4e228e959b..ab189693f4 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -45,6 +45,8 @@ typedef struct BackupBlockJob {
>      QLIST_HEAD(, CowRequest) inflight_reqs;
> =20
>      HBitmap *copy_bitmap;
> +    bool use_copy_range;
> +    int64_t copy_range_size;
>  } BackupBlockJob;
> =20
>  static const BlockJobDriver backup_job_driver;
> @@ -111,49 +113,70 @@ static int coroutine_fn backup_do_cow(BackupBlockJo=
b *job,
>      cow_request_begin(&cow_request, job, start, end);
> =20
>      for (; start < end; start +=3D job->cluster_size) {
> +retry:

This for loop is becoming complex.  Please introduce helper functions.
The loop body can be replaced with something like this:

  if (!hbitmap_get(job->copy_bitmap, start / job->cluster_size)) {
      trace_backup_do_cow_skip(job, start);
      continue; /* already copied */
  }

  trace_backup_do_cow_process(job, start);

  ret =3D -ENOTSUPP;
  if (job->use_copy_range) {
      ret =3D cow_with_offload(...);
  }
  if (ret < 0) {
      job->use_copy_range =3D false;
      ret =3D cow_with_bounce_buffer(...);
  }
  if (ret < 0) {
      trace_backup_do_cow_write_fail(job, start, ret);
      goto out;
  }

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbERjTAAoJEJykq7OBq3PIv0MH+wcyZv+UNU+7lELc9uefKS0/
vcd2/X11uV29zOXXjB6sVkBiNJe3pFdxcmtokOk72OWzc0J3hn5cxh4pkmHwcP6e
nbxFdHsLQbQ44ZNjoWtkmTivkZfxq2M4Ed5mEDtrL6sgvYYv90Wsy4vQEbQZMqGL
AMGwXT2Dkg1r/oxZEj8Cxeio2qZw0McDuRkvr8qhSsh55MBFDOHQ7bchcTiDsQIC
epVVFOvX4/ozfF/Wq083Kf0JjL3ZnaxCPl7loY813r6clnY8Z32qWuS4clRxwGNu
uV8uqfuUqPI+ggOqN8LfoDDF+02NVpixOQM48r5u03gN0A9CN5zILmsFOx6rMJc=
=qCLa
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
