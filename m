Received: from eggs.gnu.org ([2001:4830:134:3::10]:37322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIDuC-0000H7-Ty
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIDu8-0007hJ-17
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:52:48 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fIDu7-0007h4-QJ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:52:43 -0400
Received: by mail-wm0-x241.google.com with SMTP id j4-v6so13673296wme.1
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 06:52:43 -0700 (PDT)
Date: Mon, 14 May 2018 14:52:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514135240.GE5182@stefanha-x1.localdomain>
References: <20180511203238.22881-1-andrewjameswood@ymail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20180511203238.22881-1-andrewjameswood@ymail.com>
Subject: Re: [Qemu-devel] [PATCH] Added SIGPWR handler to send ACPI shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: andrewjameswood@ymail.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Andrew Wood <awood@comms.org.uk>, Daniel Berrange <berrange@redhat.com>


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 09:32:38PM +0100, andrewjameswood--- via Qemu-devel=
 wrote:
> From: Andrew Wood <awood@comms.org.uk>
>=20
> Signed-off-by: Andrew Wood <awood@comms.org.uk>

Thanks!

Please include a commit description to give the rationale for this
change.

Please address coding style issues.  You can run the checker like this:

  $ scripts/checkpatch.pl HEAD^..

> ---
>  os-posix.c |  1 +
>  vl.c       | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/os-posix.c b/os-posix.c
> index b9c2343b1e..68d70f269b 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -70,6 +70,7 @@ void os_setup_signal_handling(void)
>      sigaction(SIGINT,  &act, NULL);
>      sigaction(SIGHUP,  &act, NULL);
>      sigaction(SIGTERM, &act, NULL);
> +    sigaction(SIGPWR, &act, NULL);
>  }
> =20
>  /* Find a likely location for support files using the location of the bi=
nary.
> diff --git a/vl.c b/vl.c
> index fce1fd12d8..55c5e06858 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1846,8 +1846,17 @@ void qemu_system_killed(int signal, pid_t pid)
>      /* Cannot call qemu_system_shutdown_request directly because
>       * we are in a signal handler.
>       */
> -    shutdown_requested =3D SHUTDOWN_CAUSE_HOST_SIGNAL;
> -    qemu_notify_event();
> +    if (signal=3D=3DSIGPWR)
> +    {
> +=09
> +	powerdown_requested =3D 1;
> +    	qemu_notify_event();
> +    }
> +    else
> +    {
> +    	shutdown_requested =3D SHUTDOWN_CAUSE_HOST_SIGNAL;
> +    	qemu_notify_event();
> +    }
>  }
> =20
>  void qemu_system_shutdown_request(ShutdownCause reason)
> --=20
> 2.11.0
>=20
>=20

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZSoAAoJEJykq7OBq3PItZAH/2LBxZSouXtWn17sA4ijyvcl
BGeeInUrXOZZUBmK/mYn1yPB6/ezGc4Xdm049QLw9F4t+RGMe7nN3otqP1lkxDOL
bF23O5jEeiQrzwEHpXLYiO6T8Cz+JQvPVSg/LygedOIpz8ViJj06Syls9L+Tzt4w
HJJvH1K2R5m8IEf5D5cXn5CAkb8kAuH4Yv4nF1uvBBInR6ujj47e+ZQgCFkxX9EC
dEf3QvZZxSZ2ztOtUhdmzcS/fdbABdtFTBbzt4UmIVivOhkM2F9/ZJrLIRtpkChv
dsK8imqQglHzCpUbY53SIphn0c9WkVzBQNGksJubd3xeY97NSK4bR2ETb79s+vw=
=+0dY
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
