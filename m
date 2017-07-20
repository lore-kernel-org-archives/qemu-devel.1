Received: from eggs.gnu.org ([2001:4830:134:3::10]:46151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGA6-0002bC-CT
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGA2-0002cp-5y
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:26:58 -0400
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
Date: Thu, 20 Jul 2017 13:26:50 -0500
MIME-Version: 1.0
In-Reply-To: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DmOfBJXUroEnWpasoiLm51H24CH73FxB5"
Subject: Re: [Qemu-devel] [PATCH for-2.10] util/oslib-posix.c: Avoid warning
 on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Kamil Rytarowski <kamil@netbsd.org>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DmOfBJXUroEnWpasoiLm51H24CH73FxB5
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: Kamil Rytarowski <kamil@netbsd.org>, patches@linaro.org
Message-ID: <eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] util/oslib-posix.c: Avoid warning
 on NetBSD
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 11:32 AM, Peter Maydell wrote:
> On NetBSD the compiler warns:
> util/oslib-posix.c: In function 'sigaction_invoke':
> util/oslib-posix.c:589:5: warning: missing braces around initializer [-=
Wmissing-braces]
>      siginfo_t si =3D { 0 };
>      ^

Uggh. That is a broken compiler.  C99 declares that 'anything =3D {0}' is=

supposed to be a valid way to zero-initialize anything.

> util/oslib-posix.c:589:5: warning: (near initialization for 'si.si_pad'=
) [-Wmissing-braces]
>=20
> because on this platform siginfo_t is defined as
>   typedef union siginfo {
>           char    si_pad[128];    /* Total size; for future expansion *=
/
>           struct _ksiginfo _info;
>   } siginfo_t;
>=20
> Avoid this warning by initializing the struct with {} instead;
> this is a GCC extension but we use it all over the codebase already.

Well, I'm glad that works to shut up the broken compiler.

>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  util/oslib-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index b2dea48..cacf0ef 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -586,7 +586,7 @@ void qemu_free_stack(void *stack, size_t sz)
>  void sigaction_invoke(struct sigaction *action,
>                        struct qemu_signalfd_siginfo *info)
>  {
> -    siginfo_t si =3D { 0 };
> +    siginfo_t si =3D {};
>      si.si_signo =3D info->ssi_signo;
>      si.si_errno =3D info->ssi_errno;
>      si.si_code =3D info->ssi_code;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DmOfBJXUroEnWpasoiLm51H24CH73FxB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw9eoACgkQp6FrSiUn
Q2ow2gf/dgjVCePlP+22F40D9ETGGN7p+QTV9g5RWo1d7mjiFyYZIa+uX2PHC4ij
DqIPR030viKYPxXzvfM+iZ95i0DI2cKfkmad1sdHNMdVTm3KRXr1TeBlnBVplC3e
KfdCvze6SqrQpf5v01Aa4pX50avMS1uQ8KCfAs230ixzOF7YRyCZxBS1RNePH74Y
iUvqGGAFN3lvIkiWjtAcpjwiBmf2IUPqX6jPD8p3q6maNcSZBwd/iHfrEXz81bA4
f8UlTRlhmHz70+Yk+Wt70q0U19iszu25P1MvF5BQbC+fc5tjTfTXoKimvI+qIvHY
8ra6tdN4jNEgEJMK/0DyXIsTt8qqqw==
=C3S1
-----END PGP SIGNATURE-----

--DmOfBJXUroEnWpasoiLm51H24CH73FxB5--
