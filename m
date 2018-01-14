Received: from eggs.gnu.org ([2001:4830:134:3::10]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eakIt-0002pN-LR
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 10:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eakIs-0001MW-RP
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 10:34:35 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eakIs-0001MF-Mc
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 10:34:34 -0500
Received: by mail-oi0-x242.google.com with SMTP id t8so6815487oie.6
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 07:34:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180114024524.28821-1-f4bug@amsat.org>
References: <20180114024524.28821-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Jan 2018 15:34:13 +0000
Message-ID: <CAFEAcA8ezx6JZa4+XPeaWrJOrr_aND+gFtZPV8UxJzaY3GbGgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/i2c: QOM'ify i2c slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On 14 January 2018 at 02:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
> @@ -276,16 +277,15 @@ const VMStateDescription vmstate_i2c_slave =3D {
>      }
>  };
>
> -static int i2c_slave_qdev_init(DeviceState *dev)
> +static void i2c_slave_realize(DeviceState *dev, Error **errp)
>  {
>      I2CSlave *s =3D I2C_SLAVE(dev);
>      I2CSlaveClass *sc =3D I2C_SLAVE_GET_CLASS(s);
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
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r)
> @@ -301,7 +301,7 @@ DeviceState *i2c_create_slave(I2CBus *bus, const char=
 *name, uint8_t addr)
>  static void i2c_slave_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k =3D DEVICE_CLASS(klass);
> -    k->init =3D i2c_slave_qdev_init;
> +    k->realize =3D i2c_slave_realize;
>      set_bit(DEVICE_CATEGORY_MISC, k->categories);
>      k->bus_type =3D TYPE_I2C_BUS;
>      k->props =3D i2c_props;

This is changing the semantics of the I2CSlaveClass::init
method. Is that really OK? (If nothing else, it means
that we end up with a method named init which is called
at realize time, which is confusing, and which doesn't
have an API like realize which allows it to fill in
an Error**.)

thanks
-- PMM
