Received: from eggs.gnu.org ([2001:4830:134:3::10]:57911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKu4o-0002cB-GW
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 17:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKu4l-0003T6-Dw
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 17:46:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eKu4l-0003Sc-4l
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 17:46:31 -0500
References: <20171026100031.19042-1-richard.henderson@linaro.org>
	<20171026100031.19042-2-richard.henderson@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a2f982a-f41f-9069-8bd5-db513eaee0a2@redhat.com>
Date: Fri, 1 Dec 2017 16:46:28 -0600
MIME-Version: 1.0
In-Reply-To: <20171026100031.19042-2-richard.henderson@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cSo75qu18b9lfTQ2fQLgSjkqFcS7D1p9k"
Subject: Re: [Qemu-devel] [PULL v2 11/11] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cSo75qu18b9lfTQ2fQLgSjkqFcS7D1p9k
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <5a2f982a-f41f-9069-8bd5-db513eaee0a2@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 11/11] disas: Add capstone as submodule
References: <20171026100031.19042-1-richard.henderson@linaro.org>
 <20171026100031.19042-2-richard.henderson@linaro.org>
In-Reply-To: <20171026100031.19042-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/26/2017 05:00 AM, Richard Henderson wrote:
> Do not require the submodule, but use it if present.  Allow the
> command-line to override system or git submodule either way.
>=20
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile    | 15 ++++++++++++++
>  .gitmodules |  3 +++
>  capstone    |  1 +
>  configure   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++--=
--------
>  4 files changed, 76 insertions(+), 11 deletions(-)
>  create mode 160000 capstone

I'm seeing a couple of anomalies which I think are due to this series.
One is that make is now always noisy, even when there is nothing to do:

$ make
make[1]: '/home/eblake/qemu/capstone/libcapstone.a' is up to date.
$

It would be really nice to silence that line when things are up-to-date,
the way it used to be.

The other is that, at least on my setup (Fedora 27 with 'capstone' not
installed), I get a spurious 'make check-unit' failure (part of 'make
check'):

  GTESTER tests/check-qdict
tests/check-qdict: error while loading shared libraries:
libcapstone.so.3: cannot open shared object file: No such file or directo=
ry
make: *** [/home/eblake/qemu/tests/Makefile.include:864:
check-tests/check-qdict] Error 1
make: *** Waiting for unfinished jobs....


but if I then 'dnf install capstone-devel', running 'make check'
succeeds.  I'm not sure why the in-tree library when using the submodule
is not letting the testsuite run, but suspect that our CI engine and
most developers aren't seeing the failure because they have installed
the distro library and are therefore not relying on the submodule.

It's probably too late to change anything for 2.11, but it's worth
seeing if it can be improved during 2.12.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cSo75qu18b9lfTQ2fQLgSjkqFcS7D1p9k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloh28QACgkQp6FrSiUn
Q2qifAf+PlgrE0Qu18QXGpyOy46UrDtk7/CBKJDrsvG4GyE5qXeGCDBryYRWbky0
8tHkO9vbI/hHq6alFt8FJbeOSpvaqJrqKTcouX+zEleeiC96QGrDx9O2HZtwL1QC
gOl2Cu30AILpevzH2rxnAnXxkol0PgvJYgqxj0xuP1FbPdXWueQtln6XdVb2h0yH
FJdCyzqCY904mdk/nK0tsHmXJpTW/uUC/b/FGNAqTahTxW0Q6FsdAkdZAwP0u39p
uKdHgkYo0mkAqYlHofYL1y5vIcFNFyP8AklFdN4Dx7t0ySVGpgMgReCPTxzknWUf
IFdDko4YwjAEAWI0V5L6HkGAqxWeVw==
=3hJS
-----END PGP SIGNATURE-----

--cSo75qu18b9lfTQ2fQLgSjkqFcS7D1p9k--
