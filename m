Received: from eggs.gnu.org ([2001:4830:134:3::10]:51503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYTu-0005qd-JI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYTt-0002oM-NM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:00:38 -0400
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721034730.25612-2-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cce2586b-eafd-27cc-edc7-ea2d3d2275e0@redhat.com>
Date: Fri, 21 Jul 2017 09:00:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170721034730.25612-2-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NOpldbqgnXBowJeaBiSkB66rNivL1m7s4"
Subject: Re: [Qemu-devel] [PATCH 1/3] scripts: introduce buildconf.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NOpldbqgnXBowJeaBiSkB66rNivL1m7s4
From: Eric Blake <eblake@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>
Message-ID: <cce2586b-eafd-27cc-edc7-ea2d3d2275e0@redhat.com>
Subject: Re: [PATCH 1/3] scripts: introduce buildconf.py
References: <20170721034730.25612-1-crosa@redhat.com>
 <20170721034730.25612-2-crosa@redhat.com>
In-Reply-To: <20170721034730.25612-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 10:47 PM, Cleber Rosa wrote:
> scripts/buildconf.py is a command line utility (but also can be used
> as a Python module) that introspects the build configuration.
>=20
> It uses the generated host level config-host.mak to obtain the general
> build configuration, and optionally, also target specific
> config-target.mak and config-devices.mak.  It does not attempt to
> implement a Makefile parser, but instead relies on "make" itself to
> parse those files and output the queried variable.
>=20
> It requires a build tree that has been both configured and built.  By
> default, for convenience, it will selected a default target, which can
> be displayed and overriden.  A few examples follow.

s/overriden/overridden/


>=20
> And for checking a target different than the default one:
>=20
>  $ ./scripts/buildconf.py -c CONFIG_PARALLEL arm-softmmu; echo $?
>  255

Gross.  exit status greater than 128 typically mean death due to signal,
meanwhile, 255 is special-cased by find to kill processing immediately;
it is very rare that someone intentionally returns a status of 255, and
more often, it is evidence that someone mistakenly used exit(-1).

>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/buildconf.py | 278 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 278 insertions(+)
>  create mode 100755 scripts/buildconf.py
>=20

I don't feel comfortable reviewing the script in depth, but I will reques=
t:


> +                else:
> +                    sys.exit(-1)
> +            else:
> +                conf =3D get_build_conf(config, self.target)
> +                if conf:
> +                    print(conf)
> +                    sys.exit(0)
> +                else:
> +                    sys.exit(-1)

Please use sys.exit(1), not -1.

Overall, the idea is cool.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NOpldbqgnXBowJeaBiSkB66rNivL1m7s4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyCPYACgkQp6FrSiUn
Q2qSWgf+N+ze4eLnxpEIxLlPRsTyB1J/L7xkvr/XKsGK7aWrs8F1I+ObWzH4V9sM
XKnf8qUXLuVdnx8inswQOTxlQy3TlPeZF5mBPLysa57Jem7SaRaHA5W1mXMjXkmN
5znAeDk8+BqbHeBpx2nUi0IdxeZO525K/NzgKWe74d9Kv/RjI+QQ5EdjbBl9IwmL
7/1MJcBoWxve3e2ENrqb2/TtetGVBdw2MOGICQh+Aabn35EjeTc1Zc43RzrT0vvy
HBqiANfAqkfTEJUlR/oGy95mupHeGmUQ9qxq7cweWigx80xC/zxKD0qkMFBkBDI0
nRaokCrJfFjP2cVIfkhsNXkunWmgcA==
=GBtP
-----END PGP SIGNATURE-----

--NOpldbqgnXBowJeaBiSkB66rNivL1m7s4--
