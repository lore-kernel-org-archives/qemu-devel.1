Received: from eggs.gnu.org ([2001:4830:134:3::10]:54241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKlDJ-0008UW-NX
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKlDG-0002Bh-Ui
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:23:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKlDG-0002BU-Mj
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:23:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id f10-v6so1442739wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:23:14 -0800 (PST)
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-3-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <98b1f2e3-bf71-24a2-f339-9fd63b40d26f@redhat.com>
Date: Thu, 8 Nov 2018 15:23:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181107155405.24013-3-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] i2c: Add an SMBus vmstate structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Hi Corey,

On 7/11/18 16:54, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> There is no vmstate handling for SMBus, so no device sitting on SMBus
> can have a state transfer that works reliable.  So add it.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   hw/i2c/smbus.c         | 14 ++++++++++++++
>   include/hw/i2c/smbus.h | 18 +++++++++++++++---
>   2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
> index 6ff77c582f..b0774d7683 100644
> --- a/hw/i2c/smbus.c
> +++ b/hw/i2c/smbus.c
> @@ -349,6 +349,20 @@ int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
>       return 0;
>   }
>   
> +const VMStateDescription vmstate_smbus_device = {
> +    .name = TYPE_SMBUS_DEVICE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
> +        VMSTATE_INT32(mode, SMBusDevice),
> +        VMSTATE_INT32(data_len, SMBusDevice),
> +        VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN),
> +        VMSTATE_UINT8(command, SMBusDevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static void smbus_device_class_init(ObjectClass *klass, void *data)
>   {
>       I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
> index d8b1b9ee81..7b52020121 100644
> --- a/include/hw/i2c/smbus.h
> +++ b/include/hw/i2c/smbus.h
> @@ -53,14 +53,16 @@ typedef struct SMBusDeviceClass
>       uint8_t (*read_data)(SMBusDevice *dev, uint8_t cmd, int n);
>   } SMBusDeviceClass;
>   
> +#define SMBUS_DATA_MAX_LEN 34  /* command + len + 32 bytes of data.  */
> +
>   struct SMBusDevice {
>       /* The SMBus protocol is implemented on top of I2C.  */
>       I2CSlave i2c;
>   
>       /* Remaining fields for internal use only.  */
> -    int mode;
> -    int data_len;
> -    uint8_t data_buf[34]; /* command + len + 32 bytes of data.  */
> +    int32_t mode;
> +    int32_t data_len;
> +    uint8_t data_buf[SMBUS_DATA_MAX_LEN];

Those changes are not in your commit description.
Can you include them in a separate patch?
Thanks,
Phil.

>       uint8_t command;
>   };
>   
> @@ -93,4 +95,14 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
>   void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>                          const uint8_t *eeprom_spd, int size);
>   
> +extern const VMStateDescription vmstate_smbus_device;
> +
> +#define VMSTATE_SMBUS_DEVICE(_field, _state) {                       \
> +    .name       = (stringify(_field)),                               \
> +    .size       = sizeof(SMBusDevice),                               \
> +    .vmsd       = &vmstate_smbus_device,                             \
> +    .flags      = VMS_STRUCT,                                        \
> +    .offset     = vmstate_offset_value(_state, _field, SMBusDevice), \
> +}
> +
>   #endif
> 
