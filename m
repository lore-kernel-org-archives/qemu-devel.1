Received: from eggs.gnu.org ([2001:4830:134:3::10]:37849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eC1V2-0005M1-9B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eC1Ux-0000mo-W0
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:52:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eC1Ux-0000lK-Ln
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:52:51 -0500
Date: Tue, 7 Nov 2017 10:52:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171107105244.GD6809@stefanha-x1.localdomain>
References: <1509986155-4735-1-git-send-email-nanjekyejoannah@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <1509986155-4735-1-git-send-email-nanjekyejoannah@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH] remove numpy dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joannah Nanjekye <nanjekyejoannah@gmail.com>
Cc: qemu-devel@nongnu.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 07:35:55PM +0300, Joannah Nanjekye wrote:
> Users tend to hit an ImportError when running analyze-migration.py due
> to the numpy dependency.  numpy functionality isn't actually used, just
> binary serialization that the standard library 'struct' module already
> provides.  Removing the dependency allows the script to run
> out-of-the-box.
>=20
> Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com>
> ---
>  scripts/analyze-migration.py | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 1455387..6175c99 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -17,7 +17,6 @@
>  # You should have received a copy of the GNU Lesser General Public
>  # License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
> =20
> -import numpy as np
>  import json
>  import os
>  import argparse
> @@ -36,23 +35,29 @@ class MigrationFile(object):
>          self.file =3D open(self.filename, "rb")
> =20
>      def read64(self):
> -        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i=
8')[0])

dtype=3D'>i8' is a 64-bit (8 bytes) big-endian signed integer according to
https://docs.scipy.org/doc/numpy-1.13.0/reference/arrays.dtypes.html#arrays=
-dtypes-constructing.

> +        buffer =3D file.read(64)

This reads 64 bytes (not bits!).  It should read 8 bytes.

> +        return struct.unpack('>i16', buffer)[0]

This should be '>q' according to
https://docs.python.org/2.7/library/struct.html#format-strings.

> =20
>      def read32(self):
> -        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i=
4')[0])
> +        buffer =3D file.read(32)

read(4)

> +        return struct.unpack('>i8', buffer)[0]

'>i'

> =20
>      def read16(self):
> -        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i=
2')[0])
> +        buffer =3D file.read(16)

read(2)

> +        return struct.unpack('>i4', buffer)[0]

'>h'

> =20
>      def read8(self):
> -        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i=
1')[0])
> +        buffer =3D file.read(8)

read(1)

> +        return struct.unpack('>i2', buffer)[0]

'b'

> =20
>      def readstr(self, len =3D None):
> +        read_format =3D str(len) + 'd'
>          if len is None:
>              len =3D self.read8()
>          if len =3D=3D 0:
>              return ""
> -        return np.fromfile(self.file, count=3D1, dtype=3D('S%d' % len))[=
0]
> +        buffer =3D file.read(8)
> +        return struct.unpack(read_format, buffer[0:(0 + struct.calcsize(=
read_format))])

According to the numpy documentation 'S' produces raw bytes (not a
unicode string).  To get the raw bytes we just need file.read(len).  The
struct module isn't needed.

Something like this should work:

  if len is None:
      len =3D self.read8()
  if len =3D=3D 0:
      return ""
  return file.read(len).split(b'\0')[0]

> =20
>      def readvar(self, size =3D None):
>          if size is None:
> @@ -303,8 +308,10 @@ class VMSDFieldInt(VMSDFieldGeneric):
> =20
>      def read(self):
>          super(VMSDFieldInt, self).read()
> -        self.sdata =3D np.fromstring(self.data, count=3D1, dtype=3D(self=
=2Esdtype))[0]
> -        self.udata =3D np.fromstring(self.data, count=3D1, dtype=3D(self=
=2Eudtype))[0]
> +        buffer =3D file.read(self.data)

This statement doesn't make sense.  According to the Python
documentation:

  read([size]) -> read at most size bytes, returned as a string.

self.data *is* the buffer.  There's no need to call file.read().

> +        read_format =3D self.sdtype

Unused.

> +        self.sdata =3D struct.unpack(self.sdtype, buffer[0:(0 + struct.c=
alcsize(self.sdtype))])

struct.calcsize() is unnecessary since self.size already contains the
size in bytes.

struct.unpack returns a tuple and we need the first element, so it
should be:

  self.sdata =3D struct.unpack(...)[0]

> +        self.sdata =3D struct.unpack(self.udtype, buffer[0:(0 + struct.c=
alcsize(self.udtype))])

The data type specifiers are incorrect because the struct module uses
different syntax than numpy:

  self.sdtype =3D '>i%d' % self.size
  self.udtype =3D '>u%d' % self.size

The struct data type specifiers can be looked up like this:

  sdtypes =3D {1: 'b', 2: '>h', 4: '>i', 8: '>q'}
  udtypes =3D {1: 'B', 2: '>H', 4: '>I', 8: '>Q'}
  self.sdtype =3D sdtypes[self.size]
  self.udtype =3D udtypes[self.size]

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAZB8AAoJEJykq7OBq3PIBSgIAKcwLO9GoIfNybXcdYNGlmLM
ORjOeMFTKJm5jTprEh0TXLGLkLt9oL0YjKgw6INkbldq0qq9qpuAJXVduPmiE7gD
7KT6HUTunK12pdkW6fKjlvl9QYq+NZFlWnl3v5SzKWFowHy06A/fVjs+UuKePCS4
p/vNruacwtKQow2GayVcHvC6baxw7iVmDgyw1z+H4RkyzHTZbAhpJ4eTyv5nSnGU
ZXS0jrwfQ+V2+4BURNv7NV3mvyZHjD4ZMQTVC1sFgMemIIE13uaNA4CUGrnyM71Y
x8I7jVeywEuQBbB6CdJn8cVepqO58OhxAjsg58o55lZ7RC2JQ4tV6RPWG8aQljw=
=HluM
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
