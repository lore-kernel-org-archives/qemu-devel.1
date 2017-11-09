Received: from eggs.gnu.org ([2001:4830:134:3::10]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnYh-0002JO-7v
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnYg-0005yv-2K
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:11:55 -0500
References: <20171109013804.14488-1-mreitz@redhat.com>
	<20171109013804.14488-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02eb8b5d-7b5a-271c-0a54-aa177dc65ce8@redhat.com>
Date: Thu, 9 Nov 2017 08:11:39 -0600
MIME-Version: 1.0
In-Reply-To: <20171109013804.14488-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WTvaUoC5OoEl0d9SBxSgMpTSSH1H6K1as"
Subject: Re: [Qemu-devel] [PATCH 4/5] iotests: Make 083 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WTvaUoC5OoEl0d9SBxSgMpTSSH1H6K1as
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <02eb8b5d-7b5a-271c-0a54-aa177dc65ce8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] iotests: Make 083 less flaky
References: <20171109013804.14488-1-mreitz@redhat.com>
 <20171109013804.14488-5-mreitz@redhat.com>
In-Reply-To: <20171109013804.14488-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 07:38 PM, Max Reitz wrote:
> 083 has (at least) two issues:

I think I hit one of them intermittently yesterday; thanks for
diagnosing these (and like you say, there may be more lurking, but we'll
whack them separately if we can reproduce and identify them).

>=20
> 1. By launching the nbd-fault-injector in background, it may not be
>    scheduled until the first grep on its output file is executed.
>    However, until then, that file may not have been created yet -- so i=
t
>    either does not exist yet (thus making the grep emit an error), or i=
t
>    does exist but contains stale data (thus making the rest of the test=

>    case work connect to a wrong address).
>    Fix this by explicitly overwriting the output file before executing
>    nbd-fault-injector.
>=20
> 2. The nbd-fault-injector prints things other than "Listening on...".
>    It also prints a "Closing connection" message from time to time.  We=

>    currently invoke sed on the whole file in the hope of it only
>    containing the "Listening on..." line yet.  That hope is sometimes
>    shattered by the brutal reality of race conditions, so invoke grep
>    before sed.

Invoking 'grep | sed' is almost always a waste of a process; sed can do
the job alone.

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/083 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
> index 0306f112da..2f6444eeb9 100755
> --- a/tests/qemu-iotests/083
> +++ b/tests/qemu-iotests/083
> @@ -86,6 +86,7 @@ EOF
> =20
>  	rm -f "$TEST_DIR/nbd.sock"
> =20
> +        echo > "$TEST_DIR/nbd-fault-injector.out"

This makes the file contain a blank line.  Would it be any better as a
truly empty file, as in:

: > "$TEST_DIR/nbd-fault-injector.out"

>  	$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/nbd-=
fault-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &
> =20
>  	# Wait for server to be ready
> @@ -94,7 +95,7 @@ EOF
>  	done
> =20
>  	# Extract the final address (port number has now been assigned in tcp=
 case)
> -	nbd_addr=3D$(sed 's/Listening on \(.*\)$/\1/' "$TEST_DIR/nbd-fault-in=
jector.out")
> +        nbd_addr=3D$(grep 'Listening on ' "$TEST_DIR/nbd-fault-injecto=
r.out" | sed 's/Listening on \(.*\)$/\1/')

Fixing TAB damage while at it - nice.

Here's how to do it using just sed, and with less typing:

    nbd_addr=3D$(sed -n 's/^Listening on //p' \
               "$TEST_DIR/nbd-fault-injector.out")

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WTvaUoC5OoEl0d9SBxSgMpTSSH1H6K1as
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEYhsACgkQp6FrSiUn
Q2qZ0Af/TDPXzIYAHmTZY78GQNQBxypdA4/dTILddABFUDEBR/4oGxFfpk+0US+2
RpnyeGlxJqGOBiFhL2EZ0glfI7Fx5CTdfLC6ck2W6mdht6aicm3ynr0KU9G/N9gu
YIJRH9rrITuTvyV994m/bD05c/vZv1szTVypamET6ZmdidJ27sxJIQh6TNMB56Fb
ke3UDoYEz3HBwxU6/Evm0V/dDdozVw3bavof7bNcmIJWebO/EpCIMNxfCK7FDoCc
o41q7FZTnHC0ZPgQ1FNvrSn4o9cLrXyfZUmhEQLL8jJxGqJaaq1k8GfbC5sL5nyQ
avrA4qxzfXQs56ej8Ufq2W01xiouZA==
=1/IF
-----END PGP SIGNATURE-----

--WTvaUoC5OoEl0d9SBxSgMpTSSH1H6K1as--
