Received: from eggs.gnu.org ([2001:4830:134:3::10]:41821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWWfY-0001eG-SB
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWWfX-0006VS-N9
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:12:32 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eWWfX-0006V3-HH
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:12:31 -0500
Received: by mail-wr0-x243.google.com with SMTP id 36so85593wrh.1
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:12:31 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171229174933.1781-15-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-15-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 2 Jan 2018 16:12:00 -0800
Message-ID: <CAKmqyKMrsobYs9SGiU4datd0bd37dCj40vAqEK687Z2ybmFCcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/42] sdhci: fix CAPAB/MAXCURR
 registers, both are 64bit and read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Dec 29, 2017 at 9:49 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> running qtests:
>
>   $ make check-qtest-arm
>     GTESTER check-qtest-arm
>   SDHC rd_4b @0x44 not implemented
>   SDHC wr_4b @0x40 <- 0x89abcdef not implemented
>   SDHC wr_4b @0x44 <- 0x01234567 not implemented
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/sd/sdhci.h |  4 ++--
>  hw/sd/sdhci.c         | 23 +++++++++++++++++++----
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index da943a6562..9436375b1e 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -86,9 +86,9 @@ typedef struct SDHCIState {
>
>      /* Read-only registers */
>      /* 0x40 */
> -    uint32_t capareg;      /* Capabilities Register */
> +    uint64_t capareg;      /* Capabilities Register */
>      /* 0x48 */
> -    uint32_t maxcurr;      /* Maximum Current Capabilities Register */
> +    uint64_t maxcurr;      /* Maximum Current Capabilities Register */
>
>      uint8_t  *fifo_buffer; /* SD host i/o FIFO buffer */
>      uint32_t buf_maxsz;
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 604ad525f6..ae84af46da 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -904,10 +904,16 @@ static uint64_t sdhci_read(void *opaque, hwaddr off=
set, unsigned size)
>          ret =3D s->acmd12errsts;
>          break;
>      case SDHC_CAPAB:
> -        ret =3D s->capareg;
> +        ret =3D (uint32_t)s->capareg;
> +        break;
> +    case SDHC_CAPAB + 4:
> +        ret =3D (uint32_t)(s->capareg >> 32);
>          break;
>      case SDHC_MAXCURR:
> -        ret =3D s->maxcurr;
> +        ret =3D (uint32_t)s->maxcurr;
> +        break;
> +    case SDHC_MAXCURR + 4:
> +        ret =3D (uint32_t)(s->maxcurr >> 32);
>          break;
>      case SDHC_ADMAERR:
>          ret =3D  s->admaerr;
> @@ -1129,6 +1135,15 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>          }
>          sdhci_update_irq(s);
>          break;
> +
> +    case SDHC_CAPAB:
> +    case SDHC_CAPAB + 4:
> +    case SDHC_MAXCURR:
> +    case SDHC_MAXCURR + 4:
> +        qemu_log_mask(LOG_GUEST_ERROR, "SDHC wr_%ub @0x%02" HWADDR_PRIx
> +                      " <- 0x%08x read-only\n", size, offset, value >> s=
hift);
> +        break;
> +
>      default:
>          qemu_log_mask(LOG_UNIMP, "SDHC wr_%ub @0x%02" HWADDR_PRIx " <- 0=
x%08x "
>                        "not implemented\n", size, offset, value >> shift)=
;
> @@ -1260,9 +1275,9 @@ const VMStateDescription sdhci_vmstate =3D {
>  /* Capabilities registers provide information on supported features of t=
his
>   * specific host controller implementation */
>  static Property sdhci_properties[] =3D {
> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
> +    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg,
>              SDHC_CAPAB_REG_DEFAULT),
> -    DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
> +    DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
>      DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
>                       false),
>      DEFINE_PROP_END_OF_LIST(),
> --
> 2.15.1
>
>
