Received: from eggs.gnu.org ([2001:4830:134:3::10]:34031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNnr6-0000pu-So
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 18:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNnr1-0005jj-VK
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 18:48:56 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gNnr1-0005h8-QA
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 18:48:51 -0500
Received: by mail-ot1-x343.google.com with SMTP id 32so22344027ota.12
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 15:48:49 -0800 (PST)
Reply-To: minyard@acm.org
References: <20181115230546.27375-1-philmd@redhat.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <01bb4878-5da6-12e3-31e5-254137a059d9@gmail.com>
Date: Fri, 16 Nov 2018 17:48:45 -0600
MIME-Version: 1.0
In-Reply-To: <20181115230546.27375-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH] hw/i2c/smbus_eeprom: Create at most
 SMBUS_EEPROM_MAX EEPROMs on a SMBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 11/15/18 5:05 PM, Philippe Mathieu-Daudé wrote:
> Calling smbus_eeprom_init() with more than 8 EEPROMs would lead to a
> heap overflow.
> Replace the '8' magic number by a definition, and check no more than
> this number are created.

This looks like a good idea.  I have it in my tree.

Thanks,

-corey


> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Based-on: 20181115192446.17187-1-minyard@acm.org
> "RFC v2: Fix/add vmstate handling in some I2C code"
> ---
>   hw/i2c/smbus_eeprom.c         | 13 +++++++++++--
>   include/hw/i2c/smbus_eeprom.h |  4 +++-
>   2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index d0a8d63869..de3a492df4 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "hw/boards.h"
>   #include "hw/i2c/i2c.h"
> @@ -163,12 +164,20 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
>       qdev_init_nofail(dev);
>   }
>   
> -void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
> +void smbus_eeprom_init(I2CBus *smbus, unsigned int nb_eeprom,
>                          const uint8_t *eeprom_spd, int eeprom_spd_size)
>   {
>       int i;
> +    uint8_t *eeprom_buf;
> +
> +    if (nb_eeprom > SMBUS_EEPROM_MAX) {
> +        error_report("At most %u EEPROM are supported on a SMBus.",
> +                     SMBUS_EEPROM_MAX);
> +        exit(1);
> +    }
> +
>        /* XXX: make this persistent */
> -    uint8_t *eeprom_buf = g_malloc0(8 * SMBUS_EEPROM_SIZE);
> +    eeprom_buf = g_malloc0(nb_eeprom * SMBUS_EEPROM_SIZE);
>       if (eeprom_spd_size > 0) {
>           memcpy(eeprom_buf, eeprom_spd, eeprom_spd_size);
>       }
> diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.h
> index 2f56e5dc4e..cc9d1cdba9 100644
> --- a/include/hw/i2c/smbus_eeprom.h
> +++ b/include/hw/i2c/smbus_eeprom.h
> @@ -4,8 +4,10 @@
>   
>   #include "hw/i2c/i2c.h"
>   
> +#define SMBUS_EEPROM_MAX 8
> +
>   void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom_buf);
> -void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
> +void smbus_eeprom_init(I2CBus *bus, unsigned int nb_eeprom,
>                          const uint8_t *eeprom_spd, int size);
>   
>   #endif
