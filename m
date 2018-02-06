Received: from eggs.gnu.org ([2001:4830:134:3::10]:52223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ej2bD-000400-Qn
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ej2bC-0006dK-I9
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:43:47 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180123035837.16578-1-f4bug@amsat.org>
	<20180123035837.16578-5-f4bug@amsat.org>
	<CAKmqyKMoUcPhkr8bM1DU1QeBaRbJ9kAfOp_j-vFxf1y8p=1AbA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5a373a1f-6289-a216-cd02-254402069c12@amsat.org>
Date: Tue, 6 Feb 2018 09:43:36 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMoUcPhkr8bM1DU1QeBaRbJ9kAfOp_j-vFxf1y8p=1AbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] hw/sd/pl181: expose a SDBus and
 connect the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Walle <michael@walle.cc>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

Hi Alistair,

On 01/31/2018 01:41 PM, Alistair Francis wrote:
> On Mon, Jan 22, 2018 at 7:58 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> using the sdbus_*() API.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/pl181.c | 31 ++++++++++++++++++++-----------
>>  1 file changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
>> index 3ba1f7dd23..ce696c5d7d 100644
>> --- a/hw/sd/pl181.c
>> +++ b/hw/sd/pl181.c
>> @@ -33,6 +33,7 @@ typedef struct PL181State {
>>      SysBusDevice parent_obj;
>>
>>      MemoryRegion iomem;
>> +    SDBus sdbus;
>>      SDState *card;
> 
> Shouludn't card be removed?

Not yet :( It is still used by sd_set_cb() in pl181_reset().

In my first approach [1] I added the SDBus SLAVE/MASTER interfaces and
the cards inserted/readonly signals were only accessible by the bus, not
the HCI, leaving the SDCard objects only pluggable to SDBus (removing
the sdbus_reparent_card() need). But since it was out of scope for the
UHS cards goal, I kept it for later.

[1]
http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02318.html

> 
> Alistair
> 
>>      uint32_t clock;
>>      uint32_t power;
>> @@ -179,7 +180,7 @@ static void pl181_send_command(PL181State *s)
>>      request.cmd = s->cmd & PL181_CMD_INDEX;
>>      request.arg = s->cmdarg;
>>      DPRINTF("Command %d %08x\n", request.cmd, request.arg);
>> -    rlen = sd_do_command(s->card, &request, response);
>> +    rlen = sdbus_do_command(&s->sdbus, &request, response);
>>      if (rlen < 0)
>>          goto error;
>>      if (s->cmd & PL181_CMD_RESPONSE) {
>> @@ -223,12 +224,12 @@ static void pl181_fifo_run(PL181State *s)
>>      int is_read;
>>
>>      is_read = (s->datactrl & PL181_DATA_DIRECTION) != 0;
>> -    if (s->datacnt != 0 && (!is_read || sd_data_ready(s->card))
>> +    if (s->datacnt != 0 && (!is_read || sdbus_data_ready(&s->sdbus))
>>              && !s->linux_hack) {
>>          if (is_read) {
>>              n = 0;
>>              while (s->datacnt && s->fifo_len < PL181_FIFO_LEN) {
>> -                value |= (uint32_t)sd_read_data(s->card) << (n * 8);
>> +                value |= (uint32_t)sdbus_read_data(&s->sdbus) << (n * 8);
>>                  s->datacnt--;
>>                  n++;
>>                  if (n == 4) {
>> @@ -249,7 +250,7 @@ static void pl181_fifo_run(PL181State *s)
>>                  }
>>                  n--;
>>                  s->datacnt--;
>> -                sd_write_data(s->card, value & 0xff);
>> +                sdbus_write_data(&s->sdbus, value & 0xff);
>>                  value >>= 8;
>>              }
>>          }
>> @@ -480,10 +481,6 @@ static void pl181_reset(DeviceState *d)
>>
>>      /* We can assume our GPIO outputs have been wired up now */
>>      sd_set_cb(s->card, s->cardstatus[0], s->cardstatus[1]);
>> -    /* Since we're still using the legacy SD API the card is not plugged
>> -     * into any bus, and we must reset it manually.
>> -     */
>> -    device_reset(DEVICE(s->card));
>>  }
>>
>>  static void pl181_init(Object *obj)
>> @@ -502,14 +499,26 @@ static void pl181_init(Object *obj)
>>  static void pl181_realize(DeviceState *dev, Error **errp)
>>  {
>>      PL181State *s = PL181(dev);
>> +    DeviceState *carddev;
>>      DriveInfo *dinfo;
>> +    Error *err = NULL;
>> +
>> +    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
>> +                        dev, "sd-bus");
>>
>> +    /* Create and plug in the sd card */
>>      /* FIXME use a qdev drive property instead of drive_get_next() */
>>      dinfo = drive_get_next(IF_SD);
>> -    s->card = sd_init(dinfo ? blk_by_legacy_dinfo(dinfo) : NULL, false);
>> -    if (s->card == NULL) {
>> -        error_setg(errp, "sd_init failed");
>> +    carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
>> +    if (dinfo) {
>> +        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
>> +    }
>> +    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
>> +    if (err) {
>> +        error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
>> +        return;
>>      }
>> +    s->card = SD_CARD(carddev);
>>  }
>>
>>  static void pl181_class_init(ObjectClass *klass, void *data)
>> --
>> 2.15.1
>>
>>
