Received: from eggs.gnu.org ([2001:4830:134:3::10]:46331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWqxO-0002xu-3f
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWqxN-0006BS-3s
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:52:18 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103162400.10396-2-f4bug@amsat.org>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-2-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 3 Jan 2018 13:51:42 -0800
Message-ID: <CAKmqyKOMRixd+TkE=FKwmQFctJAB_RJ1WFdnY2_8VteRszVB9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] hw/sd/milkymist-memcard: use
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Michael Walle <michael@walle.cc>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 8:23 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/milkymist-memcard.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 4008c81002..5de3e00e2f 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -26,7 +26,7 @@
>  #include "hw/sysbus.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> -#include "qemu/error-report.h"
> +#include "include/qapi/error.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/sd/sd.h"
> @@ -138,8 +138,8 @@ static uint64_t memcard_read(void *opaque, hwaddr add=
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
> @@ -163,8 +163,9 @@ static uint64_t memcard_read(void *opaque, hwaddr add=
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
> @@ -220,8 +221,9 @@ static void memcard_write(void *opaque, hwaddr addr, =
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

Can you fix up the secondary lines indentation?

After that:

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair


>          break;
>      }
>  }
> --
> 2.15.1
>
>
