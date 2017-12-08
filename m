Received: from eggs.gnu.org ([2001:4830:134:3::10]:60662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNOB2-00076D-3R
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNOAy-0006va-4E
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:19:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eNOAx-0006v9-RV
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:19:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C44C27D0C4
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 19:19:10 +0000 (UTC)
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
	<20171208005825.14587-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f632bd0e-66ad-2c90-3625-309cf99d5374@redhat.com>
Date: Fri, 8 Dec 2017 13:19:05 -0600
MIME-Version: 1.0
In-Reply-To: <20171208005825.14587-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v35RLFxEJKHTlwOaMFRa8NaReAVw0tJJm"
Subject: Re: [Qemu-devel] [PATCH 02/12] build-sys: silence make by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v35RLFxEJKHTlwOaMFRa8NaReAVw0tJJm
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <f632bd0e-66ad-2c90-3625-309cf99d5374@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/12] build-sys: silence make by default
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
 <20171208005825.14587-3-marcandre.lureau@redhat.com>
In-Reply-To: <20171208005825.14587-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 06:58 PM, Marc-Andr=C3=A9 Lureau wrote:
> In particular, do not print anything when there is nothing to do, in
> particular, after a successful build:

Do we need both 'in particular'?

>=20
> $ make
> make[1]: '/home/elmarco/src/qemu/build/capstone/libcapstone.a' is up to=
 date.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  rules.mak | 5 +++++
>  1 file changed, 5 insertions(+)

Yay!  I've been bothered by this.

You may want to add that the noise is conditional on whether you have
capstone-devel installed.

However,

>=20
> diff --git a/rules.mak b/rules.mak
> index 6e943335f3..b760d54908 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -131,6 +131,11 @@ modules:
>  # If called with only a single argument, will print nothing in quiet m=
ode.
>  quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 &=
& $1, @$1))
> =20
> +makeflags_ =3D $(makeflags_0)
> +makeflags_0 =3D --no-print-directory -s

Why the mix of long option and short option? Would it be more legible to
use two long options?

In my testing of your patch, '-s' alone also silenced things
(admittedly, when libcapstone.a is up-to-date).  What is
--no-print-directory adding?

/me goes digging

Hmm, we already have this in Makefile:

SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory) BUILD_DIR=3D$(BUILD_D=
IR)

So maybe our problem is that we are forgetting to feed SUBDIR_MAKEFLAGS
to our sub-make that builds libcapstone.a?

Next, why is -s silencing the "is up to date" message?  Per 'make
--help', -s controls whether recipes are echoed - but that doesn't seem
to be a recipe that was echoed.  Furthermore, the make manual mentions
that -s is automatically added to MAKEFLAGS if it was present in the
command line; are we accidentally silencing too much (if the user wants
to do 'make -s V=3D1' to get JUST command lines but not the make noise)?

> +makeflags_1 =3D
> +MAKEFLAGS +=3D $(makeflags_$(V))
> +

So I'm not yet convinced that this is the right place, or if it is too
heavy of a hammer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--v35RLFxEJKHTlwOaMFRa8NaReAVw0tJJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloq5akACgkQp6FrSiUn
Q2rhnwf/YF2dNnoa3kjNk4IyBjpDGaKKemZdkh0nK3u9xpcMVEU9O1QE5muP/fOl
GSvj5aof7OUHWth93wEZ2PHKH8cLof9Czh+gBSOPy4u0SPDori9PYioeMP/X2XQx
PB4esEKJXsYYAjKVulv8VctZsLdqYoephEmFg57SIh15UTAAVjr+CAqCKK3cnpe4
PtTIXyr+UEyzLrxyDBcV1jFy9IfzcQvn+bf7CMuxxqk4J3gY2ipPe/7c1R8S9Gd+
mwi4rAXRStks1nuXkuHLpYBb6/htEiW0TOfVxAjua3EgLHrqSYCcwelOevl0oq7g
w/7iJJc2egSIsd4KeleXZm4Z7Tvo+Q==
=xIOe
-----END PGP SIGNATURE-----

--v35RLFxEJKHTlwOaMFRa8NaReAVw0tJJm--
