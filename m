Received: from eggs.gnu.org ([2001:4830:134:3::10]:39202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmm3-0004D6-7t
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSmlz-0000uD-Gq
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:40:17 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSmlv-0000qI-95
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:40:13 -0500
Received: by mail-oi1-x241.google.com with SMTP id m6so5388213oig.11
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-16-minyard@acm.org>
In-Reply-To: <20181126200435.23408-16-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 17:39:57 +0000
Message-ID: <CAFEAcA8OuW0o5KmGLPuQB149yXowdb=8DyW5oe1yfjE4H--sPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/16] hw/i2c/smbus_eeprom: Create at
 most SMBUS_EEPROM_MAX EEPROMs on a SMBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On Mon, 26 Nov 2018 at 20:04, <minyard@acm.org> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Calling smbus_eeprom_init() with more than 8 EEPROMs would lead to a
> heap overflow.
> Replace the '8' magic number by a definition, and check no more than
> this number are created.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/i2c/smbus_eeprom.c         | 13 +++++++++++--
>  include/hw/i2c/smbus_eeprom.h |  4 +++-
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 942057dc10..a0dcadbd60 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/boards.h"
>  #include "hw/i2c/i2c.h"
> @@ -157,12 +158,20 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t a=
ddress, uint8_t *eeprom_buf)
>      qdev_init_nofail(dev);
>  }
>
> -void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
> +void smbus_eeprom_init(I2CBus *smbus, unsigned int nb_eeprom,
>                         const uint8_t *eeprom_spd, int eeprom_spd_size)
>  {
>      int i;
> +    uint8_t *eeprom_buf;
> +
> +    if (nb_eeprom > SMBUS_EEPROM_MAX) {
> +        error_report("At most %u EEPROM are supported on a SMBus.",
> +                     SMBUS_EEPROM_MAX);
> +        exit(1);

You could also just assert(), since this would be a
QEMU bug (all callers use fixed values for this argument).

> +    }
> +
>       /* XXX: make this persistent */
> -    uint8_t *eeprom_buf =3D g_malloc0(8 * SMBUS_EEPROM_SIZE);
> +    eeprom_buf =3D g_malloc0(nb_eeprom * SMBUS_EEPROM_SIZE);

So if we allocate N buffers as the caller requests, what
is the thing that means that more than 8 won't work ?

We've now changed from allocating always 8 lots of
the EEPROM size to possibly allocating fewer than that.
How does the code in the device know what the size
of the buffer we're passing as the "data" property is
now? We don't pass it the number of EEPROMs as a property.

>      if (eeprom_spd_size > 0) {
>          memcpy(eeprom_buf, eeprom_spd, eeprom_spd_size);
>      }
> diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.=
h
> index 46fb1a37d6..8436200599 100644
> --- a/include/hw/i2c/smbus_eeprom.h
> +++ b/include/hw/i2c/smbus_eeprom.h
> @@ -25,8 +25,10 @@
>
>  #include "hw/i2c/i2c.h"
>
> +#define SMBUS_EEPROM_MAX 8
> +
>  void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom=
_buf);
> -void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
> +void smbus_eeprom_init(I2CBus *bus, unsigned int nb_eeprom,
>                         const uint8_t *eeprom_spd, int size);

thanks
-- PMM
