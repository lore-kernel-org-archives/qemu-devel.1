Received: from eggs.gnu.org ([2001:4830:134:3::10]:38697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXJk-0007Cy-Pa
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXJj-0008KQ-Vl
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:29:08 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-5-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:28:34 -0800
Message-ID: <CAKmqyKPvAL3+LAqMBtUOc=0igkSwg4Jmf+Q0ySL7C+oech7AMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/14] sdhci: use deposit64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> This makes the code slightly safer, also easier to review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index e39623baba..295a89e5d3 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1123,12 +1123,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t=
 val, unsigned size)
>          MASKED_WRITE(s->admaerr, mask, value);
>          break;
>      case SDHC_ADMASYSADDR:
> -        s->admasysaddr =3D (s->admasysaddr & (0xFFFFFFFF00000000ULL |
> -                (uint64_t)mask)) | (uint64_t)value;
> +        s->admasysaddr =3D deposit64(s->admasysaddr, 32, 0, value);

This doesn't look right.

Originally we were masking admasysaddr with (mask and
0xFFFFFFFF00000000). Then ORing in the value.

Now we are depositing value into a bit field that starts at bit 32 and
has 0 length. I don't see how value will be deposited at all with a 0
length.

Alistair

>          break;
>      case SDHC_ADMASYSADDR + 4:
> -        s->admasysaddr =3D (s->admasysaddr & (0x00000000FFFFFFFFULL |
> -                ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
> +        s->admasysaddr =3D deposit64(s->admasysaddr, 0, 32, value);
>          break;
>      case SDHC_FEAER:
>          s->acmd12errsts |=3D value;
> --
> 2.15.1
>
>
