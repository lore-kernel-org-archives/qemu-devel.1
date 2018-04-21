Received: from eggs.gnu.org ([2001:4830:134:3::10]:53226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9oUW-0001db-BM
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9oUT-0003TA-6g
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:07:32 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:45906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f9oUT-0003Rh-0B
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:07:29 -0400
Received: from player796.ha.ovh.net (unknown [10.109.108.30])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 91C8316768E
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 11:07:27 +0200 (CEST)
References: <20180420124835.7268-1-peter.maydell@linaro.org>
	<20180420124835.7268-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <518fe8ea-b9f1-f5a8-e3b5-525e48b0d1c5@kaod.org>
Date: Sat, 21 Apr 2018 11:07:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180420124835.7268-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/aspeed_soc: don't use
 vmstate_register_ram_global for SRAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Rob Herring <robh@kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 04/20/2018 02:48 PM, Peter Maydell wrote:
> Currently we use vmstate_register_ram_global() for the SRAM;
> this is not a good idea for devices, because it means that
> you can only ever create one instance of the device, as
> the second instance would get a RAM block name clash.
> Instead, use memory_region_init_ram(), which automatically
> registers the RAM block with a local-to-the-device name.
>=20
> Note that this is a cross-version migration compatibility break
> for the "palmetto-bmc", "ast2500-evb" and "romulus-bmc" machines.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

On palmetto, romulus and ast2500-evb boards=20

Thanks

C.> ---
>  hw/arm/aspeed_soc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 30d25f8b06..407f10d0d4 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -186,13 +186,12 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
>      }
> =20
>      /* SRAM */
> -    memory_region_init_ram_nomigrate(&s->sram, OBJECT(dev), "aspeed.sr=
am",
> +    memory_region_init_ram(&s->sram, OBJECT(dev), "aspeed.sram",
>                             sc->info->sram_size, &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
> -    vmstate_register_ram_global(&s->sram);
>      memory_region_add_subregion(get_system_memory(), ASPEED_SOC_SRAM_B=
ASE,
>                                  &s->sram);
> =20
>=20
