Received: from eggs.gnu.org ([2001:4830:134:3::10]:47192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMANz-0004ti-7Y
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMANx-0002yP-Vy
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:35 -0500
Date: Tue, 5 Dec 2017 17:40:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205064003.GI3057@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<f02979282eb1d31811f0f87c0bb5d774a959746c.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Content-Disposition: inline
In-Reply-To: <f02979282eb1d31811f0f87c0bb5d774a959746c.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 11/17] e500: derive baud from CCB clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:09PM -0600, Michael Davidsaver wrote:
> The CCB (Complex Core Bus) clock is the reference for the DUARTs
> with an extra divide by 16.
>=20
> >From the mpc8540, mpc8544, and P2010 ref manuals.
> CCB=3D333MHz, with divider=3D0x87a gives ~9600 baud.
> 333e6 Hz/(16*0x87a) =3D 9591 Hz.
> This is verified with a real mpc8540.
>=20
> The existing value for the mpc8544ds boards is replaced.
> Previously the uart "clock-frequency" device tree node
> was left as zero, and at some point either u-boot or Linux
> picks a value inconsistent with the frequency
> given to serial_mm_init().
> The FIFO timeout calculated from this was incorrect.
>=20
> Now use an arbitrary (valid) CCB frequency of 333MHz
> in the device tree and for the UART.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/ppc/e500.c      |  9 ++++++++-
>  hw/ppc/e500_ccsr.c | 16 ++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 2d87d91582..cfd5ed0152 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -49,6 +49,12 @@
> =20
>  #define RAM_SIZES_ALIGN            (64UL << 20)
> =20
> +/* Somewhat arbitrarily choosen Complex Core Bus frequency
> + * for our simulation (real freq of mpc8544ds board unknown)
> + * Used in baud rate calculations.
> + */
> +#define CCB_FREQ (333333333)
> +
>  /* TODO: parameterize
>   * Some CCSR offsets duplicated in e500_ccsr.c
>   */
> @@ -113,7 +119,7 @@ static void dt_serial_create(void *fdt, unsigned long=
 long offset,
>      qemu_fdt_setprop_string(fdt, ser, "compatible", "ns16550");
>      qemu_fdt_setprop_cells(fdt, ser, "reg", offset, 0x100);
>      qemu_fdt_setprop_cell(fdt, ser, "cell-index", idx);
> -    qemu_fdt_setprop_cell(fdt, ser, "clock-frequency", 0);
> +    qemu_fdt_setprop_cell(fdt, ser, "clock-frequency", CCB_FREQ);

Shouldn't this come off the property value, not the constant?

>      qemu_fdt_setprop_cells(fdt, ser, "interrupts", 42, 2);
>      qemu_fdt_setprop_phandle(fdt, ser, "interrupt-parent", mpic);
>      qemu_fdt_setprop_string(fdt, "/aliases", alias, ser);
> @@ -759,6 +765,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      dev =3D qdev_create(NULL, "e500-ccsr");
>      object_property_add_child(qdev_get_machine(), "e500-ccsr",
>                                OBJECT(dev), NULL);
> +    qdev_prop_set_uint32(dev, "ccb-freq", CCB_FREQ);
>      qdev_prop_set_uint32(dev, "mpic-model", params->mpic_version);
>      qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
>      qdev_prop_set_uint32(dev, "ram-size", ram_size);
> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
> index f1adba4e54..c479ed91ee 100644
> --- a/hw/ppc/e500_ccsr.c
> +++ b/hw/ppc/e500_ccsr.c
> @@ -69,6 +69,7 @@ typedef struct {
>      uint32_t merrd;
> =20
>      uint32_t porpllsr;
> +    uint32_t ccb_freq;
> =20
>      DeviceState *pic;
>  } CCSRState;
> @@ -272,15 +273,21 @@ static void e500_ccsr_realize(DeviceState *dev, Err=
or **errp)
>      /* Note: MPIC internal interrupts are offset by 16 */
> =20
>      /* DUARTS */
> +    /* for mpc8540, mpc8544, and P2010 (unmodeled), the DUART reference =
clock
> +     * is the CCB clock divided by 16.
> +     * So baud rate is CCB/(16*divider)
> +     */
>      if (serial_hds[0]) {
> -        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(0),
> -                       0, qdev_get_gpio_in(ccsr->pic, 16 + 26), 399193,
> +        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(0), 0,
> +                       qdev_get_gpio_in(ccsr->pic, 16 + 26),
> +                       ccsr->ccb_freq / 16u,
>                         serial_hds[0], DEVICE_BIG_ENDIAN);
>      }
> =20
>      if (serial_hds[1]) {
> -        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(1),
> -                       0, qdev_get_gpio_in(ccsr->pic, 16 + 26), 399193,
> +        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(1), 0,
> +                       qdev_get_gpio_in(ccsr->pic, 16 + 26),
> +                       ccsr->ccb_freq / 16u,
>                         serial_hds[1], DEVICE_BIG_ENDIAN);
>      }
> =20
> @@ -290,6 +297,7 @@ static Property e500_ccsr_props[] =3D {
>      DEFINE_PROP_UINT32("base", CCSRState, defbase, 0xff700000),
>      DEFINE_PROP_UINT32("ram-size", CCSRState, ram_size, 0),
>      DEFINE_PROP_UINT32("porpllsr", CCSRState, porpllsr, 0),
> +    DEFINE_PROP_UINT32("ccb-freq", CCSRState, ccb_freq,
>      333333333u),

And shouldn't this use the #define as the default value?

>      /* "mpic-model" aliased from MPIC */
>      DEFINE_PROP_END_OF_LIST()
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlomP0MACgkQbDjKyiDZ
s5Ks6BAA1cen/aSflPZ98hWmgEVszQ0heMOFyUeCVC5gHve8s9QqQhH8Smdb4MhG
EJMCl0f+KqwtTQ2c1Y9qR7IsChMZG0+ghx19a1N+5ECDA2MLTlBbEQUQwA0i++HX
Ou+sQM293m8wuKO6sARAj3Qpt/SI55rRmE06lyAgvq8Ai0mZF94TsrKurNIWm05Q
CARot7cQA6YIl1gOeTW/q5DRHMgB7dWkNrnh1Fl4wjGRf/4wNFO65gsog6qjxxzG
XxjpDiA9LgsbBGQx3PhEGVcHfeUdijSdUMl6JR749U3eWS0ZmrEm7BPt+V8VvjjE
lIDiVQRHAYHE7nsz2uCjojFprED4NpNHHX4iGWtUTxqcM17RaVEi+x2WOylvbwFv
ZZhoWF4b29rz+g1ryN5XXIjp3RSzBMhCCeiQvrEMHV5h7vqJtRBLiOFRm9os/GmI
4Ep5JXIiDUuQYsoWE3HtTmLUFhW57aKkUI5fJqNvOdYLu14/Ueh3fJ8yfJtpWm/e
/kNyZUr5B/U1swQy3iFqyxMZ3HvZHD0ae+6yb3VieWZLCjPAO0wck0sunE3GuO6E
Bbm8m3cA1nCCWocemxT5waDwaJ8G0L7iCjho2PjP1HN/Sl/5J8PbKMONxKjhejSu
HLKMmn0WmJoTZ/gB/ROrw3SGxd8SAdnbT4pRYOZxj1Ubp8lQvEg=
=IfVS
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
