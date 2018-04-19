Received: from eggs.gnu.org ([2001:4830:134:3::10]:34057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9HIz-0005qI-T2
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9HIw-00027J-Oz
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:41:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9HIw-00024Y-IC
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:41:22 -0400
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-4-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a413c71-a9a2-e92c-85c4-c61edc8fe72c@redhat.com>
Date: Thu, 19 Apr 2018 16:41:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-4-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="npNr0gx7u25jzobVut6PgIS03lsRxpi22"
Subject: Re: [Qemu-devel] [PATCH v2 03/43] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--npNr0gx7u25jzobVut6PgIS03lsRxpi22
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, cota@braap.org, famz@redhat.com,
 berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org,
 balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org
Message-ID: <9a413c71-a9a2-e92c-85c4-c61edc8fe72c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/43] configure: add support for
 --cross-cc-FOO
References: <20180419135901.30035-1-alex.bennee@linaro.org>
 <20180419135901.30035-4-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 08:58 AM, Alex Benn=C3=A9e wrote:
> This allows us to specify cross compilers for our guests. This is
> useful for building test images/programs. Currently we re-run the
> compile test for each target. I couldn't think of a way to cache the
> value for a given arch without getting messier configure code.
>=20
> The cross compiler for the guest is visible to each target as
> CROSS_CC_GUEST in config-target.mak.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  configure | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20

> @@ -483,6 +490,11 @@ for opt do
>    ;;
>    --disable-debug-info) debug_info=3D"no"
>    ;;
> +  --cross-cc-*[!a-zA-Z0-9_0]=3D*) error_exit "Passed bad --cross-cc-FO=
O option"

Not quite right; it looks like you intended to have a trailing - instead
of 0; and if you are trying to filter out bad characters, then you need
* on both sides of the [!...] list:

--cross-cc-*[!a-zA-Z0-9_-]*=3D*)

otherwise you are only filtering out bad characters immediately before
the first =3D.  There's also the question of whether I can spell both
'--cross-cc-FOO=3DBAR' as one argument and '--cross-cc-FOO BAR' as two
arguments; this is filtering out only the one-argument case.

> +  ;;
> +  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}
> +                eval "cross_cc_${cc_arch}=3D\$optarg"
> +  ;;


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--npNr0gx7u25jzobVut6PgIS03lsRxpi22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrZDPwACgkQp6FrSiUn
Q2qnewf+JTyIxQb1fl42fXMz1fLYCcsERoMrnjX8qSnRV63Pn3WPogiEVx0g9u+5
mN0u+MpB3xNUTQv0euLA7erwFnHHfgRYDm68n4tDSW4M7Cop4yNoWE21EBLT/PYo
fZ/akH+AaUslMwuArLMAvJlp3TwQT+ZTmNh0/s0IckM+dlA+bgaHTVfpXJ5TvR7G
aCihGdFDEHaFlKppp2cwTByDa+b31ipA9BDBoXidZ2h+oFgNMyhe0cxMT7lsALcf
RmodGUTZ+AbL9+t+qDYzJZCwZ7gFsCRmv7EPFghFLa59HWAPOlIdvqwTn6BrEeGa
IUcacw5bkg3FvCaaVX9kLRonkoZFhA==
=wHWn
-----END PGP SIGNATURE-----

--npNr0gx7u25jzobVut6PgIS03lsRxpi22--
