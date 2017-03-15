Received: from eggs.gnu.org ([2001:4830:134:3::10]:40493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cnzVs-0004JC-4m
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cnzVn-0004fD-6K
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:22:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cnzVm-0004en-Uh
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:22:07 -0400
Date: Wed, 15 Mar 2017 11:21:58 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170315032158.GK13140@stefanha-x1.localdomain>
References: <1488800630-32054-1-git-send-email-nanjekyejoannah@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <1488800630-32054-1-git-send-email-nanjekyejoannah@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1] Provided python3 support for qmp.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joannah Nanjekye <nanjekyejoannah@gmail.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 02:43:50PM +0300, Joannah Nanjekye wrote:
> From: Joannah Najekye <nanjekyejoannah@gmail.com>
>=20
> Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com>
> ---

Text below '---' is not included as part of the commit description.  I
think the following lines should be included, they describe the purpose
of the patch.  Please the text above '---'.

>=20
> The patch provides python 3 support for one of the scripts  in scripts/qm=
p that is to say qmp.py. This is not a port to python 3 but rather the patc=
h ensures that the script runs fine for both python 2 and 3.=20
>=20
> Minimum Python Versions supported:
>=20
> Python 2 : python 2.6 +
> Python 3 : python 3.3 +
>=20
> The two new imports future and builtins introduced refer to the future=20
> pip-installable package on PyPI.

PyPI packages can be used if necessary but dependencies should be
minimized.  Comments on the new dependencies below:

>  scripts/qmp/qmp.py | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 62d3651..6dcb870 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -7,7 +7,9 @@
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2.  See
>  # the COPYING file in the top-level directory.
> -
> +from __future__ import absolute_import, print_function, unicode_literals
> +from future.utils import raise_from

Why is raise_from() needed?  My understanding is that it provides
exception chaining, which this code doesn't use.  Therefore plain
'raise' is enough.  The dependency can be dropped.

> +from builtins import str=20
>  import json
>  import errno
>  import socket
> @@ -57,12 +59,12 @@ class QEMUMonitorProtocol:
>      def __negotiate_capabilities(self):
>          greeting =3D self.__json_read()
>          if greeting is None or not greeting.has_key('QMP'):
> -            raise QMPConnectError
> +            raise_from(QMPConnectError())
>          # Greeting seems ok, negotiate capabilities
>          resp =3D self.cmd('qmp_capabilities')
>          if "return" in resp:
>              return greeting
> -        raise QMPCapabilitiesError
> +        raise_from(QMPCapabilitiesError())
> =20
>      def __json_read(self, only_event=3DFalse):
>          while True:
> @@ -72,7 +74,7 @@ class QEMUMonitorProtocol:
>              resp =3D json.loads(data)
>              if 'event' in resp:
>                  if self._debug:
> -                    print >>sys.stderr, "QMP:<<< %s" % resp
> +                    print(u"QMP:<<< %s" % str(resp), file=3Dsys.stderr)=
=20

Why is str() necessary?  resp is a dict and the %s format specifier
already produces a string representation.

The same applies to the str(qmp_cmd) and str(resp) changes below.

>                  self.__events.append(resp)
>                  if not only_event:
>                      continue
> @@ -111,11 +113,11 @@ class QEMUMonitorProtocol:
>              try:
>                  ret =3D self.__json_read(only_event=3DTrue)
>              except socket.timeout:
> -                raise QMPTimeoutError("Timeout waiting for event")
> +                raise_from(QMPTimeoutError("Timeout waiting for event"))
>              except:
> -                raise QMPConnectError("Error while reading from socket")
> +                raise_from(QMPConnectError("Error while reading from soc=
ket"))
>              if ret is None:
> -                raise QMPConnectError("Error while reading from socket")
> +                raise_from(QMPConnectError("Error while reading from soc=
ket"))
>              self.__sock.settimeout(None)
> =20
>      def connect(self, negotiate=3DTrue):
> @@ -155,16 +157,16 @@ class QEMUMonitorProtocol:
>                  been closed
>          """
>          if self._debug:
> -            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
> +            print(u"QMP:>>> %s" % str(qmp_cmd), file=3Dsys.stderr)=20
>          try:
>              self.__sock.sendall(json.dumps(qmp_cmd))
>          except socket.error as err:
>              if err[0] =3D=3D errno.EPIPE:
>                  return
> -            raise socket.error(err)
> +            raise_from(socket.error(), err)
>          resp =3D self.__json_read()
>          if self._debug:
> -            print >>sys.stderr, "QMP:<<< %s" % resp
> +            print(u"QMP:<<< %s" % str(resp), file=3Dsys.stderr) =20
>          return resp
> =20
>      def cmd(self, name, args=3DNone, id=3DNone):
> --=20
> 2.7.4
>=20

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYyLNWAAoJEJykq7OBq3PIOCAH/0hSKcObJBlxK8x+19AljzUp
gVLbRinZVJpKXtYxCt0EkBh1cVTxTrDhKvOtvhfNf/f4nioCuUw/p1YsUx37xXa3
wFfKmgESfzQzyJ0fpBDoz2DO66C30Y3N12geJZk6INb/+kzfXF+X2XeqW5OXc1PN
xIcGzW704mtCLORLNnLQKJ+SSk+9OKeYUzaFWx1d0t8sYZtsbU8hnlfSBE3mOkrV
VKp60W+MjMWeSu1kEUd7raQRR+4kfxtA41gvy2tD+qNNrlLLPP5lW2pM1TLbrWJ1
Dmyerzhepg3eEILwvsdlTSxO9BJylKUEHCcw76zR6bwt7IFXdyeQWuvfPKj56Cs=
=FZvR
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
