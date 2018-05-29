Received: from eggs.gnu.org ([2001:4830:134:3::10]:54538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdFW-0002gR-2M
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdFV-000693-7V
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:57:10 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ed82683a-9935-205a-ea99-fa3910001209@redhat.com>
Date: Tue, 29 May 2018 13:56:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="euc4g1Qs6HSxG5ZcI1YoPPLJXsOr4FNwl"
Subject: Re: [Qemu-devel] [PATCH 07/14] qemu-iotests: Add
 iotests.img_info_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--euc4g1Qs6HSxG5ZcI1YoPPLJXsOr4FNwl
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <ed82683a-9935-205a-ea99-fa3910001209@redhat.com>
Subject: Re: [PATCH 07/14] qemu-iotests: Add iotests.img_info_log()
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-8-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This adds a filter function to postprocess 'qemu-img info' input
> (similar to what _img_info does), and an img_info_log() function that
> calls 'qemu-img info' and logs the filtered output.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
=2Epy
> index 319d898172..20ce5a0cf0 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -109,6 +109,10 @@ def qemu_img_pipe(*args):
>          sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitc=
ode, ' '.join(qemu_img_args + list(args))))
>      return subp.communicate()[0]
> =20
> +def img_info_log(filename):
> +    output =3D qemu_img_pipe('info', '-f', imgfmt, filename)
> +    log(filter_img_info(output, filename))
> +
>  def qemu_io(*args):
>      '''Run qemu-io and return the stdout data'''
>      args =3D qemu_io_args + list(args)
> @@ -210,6 +214,18 @@ def filter_testfiles(msg):
>      prefix =3D os.path.join(test_dir, "%s-" % (os.getpid()))
>      return msg.replace(prefix, 'TEST_DIR/')
> =20
> +def filter_img_info(output, filename):
> +    lines =3D []
> +    for line in output.split('\n'):
> +        if 'disk size' in line or 'actual size' in line:

Wouldn't that be 'actual-size' (because I presume this is for JSON output=
)?

> +            continue
> +        line =3D line.replace(filename, 'TEST_DIR/t.IMGFMT') \

Why not just 'TEST_IMG'?

Max

> +                   .replace(imgfmt, 'IMGFMT')
> +        line =3D re.sub('iters: [0-9]+', 'iters: XXX', line)
> +        line =3D re.sub('uuid: [-a-f0-9]+', 'uuid: XXXXXXXX-XXXX-XXXX-=
XXXX-XXXXXXXXXXXX', line)
> +        lines.append(line)
> +    return '\n'.join(lines)
> +
>  def log(msg, filters=3D[]):
>      for flt in filters:
>          msg =3D flt(msg)
>=20



--euc4g1Qs6HSxG5ZcI1YoPPLJXsOr4FNwl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNQAoACgkQ9AfbAGHV
z0Bx/QgAjag2mbqfE6GvY6bQnprQcP1OEQeppEmMGsZ0pU68dglhZt6Qbif2JgpU
etB7updzIV/Nj3H1p9nK9fjVcwzcSbj4XnB87Cw4djL8gbVHm3BGGXWfs160XE4C
JaNdv2qJLOeZVyUPXJce6Yxd0iCivYwfTIUdYF0XxdCqK9wu8ftqlvv/FQqftCua
q4gAGYlL0Jopd1tXM3zpifNy99d46ODq424NEAFKsuJnQGElEB/lrE8GgT+xkNJ/
zT1KZK8em0oMOjzYlKzVYiBYb1RqsYcrwAS31G0kl4DWjUDpLHmJeHKUlXaunJsi
i4kJ6roKyJ5KaHmZqNr3KljjQiYPCw==
=0oU7
-----END PGP SIGNATURE-----

--euc4g1Qs6HSxG5ZcI1YoPPLJXsOr4FNwl--
