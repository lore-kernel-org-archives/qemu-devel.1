Received: from eggs.gnu.org ([2001:4830:134:3::10]:42751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5N-00026r-KS
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5K-0002P2-H4
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:57 -0400
Date: Mon, 10 Apr 2017 15:32:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410053222.GO27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-17-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-17-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 16/21] ppc/pnv: generate an OEM SEL event
 on shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:41PM +0200, C=E9dric Le Goater wrote:
> OpenPOWER systems expect to be notified with such an event before a
> shutdown or a reboot. An OEM SEL message is sent with specific
> identifiers and a user data containing the request : OFF or REBOOT.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/pnv.c         | 14 ++++++++++++++
>  hw/ppc/pnv_bmc.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/pnv.h |  3 +++
>  3 files changed, 59 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c7caecad0aa6..df0a88c3e252 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -467,6 +467,15 @@ static void *powernv_create_fdt(MachineState *machin=
e)
>      return fdt;
>  }
> =20
> +static void pnv_powerdown_notify(Notifier *n, void *opaque)
> +{
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
> +
> +    if (pnv->bmc) {
> +        pnv_bmc_powerdown(pnv->bmc);
> +    }
> +}
> +
>  static void ppc_powernv_reset(void)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> @@ -662,6 +671,11 @@ static void ppc_powernv_init(MachineState *machine)
> =20
>      /* Create an RTC ISA device too */
>      rtc_init(pnv->isa_bus, 2000, NULL);
> +
> +    /* OpenPOWER systems use a IPMI SEL Event message to notify the
> +     * host to powerdown */
> +    pnv->powerdown_notifier.notify =3D pnv_powerdown_notify;
> +    qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
>  }
> =20
>  /*
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 2998530dc4c0..d9ed774acbac 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -32,6 +32,48 @@
>  /* TODO: include definition in ipmi.h */
>  #define IPMI_SDR_FULL_TYPE 1
> =20
> +/*
> + * OEM SEL Event data packet sent by BMC in response of a Read Event
> + * Message Buffer command
> + */
> +typedef struct OemSel {
> +    /* SEL header */
> +    uint8_t id[2];
> +    uint8_t type;
> +    uint8_t timestamp[4];
> +    uint8_t manuf_id[3];
> +
> +    /* OEM SEL data (6 bytes) follows */
> +    uint8_t netfun;
> +    uint8_t cmd;
> +    uint8_t data[4];
> +} OemSel;
> +
> +#define SOFT_OFF        0x00
> +#define SOFT_REBOOT     0x01
> +
> +static void pnv_gen_oem_sel(Object *obj, uint8_t reboot)
> +{
> +    /* IPMI SEL Event are 16 bytes long */
> +    OemSel sel =3D {
> +        .id        =3D { 0x55 , 0x55 },
> +        .type      =3D 0xC0, /* OEM */
> +        .manuf_id  =3D { 0x0, 0x0, 0x0 },
> +        .timestamp =3D { 0x0, 0x0, 0x0, 0x0 },
> +        .netfun    =3D 0x3A, /* IBM */
> +        .cmd       =3D 0x04, /* AMI OEM SEL Power Notification */
> +        .data      =3D { reboot, 0xFF, 0xFF, 0xFF },
> +    };
> +
> +    ipmi_bmc_gen_event(IPMI_BMC(obj), (uint8_t *) &sel,
> +                       0 /* do not log the event */);
> +}
> +
> +void pnv_bmc_powerdown(Object *obj)
> +{
> +    pnv_gen_oem_sel(obj, SOFT_OFF);
> +}
> +
>  void pnv_bmc_populate_sensors(Object *bmc, void *fdt)
>  {
>      int offset;
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 050763f6cf54..b70a13bd4175 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -132,6 +132,8 @@ typedef struct PnvMachineState {
>      uint32_t     cpld_irqstate;
> =20
>      Object       *bmc;
> +
> +    Notifier     powerdown_notifier;
>  } PnvMachineState;
> =20
>  #define PNV_FDT_ADDR          0x01000000
> @@ -141,6 +143,7 @@ typedef struct PnvMachineState {
>   * BMC helpers
>   */
>  void pnv_bmc_populate_sensors(Object *objbmc, void *fdt);
> +void pnv_bmc_powerdown(Object *objbmc);
> =20
>  /*
>   * POWER8 MMIO base addresses

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6xjlAAoJEGw4ysog2bOSxIwP+gMzsvSd/f1S4Q4bQNwXxqXW
QkOrdEZ1c/K4qnR0YMBcDG6YSSDvk8oATRLuEbDg6bXNvXud0wqzbJ5/40pfCPp8
iLPLTjWdPmBIWPp8hHOjY9E53qt5gvLRW8a8ze5wCQBkmHR+3E/TnrlTvVCNFeL1
HjDfU0YE74QmyuMXaSuuNBSBnDWlmmxeBp9fcwlqjzfbJu5jiHTOS0roCZ8EUy0L
MiKtAYNcVX1SZfFMU2FGxrFOJWh96sRlmDrPBt0BZAhE+pQL69wvp+nh1+tMi5yZ
pq+epG7Cu58ySGHSyXYIophUj/qDdCIVNL8B5zWtJiou5zLZamZ4yLxdNHiHZMeM
gKIaX7/CgCSxYX8VQOo1TayEuXMtdK46TLgnKRvIqF5/JOuIHej7xRuUxgoeI0gm
KTy9jmDY3adcwI2WXCjUguw0Hf7qcZDz94hv3IqwP6eZZzVJh5wOqukTHJOZ3epT
wh7Vsw6DeHv81RP/kLpetVeDhJBgsyAwcypGxbd6s4IySvacW5AM4InK00JTU0dT
bHRjKwN0GAAmgNZcTaj4be/BYf9cKahjWzHVdkuNU0rU1IAWSEETiK691xvrMRoj
qNQMEL+ixmYy7htwwVbgWKUDNHpP63i3KyDEzw29fWKLe/KL9m3snY94oVFvsCaJ
4s9wJFduSzC7EcHN57dX
=y89S
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
