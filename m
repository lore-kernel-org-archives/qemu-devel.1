Received: from eggs.gnu.org ([2001:4830:134:3::10]:49964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duHOB-00067q-AC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duHO4-0002zC-Tl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:12:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170919112645.8574-1-clg@kaod.org>
	<20170919112645.8574-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <472ff629-39bd-9fe2-c1f8-a08ba6997b53@amsat.org>
Date: Tue, 19 Sep 2017 09:12:20 -0300
MIME-Version: 1.0
In-Reply-To: <20170919112645.8574-4-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/5] aspeed: Add EEPROM I2C devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>

Hi Cédric,

On 09/19/2017 08:26 AM, Cédric Le Goater wrote:
> The Aspeed boards have at least one EEPROM to hold the Vital Product
> Data (VPD).
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 362b683e9021..3e74970d7ad2 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -251,6 +251,17 @@ static void aspeed_board_init(MachineState *machine,
>       arm_load_kernel(ARM_CPU(first_cpu), &aspeed_board_binfo);
>   }
>   
> +static void aspeed_i2c_add_eeprom(I2CBus *bus, uint8_t address, size_t size)
> +{
> +    uint8_t *eeprom_buf = g_malloc0(size);
> +    DeviceState *dev;
> +
> +    dev = qdev_create((BusState *) bus, "smbus-eeprom");
> +    qdev_prop_set_uint8(dev, "address", address);
> +    qdev_prop_set_ptr(dev, "data", eeprom_buf);
> +    qdev_init_nofail(dev);

Can you merge this with smbus_eeprom_init() ?
I think the cleaner way would be add "include/hw/i2c/eeprom.h" defining 
SMB_EEPROM_TYPE "smbus-eeprom" and declare smbus_eeprom_init() there or 
as inlined.

> +}
> +
>   static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
>   {
>       AspeedSoCState *soc = &bmc->soc;
> @@ -260,6 +271,9 @@ static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
>        * enough to provide basic RTC features. Alarms will be missing */
>       i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338", 0x68);
>   
> +    aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), 0x50,
> +                          256 * 1024);
> +
>       /* add a TMP423 temperature sensor */
>       dev = i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
>                              "tmp423", 0x4c);
> @@ -298,6 +312,9 @@ static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
>   {
>       AspeedSoCState *soc = &bmc->soc;
>   
> +    aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), 0x50,
> +                          8 * 1024);
> +
>       /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
>       i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105", 0x4d);
>   
> @@ -377,6 +394,9 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>       /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
>        * good enough */
>       i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
> +
> +    aspeed_i2c_add_eeprom(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
> +                          8 * 1024);
>   }
>   
>   static void witherspoon_bmc_init(MachineState *machine)
> 
