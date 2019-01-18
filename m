Received: from eggs.gnu.org ([209.51.188.92]:58648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1gkUrV-0001Tv-S1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1gkUrR-0007LO-6V
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:11:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1gkUrR-0007IU-0K
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:11:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1CCA8667E
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 14:05:49 +0000 (UTC)
Date: Fri, 18 Jan 2019 15:05:47 +0100
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20190118140547.GB11448@vader>
References: <1547573562-32754-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <1547573562-32754-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] seccomp: Work-around GCC 4.x bug in gnu99
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15/01/2019 - 18:32:42, Thomas Huth wrote:
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
Acked-by: Eduardo Otubo <otubo@redhat.com>

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQd07AAoJEN8y58Dw//miFDQIAKeuVktdTSjKKojFIu/QJmxt
D81qYPUZY2o88www9fdpEyK2riuMkncG7kGbrwE+1M8E62RWHbQMo5ZizxlNFqR9
iVSfJcVLyyMluTgPDepzBe09pnf9FEzn+d1HwnKb782iA28p/UWxa15O81KJ1ygo
gpYVGO3wvH6p161xGjnuWeXkffiaQbdh3l9DRWNi4DCyH2sQXnxcgPm1/Dz4WY5l
jadlNQPsivX3i1CW7+6D6/TAJWuq+GP2rhv5U/ojgZmvmN2JbbYQJMcvoIWzbJ2Y
jZp/LpA4u6w5ZcnWxrwCHDjUGvR+cVf3FM/fa2tF5EYTSFis98wjONvjX1ssEgg=
=xeLE
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
