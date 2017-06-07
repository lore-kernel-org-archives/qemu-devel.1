Received: from eggs.gnu.org ([2001:4830:134:3::10]:51248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIijx-0006qR-BE
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIijw-0005zb-GT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:43:45 -0400
References: <cover.1496844254.git.berto@igalia.com>
	<c49daf8afe80eade79ac53d305b83eb24b264338.1496844254.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ab8d614-be8d-b206-e52b-bd4539173bd7@redhat.com>
Date: Wed, 7 Jun 2017 16:43:34 -0500
MIME-Version: 1.0
In-Reply-To: <c49daf8afe80eade79ac53d305b83eb24b264338.1496844254.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ixjLf7jD828riQHUvjgKJr7khaIXEs5cV"
Subject: Re: [Qemu-devel] [PATCH v2 3/7] qcow2: Make perform_cow() call
 do_perform_cow() twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ixjLf7jD828riQHUvjgKJr7khaIXEs5cV
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1ab8d614-be8d-b206-e52b-bd4539173bd7@redhat.com>
Subject: Re: [PATCH v2 3/7] qcow2: Make perform_cow() call do_perform_cow()
 twice
References: <cover.1496844254.git.berto@igalia.com>
 <c49daf8afe80eade79ac53d305b83eb24b264338.1496844254.git.berto@igalia.com>
In-Reply-To: <c49daf8afe80eade79ac53d305b83eb24b264338.1496844254.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 09:08 AM, Alberto Garcia wrote:
> Instead of calling perform_cow() twice with a different COW region
> each time, call it just once and make perform_cow() handle both
> regions.
>=20
> This patch simply moves code around. The next one will do the actual
> reordering of the COW operations.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)

>      qemu_co_mutex_unlock(&s->lock);
> -    ret =3D do_perform_cow(bs, m->offset, m->alloc_offset, r->offset, =
r->nb_bytes);
> +    ret =3D do_perform_cow(bs, m->offset, m->alloc_offset,
> +                         start->offset, start->nb_bytes);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    ret =3D do_perform_cow(bs, m->offset, m->alloc_offset,
> +                         end->offset, end->nb_bytes);
> +
> +fail:

Since you reach this label even on success, it feels a bit awkward. I
probably would have avoided the goto and used fewer lines by refactoring
the logic as:

ret =3D do_perform_cow(..., start->...);
if (ret >=3D 0) {
    ret =3D do_perform_cow(..., end->...);
}

But that doesn't affect correctness, so whether or not you redo the
logic in the shorter fashion:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ixjLf7jD828riQHUvjgKJr7khaIXEs5cV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOHOGAAoJEKeha0olJ0Nq/akH/iuRM04t0+RdnavbqilTdCV+
qraIwpF7tWLAb6HeyFK6TdQr+8DGQhCbHMmxHB4ZAm9pyVw+wrZCyDpX3waH7AQV
JRCR3PM/N4kUb4qJnFdcP9jeZBIF4RP4p0dT9pkNCPOXFb7qvVuQGx6IY0ugHVfJ
Wpxa5KN5CZ51EWYVqkFTz1j6Zqg8BgI2vjbkl5VsSqXQBylGH3dL0WUbTnGeatc5
41XHxrY7WpBG/g0rlPWj+UBwWbNbniFVkU3P4YNWrzbn76Hz06iegX4/5+Z1w3aC
rwwC1+JpvSiTh1U2NWO+SKLGm8cu5i7jWA4CkiSuQFs6bfKyc/UlyMABVVgk+Ns=
=Ktym
-----END PGP SIGNATURE-----

--ixjLf7jD828riQHUvjgKJr7khaIXEs5cV--
