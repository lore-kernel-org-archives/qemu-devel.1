Received: from eggs.gnu.org ([2001:4830:134:3::10]:49440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcU7I-00069g-Uh
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcU7E-0001Md-Qa
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:09:32 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dcU7E-0001MD-JW
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:09:28 -0400
Received: by mail-wm0-x242.google.com with SMTP id q189so2282487wmd.0
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 03:09:28 -0700 (PDT)
Date: Tue, 1 Aug 2017 11:09:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801100925.GF13521@stefanha-x1.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-3-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Content-Disposition: inline
In-Reply-To: <20170731085110.1050-3-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/7] qemu.py: fix is_running() return
 before first launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 10:51:05AM +0200, Amador Pahim wrote:
> is_running() returns None when called before the first time we
> call launch():
>=20
>     >>> import qemu
>     >>> vm =3D qemu.QEMUMachine('qemu-system-x86_64')
>     >>> vm.is_running()
>     >>>
>=20
> It should retunt False instead. This patch fixes that.

s/retunt/return/

>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 2f1984c93c..77565eb092 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -86,7 +86,7 @@ class QEMUMachine(object):
>              raise
> =20
>      def is_running(self):
> -        return self._popen and (self._popen.poll() is None)
> +        return self._popen is not None and (self._popen.poll() is None)

The parentheses are inconsistent:

  return (self._popen is not None) and (self._popen.poll() is None)

An alternative:

  return bool(self._popen and self._popen.poll())

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgFNVAAoJEJykq7OBq3PI764H/RUGkaTlP5Veftsp6VIu3sbZ
jtc77gm6g27SLabKBSc6RoG6yiFxrlvEJ9lBs0oQYraIdktpQn9B/mIz5fjePU6D
XRWs3xYAs2ecKJOk9A0/nfoJQ3LmBbrehljzAusxRFVAm9qDh2lIQARRed4N8nCa
xRMRSlmPgIo+gZnr5tU4rMOCzW2y3qyoMOhak/9dkutcrYKUcXc09D5dD+1BLL2U
ZMmHd16yu8kwfUAZH2go2P3ihk9B9xmu547zp72y4RuYv4GMDJaPOtiUKblJIWAJ
MFgUDP73adFFDIySxDZDEL+47dN9P+SNoHlsxwHMA2LmX5JYtPRJ7nMYBi97G/A=
=fn4f
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
