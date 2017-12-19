Received: from eggs.gnu.org ([2001:4830:134:3::10]:50310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eR6WW-0007uz-Fq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eR6WV-0000Ps-EJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:16:48 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171215031547.31006-3-f4bug@amsat.org>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 18 Dec 2017 17:16:15 -0800
Message-ID: <CAKmqyKPF-t9F9dhu-uagHq68DSODgqHqEE6=fGbbqLWR9MRV5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/20] sdhci: use deposit64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Dec 14, 2017 at 7:15 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> This makes the code slightly safer, also easier to review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I just looked at the surrounding code and realised what mask actually
is set to. Now I understand what you mean.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair


> ---
>  hw/sd/sdhci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index b7d2a20985..3c78033d49 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1132,12 +1132,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t=
 val, unsigned size)
>          MASKED_WRITE(s->admaerr, mask, value);
>          break;
>      case SDHC_ADMASYSADDR:
> -        s->admasysaddr =3D (s->admasysaddr & (0xFFFFFFFF00000000ULL |
> -                (uint64_t)mask)) | (uint64_t)value;
> +        s->admasysaddr =3D deposit64(s->admasysaddr, 0, 32, value);
>          break;
>      case SDHC_ADMASYSADDR + 4:
> -        s->admasysaddr =3D (s->admasysaddr & (0x00000000FFFFFFFFULL |
> -                ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
> +        s->admasysaddr =3D deposit64(s->admasysaddr, 32, 32, value);
>          break;
>      case SDHC_FEAER:
>          s->acmd12errsts |=3D value;
> --
> 2.15.1
>
>
