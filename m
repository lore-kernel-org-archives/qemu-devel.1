Received: from eggs.gnu.org ([2001:4830:134:3::10]:50142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ehApq-0006fV-R8
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ehApm-0005wR-Sp
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:07:10 -0500
Received: from ssl.serverraum.org ([2a01:4f8:222:d45::1:2]:60237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1ehApm-0005vG-Fu
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:07:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 01 Feb 2018 10:07:02 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180123035837.16578-2-f4bug@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-2-f4bug@amsat.org>
Message-ID: <82c7f39a88b60a64eb25b86a16467d1d@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/sd/milkymist-memcard: use
 qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Am 2018-01-23 04:58, schrieb Philippe Mathieu-Daud=C3=A9:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Michael Walle <michael@walle.cc>

> ---
>  hw/sd/milkymist-memcard.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 341da88552..1292c0c099 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -22,11 +22,12 @@
>   */
>=20
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> -#include "qemu/error-report.h"
> +#include "include/qapi/error.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/sd/sd.h"
> @@ -138,8 +139,8 @@ static uint64_t memcard_read(void *opaque, hwaddr=20
> addr,
>          } else {
>              r =3D s->response[s->response_read_ptr++];
>              if (s->response_read_ptr > s->response_len) {
> -                error_report("milkymist_memcard: "
> -                        "read more cmd bytes than available.=20
> Clipping.");
> +                qemu_log_mask(LOG_GUEST_ERROR, "milkymist_memcard: "
> +                              "read more cmd bytes than available.=20
> Clipping.");
>                  s->response_read_ptr =3D 0;
>              }
>          }
> @@ -163,8 +164,9 @@ static uint64_t memcard_read(void *opaque, hwaddr=20
> addr,
>          break;
>=20
>      default:
> -        error_report("milkymist_memcard: read access to unknown=20
> register 0x"
> -                TARGET_FMT_plx, addr << 2);
> +        qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
> +                      "read access to unknown register 0x%"=20
> HWADDR_PRIx "\n",
> +                      addr << 2);
>          break;
>      }
>=20
> @@ -220,8 +222,9 @@ static void memcard_write(void *opaque, hwaddr
> addr, uint64_t value,
>          break;
>=20
>      default:
> -        error_report("milkymist_memcard: write access to unknown=20
> register 0x"
> -                TARGET_FMT_plx, addr << 2);
> +        qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
> +                      "write access to unknown register 0x%"=20
> HWADDR_PRIx " "
> +                      "(value 0x%" PRIx64 ")\n", addr << 2, value);
>          break;
>      }
>  }
