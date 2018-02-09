Received: from eggs.gnu.org ([2001:4830:134:3::10]:38773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ek6NU-0006db-E8
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ek6NP-0006Pf-JW
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:58:00 -0500
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:45544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ek6NP-0006Os-Cl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:57:55 -0500
Received: from player697.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id AF8018F67A
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 11:57:53 +0100 (CET)
References: <20180209085755.30414-1-f4bug@amsat.org>
	<20180209085755.30414-2-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6b80dc31-c710-e4cb-4d0d-ac74cfd3e874@kaod.org>
Date: Fri, 9 Feb 2018 11:57:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180209085755.30414-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/arm/aspeed: directly map the
 serial device to the system address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 02/09/2018 09:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> (qemu) info mtree
>  address-space: cpu-memory-0
>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>      0000000000000000-0000000007ffffff (prio 0, rom): aspeed.boot_rom
>      000000001e600000-000000001e7fffff (prio -1, i/o): aspeed_soc.io
> -      000000001e784000-000000001e78401f (prio 0, i/o): serial
>      000000001e620000-000000001e6200ff (prio 0, i/o): aspeed.smc.ast250=
0-fmc
>      000000001e630000-000000001e6300ff (prio 0, i/o): aspeed.smc.ast250=
0-spi1
>      [...]
>      000000001e720000-000000001e728fff (prio 0, ram): aspeed.sram
>      000000001e782000-000000001e782fff (prio 0, i/o): aspeed.timer
> +    000000001e784000-000000001e78401f (prio 0, i/o): serial
>      000000001e785000-000000001e78501f (prio 0, i/o): aspeed.wdt
>      000000001e785020-000000001e78503f (prio 0, i/o): aspeed.wdt
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

> ---
>  hw/arm/aspeed_soc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index c83b7e207b..2a5d041b3b 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -257,7 +257,8 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
>      /* UART - attach an 8250 to the IO space as our UART5 */
>      if (serial_hds[0]) {
>          qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs=
[4]);
> -        serial_mm_init(&s->iomem, ASPEED_SOC_UART_5_BASE, 2,
> +        serial_mm_init(get_system_memory(),
> +                       ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE,=
 2,
>                         uart5, 38400, serial_hds[0], DEVICE_LITTLE_ENDI=
AN);
>      }
> =20
>=20
