Received: from eggs.gnu.org ([2001:4830:134:3::10]:51522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuzLY-0003i4-Vn
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuz8N-0005j2-6G
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:59:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fuz8M-0005ik-EQ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:59:39 -0400
Date: Wed, 29 Aug 2018 12:59:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180829115932.GC2412@work-vm>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
	<1534796770-10295-10-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534796770-10295-10-git-send-email-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v2 09/10] i2c: Add an SMBus vmstate
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

* minyard@acm.org (minyard@acm.org) wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Michael S . Tsirkin" <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/i2c/smbus.c         | 14 ++++++++++++++
>  include/hw/i2c/smbus.h | 18 +++++++++++++++---
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
> index 6ff77c5..b0774d7 100644
> --- a/hw/i2c/smbus.c
> +++ b/hw/i2c/smbus.c
> @@ -349,6 +349,20 @@ int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
>      return 0;
>  }
>  
> +const VMStateDescription vmstate_smbus_device = {
> +    .name = TYPE_SMBUS_DEVICE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,

As with the other patch, I suggest the .needed and property to enable it
only for newer machine types.

> +    .fields      = (VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
> +        VMSTATE_INT32(mode, SMBusDevice),
> +        VMSTATE_INT32(data_len, SMBusDevice),
> +        VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN),
> +        VMSTATE_UINT8(command, SMBusDevice),

Do you need a post_load  to validate that data_len isn't silly?
Maybe command/mode also need checks.

Dave

> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void smbus_device_class_init(ObjectClass *klass, void *data)
>  {
>      I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
> index d8b1b9e..7b52020 100644
> --- a/include/hw/i2c/smbus.h
> +++ b/include/hw/i2c/smbus.h
> @@ -53,14 +53,16 @@ typedef struct SMBusDeviceClass
>      uint8_t (*read_data)(SMBusDevice *dev, uint8_t cmd, int n);
>  } SMBusDeviceClass;
>  
> +#define SMBUS_DATA_MAX_LEN 34  /* command + len + 32 bytes of data.  */
> +
>  struct SMBusDevice {
>      /* The SMBus protocol is implemented on top of I2C.  */
>      I2CSlave i2c;
>  
>      /* Remaining fields for internal use only.  */
> -    int mode;
> -    int data_len;
> -    uint8_t data_buf[34]; /* command + len + 32 bytes of data.  */
> +    int32_t mode;
> +    int32_t data_len;
> +    uint8_t data_buf[SMBUS_DATA_MAX_LEN];
>      uint8_t command;
>  };
>  
> @@ -93,4 +95,14 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
>  void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>                         const uint8_t *eeprom_spd, int size);
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
>  #endif
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
