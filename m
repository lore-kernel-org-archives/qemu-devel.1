Received: from eggs.gnu.org ([209.51.188.92]:58502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWSC-0005CH-PL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkWSB-0003Ld-7y
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:53:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gkWSA-0003JO-Up
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:53:07 -0500
References: <20190118132750.25932-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64316a28-affa-11ca-2d25-5a34a7787a4a@redhat.com>
Date: Fri, 18 Jan 2019 09:53:01 -0600
MIME-Version: 1.0
In-Reply-To: <20190118132750.25932-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gPQjQST03EwPZUQPpxMkpyEgpmj01h6xg"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Don't spuriously warn about
 /** comment starters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Reported-by : Thomas Huth" <thuth@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gPQjQST03EwPZUQPpxMkpyEgpmj01h6xg
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Reported-by : Thomas Huth" <thuth@redhat.com>, patches@linaro.org
Message-ID: <64316a28-affa-11ca-2d25-5a34a7787a4a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Don't spuriously warn about /**
 comment starters
References: <20190118132750.25932-1-peter.maydell@linaro.org>
In-Reply-To: <20190118132750.25932-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/19 7:27 AM, Peter Maydell wrote:
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

Just wondering if "/\*{1,2}" would also work (it may have to be spelled
"/\*\{1,2}" - I never remember which flavors of regex have which
extensions without rereading docs).  But since your way is tested, I'm
not going to force a respin.

>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This comment check is unique to QEMU checkpatch so the bug
> doesn't exist in the Linux version.
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d10dddf1be4..5f1ec537d21 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1624,7 +1624,7 @@ sub process {
> =20
>  		# Block comments use /* on a line of its own
>  		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
> -		    $rawline =3D~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-b=
lank
> +		    $rawline =3D~ m@^\+.*/\*\*?+[ \t]*.+[ \t]*$@) { # /* or /** non-=
blank

Hmm - Isn't "[ \t]*.+[ \t]*$" the same as ".+$?"  Perhaps:

m@^\+.*/\*([^*]|\*.)@

also does the trick in a more legible way (that is, any line that starts
with /* and then contains any additional characters other than a second *=
)?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--gPQjQST03EwPZUQPpxMkpyEgpmj01h6xg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxB9l0ACgkQp6FrSiUn
Q2rvBwf/TSMkd/rd8PPdpoBWS5jVlGWBbZe9x3bASLQhZKovOOf8ltt9wNIYrJB9
HIkMqfTtIbUyrbuuo0M33eQ/okeHC0F9x4tbnO7TNxz4xkweVtGilS8EM5oyqs5l
FTXTFS76ZCz8PWe8k0mfOqxfl+BAnR2tqgb0RNvQu8rWsZVKXjkZqIZk92qc27e+
SPzDkG1bSwsZNF6yqLBhjxvogE+9Su8JytCte2pV8aNHDfvkFYycQMrbZWisZn83
4NdQ4DiO/dumBIXGjzrInTA0QXipEshqTrKCnnbCRHU0sWwMwesDLROHZ0hGVi0N
EsVwlEjsgIR+paIXkXqE15bc4KpRvQ==
=E2q2
-----END PGP SIGNATURE-----

--gPQjQST03EwPZUQPpxMkpyEgpmj01h6xg--
