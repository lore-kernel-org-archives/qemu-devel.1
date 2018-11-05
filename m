Received: from eggs.gnu.org ([2001:4830:134:3::10]:57164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJh5w-00045J-Aa
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJgyH-0000qE-Jl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:39:22 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJgyH-0000oW-CO
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:39:21 -0500
Received: by mail-oi1-x241.google.com with SMTP id v83-v6so7811653oia.5
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:39:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102001303.32640-4-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
	<20181102001303.32640-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 15:39:00 +0000
Message-ID: <CAFEAcA8LOR7mCVMe6R1A+VJMXpJMreLV-0KQ0nTXZM=7VXcmSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 3/7] hw/arm/bcm2835: Use 0x
 prefix for hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Guenter Roeck <linux@roeck-us.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 November 2018 at 00:12, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/char/bcm2835_aux.c      | 2 +-
>  hw/intc/bcm2836_control.c  | 4 ++--
>  hw/misc/bcm2835_property.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Commit message says it's just adding 0x prefixes, but the
patch adds extra logging of new numbers that weren't there
before. I don't think the patch needs splitting, but the
commit message could be improved.

Also, the compile test says some of these new additions
are using the wrong kind of format string specifier.

>
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index 0364596c55..9632e8972c 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -159,7 +159,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr of=
fset, uint64_t value,
>      case AUX_ENABLES:
>          if (value !=3D 1) {
>              qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable =
SPI "
> -                          "or disable UART\n", __func__);
> +                          "or disable UART: 0x%lx\n", __func__, value);

uint64_t needs PRIx64, not %lx.

>          }
>          break;
>
> diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
> index cfa5bc7365..96cc53f8a7 100644
> --- a/hw/intc/bcm2836_control.c
> +++ b/hw/intc/bcm2836_control.c
> @@ -204,8 +204,8 @@ static void bcm2836_control_write(void *opaque, hwadd=
r offset,
>      } else if (offset >=3D REG_MBOX0_RDCLR && offset < REG_LIMIT) {
>          s->mailboxes[(offset - REG_MBOX0_RDCLR) >> 2] &=3D ~val;
>      } else {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> -                      __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx" =
0x%lx\n",
> +                      __func__, offset, val);

Ditto. If you want to print the value you should also say in the
log message string what the second hex number in it is.
(Mostly we don't seem to worry about printing the data value
for "write to bogus device address" messages.)

>          return;
>      }
>
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index 5d332324bd..c715cbaef6 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -277,7 +277,7 @@ static void bcm2835_property_mbox_push(BCM2835Propert=
yState *s, uint32_t value)
>
>          default:
>              qemu_log_mask(LOG_GUEST_ERROR,
> -                          "bcm2835_property: unhandled tag %08x\n", tag)=
;
> +                          "bcm2835_property: unhandled tag 0x%08x\n", ta=
g);
>              break;
>          }
>
> --
> 2.17.2

thanks
-- PMM
