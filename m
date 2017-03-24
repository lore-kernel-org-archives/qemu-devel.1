Received: from eggs.gnu.org ([2001:4830:134:3::10]:43240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crTa6-0001dX-9W
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crTa1-00016Q-9a
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1crTa1-00015v-1m
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:04:53 -0400
Date: Fri, 24 Mar 2017 18:04:45 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170324180445.GA6789@stefanha-x1.localdomain>
References: <1490174864-7454-1-git-send-email-nanjekyejoannah@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <1490174864-7454-1-git-send-email-nanjekyejoannah@gmail.com>
Subject: Re: [Qemu-devel] [Patch v2] Provided python3 support for qmp.py 2/2]
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


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 12:27:44PM +0300, Joannah Nanjekye wrote:
> From: nanjekyejoannah <nanjekyejoannah@gmail.com>

Thanks for the patch!

>=20
> Signed-off-by: nanjekyejoannah <nanjekyejoannah@gmail.com>
>=20
> The patch provides python 3 support for one of the scripts  in scripts/qm=
p that is to say qmp.py. This is not a port to python 3 but rather the patc=
h ensures that the script runs fine for both python 2 and 3.
>=20
> Minimum Python Versions supported:
>=20
>   Python 2 : python 2.6 +
>   Python 3 : python 3.3 +
>=20
> The two new imports future and builtins introduced refer to the future
> pip-installable package on PyPI.

Signed-off-by goes here (after the commit description).

>=20
> ---
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 6dcb870..57ac86b 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -8,8 +8,6 @@
>  # This work is licensed under the terms of the GNU GPL, version 2.  See
>  # the COPYING file in the top-level directory.
>  from __future__ import absolute_import, print_function, unicode_literals
> -from future.utils import raise_from
> -from builtins import str=20

This looks like a patch on top of your previous patch.

Please send a v3 patch that applies directly to qemu.git/master.  You
may need to use "git rebase -i master" to squash intermediate commits
you've made together into a single patch.  Logically these changes are
part of the same code change so there's no need for multiple patches.

The v3 patch email should be:

  [PATCH v3] scripts/qmp: python3 support for qmp.py

Please also CC Markus Armbruster <armbru@redhat.com>.  He is the
maintainer of this file (you can check for maintainers using
scripts/get_maintainer.pl -f scripts/qmp.py).

>  import json
>  import errno
>  import socket
> @@ -58,13 +56,13 @@ class QEMUMonitorProtocol:
> =20
>      def __negotiate_capabilities(self):
>          greeting =3D self.__json_read()
> -        if greeting is None or not greeting.has_key('QMP'):
> -            raise_from(QMPConnectError())
> +        if greeting is None or not 'QMP' in list(greeting):
> +            raise QMPConnectError()
>          # Greeting seems ok, negotiate capabilities
>          resp =3D self.cmd('qmp_capabilities')
>          if "return" in resp:
>              return greeting
> -        raise_from(QMPCapabilitiesError())
> +        raise QMPCapabilitiesError()
> =20
>      def __json_read(self, only_event=3DFalse):
>          while True:
> @@ -74,7 +72,7 @@ class QEMUMonitorProtocol:
>              resp =3D json.loads(data)
>              if 'event' in resp:
>                  if self._debug:
> -                    print(u"QMP:<<< %s" % str(resp), file=3Dsys.stderr)=
=20
> +                    print(u"QMP:<<< %s" % resp, file=3Dsys.stderr)=20
>                  self.__events.append(resp)
>                  if not only_event:
>                      continue
> @@ -113,11 +111,11 @@ class QEMUMonitorProtocol:
>              try:
>                  ret =3D self.__json_read(only_event=3DTrue)
>              except socket.timeout:
> -                raise_from(QMPTimeoutError("Timeout waiting for event"))
> +                raise QMPTimeoutError("Timeout waiting for event")
>              except:
> -                raise_from(QMPConnectError("Error while reading from soc=
ket"))
> +                raise(QMPConnectError("Error while reading from socket"))
>              if ret is None:
> -                raise_from(QMPConnectError("Error while reading from soc=
ket"))
> +                raise QMPConnectError("Error while reading from socket")
>              self.__sock.settimeout(None)
> =20
>      def connect(self, negotiate=3DTrue):
> @@ -157,16 +155,16 @@ class QEMUMonitorProtocol:
>                  been closed
>          """
>          if self._debug:
> -            print(u"QMP:>>> %s" % str(qmp_cmd), file=3Dsys.stderr)=20
> +            print(u"QMP:>>> %s" % qmp_cmd, file=3Dsys.stderr)=20
>          try:
> -            self.__sock.sendall(json.dumps(qmp_cmd))
> +            self.__sock.sendall((json.dumps(qmp_cmd)).encode('latin-1'))
>          except socket.error as err:
>              if err[0] =3D=3D errno.EPIPE:
>                  return
> -            raise_from(socket.error(), err)
> +            raise (socket.error(), err)
>          resp =3D self.__json_read()
>          if self._debug:
> -            print(u"QMP:<<< %s" % str(resp), file=3Dsys.stderr) =20
> +            print(u"QMP:<<< %s" % resp, file=3Dsys.stderr) =20
>          return resp
> =20
>      def cmd(self, name, args=3DNone, id=3DNone):

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1V+9AAoJEJykq7OBq3PICUQH/2QIYhWqcIoVZggL56F+sHcK
uPtf44RDZKbNyDrQ9UHoBQ1i/1Yp+8TFYxgolruwkXb4Nuy3HDFlE5RNoUfilsMU
nQKXQFWrn8XswImacZZWcUM5y5C4Gkr0Q6wbp/I171PlzekUK5981cEPZ/r8uu03
FiHxdCV0XzOuaIKYpLed2Z6pIBXVF5TqSODiXUZaGGfl1f3XkRGJF2QTopnHlzv9
DtHZ47175ZXwj2ptBwWH0pPHoIDkchYgXK/uFDL+ZXq3CuCVfJfhCGQb0irpgOrd
v0uoQK5lC5v4vtMsDe38HCrQmy84q5qihXFSuvNpHwGNmJbspE5zhnpXDw0o8+M=
=z38B
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
