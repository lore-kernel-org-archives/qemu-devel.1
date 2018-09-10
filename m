Received: from eggs.gnu.org ([2001:4830:134:3::10]:45290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fzHqK-000196-QY
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 04:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fzHgV-0004Ao-3E
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 04:36:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fzHgU-0004AU-TH
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 04:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAFD7807A0C3
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 08:36:37 +0000 (UTC)
Date: Mon, 10 Sep 2018 10:36:33 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180910083633.GD5786@vader>
References: <20180830143348.10595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20180830143348.10595-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] seccomp: check TSYNC host capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30/08/2018 - 16:33:48, Marc-Andr=C3=A9 Lureau wrote:
> Remove -sandbox option if the host is not capable of TSYNC, since the
> sandbox will fail at setup time otherwise. This will help libvirt, for
> ex, to figure out if -sandbox will work.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-seccomp.c | 19 ++++++++++++++++++-
>  vl.c           |  4 ++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index 4729eb107f..1baa5c69ed 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -282,7 +282,24 @@ static QemuOptsList qemu_sandbox_opts =3D {
> =20
>  static void seccomp_register(void)
>  {
> -    qemu_add_opts(&qemu_sandbox_opts);
> +    bool add =3D false;
> +
> +    /* FIXME: use seccomp_api_get() >=3D 2 check when released */
> +
> +#if defined(SECCOMP_FILTER_FLAG_TSYNC)
> +    int check;
> +
> +    /* check host TSYNC capability, it returns errno =3D=3D ENOSYS if un=
available */
> +    check =3D qemu_seccomp(SECCOMP_SET_MODE_FILTER,
> +                         SECCOMP_FILTER_FLAG_TSYNC, NULL);
> +    if (check < 0 && errno =3D=3D EFAULT) {
> +        add =3D true;
> +    }
> +#endif
> +
> +    if (add) {
> +        qemu_add_opts(&qemu_sandbox_opts);
> +    }
>  }
>  opts_init(seccomp_register);
>  #endif
> diff --git a/vl.c b/vl.c
> index 408bff9c1e..70c2449b86 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4007,8 +4007,8 @@ int main(int argc, char **argv, char **envp)
>      }
> =20
>  #ifdef CONFIG_SECCOMP
> -    if (qemu_opts_foreach(qemu_find_opts("sandbox"),
> -                          parse_sandbox, NULL, NULL)) {
> +    olist =3D qemu_find_opts_err("sandbox", NULL);
> +    if (olist && qemu_opts_foreach(olist, parse_sandbox, NULL, NULL)) {
>          exit(1);
>      }
>  #endif
> --=20
> 2.19.0.rc0.48.gb9dfa238d5
>=20
Acked-by: Eduardo Otubo <otubo@redhat.com>

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbli0RAAoJEN8y58Dw//miQSsH/2UW996QbRb8Jo8ZVS0W35G4
32w+Md8T8ruA4wr/gg/VdXZeGTRXX7rV+W8DudwQxLUBu1C2OgmuQcfaTWi1G210
6xaJhx2GA6vs0Ogaxy8m4BYtzAtCo6TihfjxfyoM1TgKF3UKUsCUHUrfqlRlc33E
Lm5hMT4v8v9/qpxsVEBgXE+epHA/AMSjEGkeDQjR8vVHmY2iK9XmN20ShgX82cJQ
yDB2hjPtzbm3dv5DoFU7ycHq8NJT8HXRqp13p9RmxcYjQS92YYEovqV4LIogrq7N
2AQaExDV+1CtrD3Ll/V0c8oSCRw9c6AQ1TnOXd6CErTMZ5ETee5Ut7E/CZRqfrQ=
=Ielq
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
