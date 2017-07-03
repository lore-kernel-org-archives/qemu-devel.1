Received: from eggs.gnu.org ([2001:4830:134:3::10]:38819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dRx3a-00053G-Sx
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dRx3X-0002Vn-RZ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:50:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dRx3X-0002R2-JZ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:50:07 -0400
Date: Mon, 3 Jul 2017 09:50:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170703085000.GA22607@stefanha-x1.localdomain>
References: <1498849781-12776-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <1498849781-12776-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH] Python3 Support for qmp.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 01, 2017 at 12:39:41AM +0530, Ishani Chugh wrote:
> This patch intends to make qmp.py compatible with both python2 and python=
3.

Please identify the Python 2/3 compatibility issues addressed in the
patch like:

 * Python 3 does not have dict.has_key(key), use key in dict instead
 * Avoid line-based I/O since Python 2/3 have different character
   encoding behavior.  Explicitly encode/decode JSON UTF-8.

This explains why code changes are being made.

>=20
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  scripts/qmp/qmp.py | 66 +++++++++++++++++++++++++++++++++++-------------=
------
>  1 file changed, 43 insertions(+), 23 deletions(-)
>=20
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 62d3651..9926c36 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -13,18 +13,23 @@ import errno
>  import socket
>  import sys
> =20
> +
>  class QMPError(Exception):
>      pass

Whitespace changes are generally discouraged because they perturb the
code (creating merge conflicts, adding noise to diffs, and obscuring
line change history).

I think you're making them for a good reason here - probably to conform
to Python PEP8 coding style?  But I'm not sure because there is
explanation in the commit description.

If you want to reformat this file to meet the PEP8 standard, please do
it as a separate patch.

> @@ -42,6 +47,7 @@ class QEMUMonitorProtocol:
>          self.__address =3D address
>          self._debug =3D debug
>          self.__sock =3D self.__get_sock()
> +        self.data =3D b""

Please follow the variable naming convention: two underscores for
private member fields (i.e. self.__data).

>          if server:
>              self.__sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADD=
R, 1)
>              self.__sock.bind(self.__address)
> @@ -56,23 +62,35 @@ class QEMUMonitorProtocol:
> =20
>      def __negotiate_capabilities(self):
>          greeting =3D self.__json_read()
> -        if greeting is None or not greeting.has_key('QMP'):
> +        if greeting is None or 'QMP' not in greeting:
>              raise QMPConnectError
> -        # Greeting seems ok, negotiate capabilities

Why remove this comment?

> @@ -87,18 +105,18 @@ class QEMUMonitorProtocol:
>          @param wait (bool): block until an event is available.
>          @param wait (float): If wait is a float, treat it as a timeout v=
alue.
> =20
> -        @raise QMPTimeoutError: If a timeout float is provided and the t=
imeout
> -                                period elapses.
> -        @raise QMPConnectError: If wait is True but no events could be r=
etrieved
> -                                or if some other error occurred.
> +        @raise QMPTimeoutError: If a timeout float is provided and the
> +                                timeout period elapses.
> +        @raise QMPConnectError: If wait is True but no events could be
> +                                retrieved or if some other error occurre=
d.
>          """
> =20
>          # Check for new events regardless and pull them into the cache:
>          self.__sock.setblocking(0)
>          try:
> -            self.__json_read()
> +            test =3D self.__json_read()

Is 'test' a debug variable that should be removed from the final patch?

>          except socket.error as err:
> -            if err[0] =3D=3D errno.EAGAIN:
> +            if err.errno =3D=3D errno.EAGAIN:
>                  # No data available
>                  pass

Pre-existing bug: if the exceptin is not EAGAIN we need to raise the
exception again.

>          self.__sock.setblocking(1)
> @@ -128,7 +146,7 @@ class QEMUMonitorProtocol:
>          @raise QMPCapabilitiesError if fails to negotiate capabilities
>          """
>          self.__sock.connect(self.__address)
> -        self.__sockfile =3D self.__sock.makefile()
> +        self.__sockfile =3D self.__sock.makefile('rb')

self.__sockfile is no longer used, please delete it.

>          if negotiate:
>              return self.__negotiate_capabilities()
> =20
> @@ -143,7 +161,7 @@ class QEMUMonitorProtocol:
>          """
>          self.__sock.settimeout(15)
>          self.__sock, _ =3D self.__sock.accept()
> -        self.__sockfile =3D self.__sock.makefile()
> +        self.__sockfile =3D self.__sock.makefile('rb')

Same here.

> @@ -245,3 +264,4 @@ class QEMUMonitorProtocol:
> =20
>      def is_scm_available(self):
>          return self.__sock.family =3D=3D socket.AF_UNIX
> +

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZWgU4AAoJEJykq7OBq3PIZoYIALz/17Lp81kgpKxup7lyL4tq
s6ljxGxAMlwaensda+ZLivGbR+GIt96DZ2wdg7CRUNVuw09zMVhTvpvZM9+OIjts
xN1agexkaH3ZRvaWqExwWK/1nQFWG/Xcm0Rkn9ktP8WC3CWSVG2IyMNjZRSWBe0P
hwoPvWnKgNYeHWGscZ5jqu8QEBYI2YBKhKCQSd8nrIaXwjDtEHljXapoXoaMPM8V
sG+jbaOrvFsFjdy41pRxMeYqxujB1O3NIYudFzJNX5hCP+l5INiZAP27tG9FKZ5Q
sL9CJfGxlMwzdMl9au04skRFoVetpMkLq9ETPdOe9Z/e1DFCiMawiLCnW/KUSOQ=
=8Xew
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
