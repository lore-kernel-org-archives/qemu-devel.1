Received: from eggs.gnu.org ([2001:4830:134:3::10]:59607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dnM4j-0004aI-IM
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dnM4g-0003UW-FX
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dnM4g-0003U6-71
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:47:46 -0400
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-8-apahim@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <a8cb8cb6-1c01-1838-7499-7115b89f7a0b@redhat.com>
Date: Thu, 31 Aug 2017 11:47:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170818170526.13496-8-apahim@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KSOUr2tTUA4CxnJLb2mI0JcFnd1r026xi"
Subject: Re: [Qemu-devel] [PATCH v7 07/11] qemu.py: include debug
 information on launch error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KSOUr2tTUA4CxnJLb2mI0JcFnd1r026xi
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com,
 crosa@redhat.com
Message-ID: <a8cb8cb6-1c01-1838-7499-7115b89f7a0b@redhat.com>
Subject: Re: [PATCH v7 07/11] qemu.py: include debug information on launch
 error
References: <20170818170526.13496-1-apahim@redhat.com>
 <20170818170526.13496-8-apahim@redhat.com>
In-Reply-To: <20170818170526.13496-8-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 18.8.2017 v 19:05 Amador Pahim napsal(a):
> When launching a VM, if an exception happens and the VM is not
> initiated, it might be useful to see the qemu command line and
> the qemu command output.
>=20
> This patch creates that message. Notice that self._iolog needs to be
> cleaned up in the beginning of the launch() to make sure we will not
> expose the qemu log from a previous launch if the current one fails.
>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 0bcec4b3b1..29fd2469f9 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -147,6 +147,7 @@ class QEMUMachine(object):
> =20
>      def launch(self):
>          '''Launch the VM and establish a QMP connection'''
> +        self._iolog =3D None
>          self._qemu_full_args =3D None
>          devnull =3D open(os.path.devnull, 'rb')
>          qemulog =3D open(self._qemu_log_path, 'wb')
> @@ -162,6 +163,13 @@ class QEMUMachine(object):
>              self._post_launch()
>          except:
>              self.shutdown()
> +
> +            LOG.debug('Error launching VM')
> +            if self._qemu_full_args:
> +                LOG.debug('Command: %r', ' '.join(self._qemu_full_args=
))
> +            if self._iolog:
> +                LOG.debug('Output: %r', self._iolog)
> +
>              raise
> =20

I don't want to open the cave, but anybody else would actually prefer cus=
tom Exception with the qemu_full_args, iolog and details about the origin=
al exception to this? Users who don't care would see/log all the details =
from the `exception.__str__` and those who are interested in the original=
 exception would query for it eg. via `exception.original_exception`.

Anyway even this change is IMO step into the right direction and we can (=
and should) refine the use of exceptions in following patches (as Markus =
spotted, pure Exceptions and other ugliness lives in those waters).

As for the debug vs. error I'd actually stick to "debug", because in nega=
tive testing the logged message is only an expected debug and in positive=
 testing it expands the knowledge of the flow, but the actual error messa=
ge should come from the exception. Not a strong opinion, though...

Regards,
Luk=C3=A1=C5=A1

>      def shutdown(self):
>=20



--KSOUr2tTUA4CxnJLb2mI0JcFnd1r026xi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZp9s4ExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFN
MQf/YKsa2VwLq8h+GBZDjT59hISTmVefgjMezUVmd3eIyyzrDmF4OJajZjBl7kSZ
DlDOtZqbDsPOhP6r8pD8G7Y/xwd7uSoWSJAdc2QL8ZiFlqTw4zAqwrOGsPdqnBDP
Vw8hNEPhJ4qX82pk59TIhiPkAYsAXCXmdA+5r+X8WlWpPrHHeryv0HNqFG33IeD3
yURV0unCqr32O5Jk1xFNTWeKR59/BruUWHOpBcmRu4qUTVFkAA8kiOf0Tkbm/cBF
iBU7Lal1/4NYLE4S2PK4ODI6/tCbAzcUeDXkTsw72qm3C+Xe9wtSYYJp9sQJ2LOa
myWM64NqVMvBbjBkiY7aGXOsLg==
=0RGz
-----END PGP SIGNATURE-----

--KSOUr2tTUA4CxnJLb2mI0JcFnd1r026xi--
