Received: from eggs.gnu.org ([2001:4830:134:3::10]:44440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cnzfa-0006Lc-PD
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cnzfX-0004Px-MG
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cnzfX-0004PY-Fv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:32:11 -0400
Date: Wed, 15 Mar 2017 11:32:06 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170315033206.GL13140@stefanha-x1.localdomain>
References: <1488800630-32054-1-git-send-email-nanjekyejoannah@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
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


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 02:43:50PM +0300, Joannah Nanjekye wrote:
> From: Joannah Najekye <nanjekyejoannah@gmail.com>
>=20
> Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com>
> ---
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
>=20
>  scripts/qmp/qmp.py | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Did you test your patch with Python 3?  Launch QEMU like this:

  $ qemu-system-x86_64 -qmp unix:/tmp/foo.sock,server

In another terminal you can launch Python and interactively test the
module like I did above.

I still get the following Python 3 exception with your patch:

$ python3
Python 3.5.2 (default, Sep 14 2016, 11:28:32)
[GCC 6.2.1 20160901 (Red Hat 6.2.1-1)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import qmp
>>> q =3D qmp.QEMUMonitorProtocol('/tmp/foo.sock')
>>> q.connect()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "qemu/scripts/qmp/qmp.py", line 135, in connect
    return self.__negotiate_capabilities()
  File "qemu/scripts/qmp/qmp.py", line 61, in __negotiate_capabilities
    if greeting is None or not greeting.has_key('QMP'):
AttributeError: 'dict' object has no attribute 'has_key'

In Python 3 the dict object lacks the has_key() method.  Please convert
the code to use 'key' in dict instead of dict.has_key('key').

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYyLW2AAoJEJykq7OBq3PI04UH/22TnsroE01/5UlgSgD4ImEZ
FlR3pfEcyZ180x2d06Cew9/PYsSGsIvUvcBx6JPmfqcPLGWzmA5QcAd8obPcybpC
uv+XxXj2p/++QlHooTxaZ4icG/Zr9N0383z6WuaxLxTvoJcC9t0RlU3GcmIZf05u
mpv5PFdGcF9VEj7rG3zuGhtNQ9L3IZYbsDO0SypIgzaoxXbEaUtVVH+XmsEdNxnQ
Vsx6qypuYCfMJs0bW8bH25qd2XxH+DbI1T1JYSS1uhk/0kEIYMi/e0pdPdDEheDZ
oc+tvMQxN6R3tqxvzr2HHn1xokwCzdgvlYWR1PyrqkmL7sNoWWNO/d3WMaHfRbQ=
=JT66
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
