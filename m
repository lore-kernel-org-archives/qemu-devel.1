Received: from eggs.gnu.org ([2001:4830:134:3::10]:33359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaYUH-0007Be-GO
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaYUE-00073b-FT
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:57:33 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaYUE-00072z-Ah
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:57:30 -0500
Received: by mail-qt0-x241.google.com with SMTP id o35so426235qtj.13
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 18:57:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180114024524.28821-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <855a3edf-0dde-04a8-1a3c-04538dc65ea4@amsat.org>
Date: Sat, 13 Jan 2018 23:57:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180114024524.28821-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/i2c: QOM'ify i2c slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>

This description is more appropriate:
"hw/i2c: convert i2c slave init() to realize()"

On 01/13/2018 11:45 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/i2c/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 59068f157e..c84dbfb884 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/i2c/i2c.h"
>  
>  typedef struct I2CNode I2CNode;
> @@ -276,16 +277,15 @@ const VMStateDescription vmstate_i2c_slave = {
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
> +    if (sc->init && sc->init(s)) {
> +        error_setg(errp, "i2c slave initialization failed");
> +        return;
>      }
> -
> -    return 0;
>  }
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
> @@ -301,7 +301,7 @@ DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>  static void i2c_slave_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k = DEVICE_CLASS(klass);
> -    k->init = i2c_slave_qdev_init;
> +    k->realize = i2c_slave_realize;
>      set_bit(DEVICE_CATEGORY_MISC, k->categories);
>      k->bus_type = TYPE_I2C_BUS;
>      k->props = i2c_props;
> 
