Received: from eggs.gnu.org ([2001:4830:134:3::10]:41141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fQAyz-0001Jv-Ko
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fQAyy-0002QL-MO
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:22:37 -0400
Date: Tue, 5 Jun 2018 13:22:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180605122229.GD13288@stefanha-x1.localdomain>
References: <20180605080710.27035-1-famz@redhat.com>
	<20180605080710.27035-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <20180605080710.27035-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] backup: Use copy offloading
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


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 04:07:10PM +0800, Fam Zheng wrote:
> The implementation is similar to the 'qemu-img convert'. In the
> beginning of the job, offloaded copy is attempted. If it fails, further
> I/O will go through the existing bounce buffer code path.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>

Nice, this has become much more readable.

> +/* Copy range to target and return the bytes copied. If error occured, r=
eturn a
> + * negative error number. */
> +static int backup_cow_with_offload(BackupBlockJob *job,

coroutine_fn

> +                                   int64_t start,
> +                                   int64_t end,
> +                                   bool is_write_notifier)
> +{
> +    int ret;
> +    int nr_clusters;
> +    BlockBackend *blk =3D job->common.blk;
> +    int nbytes;
> +
> +    assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
> +    nbytes =3D MIN(job->copy_range_size, end - start);
> +    nr_clusters =3D DIV_ROUND_UP(nbytes, job->cluster_size);
> +    hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
> +                  nr_clusters);
> +    ret =3D blk_co_copy_range(blk, start, job->target, start, nbytes,
> +                            is_write_notifier ? BDRV_REQ_NO_SERIALISING =
: 0);
> +    if (ret < 0) {
> +        job->use_copy_range =3D false;

This is not necessary since backup_do_cow() also sets it to false.  This
function doesn't need to know about job->use_copy_range.

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFoCFAAoJEJykq7OBq3PIP18H/A7Il4Qkykhht2/UnAhsldya
Guej7rjABw23Fp9S6U0IMfEhNKjTK3sIZ03aJ0A8Bhetx2Xw6O4aKTE3qkAn7SJ2
uVjX1Por9Or04lwo0MYTG/4s4o2IbEii6PtE+a69IwBBLGao6wYoeWYbyz54/zBU
usAdiB5A4h3GjWc1gixmEQMZVGAYnVrmDcDrIm5XUiec+K3iOhN5yCM2mdRQ95mK
gurddKj7xs0DzFMqrmyMvcyd5vJuvdg6nxF5jhEZb7qsCYMpEe9XB3B4CpVYkAY0
H8K6PNUiK4ZrLR+rgo7FVWn4SxKQiw3AQdsQKGXeodQPsSqJdVbNkpxrf/EnI28=
=u5dz
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
