Received: from eggs.gnu.org ([209.51.188.92]:37685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1glgia-0003wm-Jp
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1glgiZ-00039Y-2l
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 16:02:52 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
Date: Mon, 21 Jan 2019 15:02:37 -0600
MIME-Version: 1.0
In-Reply-To: <20181221234750.23577-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u9qU9l5B6nkc40DW1xasqnPI2S5iODaGj"
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u9qU9l5B6nkc40DW1xasqnPI2S5iODaGj
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-4-mreitz@redhat.com>
In-Reply-To: <20181221234750.23577-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/21/18 5:47 PM, Max Reitz wrote:
> To do this, we need to allow creating the NBD server on various ports
> instead of a single one (which may not even work if you run just one
> instance, because something entirely else might be using that port).

Can you instead reuse the ideas from nbd_server_set_tcp_port() from
qemu-iotests/common.nbd?

>=20
> So we just pick a random port in [32768, 32768 + 1024) and try to creat=
e
> a server there.  If that fails, we just retry until something sticks.

That has the advantage of checking whether a port is actually in use
(using 'ss' - although it does limit the test to Linux-only; perhaps
using socat instead of ss could make the test portable to non-Linux?)

>=20
> For the IPv6 test, we need a different range, though (just above that
> one).  This is because "localhost" resolves to both 127.0.0.1 and ::1.
> This means that if you bind to it, it will bind to both, if possible, o=
r
> just one if the other is already in use.  Therefore, if the IPv6 test
> has already taken [::1]:some_port and we then try to take
> localhost:some_port, that will work -- only the second server will be
> bound to 127.0.0.1:some_port alone and not [::1]:some_port in addition.=

> So we have two different servers on the same port, one for IPv4 and one=

> for IPv6.
>=20
> But when we then try to connect to the server through
> localhost:some_port, we will always end up at the IPv6 one (as long as
> it is up), and this may not be the one we want.
>=20
> Thus, we must make sure not to create an IPv6-only NBD server on the
> same port as a normal "dual-stack" NBD server -- which is done by using=

> distinct port ranges, as explained above.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/147 | 98 +++++++++++++++++++++++++++++-------------=

>  1 file changed, 68 insertions(+), 30 deletions(-)
>=20

> @@ -88,17 +92,29 @@ class QemuNBD(NBDBlockdevAddBase):
>          except OSError:
>              pass
> =20
> +    def _try_server_up(self, *args):
> +        status, msg =3D qemu_nbd_pipe('-f', imgfmt, test_img, *args)
> +        if status =3D=3D 0:
> +            return True
> +        if 'Address already in use' in msg:
> +            return False
> +        self.fail(msg)

Do you actually need to attempt a qemu-nbd process, if you take my
suggestion of using ss to probe for an unused port?  And if not, do we
still need qemu_nbd_pipe() added earlier in the series?


> -        address =3D { 'type': 'inet',
> -                    'data': {
> -                        'host': 'localhost',
> -                        'port': str(NBD_PORT)
> -                    } }
> -        self._server_up(address, export_name)
> +        while True:
> +            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_END=
)

common.nbd just iterates, instead of trying random ports.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--u9qU9l5B6nkc40DW1xasqnPI2S5iODaGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxGM20ACgkQp6FrSiUn
Q2oY3Af/eY6w8+bGv1FxoOZrTAeO7c4bFJjo87OTpB7+jqPY5dAJFyBBnqsh8mmg
kNKuGGt6D9OYYwzRUr7wvCLpHi65CgsmcGFGLmUzQvoEH+8zposD83GV5sciE5BH
4mJaAG0sHtMNv3njmVQQ4rbGZsUFvQvoqQXfzdxsXUKPkhp5/VjL3nbPPUP0PwUd
RGdz+pvu8efdKcS5qGa7d8cMzPVCZG3qnJAhT84n5gTgnK/8vYIP6vxJxN3VCCIB
mp2uD0dzxz2VRZI7HfgF1+I74nf8MQ3K9brmDrD9hxiwZdCsxGyvDwLofwzipR7H
8AT1JPwc2NEmpvMX6C0gEQpaFynLEQ==
=now6
-----END PGP SIGNATURE-----

--u9qU9l5B6nkc40DW1xasqnPI2S5iODaGj--
