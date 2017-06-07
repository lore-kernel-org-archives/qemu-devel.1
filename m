Received: from eggs.gnu.org ([2001:4830:134:3::10]:42534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIi3f-0002H6-8V
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIi3b-0005x9-6P
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:00:03 -0400
References: <1496862674-23626-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df973d1f-cbb1-22c1-5763-f29001a16fd8@redhat.com>
Date: Wed, 7 Jun 2017 15:59:54 -0500
MIME-Version: 1.0
In-Reply-To: <1496862674-23626-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ptRgMbavdaJ8SU7Rq3x9n5BRAgVMHu4kJ"
Subject: Re: [Qemu-devel] [PATCH] Makefile: Do not generate files if
 "configure" has not been run yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ptRgMbavdaJ8SU7Rq3x9n5BRAgVMHu4kJ
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <df973d1f-cbb1-22c1-5763-f29001a16fd8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: Do not generate files if
 "configure" has not been run yet
References: <1496862674-23626-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1496862674-23626-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 02:11 PM, Thomas Huth wrote:
> When doing a "make -j10" in the vanilla QEMU source tree (without
> running "configure first), the Makefile currently generates two

s/"configure/"configure"/

> files already, qemu-version.h and qemu-options.def. This should not
> happen, so let's make these targets depend on config-host.mak.
> Also the python files can not be executed without $(PYTHON), so
> these scripts should depend on config-host.mak, too.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index c830d7a..6786dc2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -286,7 +286,7 @@ endif
> =20
>  all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
> =20
> -qemu-version.h: FORCE
> +qemu-version.h: config-host.mak FORCE

This one makes sense.

> @@ -393,6 +394,8 @@ gen-out-type =3D $(subst .,-,$(suffix $@))
> =20
>  qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddic=
t.py
> =20
> +$(qapi-py): config-host.mak

But this one is weird. How can a pre-existing file have a dependency?
Remember, $(qapi-py) is not the list of built files, but the list of
files used to build other files.  It seems like you either want
config-host.mak includes in $(qapi-py), or...

> +
>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.=
h :\
>  $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(q=
api-py)

=2E..that THIS should be the rule that depends on config-host.mak in
addition do depending on $(qapi-py).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ptRgMbavdaJ8SU7Rq3x9n5BRAgVMHu4kJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOGlKAAoJEKeha0olJ0NqP7AH/AxXtehObqua8jatCFwoN9r4
f+m/5m8iYJJkIe8gnr9EThzGQnaq9GK4hawIRi5D78Tik/3YwpqWK1WC30ruPUEw
WdonBY5LPuT/AihaiDqqTjhkdzumTI2pj9Tjc6h3Oye2shoh0B3M+LoO4+ZiUlSO
pW4ZnFLgaVVQEvM+lD1kBx2kICRzlfJXJ6rrtDcmhrAeUK8FOx6owDFSNVMml1ou
b2tHcfr7zFckcyyWkflaOMZTnUyQspvUJeRIMhPyLJIVTphGEV/pWxGlHZrZIW47
yvA0xCZ4wFxehgO48Lpf/W6eLUoFkKd1jMx58aAVaSTpqGJZllGmc9Bak6gk1zI=
=BH1V
-----END PGP SIGNATURE-----

--ptRgMbavdaJ8SU7Rq3x9n5BRAgVMHu4kJ--
