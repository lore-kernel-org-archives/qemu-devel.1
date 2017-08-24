Received: from eggs.gnu.org ([2001:4830:134:3::10]:35065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl12O-0006jO-4i
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dl12J-0001U8-57
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:55:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dl12I-0001Rk-I3
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:55:39 -0400
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<20170818142613.32394-3-ldoktor@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <c74a76a9-aae3-3088-1444-57975b4bf428@redhat.com>
Date: Thu, 24 Aug 2017 18:55:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170818142613.32394-3-ldoktor@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dReLr8DtAceWVOgH5W2hbRigvIrtVqOmI"
Subject: Re: [Qemu-devel] [PATCH v6 02/10] qemu|qtest: Avoid dangerous
 arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dReLr8DtAceWVOgH5W2hbRigvIrtVqOmI
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org
Message-ID: <c74a76a9-aae3-3088-1444-57975b4bf428@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 02/10] qemu|qtest: Avoid dangerous
 arguments
References: <20170818142613.32394-1-ldoktor@redhat.com>
 <20170818142613.32394-3-ldoktor@redhat.com>
In-Reply-To: <20170818142613.32394-3-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/18/2017 10:26 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> The list object is mutable in python and potentially might modify other=

> object's arguments when used as default argument. Reproducer:
>=20
>     >>> vm1 =3D QEMUMachine("qemu")
>     >>> vm2 =3D QEMUMachine("qemu")
>     >>> vm1._wrapper.append("foo")
>     >>> print vm2._wrapper
>     ['foo']
>=20
> In this case the `args` is actually copied so it would be safe to keep
> it, but it's not a good practice to keep it. The same issue applies in
> inherited qtest module.
>=20
> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qemu.py  | 6 +++++-
>  scripts/qtest.py | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index dd679f1..5d09de4 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -23,7 +23,7 @@ import qmp.qmp
>  class QEMUMachine(object):
>      '''A QEMU VM'''
> =20
> -    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
> +    def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNon=
e,
>                   test_dir=3D"/var/tmp", monitor_address=3DNone,
>                   socket_scm_helper=3DNone, debug=3DFalse):
>          '''
> @@ -39,6 +39,10 @@ class QEMUMachine(object):
>          @param debug: enable debug mode
>          @note: Qemu process is not started until launch() is used.
>          '''
> +        if args is None:
> +            args =3D []
> +        if wrapper is None:
> +            wrapper =3D []
>          if name is None:
>              name =3D "qemu-%d" % os.getpid()
>          if monitor_address is None:
> diff --git a/scripts/qtest.py b/scripts/qtest.py
> index d5aecb5..ab183c0 100644
> --- a/scripts/qtest.py
> +++ b/scripts/qtest.py
> @@ -79,7 +79,7 @@ class QEMUQtestProtocol(object):
>  class QEMUQtestMachine(qemu.QEMUMachine):
>      '''A QEMU VM'''
> =20
> -    def __init__(self, binary, args=3D[], name=3DNone, test_dir=3D"/va=
r/tmp",
> +    def __init__(self, binary, args=3DNone, name=3DNone, test_dir=3D"/=
var/tmp",
>                   socket_scm_helper=3DNone):
>          if name is None:
>              name =3D "qemu-%d" % os.getpid()
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>


--dReLr8DtAceWVOgH5W2hbRigvIrtVqOmI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmfWV4ACgkQZX6NM6Xy
CfPvUxAAmkQPdMS7U09sHVNRPvkhIiiArMnp9xCaz1cL+bAS6KPqVosuj4idKWhi
ru1sc9o+cFq42zA0dtwFlqEquKbimmzRuLEPmjSQ+sKWHMhqToUjNESIO7mZZxXS
8kflsC0fGof8ngW/V84SLPGXyF4mmwsJv2IXndwQLYQ9FT+tKxKVdFaVweY7i79Z
hAmP29x/cdoct1mEIJwVCEyE7PL//N2ixeX9mHv8s8iT80IDg+uAhI3zTo9gvx7d
bBpvyGkd3ToHjkgiOAH47sB9YvqH5C+M5ozmPtQPXT6HsQEoAjWv9WRzfD9jme0D
uuB8cK7FmeMYGSmqH3ijYawo7kDTCrPSwUP6YG4VhL6PTeSSMQCpC4GReOek5WIH
VBh4T+z+KdQNv6hrQsDug6uDQB3MBtG66sq6n4OtLb9xEEjV44fag4rc1ppiickv
4FHad49yMIvW5XUo3Fx2setZTVIH9V55vnN8xd3qAEw8tauNe9JfOIP3DWgg2qbI
bb1D4ZRh6emb6pHC+scTohtr6uZq8CBtjheM5tIC15dSafedkyArHX+KdVhzLuul
Rz+y8Y+MaIBGhxAuNOEQhLJew9Ro9LVpIxf9eGcFL/4eO8zXgjIh4Zw7JfiYujs1
xMC1oU4oE0dXeXMWjCc0NadNWjRsX5w2Sdh7qj+8fpmfJBC8ANo=
=DdNe
-----END PGP SIGNATURE-----

--dReLr8DtAceWVOgH5W2hbRigvIrtVqOmI--
