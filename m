Received: from eggs.gnu.org ([2001:4830:134:3::10]:40238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGnDL-0000e5-P9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGnDG-0008CJ-Gw
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:38:23 -0500
Date: Mon, 20 Nov 2017 14:38:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120143814.GF4516@stefanha-x1.localdomain>
References: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510851298-59922-5-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
In-Reply-To: <1510851298-59922-5-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] iotests: 030: add compressed
 block-stream test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 07:54:58PM +0300, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  tests/qemu-iotests/030     | 66 ++++++++++++++++++++++++++++++++++++++++=
+++++-
>  tests/qemu-iotests/030.out |  4 +--
>  2 files changed, 67 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 457984b..831d6f3 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -21,7 +21,7 @@
>  import time
>  import os
>  import iotests
> -from iotests import qemu_img, qemu_io
> +from iotests import qemu_img, qemu_img_pipe, qemu_io
> =20
>  backing_img =3D os.path.join(iotests.test_dir, 'backing.img')
>  mid_img =3D os.path.join(iotests.test_dir, 'mid.img')
> @@ -804,5 +804,69 @@ class TestSetSpeed(iotests.QMPTestCase):
> =20
>          self.cancel_and_wait(resume=3DTrue)
> =20
> +class TestCompressed(iotests.QMPTestCase):
> +    supported_fmts =3D ['qcow2']
> +    cluster_size =3D 64 * 1024;
> +    image_len =3D 1 * 1024 * 1024;

Please drop the unnecessary semicolons

> +
> +    def setUp(self):
> +        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=3D%=
d' % TestCompressed.cluster_size, backing_img, str(TestCompressed.image_len=
))
> +        qemu_io('-c', 'write -P 1 0 ' + str(TestCompressed.image_len), b=
acking_img)
> +        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s,cluster_size=3D%d' % (backing_img, TestCompressed.cluster_size), test_img)
> +
> +        # write '3' in every 3rd cluster
> +        step =3D 3
> +        for off in range(0, TestCompressed.image_len, TestCompressed.clu=
ster_size * step):
> +            qemu_io('-c', 'write -P %d %d %d' %
> +                    (step, off, TestCompressed.cluster_size), test_img)
> +
> +        self.vm =3D iotests.VM().add_drive(test_img)
> +        self.vm.launch()
> +
> +    def tearDown(self):
> +        os.remove(test_img)
> +        os.remove(backing_img)
> +
> +    def _first_divider(self, x, divs):

"Divisor" or "factor":
https://en.wikipedia.org/wiki/Divisor

> +        return divs[0] if not x%divs[0] else self._first_divider(x, divs=
[1:])

An alternative that I find easier to read than conditional expressions:

  for divisor in divs:
      if x % divisor =3D=3D 0:
          return divisor
  raise ValueError('No suitable divisor found')

> +
> +    def test_compressed(self):
> +        self.assert_no_active_block_jobs()
> +
> +        result =3D self.vm.qmp('block-stream', device=3D'drive0', compre=
ss=3DTrue)
> +        if iotests.imgfmt not in TestCompressed.supported_fmts:
> +            self.assert_qmp(
> +                result, 'error/desc',
> +                'Compression is not supported for this drive drive0')
> +            return
> +        self.assert_qmp(result, 'return', {})
> +
> +        # write '4' in every 4th cluster
> +        step =3D 4
> +        for off in range(0, TestCompressed.image_len, TestCompressed.clu=
ster_size * step):
> +            result =3D self.vm.qmp('human-monitor-command',
> +                                 command_line=3D
> +                                 'qemu-io drive0 "write -P %d %d %d"' %
> +                                 (step, off, TestCompressed.cluster_size=
))
> +            self.assert_qmp(result, 'return', "")
> +
> +        self.wait_until_completed()
> +        self.assert_no_active_block_jobs()
> +
> +        self.vm.shutdown()

It is safe to call self.vm.shutdown() multiple times.  Please call it
=66rom tearDown() too so the QEMU process is cleaned up on failure.

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaEujWAAoJEJykq7OBq3PImpgH/3jbiLCFOZyvI/Y6bzpMPJY9
BIluu1DGqNGsujni6v/drSfQQFVwd/Kgj9+I9DmsOgcwAkw5C2YhNW9rLrfvvQ0t
HeFrrTAwsP6Ps1fTwNZ3c3IAnoYrXTUQJ7tbXWlsniTrob6dbqAvRsBuJ5xQh2Nh
uHPgS14dGlSCiw36fsXo0gIifcPy7L582Go5+c9f2NRvP3LH13vOeSJUa4vPTKFS
kefN8Rh8R9CQodpE0n6yXJdJ+E9IrtWlgEFQF0pFPlUTEno8s84/4SGzX14iRaAR
P6diAaZ5WkDSDz60o5rFJGn3lTleug6ZjQZHAifFw3HyOMsPBrqamrHCwy0uQLE=
=SDId
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
