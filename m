Received: from eggs.gnu.org ([2001:4830:134:3::10]:33509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eompO-0007Dq-R6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eompN-0004Pz-31
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:06:10 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180216022933.10945-1-f4bug@amsat.org>
	<20180216022933.10945-6-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d19cdb63-b75e-82d6-1883-109a1d75fad8@amsat.org>
Date: Thu, 22 Feb 2018 06:06:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180216022933.10945-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 5/7] hw/sd/pl181: expose a SDBus and
 connect the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Stefan Weil <sw@weilnetz.de>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

ping? :)

On 02/15/2018 11:29 PM, Philippe Mathieu-Daudé wrote:
> using the sdbus_*() API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> 
> RFC because how pl181_sdbus_create_inplace() doing class_init(SDBus) in
> realize(pl181) seems weird...
> 
> from http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg01268.html:
> 
>     I think you have to change that sd_set_cb() code now.
>     If you look at sd_cardchange() it uses "is this SD card
>     object on an SDBus" to determine whether to notify the
>     controller via the old-API IRQ lines, or using the
>     set_inserted() and set_readonly() callbacks on the SDBusClass.
> 
> This previous series intended to enforce a cleaner OOP design, adding a
> TYPE_SD_BUS_MASTER_INTERFACE TypeInfo:
> 
> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02322.html
> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02326.html
> http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02327.html
> ---
> 
>  hw/sd/pl181.c | 59 ++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index 3ba1f7dd23..97e85e4a64 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -33,7 +33,7 @@ typedef struct PL181State {
>      SysBusDevice parent_obj;
>  
>      MemoryRegion iomem;
> -    SDState *card;
> +    SDBus sdbus;
>      uint32_t clock;
>      uint32_t power;
>      uint32_t cmdarg;
> @@ -179,7 +179,7 @@ static void pl181_send_command(PL181State *s)
>      request.cmd = s->cmd & PL181_CMD_INDEX;
>      request.arg = s->cmdarg;
>      DPRINTF("Command %d %08x\n", request.cmd, request.arg);
> -    rlen = sd_do_command(s->card, &request, response);
> +    rlen = sdbus_do_command(&s->sdbus, &request, response);
>      if (rlen < 0)
>          goto error;
>      if (s->cmd & PL181_CMD_RESPONSE) {
> @@ -223,12 +223,12 @@ static void pl181_fifo_run(PL181State *s)
>      int is_read;
>  
>      is_read = (s->datactrl & PL181_DATA_DIRECTION) != 0;
> -    if (s->datacnt != 0 && (!is_read || sd_data_ready(s->card))
> +    if (s->datacnt != 0 && (!is_read || sdbus_data_ready(&s->sdbus))
>              && !s->linux_hack) {
>          if (is_read) {
>              n = 0;
>              while (s->datacnt && s->fifo_len < PL181_FIFO_LEN) {
> -                value |= (uint32_t)sd_read_data(s->card) << (n * 8);
> +                value |= (uint32_t)sdbus_read_data(&s->sdbus) << (n * 8);
>                  s->datacnt--;
>                  n++;
>                  if (n == 4) {
> @@ -249,7 +249,7 @@ static void pl181_fifo_run(PL181State *s)
>                  }
>                  n--;
>                  s->datacnt--;
> -                sd_write_data(s->card, value & 0xff);
> +                sdbus_write_data(&s->sdbus, value & 0xff);
>                  value >>= 8;
>              }
>          }
> @@ -477,13 +477,6 @@ static void pl181_reset(DeviceState *d)
>      s->linux_hack = 0;
>      s->mask[0] = 0;
>      s->mask[1] = 0;
> -
> -    /* We can assume our GPIO outputs have been wired up now */
> -    sd_set_cb(s->card, s->cardstatus[0], s->cardstatus[1]);
> -    /* Since we're still using the legacy SD API the card is not plugged
> -     * into any bus, and we must reset it manually.
> -     */
> -    device_reset(DEVICE(s->card));
>  }
>  
>  static void pl181_init(Object *obj)
> @@ -499,16 +492,52 @@ static void pl181_init(Object *obj)
>      qdev_init_gpio_out(dev, s->cardstatus, 2);
>  }
>  
> +static void pl181_set_readonly(DeviceState *dev, bool level)
> +{
> +    PL181State *s = (PL181State *)dev;
> +
> +    qemu_set_irq(s->cardstatus[0], level);
> +}
> +
> +static void pl181_set_inserted(DeviceState *dev, bool level)
> +{
> +    PL181State *s = (PL181State *)dev;
> +
> +    qemu_set_irq(s->cardstatus[1], level);
> +}
> +
> +static void pl181_sdbus_create_inplace(SDBus *sdbus, DeviceState *dev)
> +{
> +    SDBusClass *sbc;
> +
> +    qbus_create_inplace(sdbus, sizeof(SDBus), TYPE_SD_BUS, dev, "sd-bus");
> +
> +    /* pl181_sdbus_class_init */
> +    sbc = SD_BUS_GET_CLASS(sdbus);
> +    sbc->set_inserted = pl181_set_inserted;
> +    sbc->set_readonly = pl181_set_readonly;
> +}
> +
>  static void pl181_realize(DeviceState *dev, Error **errp)
>  {
>      PL181State *s = PL181(dev);
> +    DeviceState *carddev;
>      DriveInfo *dinfo;
> +    Error *err = NULL;
> +
> +    pl181_sdbus_create_inplace(&s->sdbus, dev);
>  
> +    /* Create and plug in the sd card */
>      /* FIXME use a qdev drive property instead of drive_get_next() */
>      dinfo = drive_get_next(IF_SD);
> -    s->card = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, false);
> -    if (s->card == NULL) {
> -        error_setg(errp, "sd_init failed");
> +    carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
> +    if (dinfo) {
> +        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
> +    }
> +    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
> +    if (err) {
> +        error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
> +        return;
>      }
>  }
>  
> 
