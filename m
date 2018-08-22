Received: from eggs.gnu.org ([2001:4830:134:3::10]:43503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsS2f-0003rW-HC
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsS2e-0008Mi-Gf
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:15:17 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <553da197-ebd0-1eda-909c-aa0740332737@redhat.com>
Date: Wed, 22 Aug 2018 14:15:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h1yGjZN4EsrtdFRZuHy4klndtL7SR5jnv"
Subject: Re: [Qemu-devel] [PATCH 5/7] block/mirror: utilize job_exit shim
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
--h1yGjZN4EsrtdFRZuHy4klndtL7SR5jnv
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <553da197-ebd0-1eda-909c-aa0740332737@redhat.com>
Subject: Re: [PATCH 5/7] block/mirror: utilize job_exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-6-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
> Change the manual deferment to mirror_exit into the implicit
> callback to job_exit and the mirror_exit callback.
>=20
> This does change the order of some bdrv_unref calls and job_completed,
> but thanks to the new context in which we call .job_exit, this is safe
> to defer the possible flushing of any nodes to the job_finalize_single
> cleanup stage.

Ah, right, I forgot this.  Hm, what exactly do you mean?  This function
is executed in the main loop, so it can make 'src' go away.  I don't see
any difference to before.

The only difference I see is that the BH-scheduled function is now
job_exit() instead of just mirror_complete() (which is now called as
part of job_exit()).  But then again, it was mirror_complete() itself
that called job_completed(), like it is now job_exit().  So if
everything worked after this patch, I don't see why mirror_complete()
would bdrv_ref() 'src' around job_completed().

Max

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)


--h1yGjZN4EsrtdFRZuHy4klndtL7SR5jnv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9U8oACgkQ9AfbAGHV
z0CrJgf/eCrfvAPajqLiFDPqx9dvxkvZAADDve6hK8WFUDk8B807tey0+aJT+gCD
+BNebDV84+g5jEXg3Cj52HBvHSpRRTkIjSRJgzi0jbbhtIsIsdghoPGj6QTg3zCz
/5LGW6WaRFH3LPeoX/1jtD0NuRyx9IZ3YkJeFtBX9Yqxjw/s1hEWgV8+tVG0Rhyu
3Wb6LsrLkLW50D1FRdkNTdllh2mxbhV24rf7D/EXC6dpUa/RrKszOyQnlUQhU+53
7gKpzfzHG3Fes27A+Tj+ATZaFvmdPiF8RJW4Be01crUOGTlOQjD5yj3F8AvWq4fc
TuJoxC4z/RwPy/WGTg/I10g0fH2bSA==
=0kXV
-----END PGP SIGNATURE-----

--h1yGjZN4EsrtdFRZuHy4klndtL7SR5jnv--
