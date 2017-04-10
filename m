Received: from eggs.gnu.org ([2001:4830:134:3::10]:53106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxV8m-0006NB-VS
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxV8i-0000pL-4L
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:57:41 -0400
Date: Mon, 10 Apr 2017 09:57:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410085728.GB2567@stefanha-x1.localdomain>
References: <20170321031635.22123-1-famz@redhat.com>
	<20170321031635.22123-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20170321031635.22123-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 04/16] block: Propagate
 BLK_PERM_AIO_CONTEXT_CHANGE down the graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2017 at 11:16:23AM +0800, Fam Zheng wrote:
> @@ -1713,21 +1714,22 @@ void bdrv_format_default_perms(BlockDriverState *=
bs, BdrvChild *c,
>          perm |=3D BLK_PERM_CONSISTENT_READ;
>          shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
>      } else {
> -        /* We want consistent read from backing files if the parent need=
s it.
> +        /* We want consistent read and aio context change from backing f=
iles if
> +         * the parent needs it.
>           * No other operations are performed on backing files. */
> -        perm &=3D BLK_PERM_CONSISTENT_READ;
> +        perm &=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_AIO_CONTEXT_CHANGE;
> =20
> -        /* If the parent can deal with changing data, we're okay with a
> +        /* If the parent can deal with changing aio context, we're okay =
too;
> +         * If the parent can deal with changing data, we're okay with a
>           * writable and resizable backing file. */
>          /* TODO Require !(perm & BLK_PERM_CONSISTENT_READ), too? */
> +        shared &=3D BLK_PERM_AIO_CONTEXT_CHANGE | BLK_PERM_WRITE;
>          if (shared & BLK_PERM_WRITE) {
> -            shared =3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
> -        } else {
> -            shared =3D 0;
> +            shared |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;

We already have BLK_PERM_WRITE so we're just adding BLK_PERM_RESIZE.
The following is clearer:

  shared |=3D BLK_PERM_RESIZE;

>          }
> =20
>          shared |=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
> -                  BLK_PERM_WRITE_UNCHANGED;
> +                  BLK_PERM_WRITE_UNCHANGED | BLK_PERM_AIO_CONTEXT_CHANGE;

Why was shared &=3D BLK_PERM_AIO_CONTEXT_CHANGE necessary above if we
unconditionally OR it here?

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY60j4AAoJEJykq7OBq3PIAmQIALJynocEvzXDC3QpL3UDkQJQ
fLhKB/SxoIaA1OijRP7BBWvWWm+k+4IvfJ3NUyxoHQBU5Fy/Z7ubMByCw8Mvd7Xa
9hA8CgXfeCK8SuYDztj2cAcV3UYbmMMcHWW1e369MVVXHhm7913pz4MQJPeti934
pVKMY495xx3gJDpEa/Wt3l+Vi33LjUEOhBZSuObFXA5ee0UfZFU/0AjA3Qwsc4BE
dTBDiw5mmaNKdhsh6N8j0Sd1hPDB3Hoi8hyCA4xy1gRylmM/RMA3fdBwP98gGEIf
8gw2EB9rnGulfUQecIbiUXaWOXKktYhfOuPU5+ptun4FV/jMPpv+pQkCFsay7lY=
=R7gA
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
