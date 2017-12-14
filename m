Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePWdS-0005wP-2W
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePWdM-0000Fg-4b
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:45:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171214145255.31545-15-andrew.smirnov@gmail.com>
References: <20171214145255.31545-1-andrew.smirnov@gmail.com>
	<20171214145255.31545-15-andrew.smirnov@gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 08:45:14 -0800
Message-ID: <CAHQ1cqHrCv8ENWDUzENRrLaBVMR0oVV_UDqwrGEeJ8Sko8bB4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/15] sd: Check for READ_MULTIPLE_BLOCK
 size limit violation first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "open list:ARM" <qemu-arm@nongnu.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Dec 14, 2017 at 6:52 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Check for READ_MULTIPLE_BLOCK size limit violation first as opposed to
> doing at the end of the command handler. Consider the following
> scenario:
>
> Emulated host driver is trying to read last byte of the last sector
> via CMD18/ADMA, so what would happen is the following:
>
> 1. "ret" is filled with desired byte and "sd->data_offset" is
>    incremented to 512 by
>
>             ret =3D sd->data[sd->data_offset ++];
>
> 2. sd->data_offset >=3D io_len becomes true, so
>
>             sd->data_start +=3D io_len;
>
>    moves "sd->data_start" past valid data boundaries.
>
> 3. as a result "sd->data_start + io_len > sd->size" check becomes true
>    and sd->card_status is marked with ADDRESS_ERROR, telling emulated
>    host that the last CMD18 read failed, despite nothing bad/illegal
>    happening.
>
> To avoid having this false positive, move out-of-bounds check to
> happen before BLK_READ_BLOCK(), so this way it will only trigger if
> illegal read is truly about to happen.
>

Disregard this patch, exactly this fix is already present in latest QEMU ma=
ster.

Sorry for the noise.

Thanks,
Andrey Smirnov

> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/sd/sd.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index ba47bff4db..ce4ef17be3 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1797,8 +1797,17 @@ uint8_t sd_read_data(SDState *sd)
>          break;
>
>      case 18:   /* CMD18:  READ_MULTIPLE_BLOCK */
> -        if (sd->data_offset =3D=3D 0)
> +        if (sd->data_offset =3D=3D 0) {
> +            if (sd->data_start + io_len > sd->size) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Trying to read past card's capacity\n=
",
> +                              __func__);
> +                sd->card_status |=3D ADDRESS_ERROR;
> +                return 0x00;
> +            }
> +
>              BLK_READ_BLOCK(sd->data_start, io_len);
> +        }
>          ret =3D sd->data[sd->data_offset ++];
>
>          if (sd->data_offset >=3D io_len) {
> @@ -1812,11 +1821,6 @@ uint8_t sd_read_data(SDState *sd)
>                      break;
>                  }
>              }
> -
> -            if (sd->data_start + io_len > sd->size) {
> -                sd->card_status |=3D ADDRESS_ERROR;
> -                break;
> -            }
>          }
>          break;
>
> --
> 2.14.3
>
