Received: from eggs.gnu.org ([2001:4830:134:3::10]:45830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1eEPBh-0002du-QG
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1eEPBg-0003zd-GY
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:34:49 -0500
Message-ID: <1510619669.4287.82.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 14 Nov 2017 11:04:29 +1030
In-Reply-To: <20171113132801.8562-1-joel@jms.id.au>
References: <20171113132801.8562-1-joel@jms.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-5ZHCzvozudbOoeAxO8cJ"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/aspeed: Unlock SCU when running
 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--=-5ZHCzvozudbOoeAxO8cJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-11-13 at 23:58 +1030, Joel Stanley wrote:
> The ASPEED hardware contains a lock register for the SCU that disables
> any writes to the SCU when it is locked. The machine comes up with the
> lock enabled, but on all known hardware u-boot will unlock it and leave
> it unlocked when loading the kernel.
>=20
> This means the kernel expects the SCU to be unlocked. When booting from
> an emulated ROM the normal u-boot unlock path is executed. Things don't
> go well when booting using the -kernel command line, as u-boot does not
> run first.
>=20
> Change behaviour so that when a kernel is passed to the machine, set the
> reset value of the SCU to be unlocked.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  - use the correct value for the key
>  - rename it ASPEED_SCU_PROT_KEY
> ---
>  hw/arm/aspeed.c              | 10 ++++++++++
>  hw/arm/aspeed_soc.c          |  2 ++
>  hw/misc/aspeed_scu.c         |  5 +++--
>  include/hw/misc/aspeed_scu.h |  3 +++
>  4 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ab895ad490af..754df8403273 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -36,6 +36,7 @@ typedef struct AspeedBoardState {
>  typedef struct AspeedBoardConfig {
>      const char *soc_name;
>      uint32_t hw_strap1;
> +    uint32_t hw_prot_key;

It doesn't seem like this member is used?

With respect to the patch as a whole, I was planning to implement a
small kernel driver for the SCU to unlock it on probe but never got
around to it. However, this seems reasonable; I always worked around it
locally in a much more hacky fashion. It would be handy to have an
upstream solution.

Andrew

>      const char *fmc_model;
>      const char *spi_model;
>      uint32_t num_cs;
> @@ -186,6 +187,15 @@ static void aspeed_board_init(MachineState *machine,
>                              &error_abort);
>      object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
>                              &error_abort);
> +    if (machine->kernel_filename) {
> +        /*
> +         * When booting with a -kernel command line there is no u-boot
> +         * that runs to unlock the SCU. In this case set the default to
> +         * be unlocked as the kernel expects
> +         */
> +        object_property_set_int(OBJECT(&bmc->soc), ASPEED_SCU_PROT_KEY,
> +                                "hw-prot-key", &error_abort);
> +    }
>      object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
>                               &error_abort);
> =20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 5aa3d2ddd9cd..c83b7e207b86 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -154,6 +154,8 @@ static void aspeed_soc_init(Object *obj)
>                                "hw-strap1", &error_abort);
>      object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
>                                "hw-strap2", &error_abort);
> +    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
> +                              "hw-prot-key", &error_abort);
> =20
>      object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
>      object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 95022d3607ad..74537ce9755d 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -85,7 +85,6 @@
>  #define BMC_REV              TO_REG(0x19C)
>  #define BMC_DEV_ID           TO_REG(0x1A4)
> =20
> -#define PROT_KEY_UNLOCK 0x1688A8A8
>  #define SCU_IO_REGION_SIZE 0x1000
> =20
>  static const uint32_t ast2400_a0_resets[ASPEED_SCU_NR_REGS] =3D {
> @@ -192,7 +191,7 @@ static void aspeed_scu_write(void *opaque, hwaddr off=
set, uint64_t data,
>      }
> =20
>      if (reg > PROT_KEY && reg < CPU2_BASE_SEG1 &&
> -            s->regs[PROT_KEY] !=3D PROT_KEY_UNLOCK) {
> +            s->regs[PROT_KEY] !=3D ASPEED_SCU_PROT_KEY) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__)=
;
>          return;
>      }
> @@ -246,6 +245,7 @@ static void aspeed_scu_reset(DeviceState *dev)
>      s->regs[SILICON_REV] =3D s->silicon_rev;
>      s->regs[HW_STRAP1] =3D s->hw_strap1;
>      s->regs[HW_STRAP2] =3D s->hw_strap2;
> +    s->regs[PROT_KEY] =3D s->hw_prot_key;
>  }
> =20
>  static uint32_t aspeed_silicon_revs[] =3D {
> @@ -299,6 +299,7 @@ static Property aspeed_scu_properties[] =3D {
>      DEFINE_PROP_UINT32("silicon-rev", AspeedSCUState, silicon_rev, 0),
>      DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),
>      DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
> +    DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index bd4ac013f997..d70cc0aeca61 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -29,6 +29,7 @@ typedef struct AspeedSCUState {
>      uint32_t silicon_rev;
>      uint32_t hw_strap1;
>      uint32_t hw_strap2;
> +    uint32_t hw_prot_key;
>  } AspeedSCUState;
> =20
>  #define AST2400_A0_SILICON_REV   0x02000303U
> @@ -38,6 +39,8 @@ typedef struct AspeedSCUState {
> =20
>  extern bool is_supported_silicon_rev(uint32_t silicon_rev);
> =20
> +#define ASPEED_SCU_PROT_KEY      0x1688A8A8
> +
>  /*
>   * Extracted from Aspeed SDK v00.03.21. Fixes and extra definitions
>   * were added.
--=-5ZHCzvozudbOoeAxO8cJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJaCjoVAAoJEJ0dnzgO5LT5+DIP/11mzFbN5rP6szkwl+V9jR/I
8HtF+PkLshbGm67+lB8HFv0D5SsoPKjp3J6KT784VLWd5jyIWmP3U0KSIFOKDwY/
B4cvPuzbx4Hf4jt9HGj9VNWiw+BGoW9Xkqc4+d2MWkfZioOraXt4btvHxjP3Dg8t
cdfMytXN1bTC0sPo2IX3+kh+KE4l2RZ+OENOSlPp4JC7yi8kl1cuB5/4EFUuRDvT
0VDjhzb/1MhfKnufDvk0uzeSoaX42DWV5TjM417KLutHooe3XyDGZ55cbJY+8qc2
71P4saKpjxPolidoo7UOF9Wwx6zDbTR+iPqyKPgz8cL7yzaKX5/toC7ouAbvHsGn
LbCQbMUC0ka7HJweKlk604sqjr+GSOibS+vnI/4gN2rB4gejdJ3SSuCLOmCHscxM
HzRs1OjALX8kShWxdTuTBiFHCqa8xVEpEMGUmw3TwZIQcfZHnXNLGSRu0xt7HWKo
Yfu6h7ICa0qqZkXWaq8rzsUxvdCqT9vxWOYxU5yzCxBkDzjLfhAu+k4/jdJSB5jQ
KaeBNBaAZc/Om+uqKuevWE1a3ignSbKtUNvbAM7bv+vsQmkomdjL9hf29hN8SEhZ
EajHuu+LQ56Z51kDkWCs7s+R0VN0DLkmZVtp2V9qP3PV1rmuNii6R2+jI4TxHve0
RDmwI+a5BgdVhN+HCWmX
=ZSX+
-----END PGP SIGNATURE-----

--=-5ZHCzvozudbOoeAxO8cJ--
