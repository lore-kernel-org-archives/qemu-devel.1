Received: from eggs.gnu.org ([2001:4830:134:3::10]:58316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePeOg-0005uH-8L
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePeOe-0002Eb-RK
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 20:02:42 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213204436.5379-5-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
	<20171213204436.5379-5-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 17:02:05 -0800
Message-ID: <CAKmqyKMSVEtRjqmutKz1Bwb3W9xOcYnMbM0RADWeYzBzB3vj+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/11] sdbus: add sdbus_create_bus() to
 replace qbus_create_inplace()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 12:44 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> A "bus-name" property can be use to change the default SDHCI "sd-bus" nam=
e.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/sd/sd.h           |  1 +
>  include/hw/sd/sdhci.h        |  3 ++-
>  hw/arm/bcm2835_peripherals.c |  2 +-
>  hw/sd/core.c                 |  5 +++++
>  hw/sd/sdhci.c                | 36 ++++++++++++++++++++----------------
>  5 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index f6994e61f2..dc9d697c12 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -51,6 +51,7 @@ struct SDBus {
>  };
>
>  /* Functions to be used by qdevified callers */
> +SDBus *sdbus_create_bus(DeviceState *parent, const char *name);
>  int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
>  void sdbus_write_data(SDBus *sd, uint8_t value);
>  uint8_t sdbus_read_data(SDBus *sd);
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index e6644e6e7d..579e0ea644 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -39,7 +39,8 @@ typedef struct SDHCIState {
>      };
>
>      /*< public >*/
> -    SDBus sdbus;
> +    char *bus_name;
> +    SDBus *sdbus;
>      MemoryRegion iomem;
>      MemoryRegion *dma_mr;
>      AddressSpace dma_as;
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 7f30f19c4c..60a0eec4d1 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -310,7 +310,7 @@ static void bcm2835_peripherals_realize(DeviceState *=
dev, Error **errp)
>
>      /* GPIO */
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
> -                                   OBJECT(&s->sdhci.sdbus), &error_abort=
);
> +                                   OBJECT(s->sdhci.sdbus), &error_abort)=
;
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
>                                     OBJECT(&s->sdhost.sdbus), &error_abor=
t);
>      object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index eda595973b..021a8d7258 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -187,3 +187,8 @@ static void sd_bus_register_types(void)
>  }
>
>  type_init(sd_bus_register_types)
> +
> +SDBus *sdbus_create_bus(DeviceState *parent, const char *name)
> +{
> +    return SD_BUS(qbus_create(TYPE_SD_BUS, parent, name));
> +}
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 5f8064c59b..40596f6ebe 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -186,8 +186,8 @@ static void sdhci_reset(SDHCIState *s)
>      memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s->sdm=
asysad);
>
>      /* Reset other state based on current card insertion/readonly status=
 */
