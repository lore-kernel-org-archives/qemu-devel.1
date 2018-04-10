Received: from eggs.gnu.org ([2001:4830:134:3::10]:60224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f60t9-00079y-Ao
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f60t5-0005qr-AB
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:33:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f60t5-0005qS-3f
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:33:11 -0400
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>
Date: Tue, 10 Apr 2018 16:33:03 -0500
MIME-Version: 1.0
In-Reply-To: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GM5qJd6f5V19ixLaMFY9MorT79nstERuU"
Subject: Re: [Qemu-devel] [PATCH] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GM5qJd6f5V19ixLaMFY9MorT79nstERuU
From: Eric Blake <eblake@redhat.com>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Message-ID: <0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qmp: add pmemload command
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
In-Reply-To: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 04:24 PM, Simon Ruderich wrote:
> Adapted patch from Baojun Wang [1] with the following commit message:
>=20
>     I found this could be useful to have qemu-softmmu as a cross
>     debugger (launch with -s -S command line option), then if we can
>     have a command to load guest physical memory, we can use cross gdb
>     to do some target debug which gdb cannot do directly.
>=20
> pmemload is necessary to directly write physical memory which is not
> possible with gdb alone as it uses only logical addresses.
>=20
> [1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00073.h=
tml
>=20
> Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---

> +void qmp_pmemload(int64_t addr, int64_t size, const char *filename,
> +                  Error **errp)
> +{
> +    FILE *f;
> +    size_t l;
> +    uint8_t buf[1024];
> +
> +    f =3D fopen(filename, "rb");

Use qemu_fopen() here, so that you can automagically support /dev/fdset/
magic filenames that work on file descriptors passed via SCM_RIGHTS.


> +++ b/qapi-schema.json
> @@ -1136,6 +1136,24 @@
>  { 'command': 'pmemsave',
>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> =20
> +##
> +# @pmemload:
> +#
> +# Load a portion of guest physical memory from a file.
> +#
> +# @val: the physical address of the guest to start from

Is 'val' really the best name for this, or would 'phys-addr' or similar
be a more descriptive name?

> +#
> +# @size: the size of memory region to load
> +#
> +# @filename: the file to load the memory from as binary data
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.10

You've missed 2.10 by a long shot.  The earliest this new feature could
appear is 2.13.

Do you additionally need an offset where to start reading from within
the file (that is, since you already have the 'size' parameter to avoid
reading the entire file, and the 'val' parameter to target anywhere in
physical memory, how do I start reading anywhere from the file)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GM5qJd6f5V19ixLaMFY9MorT79nstERuU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrNLY8ACgkQp6FrSiUn
Q2rS6Qf9H/PgJobFdchKwqcaVj7dfBBAyNeZsKkMFtOyc7mYALy1oe+HuXFOLnKH
A32PrjU3ePIkWfljejspFuBz7lHoKv55gIcQ1ihtJ8SAOpI/xArzkLn7T5FCrnaL
38qnfWHhty/rP3ilSM7kUQzwjRHruW+XpJefcvUoXNBpXjvE9FvI27O7oj0i5rHW
56V+TcVVpYd3LvfXcLp0ywUoIPQ7mxPTBBcs7MGuoP9gA/7nYd6uVElvQrHFo3Ip
42LcKCHoBYXDBESLgjwuHEtHs2R1Eb3HxS+ih5THtn2cYOWbTO/E+6atKQnB2/DX
W2HW4jksU6GbhjFDacHgCq86HrUYJQ==
=mZgI
-----END PGP SIGNATURE-----

--GM5qJd6f5V19ixLaMFY9MorT79nstERuU--
