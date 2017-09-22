Received: from eggs.gnu.org ([2001:4830:134:3::10]:51005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dvJTC-0004pm-AH
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dvJT9-0003WO-74
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:37:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dvJT8-0003Ui-Tm
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:37:55 -0400
References: <20170921162234.847-1-ehabkost@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <94b1569d-806a-98f3-7056-8f6a1b78e55c@redhat.com>
Date: Fri, 22 Sep 2017 10:37:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170921162234.847-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="su94NI1AU7aOvXWDrr90NDLpq75eq2L39"
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Call logging.basicConfig()
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Fam Zheng <famz@redhat.com>, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--su94NI1AU7aOvXWDrr90NDLpq75eq2L39
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Amador Pahim <apahim@redhat.com>, Fam Zheng <famz@redhat.com>,
 stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com
Message-ID: <94b1569d-806a-98f3-7056-8f6a1b78e55c@redhat.com>
Subject: Re: [PATCH] qemu.py: Call logging.basicConfig() automatically
References: <20170921162234.847-1-ehabkost@redhat.com>
In-Reply-To: <20170921162234.847-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 21.9.2017 v 18:22 Eduardo Habkost napsal(a):
> Not all scripts using qemu.py configure the Python logging
> module, and end up generating a "No handlers could be found for
> logger" message instead of actual log messages.
>=20
> To avoid requiring every script using qemu.py to configure
> logging manually, call basicConfig() when creating a QEMUMachine
> object.  This won't affect scripts that already set up logging,
> but will ensure that scripts that don't configure logging keep
> working.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Fixes: 4738b0a85a0c2031fddc71b51cccebce0c4ba6b1
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 5e02dd8e78..73d6031e02 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -89,6 +89,9 @@ class QEMUMachine(object):
>          self._qmp =3D None
>          self._qemu_full_args =3D None
> =20
> +        # just in case logging wasn't configured by the main script:
> +        logging.basicConfig(level=3D(logging.DEBUG if debug else loggi=
ng.WARN))
> +
>      def __enter__(self):
>          return self
> =20
>=20

Hello Eduardo,

what troubles me about this approach is it enables debug based on first i=
nstance arguments, while other instances might use a different value. Ide=
ally we should create `"%s.%s" % (__name__, id(self))` logger per each in=
stance and only set this log level there. The same would have to happen f=
or QMP and other modules, which should either use the configured instance=
's logger, or create own logger as a child of that logger and optionally =
tweaked the levels there (if necessary), so the result would be:

QEMUMachine(debug=3DTrue)
QEMUMachine(debug=3DFalse)

qemu.139855463298312: DEBUG: Starting instance 139855463298312
qemu.139855463298312.qmp: DEBUG: Initializing connection to qmp
qemu.139855463298312: INFO: Started qemu cmd...
qemu.139855463216512: INFO: Started qemu cmd...

while with your patch you get:

qemu.139855463298312: DEBUG: Starting instance 139855463298312
qemu.139855463298312.qmp: DEBUG: Initializing connection to qmp
qemu.139855463298312: INFO: Started qemu cmd...
qemu.139855463216512: DEBUG: Starting instance 139855463298312
qemu.139855463216512.qmp: DEBUG: Initializing connection to qmp
qemu.139855463216512: INFO: Started qemu cmd...


But mine approach would break other scripts that call logging.baseConfig =
(eg. qemu/device-crash-test), because they rely on root logger's log-leve=
l (because `import qemu` would have issued logging.baseConfig). I can't c=
ome-up with a better alternative and this indeed fixes the issues with sc=
ripts using qemu without initializing loggers so considering this as a **=
hotfix**:

Acked-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

But we should focus on fixing all the entry points (either initialize fro=
m all of them, or force-create the root logger based on the entry-point r=
equirements). Kevin, could you please share the exact reproducer? I used =
a custom file importing QEMUMachine() with a some added LOG calls.

Luk=C3=A1=C5=A1


--su94NI1AU7aOvXWDrr90NDLpq75eq2L39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZxMvYExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsHu
fQf8CaAYXMsAkX1aDz8D+WsPQooug6TNXiUpBAQSXma0CjY8Jun0+EXUM+Q6hdMq
jSQAfVaxd/yIRI8ORXf1RPAyriMm99rque3Y3UUIjuFqaRskpsHUblEJfPAxJoLR
hpUho7cfj83HFnpKbqdP/h2YozMlPhwxNRvZDPb8z8tQ7MwYVq6MzToE3AxZb8db
9PXOgpaCNgMMXTv+GBc9jf55Pwju2TbpF4nJw9DoHe9Ha2vvD5vFaYX1S6KpHe3b
CmXswLwvD7mqs8lQ4Fmpy14M+TUXqEYG0hfonQQ5R12N/TwFmP0ZOPH2p5u5wVw2
3tBlPR/nISH7rtw0zlWGCoOAqg==
=zxaE
-----END PGP SIGNATURE-----

--su94NI1AU7aOvXWDrr90NDLpq75eq2L39--
