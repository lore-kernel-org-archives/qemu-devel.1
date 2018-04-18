Received: from eggs.gnu.org ([2001:4830:134:3::10]:33258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f8mn6-000476-9U
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f8mn3-0006C4-5S
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:06:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1f8mn2-0006BO-T5
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:06:25 -0400
References: <1523864788-15800-1-git-send-email-zhenwei.pi@youruncloud.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0e4da059-da4c-64ff-65f0-068fdd68fdcd@redhat.com>
Date: Wed, 18 Apr 2018 15:06:13 +0200
MIME-Version: 1.0
In-Reply-To: <1523864788-15800-1-git-send-email-zhenwei.pi@youruncloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9i31azO2pPhdwfPMBdkquiy4sk1NTsALe"
Subject: Re: [Qemu-devel] [PATCH] qemu-progress: redirct qemu progress
 message to another file stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhenwei pi <zhenwei.pi@youruncloud.com>, pbonzini@redhat.com, kwolf@redhat.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9i31azO2pPhdwfPMBdkquiy4sk1NTsALe
From: Max Reitz <mreitz@redhat.com>
To: zhenwei pi <zhenwei.pi@youruncloud.com>, pbonzini@redhat.com,
 kwolf@redhat.com
Cc: qemu-devel@nongnu.org
Message-ID: <0e4da059-da4c-64ff-65f0-068fdd68fdcd@redhat.com>
Subject: Re: [PATCH] qemu-progress: redirct qemu progress message to another
 file stream
References: <1523864788-15800-1-git-send-email-zhenwei.pi@youruncloud.com>
In-Reply-To: <1523864788-15800-1-git-send-email-zhenwei.pi@youruncloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-16 09:46, zhenwei pi wrote:
> currently qemu progress message only print into stdout, and other threa=
d may
> print some log into stdout at the same time.
> add a new api qemu_progress_set_output to redirect progress message to
> another file stream.
>=20
> Signed-off-by: zhenwei pi <zhenwei.pi@youruncloud.com>
> ---
>  include/qemu-common.h |  1 +
>  util/qemu-progress.c  | 22 +++++++++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)

Well, but after this patch, qemu will still only print progress to
stdout because qemu_progress_set_output() isn't used anywhere...

> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 8a4f63c..511e7e0 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -128,6 +128,7 @@ ssize_t qemu_co_send_recv(int sockfd, void *buf, si=
ze_t bytes, bool do_send);
>  void qemu_progress_init(int enabled, float min_skip);
>  void qemu_progress_end(void);
>  void qemu_progress_print(float delta, int max);
> +int qemu_progress_set_output(FILE *output);
>  const char *qemu_get_vm_name(void);
> =20
>  #define QEMU_FILE_TYPE_BIOS   0
> diff --git a/util/qemu-progress.c b/util/qemu-progress.c
> index 3c2223c..dd7aa52 100644
> --- a/util/qemu-progress.c
> +++ b/util/qemu-progress.c
> @@ -31,6 +31,7 @@ struct progress_state {
>      float min_skip;
>      void (*print)(void);
>      void (*end)(void);
> +    FILE *output;
>  };
> =20
>  static struct progress_state state;
> @@ -43,17 +44,18 @@ static volatile sig_atomic_t print_pending;
>   */
>  static void progress_simple_print(void)
>  {
> -    printf("    (%3.2f/100%%)\r", state.current);
> -    fflush(stdout);
> +    fprintf(state.output, "    (%3.2f/100%%)\r", state.current);
> +    fflush(state.output);

Also, I'm not sure we should use \r when printing to anything but stdout.=


Max

>  }
> =20
>  static void progress_simple_end(void)
>  {
> -    printf("\n");
> +    fprintf(state.output, "\n");
>  }
> =20
>  static void progress_simple_init(void)
>  {
> +    state.output =3D stdout;
>      state.print =3D progress_simple_print;
>      state.end =3D progress_simple_end;
>  }
> @@ -129,6 +131,20 @@ void qemu_progress_end(void)
>  }
> =20
>  /*
> + * Redirect progress into another file stream.
> + * @output is the new file stream.
> + */
> +int qemu_progress_set_output(FILE *output)
> +{
> +    if (!output) {
> +        return -EINVAL;
> +    }
> +
> +    state.output =3D output;
> +    return 0;
> +}
> +
> +/*
>   * Report progress.
>   * @delta is how much progress we made.
>   * If @max is zero, @delta is an absolut value of the total job done.
>=20



--9i31azO2pPhdwfPMBdkquiy4sk1NTsALe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrXQsUACgkQ9AfbAGHV
z0DAyggApmLiyBrfonDIpRm1Oav0Wz7L01yeh1UDznyfjVTmSQdoYFOpRY8PIbMJ
NKAY9yBTiKbm4v49n2KlitQQdF2X1/BQ/Vb93v25z2EqJE01SglI3PYW0QQezZ//
Fg9MgG2V5ryy46u3brpTx1sbsJ3Nlzs6qRCPjvoh++OBT37H8HOoloQTRRiTif4f
Ah41I4pXGSLqsrMlG/6Epme7+1NcABn5FEqxUgUDt3f5S7dL+1YG6RZllXyiK5NE
7iZLRFayf4TuT6VCfqzoWU1+X1VtIa/P1KjGm+d4DtdofLryRtyM2Wx2kUj0zQRH
ocBTmgqomHkdpbzBcJa14cmHbVsUgg==
=N3j2
-----END PGP SIGNATURE-----

--9i31azO2pPhdwfPMBdkquiy4sk1NTsALe--
