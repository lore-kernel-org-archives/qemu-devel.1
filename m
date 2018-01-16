Received: from eggs.gnu.org ([2001:4830:134:3::10]:47277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebRw3-0004AO-Kd
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebRvz-0000Lo-DJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:09:55 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebRvz-0000LF-7T
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:09:51 -0500
Received: by mail-qk0-x241.google.com with SMTP id b76so21002968qkc.1
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:09:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-4-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97f95d08-e17a-f795-7b18-99965f1e7ead@amsat.org>
Date: Tue, 16 Jan 2018 11:09:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180116131555.14242-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/i2c: convert I2CSlaveClass::init
 -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 01/16/2018 10:15 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/i2c/i2c.h    |  2 +-
>  include/hw/i2c/smbus.h  |  2 +-
>  hw/audio/wm8750.c       |  8 +++-----
>  hw/display/ssd0303.c    |  5 ++---
>  hw/gpio/max7310.c       |  6 ++----
>  hw/i2c/core.c           | 10 ++++------
>  hw/i2c/smbus.c          | 10 ++++------
>  hw/input/lm832x.c       |  5 ++---
>  hw/misc/tmp105.c        |  6 ++----
>  hw/misc/tmp421.c        |  6 ++----
>  hw/nvram/eeprom_at24c.c | 24 +++++++++++-------------
>  hw/timer/twl92230.c     | 12 +++++-------
>  12 files changed, 39 insertions(+), 57 deletions(-)
> 
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 2ce611d4c8..4a9344b75c 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -30,7 +30,7 @@ typedef struct I2CSlaveClass
>      DeviceClass parent_class;
>  
>      /* Callbacks provided by the device.  */
> -    int (*init)(I2CSlave *dev);
> +    void (*realize)(I2CSlave *slave, Error **errp);
>  
>      /* Master to slave. Returns non-zero for a NAK, 0 for success. */
>      int (*send)(I2CSlave *s, uint8_t data);
> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
> index 544bbc1957..da31894383 100644
> --- a/include/hw/i2c/smbus.h
> +++ b/include/hw/i2c/smbus.h
> @@ -38,7 +38,7 @@
>  typedef struct SMBusDeviceClass
>  {
>      I2CSlaveClass parent_class;
> -    int (*init)(SMBusDevice *dev);
> +    void (*realize)(SMBusDevice *dev, Error **errp);
>      void (*quick_cmd)(SMBusDevice *dev, uint8_t read);
>      void (*send_byte)(SMBusDevice *dev, uint8_t val);
>      uint8_t (*receive_byte)(SMBusDevice *dev);
> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
> index 8bb44a7cc1..c209334f4e 100644
> --- a/hw/audio/wm8750.c
> +++ b/hw/audio/wm8750.c
> @@ -618,14 +618,12 @@ static const VMStateDescription vmstate_wm8750 = {
>      }
>  };
>  
> -static int wm8750_init(I2CSlave *i2c)
> +static void wm8750_realize(I2CSlave *slave, Error **errp)
>  {
> -    WM8750State *s = WM8750(i2c);
> +    WM8750State *s = WM8750(slave);
>  
>      AUD_register_card(CODEC, &s->card);
>      wm8750_reset(I2C_SLAVE(s));
> -
> -    return 0;
>  }
>  
>  #if 0
> @@ -709,7 +707,7 @@ static void wm8750_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
>  
> -    sc->init = wm8750_init;
> +    sc->realize = wm8750_realize;
>      sc->event = wm8750_event;
>      sc->recv = wm8750_rx;
>      sc->send = wm8750_tx;
> diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
> index 68a80b9d64..c4cd059a52 100644
> --- a/hw/display/ssd0303.c
> +++ b/hw/display/ssd0303.c
> @@ -297,13 +297,12 @@ static const GraphicHwOps ssd0303_ops = {
>      .gfx_update  = ssd0303_update_display,
>  };
>  
> -static int ssd0303_init(I2CSlave *i2c)
> +static void ssd0303_realize(I2CSlave *i2c, Error **errp)
>  {
>      ssd0303_state *s = SSD0303(i2c);
>  
>      s->con = graphic_console_init(DEVICE(i2c), 0, &ssd0303_ops, s);
>      qemu_console_resize(s->con, 96 * MAGNIFY, 16 * MAGNIFY);
> -    return 0;
>  }
>  
>  static void ssd0303_class_init(ObjectClass *klass, void *data)
> @@ -311,7 +310,7 @@ static void ssd0303_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>  
> -    k->init = ssd0303_init;
> +    k->realize = ssd0303_realize;
>      k->event = ssd0303_event;
>      k->recv = ssd0303_recv;
>      k->send = ssd0303_send;
> diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
> index f82e3e6555..070da0e4dc 100644
> --- a/hw/gpio/max7310.c
> +++ b/hw/gpio/max7310.c
> @@ -182,14 +182,12 @@ static void max7310_gpio_set(void *opaque, int line, int level)
>  
>  /* MAX7310 is SMBus-compatible (can be used with only SMBus protocols),
>   * but also accepts sequences that are not SMBus so return an I2C device.  */
> -static int max7310_init(I2CSlave *i2c)
> +static void max7310_realize(I2CSlave *i2c, Error **errp)
>  {
>      MAX7310State *s = MAX7310(i2c);
>  
>      qdev_init_gpio_in(&i2c->qdev, max7310_gpio_set, 8);
>      qdev_init_gpio_out(&i2c->qdev, s->handler, 8);
> -
> -    return 0;
>  }
>  
>  static void max7310_class_init(ObjectClass *klass, void *data)
> @@ -197,7 +195,7 @@ static void max7310_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>  
> -    k->init = max7310_init;
> +    k->realize = max7310_realize;
>      k->event = max7310_event;
>      k->recv = max7310_rx;
>      k->send = max7310_tx;
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 59068f157e..f9f48a1666 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -276,16 +276,14 @@ const VMStateDescription vmstate_i2c_slave = {
>      }
>  };
>  
> -static int i2c_slave_qdev_init(DeviceState *dev)
> +static void i2c_slave_realize(DeviceState *dev, Error **errp)
>  {
>      I2CSlave *s = I2C_SLAVE(dev);
>      I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(s);
>  
> -    if (sc->init) {
> -        return sc->init(s);
> +    if (sc->realize) {
> +        return sc->realize(s, errp);
>      }
> -
> -    return 0;
>  }
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
> @@ -301,7 +299,7 @@ DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>  static void i2c_slave_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k = DEVICE_CLASS(klass);
> -    k->init = i2c_slave_qdev_init;
> +    k->realize = i2c_slave_realize;
>      set_bit(DEVICE_CATEGORY_MISC, k->categories);
>      k->bus_type = TYPE_I2C_BUS;
>      k->props = i2c_props;
> diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
> index a90d65ef37..a5293c2552 100644
> --- a/hw/i2c/smbus.c
> +++ b/hw/i2c/smbus.c
> @@ -202,16 +202,14 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
>      return 0;
>  }
>  
> -static int smbus_device_init(I2CSlave *i2c)
> +static void smbus_device_realize(I2CSlave *i2c, Error **errp)
>  {
>      SMBusDevice *dev = SMBUS_DEVICE(i2c);
>      SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
>  
> -    if (sc->init) {
> -        return sc->init(dev);
> +    if (sc->realize) {
> +        sc->realize(dev, errp);
>      }
> -
> -    return 0;
>  }
>  
>  /* Master device commands.  */
> @@ -354,7 +352,7 @@ static void smbus_device_class_init(ObjectClass *klass, void *data)
>  {
>      I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
>  
> -    sc->init = smbus_device_init;
> +    sc->realize = smbus_device_realize;
>      sc->event = smbus_i2c_event;
>      sc->recv = smbus_i2c_recv;
>      sc->send = smbus_i2c_send;
> diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
> index 2340523da0..818b6af585 100644
> --- a/hw/input/lm832x.c
> +++ b/hw/input/lm832x.c
> @@ -464,7 +464,7 @@ static const VMStateDescription vmstate_lm_kbd = {
>  };
>  
>  
> -static int lm8323_init(I2CSlave *i2c)
> +static void lm8323_realize(I2CSlave *i2c, Error **errp)
>  {
>      LM823KbdState *s = LM8323(i2c);
>  
> @@ -477,7 +477,6 @@ static int lm8323_init(I2CSlave *i2c)
>      lm_kbd_reset(s);
>  
>      qemu_register_reset((void *) lm_kbd_reset, s);
> -    return 0;
>  }
>  
>  void lm832x_key_event(DeviceState *dev, int key, int state)
> @@ -505,7 +504,7 @@ static void lm8323_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>  
> -    k->init = lm8323_init;
> +    k->realize = lm8323_realize;
>      k->event = lm_i2c_event;
>      k->recv = lm_i2c_rx;
>      k->send = lm_i2c_tx;
> diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
> index 04e83787d4..62f4f191e4 100644
> --- a/hw/misc/tmp105.c
> +++ b/hw/misc/tmp105.c
> @@ -229,15 +229,13 @@ static void tmp105_reset(I2CSlave *i2c)
>      tmp105_interrupt_update(s);
>  }
>  
> -static int tmp105_init(I2CSlave *i2c)
> +static void tmp105_realize(I2CSlave *i2c, Error **errp)
>  {
>      TMP105State *s = TMP105(i2c);
>  
>      qdev_init_gpio_out(&i2c->qdev, &s->pin, 1);
>  
>      tmp105_reset(&s->i2c);
> -
> -    return 0;
>  }
>  
>  static void tmp105_initfn(Object *obj)
> @@ -252,7 +250,7 @@ static void tmp105_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>  
> -    k->init = tmp105_init;
> +    k->realize = tmp105_realize;
>      k->event = tmp105_event;
>      k->recv = tmp105_rx;
>      k->send = tmp105_tx;
> diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
> index 4a505abbce..3347a53d7d 100644
> --- a/hw/misc/tmp421.c
> +++ b/hw/misc/tmp421.c
> @@ -335,13 +335,11 @@ static void tmp421_reset(I2CSlave *i2c)
>      s->status = 0;
>  }
>  
> -static int tmp421_init(I2CSlave *i2c)
> +static void tmp421_realize(I2CSlave *i2c, Error **errp)
>  {
>      TMP421State *s = TMP421(i2c);
>  
>      tmp421_reset(&s->i2c);
> -
> -    return 0;
>  }
>  
>  static void tmp421_initfn(Object *obj)
> @@ -366,7 +364,7 @@ static void tmp421_class_init(ObjectClass *klass, void *data)
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>      TMP421Class *sc = TMP421_CLASS(klass);
>  
> -    k->init = tmp421_init;
> +    k->realize = tmp421_realize;
>      k->event = tmp421_event;
>      k->recv = tmp421_rx;
>      k->send = tmp421_tx;
> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
> index efa3621ac6..691cadb4a8 100644
> --- a/hw/nvram/eeprom_at24c.c
> +++ b/hw/nvram/eeprom_at24c.c
> @@ -117,31 +117,29 @@ int at24c_eeprom_send(I2CSlave *s, uint8_t data)
>      return 0;
>  }
>  
> -static
> -int at24c_eeprom_init(I2CSlave *i2c)
> +static void at24c_eeprom_realize(I2CSlave *slave, Error **errp)
>  {
> -    EEPROMState *ee = AT24C_EE(i2c);
> -
> -    ee->mem = g_malloc0(ee->rsize);
> +    EEPROMState *ee = AT24C_EE(slave);
>  
>      if (ee->blk) {
>          int64_t len = blk_getlength(ee->blk);
>  
>          if (len != ee->rsize) {
> -            ERR(TYPE_AT24C_EE " : Backing file size %lu != %u\n",
> -                    (unsigned long)len, (unsigned)ee->rsize);
> -            exit(1);
> +            error_setg(errp, TYPE_AT24C_EE ": Backing file size %ld != %u",
> +                      len, ee->rsize);
> +            return;

And this fails on 32bit hosts...

hw/nvram/eeprom_at24c.c: In function 'at24c_eeprom_realize':
include/qapi/error.h:162:25: error: format '%ld' expects argument of
type 'long int', but argument 6 has type 'int64_t {aka long long int}'
[-Werror=format=]
hw/nvram/eeprom_at24c.c:128:13: note: in expansion of macro 'error_setg'
         error_setg(errp, TYPE_AT24C_EE ": Backing file size %ld != %u",
         ^~~~~~~~~~
cc1: all warnings being treated as errors

>          }
>  
>          if (blk_set_perm(ee->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
>                           BLK_PERM_ALL, &error_fatal) < 0)
>          {
> -            ERR(TYPE_AT24C_EE
> -                    " : Backing file incorrect permission\n");
> -            exit(1);
> +            error_setg(errp, TYPE_AT24C_EE
> +                             ": Backing file incorrect permission");
> +            return;
>          }
>      }
> -    return 0;
> +
> +    ee->mem = g_malloc0(ee->rsize);
>  }
>  
>  static
> @@ -179,7 +177,7 @@ void at24c_eeprom_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
>  
> -    k->init = &at24c_eeprom_init;
> +    k->realize = &at24c_eeprom_realize;
>      k->event = &at24c_eeprom_event;
>      k->recv = &at24c_eeprom_recv;
>      k->send = &at24c_eeprom_send;
> diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
> index eb58c378e0..4f18080c95 100644
> --- a/hw/timer/twl92230.c
> +++ b/hw/timer/twl92230.c
> @@ -853,10 +853,10 @@ static const VMStateDescription vmstate_menelaus = {
>      }
>  };
>  
> -static int twl92230_init(I2CSlave *i2c)
> +static void twl92230_realize(I2CSlave *slave, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(i2c);
> -    MenelausState *s = TWL92230(i2c);
> +    DeviceState *dev = DEVICE(slave);
> +    MenelausState *s = TWL92230(slave);
>  
>      s->rtc.hz_tm = timer_new_ms(rtc_clock, menelaus_rtc_hz, s);
>      /* Three output pins plus one interrupt pin.  */
> @@ -865,9 +865,7 @@ static int twl92230_init(I2CSlave *i2c)
>      /* Three input pins plus one power-button pin.  */
>      qdev_init_gpio_in(dev, menelaus_gpio_set, 4);
>  
> -    menelaus_reset(i2c);
> -
> -    return 0;
> +    menelaus_reset(slave);
>  }
>  
>  static void twl92230_class_init(ObjectClass *klass, void *data)
> @@ -875,7 +873,7 @@ static void twl92230_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
>  
> -    sc->init = twl92230_init;
> +    sc->realize = twl92230_realize;
>      sc->event = menelaus_event;
>      sc->recv = menelaus_rx;
>      sc->send = menelaus_tx;
> 