> -    sdhci_set_inserted(dev, sdbus_get_inserted(&s->sdbus));
> -    sdhci_set_readonly(dev, sdbus_get_readonly(&s->sdbus));
> +    sdhci_set_inserted(dev, sdbus_get_inserted(s->sdbus));
> +    sdhci_set_readonly(dev, sdbus_get_readonly(s->sdbus));
>
>      s->data_count =3D 0;
>      s->stopped_state =3D sdhc_not_stopped;
> @@ -223,7 +223,7 @@ static void sdhci_send_command(SDHCIState *s)
>      request.arg =3D s->argument;
>
>      trace_sdhci_send_command(request.cmd, request.arg);
> -    rlen =3D sdbus_do_command(&s->sdbus, &request, response);
> +    rlen =3D sdbus_do_command(s->sdbus, &request, response);
>
>      if (s->cmdreg & SDHC_CMD_RESPONSE) {
>          if (rlen =3D=3D 4) {
> @@ -278,7 +278,7 @@ static void sdhci_end_transfer(SDHCIState *s)
>          request.cmd =3D 0x0C;
>          request.arg =3D 0;
>          trace_sdhci_end_transfer(request.cmd, request.arg);
> -        sdbus_do_command(&s->sdbus, &request, response);
> +        sdbus_do_command(s->sdbus, &request, response);
>          /* Auto CMD12 response goes to the upper Response register */
>          s->rspreg[3] =3D (response[0] << 24) | (response[1] << 16) |
>                  (response[2] << 8) | response[3];
> @@ -310,7 +310,7 @@ static void sdhci_read_block_from_card(SDHCIState *s)
>      }
>
>      for (index =3D 0; index < (s->blksize & 0x0fff); index++) {
> -        s->fifo_buffer[index] =3D sdbus_read_data(&s->sdbus);
> +        s->fifo_buffer[index] =3D sdbus_read_data(s->sdbus);
>      }
>
>      /* New data now available for READ through Buffer Port Register */
> @@ -402,7 +402,7 @@ static void sdhci_write_block_to_card(SDHCIState *s)
>      }
>
>      for (index =3D 0; index < (s->blksize & 0x0fff); index++) {
> -        sdbus_write_data(&s->sdbus, s->fifo_buffer[index]);
> +        sdbus_write_data(s->sdbus, s->fifo_buffer[index]);
>      }
>
>      /* Next data can be written through BUFFER DATORT register */
> @@ -488,7 +488,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>          while (s->blkcnt) {
>              if (s->data_count =3D=3D 0) {
>                  for (n =3D 0; n < block_size; n++) {
> -                    s->fifo_buffer[n] =3D sdbus_read_data(&s->sdbus);
> +                    s->fifo_buffer[n] =3D sdbus_read_data(s->sdbus);
>                  }
>              }
>              begin =3D s->data_count;
> @@ -529,7 +529,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>              s->sdmasysad +=3D s->data_count - begin;
>              if (s->data_count =3D=3D block_size) {
>                  for (n =3D 0; n < block_size; n++) {
> -                    sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
> +                    sdbus_write_data(s->sdbus, s->fifo_buffer[n]);
>                  }
>                  s->data_count =3D 0;
>                  if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> @@ -560,7 +560,7 @@ static void sdhci_sdma_transfer_single_block(SDHCISta=
te *s)
>
>      if (s->trnmod & SDHC_TRNS_READ) {
>          for (n =3D 0; n < datacnt; n++) {
> -            s->fifo_buffer[n] =3D sdbus_read_data(&s->sdbus);
> +            s->fifo_buffer[n] =3D sdbus_read_data(s->sdbus);
>          }
>          dma_memory_write(&address_space_memory, s->sdmasysad, s->fifo_bu=
ffer,
>                           datacnt);
> @@ -568,7 +568,7 @@ static void sdhci_sdma_transfer_single_block(SDHCISta=
te *s)
>          dma_memory_read(&address_space_memory, s->sdmasysad, s->fifo_buf=
fer,
>                          datacnt);
>          for (n =3D 0; n < datacnt; n++) {
> -            sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
> +            sdbus_write_data(s->sdbus, s->fifo_buffer[n]);
>          }
>      }
>      s->blkcnt--;
> @@ -659,7 +659,7 @@ static void sdhci_do_adma(SDHCIState *s)
>                  while (length) {
>                      if (s->data_count =3D=3D 0) {
>                          for (n =3D 0; n < block_size; n++) {
> -                            s->fifo_buffer[n] =3D sdbus_read_data(&s->sd=
bus);
> +                            s->fifo_buffer[n] =3D sdbus_read_data(s->sdb=
us);
>                          }
>                      }
>                      begin =3D s->data_count;
> @@ -700,7 +700,7 @@ static void sdhci_do_adma(SDHCIState *s)
>                      dscr.addr +=3D s->data_count - begin;
>                      if (s->data_count =3D=3D block_size) {
>                          for (n =3D 0; n < block_size; n++) {
> -                            sdbus_write_data(&s->sdbus, s->fifo_buffer[n=
]);
> +                            sdbus_write_data(s->sdbus, s->fifo_buffer[n]=
);
>                          }
>                          s->data_count =3D 0;
>                          if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> @@ -807,7 +807,7 @@ static void sdhci_data_transfer(void *opaque)
>              break;
>          }
>      } else {
> -        if ((s->trnmod & SDHC_TRNS_READ) && sdbus_data_ready(&s->sdbus))=
 {
> +        if ((s->trnmod & SDHC_TRNS_READ) && sdbus_data_ready(s->sdbus)) =
{
>              s->prnsts |=3D SDHC_DOING_READ | SDHC_DATA_INHIBIT |
>                      SDHC_DAT_LINE_ACTIVE;
>              sdhci_read_block_from_card(s);
> @@ -1156,15 +1156,14 @@ static inline unsigned int sdhci_get_fifolen(SDHC=
IState *s)
>
>  static void sdhci_initfn(SDHCIState *s)
>  {
> -    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
> -                        TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");

Isn't "sd-bus" here the name? Can't you just move this line to realize
and pass the string in there?

Alistair

> -
>      s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_ins=
ertion_irq, s);
>      s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_tr=
ansfer, s);
>  }
>
>  static void sdhci_realizefn(SDHCIState *s, Error **errp)
>  {
> +    const char *name =3D s->bus_name ? s->bus_name : "sd-bus";
> +
>      sdhci_init_capareg(s, errp);
>
>      s->buf_maxsz =3D sdhci_get_fifolen(s);
> @@ -1177,10 +1176,14 @@ static void sdhci_realizefn(SDHCIState *s, Error =
**errp)
>      address_space_init(&s->dma_as,
>                         s->dma_mr ? s->dma_mr : get_system_memory(),
>                         "sdhci-dma");
> +
> +    s->sdbus =3D sdbus_create_bus(DEVICE(s), name);
>  }
>
>  static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
>  {
> +    g_free(s->sdbus);
> +
>      if (s->dma_mr) {
>          address_space_destroy(&s->dma_as);
>          object_unparent(OBJECT(&s->dma_mr));
> @@ -1269,6 +1272,7 @@ static Property sdhci_properties[] =3D {
>                       false),
>      DEFINE_PROP_LINK("dma-memory", SDHCIState, dma_mr,
>                       TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_STRING("sd-bus-name", SDHCIState, bus_name),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.15.1
>
>
