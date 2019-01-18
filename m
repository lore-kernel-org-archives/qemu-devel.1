Received: from eggs.gnu.org ([209.51.188.92]:49314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkXbU-0001A2-BM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkXbT-0004KA-G4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:06:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkXbT-0004JP-7B
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:06:47 -0500
References: <20190118165050.22270-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0d4eed9-c715-a20e-d3bc-85ab11876cca@redhat.com>
Date: Fri, 18 Jan 2019 11:06:45 -0600
MIME-Version: 1.0
In-Reply-To: <20190118165050.22270-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dtxZ2yghWBjsxLFPgd0IhSI1fsGaGUaQN"
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: Don't emit spurious
 warnings about block comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dtxZ2yghWBjsxLFPgd0IhSI1fsGaGUaQN
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>
Message-ID: <e0d4eed9-c715-a20e-d3bc-85ab11876cca@redhat.com>
Subject: Re: [PATCH v2] checkpatch: Don't emit spurious warnings about block
 comments
References: <20190118165050.22270-1-peter.maydell@linaro.org>
In-Reply-To: <20190118165050.22270-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 10:50 AM, Peter Maydell wrote:
> In checkpatch we attempt to check for and warn about
> block comments which start with /* or /** followed by a
> non-blank. Unfortunately a bug in the regex meant that
> we would incorrectly warn about comments starting with
> "/**" with no following text:
>=20
>   git show 9813dc6ac3954d58ba16b3920556f106f97e1c67|./scripts/checkpatc=
h.pl -
>   WARNING: Block comments use a leading /* on a separate line
>   #34: FILE: tests/libqtest.h:233:
>   +/**
>=20
> The sequence "/\*\*?" was intended to match either "/*" or "/**",
> but Perl's semantics for '?' allow it to backtrack and try the
> "matches 0 chars" option if the "matches 1 char" choice leads to
> a failure of the rest of the regex to match.  Switch to "/\*\*?+"
> which uses what perlre(1) calls the "possessive" quantifier form:
> this means that if it matches the "/**" string it will not later
> backtrack to matching just the "/*" prefix.
>=20
> The other end of the regex is also wrong: it is attempting
> to check for "/* or /** followed by something that isn't
> just whitespace", but [ \t]*.+[ \t]* will match on pure
> whitespace. This is less significant but means that a line
> with just a comment-starter followed by trailing whitespace
> will generate an incorrect warning about block comment style
> as well as the correct error about trailing whitespace which
> a different checkpatch test emits.
>=20

Fixes: 8c06fbdf36bf4d4d486116200248730887a4d7d6

> Reported-by: Thomas Huth <thuth@redhat.com>
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

>  		# Block comments use /* on a line of its own
>  		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
> -		    $rawline =3D~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-b=
lank
> +		    $rawline =3D~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-bla=
nk

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--dtxZ2yghWBjsxLFPgd0IhSI1fsGaGUaQN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxCB6UACgkQp6FrSiUn
Q2rkSAf/V8eQgdkqzBfFjtSAbvcBFBGSbrt8xFBZNegdxwht4r3jUPzts8d1nEHp
vrlmFEyZ7q0tOmWbjWrzdXEdaUDY5oUtsRp3faASja9xaaWB999gfIg0yfGmU/TF
aGKYwAhrca54yOxEHLbj6+j7ObTiMLrt0NeibVTzKS2mhiGPl0WHzTnbj87/2jwY
dJmTaUPMTphgTe1NK1QItiJjOMYb5HD/Eya2QSHw3Kqlh9X/uDGAkV4xY46q5CAc
ONJb34YcPQMg7LtQF7PeDls5TenCR0oZYelhTJrOf70i4rBoNknk3AOq2DzdffDo
eefTDOC2dRcDOOgUa1f7CVvrrZEW4A==
=av2o
-----END PGP SIGNATURE-----

--dtxZ2yghWBjsxLFPgd0IhSI1fsGaGUaQN--
