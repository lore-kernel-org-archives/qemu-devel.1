Received: from eggs.gnu.org ([2001:4830:134:3::10]:52562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXeC-00081K-Ad
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXeB-00006z-6S
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:50:16 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXeA-00005m-Hx
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:50:15 -0500
Received: by mail-wr0-x241.google.com with SMTP id q9so5867472wre.7
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:50:14 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-15-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-15-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:49:42 -0800
Message-ID: <CAKmqyKPjSwy+PaSX0AojVXL0d-6FfCNrN_eNHUTfJsHDH0d6xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/14] sdhci: add a "dma-memory" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Add a dma property allowing machine creation to provide the address-space
> sdhci dma operates on.
>
> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>  from qemu/xilinx tag xilinx-v2016.1]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  include/hw/sd/sdhci.h |  2 ++
>  hw/sd/sdhci.c         | 24 ++++++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 1b6a98d578..e6644e6e7d 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -41,6 +41,8 @@ typedef struct SDHCIState {
>      /*< public >*/
>      SDBus sdbus;
>      MemoryRegion iomem;
> +    MemoryRegion *dma_mr;
> +    AddressSpace dma_as;
>
>      QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
>      QEMUTimer *transfer_timer;
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 78bb8e8e89..5f8064c59b 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -590,7 +590,7 @@ static void get_adma_description(SDHCIState *s, ADMAD=
escr *dscr)
>      hwaddr entry_addr =3D (hwaddr)s->admasysaddr;
>      switch (SDHC_DMA_TYPE(s->hostctl)) {
>      case SDHC_CTRL_ADMA2_32:
> -        adma2 =3D ldq_le_dma(&address_space_memory, entry_addr);
> +        adma2 =3D ldq_le_dma(&s->dma_as, entry_addr);
>          /* The spec does not specify endianness of descriptor table.
>           * We currently assume that it is LE.
>           */
> @@ -600,7 +600,7 @@ static void get_adma_description(SDHCIState *s, ADMAD=
escr *dscr)
>          dscr->incr =3D 8;
>          break;
>      case SDHC_CTRL_ADMA1_32:
> -        adma1 =3D ldl_le_dma(&address_space_memory, entry_addr);
> +        adma1 =3D ldl_le_dma(&s->dma_as, entry_addr);
>          dscr->addr =3D (hwaddr)(adma1 & 0xFFFFF000);
>          dscr->attr =3D (uint8_t)extract32(adma1, 0, 7);
>          dscr->incr =3D 4;
> @@ -611,9 +611,9 @@ static void get_adma_description(SDHCIState *s, ADMAD=
escr *dscr)
>          }
>          break;
>      case SDHC_CTRL_ADMA2_64:
> -        dscr->attr =3D ldub_dma(&address_space_memory, entry_addr);
> -        dscr->length =3D lduw_le_dma(&address_space_memory, entry_addr +=
 2);
> -        dscr->attr =3D ldq_le_dma(&address_space_memory, entry_addr + 4)=
;
> +        dscr->attr =3D ldub_dma(&s->dma_as, entry_addr);
> +        dscr->length =3D lduw_le_dma(&s->dma_as, entry_addr + 2);
> +        dscr->attr =3D ldq_le_dma(&s->dma_as, entry_addr + 4);
>          dscr->attr &=3D 0xfffffff8;
>          dscr->incr =3D 12;
>          break;
> @@ -670,7 +670,7 @@ static void sdhci_do_adma(SDHCIState *s)
>                          s->data_count =3D block_size;
>                          length -=3D block_size - begin;
>                      }
> -                    dma_memory_write(&address_space_memory, dscr.addr,
> +                    dma_memory_write(&s->dma_as, dscr.addr,
>                                       &s->fifo_buffer[begin],
>                                       s->data_count - begin);
>                      dscr.addr +=3D s->data_count - begin;
> @@ -1172,10 +1172,20 @@ static void sdhci_realizefn(SDHCIState *s, Error =
**errp)
>
>      memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdh=
ci",
>                            SDHC_REGISTERS_MAP_SIZE);
> +
> +    /* use system_memory() if property "dma-memory" not set */
> +    address_space_init(&s->dma_as,
> +                       s->dma_mr ? s->dma_mr : get_system_memory(),
> +                       "sdhci-dma");
>  }
>
>  static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
>  {
> +    if (s->dma_mr) {
> +        address_space_destroy(&s->dma_as);
> +        object_unparent(OBJECT(&s->dma_mr));
> +    }
> +
>      g_free(s->fifo_buffer);
>      s->fifo_buffer =3D NULL;
>  }
> @@ -1257,6 +1267,8 @@ static Property sdhci_properties[] =3D {
>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>      DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
>                       false),
> +    DEFINE_PROP_LINK("dma-memory", SDHCIState, dma_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.15.1
>
>
