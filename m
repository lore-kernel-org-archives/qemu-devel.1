Received: from eggs.gnu.org ([209.51.188.92]:38973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1gtVPv-0003aw-2T
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1gtVPn-00027h-Ak
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:35:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1gtVPm-00021B-Gh
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:35:46 -0500
Date: Tue, 12 Feb 2019 11:35:41 +0100
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20190212103541.GB8193@vader>
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
	<1547732292-14021-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <1547732292-14021-4-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PULL v3 26/28] seccomp: Work-around GCC 4.x bug
 in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, clg@kaod.org, mst@redhat.com, Li Qiang <liq3ea@163.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, groug@kaod.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17/01/2019 - 14:38:12, Thomas Huth wrote:
> We'd like to compile QEMU with -std=3Dgnu99, but GCC 4.8 currently
> fails to compile qemu-seccomp.c in this mode:
>=20
> qemu-seccomp.c:45:1: error: initializer element is not constant
>  };
>  ^
> qemu-seccomp.c:45:1: error: (near initialization for =E2=80=98sched_setsc=
heduler_arg[0]=E2=80=99)
>=20
> This is due to a compiler bug which has just been fixed in GCC 5.0:
>=20
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63567
>=20
> Since we still want to support GCC 4.8 for a while and also want to use
> gnu99 mode, work-around the issue by expanding the macro manually.
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-seccomp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index 5c73e6a..36d5829 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -41,7 +41,8 @@ struct QemuSeccompSyscall {
>  };
> =20
>  const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
> -    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
> +    /* was SCMP_A1(SCMP_CMP_NE, SCHED_IDLE), but expanded due to GCC 4.x=
 bug */
> +    { .arg =3D 1, .op =3D SCMP_CMP_NE, .datum_a =3D SCHED_IDLE }
>  };
> =20
>  static const struct QemuSeccompSyscall blacklist[] =3D {
> --=20
> 1.8.3.1
>=20
>=20

Just noticed you already sent the pull request, sorry, my tree was outdated.
Please ignore my previous email :)

--=20
Eduardo Otubo

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYqF9AAoJEN8y58Dw//miYCEH/jDkj5EGqSX3DIvQtVhOj38L
/RE0eY1epJ5JizXb62iJSrc/2eg3RPchqANKmT9OkSmHaE85GBYzjS5Gbq6pvl4H
5AGgC0Vx5gVP90C5eeFNy/J3/KQT+iWEWmX39FtTXi0FthhyHayw2y4si4Euh0jM
4WWbAnRG4M9CtLQ+8BihIK0JQXglulsW/vudH9glXLU0wRfqVGpcj70jCXMf1WBV
rqvDMnpQLa6FcixYYKHmoyylLESiNbvnwE7dSDm0XhrkX5S0RNENIAvsVh/tkbH/
NT+9rAN7l+u97++i5wEUiZT8bzJTJr8hQUqxzvL5rK24ju8VhJJqDOpxffqgZwE=
=LvoL
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
