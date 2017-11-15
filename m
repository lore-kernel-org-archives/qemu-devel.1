Received: from eggs.gnu.org ([2001:4830:134:3::10]:48388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eEsto-0002Hu-Pk
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 03:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eEstj-0006UW-QM
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 03:18:20 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:41321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eEstj-0006Ts-Hb
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 03:18:15 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 11B8286863
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 09:18:13 +0100 (CET)
References: <20171114122018.12204-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <27983ce7-8de1-620f-ca06-ee4f92dab180@kaod.org>
Date: Wed, 15 Nov 2017 09:18:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171114122018.12204-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/arm/aspeed: Unlock SCU when running
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>

On 11/14/2017 01:20 PM, Joel Stanley wrote:
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
> Change behaviour so that when a kernel is passed to the machine, set th=
e
> reset value of the SCU to be unlocked.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> v3:
>  - remove unused member from AspeedBoardConfig
> v2:
>  - use the correct value for the key
>  - rename it ASPEED_SCU_PROT_KEY
> ---
>  hw/arm/aspeed.c              | 9 +++++++++
>  hw/arm/aspeed_soc.c          | 2 ++
>  hw/misc/aspeed_scu.c         | 5 +++--
>  include/hw/misc/aspeed_scu.h | 3 +++
>  4 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ab895ad490af..7088c907bd23 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -186,6 +186,15 @@ static void aspeed_board_init(MachineState *machin=
e,
>                              &error_abort);
>      object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
>                              &error_abort);
> +    if (machine->kernel_filename) {
> +        /*
> +         * When booting with a -kernel command line there is no u-boot
> +         * that runs to unlock the SCU. In this case set the default t=
o
> +         * be unlocked as the kernel expects
> +         */
> +        object_property_set_int(OBJECT(&bmc->soc), ASPEED_SCU_PROT_KEY=
,
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
>      object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename)=
;
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
> @@ -192,7 +191,7 @@ static void aspeed_scu_write(void *opaque, hwaddr o=
ffset, uint64_t data,
>      }
> =20
>      if (reg > PROT_KEY && reg < CPU2_BASE_SEG1 &&
> -            s->regs[PROT_KEY] !=3D PROT_KEY_UNLOCK) {
> +            s->regs[PROT_KEY] !=3D ASPEED_SCU_PROT_KEY) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func_=
_);
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
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.=
h
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
>=20
