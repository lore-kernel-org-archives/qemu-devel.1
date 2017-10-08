Received: from eggs.gnu.org ([2001:4830:134:3::10]:50694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e1MOB-0001VF-7Y
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e1MO8-0007bv-3Z
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 20:57:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6f338f6a-c6cb-19e8-2d6b-48f4a931c7da@amsat.org>
Date: Sun, 8 Oct 2017 18:35:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170920070135.31379-4-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] smbus: add a
 smbus_eeprom_init_one() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>

On 09/20/2017 04:01 AM, Cédric Le Goater wrote:
> This is an helper routine to add a single EEPROM on an I2C bus. It can
> be directly used by smbus_eeprom_init() which adds a certain number of
> EEPROMs on mips and x86 machines.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/i2c/smbus_eeprom.c  | 16 +++++++++++-----
>  include/hw/i2c/smbus.h |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index b13ec0fe7a2a..2d24a4cd59bf 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -140,6 +140,16 @@ static void smbus_eeprom_register_types(void)
>  
>  type_init(smbus_eeprom_register_types)
>  
> +void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
> +{
> +    DeviceState *dev;
> +
> +    dev = qdev_create((BusState *) smbus, "smbus-eeprom");
> +    qdev_prop_set_uint8(dev, "address", address);
> +    qdev_prop_set_ptr(dev, "data", eeprom_buf);
> +    qdev_init_nofail(dev);
> +}
> +
>  void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>                         const uint8_t *eeprom_spd, int eeprom_spd_size)
>  {
> @@ -150,10 +160,6 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>      }
>  
>      for (i = 0; i < nb_eeprom; i++) {
> -        DeviceState *eeprom;
> -        eeprom = qdev_create((BusState *)smbus, "smbus-eeprom");
> -        qdev_prop_set_uint8(eeprom, "address", 0x50 + i);
> -        qdev_prop_set_ptr(eeprom, "data", eeprom_buf + (i * 256));
> -        qdev_init_nofail(eeprom);
> +        smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256));
>      }
>  }
> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
> index 544bbc19574f..666cdeb04c07 100644
> --- a/include/hw/i2c/smbus.h
> +++ b/include/hw/i2c/smbus.h
> @@ -77,6 +77,7 @@ int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data);
>  int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
>                        int len);
>  
> +void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
>  void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>                         const uint8_t *eeprom_spd, int size);
>  
> 
