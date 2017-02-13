Received: from eggs.gnu.org ([2001:4830:134:3::10]:34645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd9ok-0004uG-8h
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 01:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd9oi-0002qy-Vz
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 01:08:54 -0500
Date: Mon, 13 Feb 2017 16:43:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213054309.GD25381@umbus>
References: <1486638881-17290-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lpbaaqEfWJan1gxl"
Content-Disposition: inline
In-Reply-To: <1486638881-17290-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/pci-host/prep: Do not use
 hw_error() in realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--lpbaaqEfWJan1gxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 12:14:41PM +0100, Thomas Huth wrote:
> hw_error() is for CPU related errors only (it prints out a
> register dump and calls abort()), so we should not use it
> if we just failed to load the bios image. Apart from that,
> realize() functions should not exit directly but always set
> the errp with error_setg() in case of errors instead.
> Additionally, move some code around and delete the bios memory
> subregion again in case of such an error, so that we leave a
> clean state when returning to the caller.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.9.

> ---
>  hw/pci-host/prep.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 5580293..260a119 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -309,7 +309,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
>      memory_region_set_readonly(&s->bios, true);
>      memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SI=
ZE),
>                                  &s->bios);
> -    vmstate_register_ram_global(&s->bios);
>      if (s->bios_name) {
>          filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, s->bios_name);
>          if (filename) {
> @@ -328,12 +327,15 @@ static void raven_realize(PCIDevice *d, Error **err=
p)
>                  }
>              }
>          }
> +        g_free(filename);
>          if (bios_size < 0 || bios_size > BIOS_SIZE) {
> -            /* FIXME should error_setg() */
> -            hw_error("qemu: could not load bios image '%s'\n", s->bios_n=
ame);
> +            memory_region_del_subregion(get_system_memory(), &s->bios);
> +            error_setg(errp, "Could not load bios image '%s'", s->bios_n=
ame);
> +            return;
>          }
> -        g_free(filename);
>      }
> +
> +    vmstate_register_ram_global(&s->bios);
>  }
> =20
>  static const VMStateDescription vmstate_raven =3D {
> @@ -361,7 +363,6 @@ static void raven_class_init(ObjectClass *klass, void=
 *data)
>      /*
>       * Reason: PCI-facing part of the host bridge, not usable without
>       * the host-facing part, which can't be device_add'ed, yet.
> -     * Reason: realize() method uses hw_error().
>       */
>      dc->cannot_instantiate_with_device_add_yet =3D true;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lpbaaqEfWJan1gxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoUdtAAoJEGw4ysog2bOSNvIQANcVBsl84KsLwxslO9SWMm+T
DewaCuDD0AXci8q4beTKNF7otutirPe6T2AmVJOmUx0u98uB13qt6vClS9NKWXhT
ae4TDgemE4Byfbpsz0z7bcwA4Tud9xsqItOaW6HKYnfaM6nUCZgWtDH+KlvriCul
hx5f1H3ozW3ZLuF/9m6Z410gZXJuMlJs1tvkxXn6+lb/IK3asbwf7wN73jzSQO4y
2FjePIKBBjk38pc1u71PKSt1xgNU5VvP2ayCAFLiM+aoo4xF4vqMVe4M9TZDElUp
GaIEYzsK3+pCefmF4/3RJEBo+xGr9xebTqfnNPd+HgxEf0bEdaNqGtueeX749j11
H0T8N6BWvtwuIXpjKFWPxG8/HzZtfv9uj15g7+wdMrxcpVkkt52B4Frw8o3abqGl
d2Mh5g/7qKnPFvaGNbT/0lFT3fiiJKNMgW3rxixXNgcOXpifrka75zxZ+uFHJNAc
JWBS2EuroEWq+LKyud6WyIWoE7trx/S0dNSHSIwThMQ9DNkAU6gD7d5Z9EYUtYcG
wBf4J6aQD8doWTXPJ+pGU919pGeXi8ZS+Vqr9tPtWFAtupRK0D65tSYlGm0/m7PV
GEgMJy3x9uNLvDFQCQwFBvfmqBg3mxdA9qtHq9J83xh0Pcdd00yldC/PRpywOasB
HQ458uZt2u/2OWhcMn0B
=ZtRr
-----END PGP SIGNATURE-----

--lpbaaqEfWJan1gxl--
