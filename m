Received: from eggs.gnu.org ([2001:4830:134:3::10]:41189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJsj-0006UT-Jj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJsg-0004TC-1t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:52:13 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duJsf-0004SZ-SL
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:52:09 -0400
Received: by mail-wr0-f182.google.com with SMTP id m18so232636wrm.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:52:09 -0700 (PDT)
References: <20170919125041.2153-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9832b91c-18dd-778a-b7a1-696a27359721@redhat.com>
Date: Tue, 19 Sep 2017 16:52:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170919125041.2153-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/input/lm832x: move LM8323 declarations
 to input/keypad.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 19/09/2017 14:50, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Based-on: 20170919123053.32675-1-f4bug@amsat.org
> 
> $ ./scripts/get_maintainer.pl -f hw/input/lm832x.c
> get_maintainer.pl: No maintainers found, printing recent contributors.

I think the keymap and handler should be moved entirely to
hw/input/lm832x.c, removing the corresponding code from nseries.c; same
for tsc210x.c.

Unfortunately this is not my area, so I'm not very sure about it.  But
it should be relatively easy to write a qtest for lm832x, since it's an
i2c device just like e.g. tmp105.c (you can use QMP to send keys).

Thanks,

Paolo

>  include/hw/i2c/i2c.h      |  3 ---
>  include/hw/input/keypad.h | 23 +++++++++++++++++++++++
>  hw/arm/nseries.c          |  3 ++-
>  hw/input/lm832x.c         |  3 +--
>  4 files changed, 26 insertions(+), 6 deletions(-)
>  create mode 100644 include/hw/input/keypad.h
> 
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 24e95d0155..8fdf3e47d6 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -70,9 +70,6 @@ int i2c_recv(I2CBus *bus);
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
>  
> -/* lm832x.c */
> -void lm832x_key_event(DeviceState *dev, int key, int state);
> -
>  extern const VMStateDescription vmstate_i2c_slave;
>  
>  #define VMSTATE_I2C_SLAVE(_field, _state) {                          \
> diff --git a/include/hw/input/keypad.h b/include/hw/input/keypad.h
> new file mode 100644
> index 0000000000..efacef6458
> --- /dev/null
> +++ b/include/hw/input/keypad.h
> @@ -0,0 +1,23 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef HW_KEYPAD_H
> +#define HW_KEYPAD_H
> +
> +#include "hw/hw.h"
> +
> +#define TYPE_LM8323 "lm8323"
> +
> +void lm832x_key_event(DeviceState *dev, int key, int state);
> +
> +#endif
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index a32ac82702..594b7e878c 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -30,6 +30,7 @@
>  #include "ui/console.h"
>  #include "hw/boards.h"
>  #include "hw/i2c/i2c.h"
> +#include "hw/input/keypad.h"
>  #include "hw/devices.h"
>  #include "hw/block/flash.h"
>  #include "hw/hw.h"
> @@ -412,7 +413,7 @@ static void n810_kbd_setup(struct n800_s *s)
>      /* Attach the LM8322 keyboard to the I2C bus,
>       * should happen in n8x0_i2c_setup and s->kbd be initialised here.  */
>      s->kbd = i2c_create_slave(omap_i2c_bus(s->mpu->i2c[0]),
> -                           "lm8323", N810_LM8323_ADDR);
> +                              TYPE_LM8323, N810_LM8323_ADDR);
>      qdev_connect_gpio_out(s->kbd, 0, kbd_irq);
>  }
>  
> diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
> index 2340523da0..868ddfe5ea 100644
> --- a/hw/input/lm832x.c
> +++ b/hw/input/lm832x.c
> @@ -19,12 +19,11 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "hw/hw.h"
>  #include "hw/i2c/i2c.h"
> +#include "hw/input/keypad.h"
>  #include "qemu/timer.h"
>  #include "ui/console.h"
>  
> -#define TYPE_LM8323 "lm8323"
>  #define LM8323(obj) OBJECT_CHECK(LM823KbdState, (obj), TYPE_LM8323)
>  
>  typedef struct {
> 
