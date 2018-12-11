Received: from eggs.gnu.org ([2001:4830:134:3::10]:59766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWccM-0003WP-Uv
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWccJ-0005Qc-OY
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:38:10 -0500
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:37755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWccJ-0005KF-67
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:38:07 -0500
Received: from player695.ha.ovh.net (unknown [10.109.146.86])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C1C241C4B3A
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 08:38:04 +0100 (CET)
References: <20181211031044.27628-1-joel@jms.id.au>
	<20181211031044.27628-3-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2c0685d1-f126-28cb-7d7b-28e140e735c7@kaod.org>
Date: Tue, 11 Dec 2018 08:37:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181211031044.27628-3-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] aspeed/scu: Implement power off
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 12/11/18 4:10 AM, Joel Stanley wrote:
> This register does not exist in hardware. It is here to allow the guest
> code to cause Qemu to exit when required.
>=20
> The register address chosen is unused in the emulated machines
> datasheets.

yes. I checked also.=20

On the AST2600, 0x1A0 is now in the CPU scratch register range,
but I don't think this is problem.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.



>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/misc/aspeed_scu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index c8217740efc1..aa17d032ba93 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -16,6 +16,7 @@
>  #include "qapi/visitor.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> +#include "sysemu/sysemu.h"
>  #include "crypto/random.h"
>  #include "trace.h"
> =20
> @@ -84,6 +85,7 @@
>  #define SRAM_DECODE_BASE1    TO_REG(0x194)
>  #define SRAM_DECODE_BASE2    TO_REG(0x198)
>  #define BMC_REV              TO_REG(0x19C)
> +#define POWEROFF             TO_REG(0x1A0)
>  #define BMC_DEV_ID           TO_REG(0x1A4)
> =20
>  #define SCU_IO_REGION_SIZE 0x1000
> @@ -264,6 +266,9 @@ static void aspeed_scu_write(void *opaque, hwaddr o=
ffset, uint64_t data,
>          }
>          /* Avoid assignment below, we've handled everything */
>          return;
> +    case POWEROFF:
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        break;
>      case FREQ_CNTR_EVAL:
>      case VGA_SCRATCH1 ... VGA_SCRATCH8:
>      case RNG_DATA:
>=20
