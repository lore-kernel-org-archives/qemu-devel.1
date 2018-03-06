Received: from eggs.gnu.org ([2001:4830:134:3::10]:44127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3Ae-0005M6-EF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 22:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3Ad-0005mq-8n
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 22:21:44 -0500
Date: Tue, 6 Mar 2018 13:09:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180306020918.GS2650@umbus.fritz.box>
References: <20180305215113.25085-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aTHdXM4WpLndGb15"
Content-Disposition: inline
In-Reply-To: <20180305215113.25085-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] adb: add trace-events for monitoring
 keyboard/mouse during bus enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--aTHdXM4WpLndGb15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 09:51:13PM +0000, Mark Cave-Ayland wrote:
> This is useful to help diagnose problems related to address clashes during
> MacOS 9 boot.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/input/adb-kbd.c    | 4 ++++
>  hw/input/adb-mouse.c  | 5 +++++
>  hw/input/trace-events | 5 +++++
>  3 files changed, 14 insertions(+)
>=20
> diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
> index 266aed1b7b..50b62712c8 100644
> --- a/hw/input/adb-kbd.c
> +++ b/hw/input/adb-kbd.c
> @@ -258,6 +258,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obu=
f,
>              case ADB_CMD_CHANGE_ID_AND_ACT:
>              case ADB_CMD_CHANGE_ID_AND_ENABLE:
>                  d->devaddr =3D buf[1] & 0xf;
> +                trace_adb_kbd_request_change_addr(d->devaddr);
>                  break;
>              default:
>                  d->devaddr =3D buf[1] & 0xf;
> @@ -269,6 +270,9 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obu=
f,
>                  if (buf[2] =3D=3D 1 || buf[2] =3D=3D 2 || buf[2] =3D=3D =
3) {
>                      d->handler =3D buf[2];
>                  }
> +
> +                trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
> +                                                              d->handler=
);
>                  break;
>              }
>          }
> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
> index 47e88faf25..3ba6027d33 100644
> --- a/hw/input/adb-mouse.c
> +++ b/hw/input/adb-mouse.c
> @@ -118,6 +118,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *o=
buf,
>          s->dx =3D 0;
>          s->dy =3D 0;
>          s->dz =3D 0;
> +        trace_adb_mouse_flush();
>          return 0;
>      }
> =20
> @@ -138,6 +139,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *o=
buf,
>              case ADB_CMD_CHANGE_ID_AND_ACT:
>              case ADB_CMD_CHANGE_ID_AND_ENABLE:
>                  d->devaddr =3D buf[1] & 0xf;
> +                trace_adb_mouse_request_change_addr(d->devaddr);
>                  break;
>              default:
>                  d->devaddr =3D buf[1] & 0xf;
> @@ -155,6 +157,9 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *o=
buf,
>                  if (buf[2] =3D=3D 1 || buf[2] =3D=3D 2) {
>                      d->handler =3D buf[2];
>                  }
> +
> +                trace_adb_mouse_request_change_addr_and_handler(d->devad=
dr,
> +                                                                d->handl=
er);
>                  break;
>              }
>          }
> diff --git a/hw/input/trace-events b/hw/input/trace-events
> index 5affabc81d..db72484a25 100644
> --- a/hw/input/trace-events
> +++ b/hw/input/trace-events
> @@ -4,10 +4,15 @@
>  adb_kbd_no_key(void) "Ignoring NO_KEY"
>  adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>  adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%=
2.2x obuf[1] 0x%2.2x"
> +adb_kbd_request_change_addr(int devaddr) "change addr to 0x%x"
> +adb_kbd_request_change_addr_and_handler(int devaddr, int handler) "chang=
e addr and handler to 0x%x, 0x%x"
> =20
>  # hw/input/adb-mouse.c
> +adb_mouse_flush(void) "flush"
>  adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
>  adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0=
x%2.2x obuf[1] 0x%2.2x"
> +adb_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
> +adb_mouse_request_change_addr_and_handler(int devaddr, int handler) "cha=
nge addr and handler to 0x%x, 0x%x"
> =20
>  # hw/input/ps2.c
>  ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aTHdXM4WpLndGb15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqd+EsACgkQbDjKyiDZ
s5IMBA//Sz+U53sH4b7lk7wRKLaBXwIskTRAnNBgfhROfo+M5bzIKkSut8/tb6qH
sWDNN8tHMojAu4byrHZYCAvjekwH7F9YmyGOxsg+X9+FDOG0NLyWT3M/7O36Gess
BgFQkriiwPO5xpHjQ/Oc8giREXaHOAnXrsZbi+jGea3jNmaQxdr3o3ubWqu996J7
d6y76Ph23/hF9PUQaUhWiN7PzsC06+VrFBcpCIf8O6llHgmdHyc1+TjPpzKY07Yu
AMrJHS2ih5lBjp1KM5diXaiWia9g82zpurrpa2MnF1ikklz/RCfVhgVwRys5FI5s
FYncJxSP8RUovQ32xjjHaFvp8ysbWd4hdCIb/9VleLt9L3GEqqvK9KCKUjx6Zj2O
bgZgLe/ofKbCzclq04ZGSlpHCCt5zZdXtI+OsPtszvyk7XehOB4wPerafHAAr6d1
F+VZ2hzpNS1Swnh0jvhwfMfIYfhmg0xJE+pEaNIpaWGTkDsJqk0hpCygPagxs8f7
TVWkP68YW+4jp/w7ee+WiD9DggBFOeJGon2M4yP3725J53eZzC/QfjAukB5UwVVY
0xMXkhqQ+JCnmqTysNMlUQLWdcbE2m7MuPnYSaQOcs6/1gVcSXZgrhOe5LNyvfwP
MSynZd+tFJi4BArrwxbYKwYN0p8P4PGLt0glQa9BndTMbDm6Kcw=
=sU7m
-----END PGP SIGNATURE-----

--aTHdXM4WpLndGb15--
