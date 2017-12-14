Received: from eggs.gnu.org ([2001:4830:134:3::10]:36004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXEn-0002O3-V1
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXEn-0003BU-1A
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:24:01 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:42400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXEm-0003Ak-Ph
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:24:00 -0500
Received: by mail-wm0-x243.google.com with SMTP id b199so12886529wme.1
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:24:00 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-4-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-4-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:23:29 -0800
Message-ID: <CAKmqyKMSwraSQ1XBuWYi1A2zfcgCKEqRC_PvKkpcH=f=ynDnXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/14] sdhci: use the ldst_le_dma() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> This makes the code slightly safer, also easier to review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 312b167bfa..e39623baba 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -603,14 +603,12 @@ typedef struct ADMADescr {
>
>  static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
>  {
> -    uint32_t adma1 =3D 0;
> -    uint64_t adma2 =3D 0;
> +    uint32_t adma1;
> +    uint64_t adma2;
>      hwaddr entry_addr =3D (hwaddr)s->admasysaddr;
>      switch (SDHC_DMA_TYPE(s->hostctl)) {
>      case SDHC_CTRL_ADMA2_32:
> -        dma_memory_read(&address_space_memory, entry_addr, (uint8_t *)&a=
dma2,
> -                        sizeof(adma2));
> -        adma2 =3D le64_to_cpu(adma2);
> +        adma2 =3D ldq_le_dma(&address_space_memory, entry_addr);
>          /* The spec does not specify endianness of descriptor table.
>           * We currently assume that it is LE.
>           */
> @@ -620,9 +618,7 @@ static void get_adma_description(SDHCIState *s, ADMAD=
escr *dscr)
>          dscr->incr =3D 8;
>          break;
>      case SDHC_CTRL_ADMA1_32:
> -        dma_memory_read(&address_space_memory, entry_addr, (uint8_t *)&a=
dma1,
> -                        sizeof(adma1));
> -        adma1 =3D le32_to_cpu(adma1);
> +        adma1 =3D ldl_le_dma(&address_space_memory, entry_addr);
>          dscr->addr =3D (hwaddr)(adma1 & 0xFFFFF000);
>          dscr->attr =3D (uint8_t)extract32(adma1, 0, 7);
>          dscr->incr =3D 4;
> @@ -633,14 +629,9 @@ static void get_adma_description(SDHCIState *s, ADMA=
Descr *dscr)
>          }
>          break;
>      case SDHC_CTRL_ADMA2_64:
> -        dma_memory_read(&address_space_memory, entry_addr,
> -                        (uint8_t *)(&dscr->attr), 1);
> -        dma_memory_read(&address_space_memory, entry_addr + 2,
> -                        (uint8_t *)(&dscr->length), 2);
> -        dscr->length =3D le16_to_cpu(dscr->length);
> -        dma_memory_read(&address_space_memory, entry_addr + 4,
> -                        (uint8_t *)(&dscr->addr), 8);
> -        dscr->attr =3D le64_to_cpu(dscr->attr);

> +        dscr->attr =3D ldub_dma(&address_space_memory, entry_addr);
> +        dscr->length =3D lduw_le_dma(&address_space_memory, entry_addr +=
 2);
> +        dscr->attr =3D ldq_le_dma(&address_space_memory, entry_addr + 4)=
;

Why this is being overwritten?

It looks like you have dropped an addr as well.

Alistair

>          dscr->attr &=3D 0xfffffff8;
>          dscr->incr =3D 12;
>          break;
> --
> 2.15.1
>
>
