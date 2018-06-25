Received: from eggs.gnu.org ([2001:4830:134:3::10]:52213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fXNIf-00017M-7O
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fXNIe-0000Gh-FN
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:56:41 -0400
Date: Mon, 25 Jun 2018 09:56:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180625085631.GA29002@stefanha-x1.localdomain>
References: <20180621170657.27542-1-kwolf@redhat.com>
	<20180621170657.27542-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20180621170657.27542-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] file-posix: Make
 .bdrv_co_truncate asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 07:06:57PM +0200, Kevin Wolf wrote:
> +    RawPosixAIOData *acb =3D g_new(RawPosixAIOData, 1);
> +    ThreadPool *pool;
> =20
> -out:
> -    if (result < 0) {
> -        if (ftruncate(fd, current_length) < 0) {
> -            error_report("Failed to restore old file length: %s",
> -                         strerror(errno));
> -        }
> -    }
> +    *acb =3D (RawPosixAIOData) {
> +        .bs             =3D bs,
> +        .aio_fildes     =3D fd,
> +        .aio_type       =3D QEMU_AIO_TRUNCATE,
> +        .aio_offset     =3D offset,
> +        .prealloc       =3D prealloc,
> +        .errp           =3D errp,
> +    };
> =20
> -    g_free(buf);
> -    return result;
> +    /* @bs can be NULL, bdrv_get_aio_context() returns the main context =
then */
> +    pool =3D aio_get_thread_pool(bdrv_get_aio_context(bs));
> +    return thread_pool_submit_co(pool, aio_worker, acb);

Where is acb freed?

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbMK4/AAoJEJykq7OBq3PI9HIH/1L4LsB1n+GCky5KDdhL3E++
JyXtzObZsWSnUzZAP0M5Q0l0/+2HR2HtpfI2TiJcdeVLrRQClSBKtTBiUHXCQ1Xr
+5K2596AajlwGlXFTNrADjXLHqsGN8XDU0bpbmgwmtiSt0h+jpFnz0eoUj5Jsw2g
p6VSfS8TP0y9I24JlYHhE3bmO61WJt/vaceLOolWzj98piyaHFEoO9M6BNLFO2x2
DbdWYYIEW0MY4UtYGN/+PiJGPR0YgOtqAoizx4w2KKHWTagX7NJezGl1DFUXgRGy
kBn96BccGPO4Fka7YbF077Ic6ZbiDk6aiMg58g19PA5iU6FU5WlpyEHjXrNFcxA=
=k8+2
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
