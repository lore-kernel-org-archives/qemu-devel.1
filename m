Received: from eggs.gnu.org ([2001:4830:134:3::10]:50103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvGd-0000Q5-Qe
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egvGc-00065y-Ty
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:29:47 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:45271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egvGc-00065E-M9
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:29:46 -0500
Received: by mail-lf0-x243.google.com with SMTP id x196so21614460lfd.12
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:29:46 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180123035837.16578-2-f4bug@amsat.org>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-2-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:29:14 -0800
Message-ID: <CAKmqyKMgQJvQhHAsyA=tupxDxWfym89WUbZBW+ayKTD_qXXPRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jan 22, 2018 at 7:58 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/milkymist-memcard.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 341da88552..1292c0c099 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -22,11 +22,12 @@
>   */
>
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
> @@ -138,8 +139,8 @@ static uint64_t memcard_read(void *opaque, hwaddr add=
r,
>          } else {
>              r =3D s->response[s->response_read_ptr++];
>              if (s->response_read_ptr > s->response_len) {
> -                error_report("milkymist_memcard: "
> -                        "read more cmd bytes than available. Clipping.")=
;
> +                qemu_log_mask(LOG_GUEST_ERROR, "milkymist_memcard: "
> +                              "read more cmd bytes than available. Clipp=
ing.");
>                  s->response_read_ptr =3D 0;
>              }
>          }
> @@ -163,8 +164,9 @@ static uint64_t memcard_read(void *opaque, hwaddr add=
r,
>          break;
>
>      default:
> -        error_report("milkymist_memcard: read access to unknown register=
 0x"
> -                TARGET_FMT_plx, addr << 2);
> +        qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
> +                      "read access to unknown register 0x%" HWADDR_PRIx =
"\n",
> +                      addr << 2);
>          break;
>      }
>
> @@ -220,8 +222,9 @@ static void memcard_write(void *opaque, hwaddr addr, =
uint64_t value,
>          break;
>
>      default:
> -        error_report("milkymist_memcard: write access to unknown registe=
r 0x"
> -                TARGET_FMT_plx, addr << 2);
> +        qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
> +                      "write access to unknown register 0x%" HWADDR_PRIx=
 " "
> +                      "(value 0x%" PRIx64 ")\n", addr << 2, value);
>          break;
>      }
>  }
> --
> 2.15.1
>
>
