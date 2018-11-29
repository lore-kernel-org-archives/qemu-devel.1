Received: from eggs.gnu.org ([2001:4830:134:3::10]:53570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gSM57-00005j-Q0
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gSM4z-0000SN-R4
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:10:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gSM4z-0000RS-Ix
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:10:05 -0500
Date: Thu, 29 Nov 2018 13:09:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181129130955.GG2333@work-vm>
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-12-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126200435.23408-12-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v3 11/16] i2c:smbus_slave: Add an SMBus
 vmstate structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

* minyard@acm.org (minyard@acm.org) wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> There is no vmstate handling for SMBus, so no device sitting on SMBus
> can have a state transfer that works reliably.  So add it.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/i2c/smbus_slave.c         | 18 ++++++++++++++++++
>  include/hw/i2c/smbus_slave.h | 24 +++++++++++++++++++++---
>  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
> index d03f714608..e839c1dd11 100644
> --- a/hw/i2c/smbus_slave.c
> +++ b/hw/i2c/smbus_slave.c
> @@ -206,6 +206,24 @@ static void smbus_device_class_init(ObjectClass *klass, void *data)
>      sc->send = smbus_i2c_send;
>  }
>  
> +bool smbus_vmstate_needed(SMBusDevice *dev)
> +{
> +    return dev->mode != SMBUS_IDLE;
> +}
> +
> +const VMStateDescription vmstate_smbus_device = {
> +    .name = TYPE_SMBUS_DEVICE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
> +        VMSTATE_INT32(mode, SMBusDevice),
> +        VMSTATE_INT32(data_len, SMBusDevice),
> +        VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const TypeInfo smbus_device_type_info = {
>      .name = TYPE_SMBUS_DEVICE,
>      .parent = TYPE_I2C_SLAVE,
> diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
> index fad2db9c76..78fd45cb51 100644
> --- a/include/hw/i2c/smbus_slave.h
> +++ b/include/hw/i2c/smbus_slave.h
> @@ -75,14 +75,32 @@ typedef struct SMBusDeviceClass
>      void (*transaction_complete)(SMBusDevice *dev);
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
>  };
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
> +/*
> + * Users should call this in their .needed functions to know if the
> + * SMBus slave data needs to be transferred.
> + */
> +bool smbus_vmstate_needed(SMBusDevice *dev);
> +
>  #endif
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
