Received: from eggs.gnu.org ([2001:4830:134:3::10]:57331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRKia-0008TK-Dw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRKiW-00049O-BZ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:30:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gRKiW-000487-2a
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:30:40 -0500
Date: Mon, 26 Nov 2018 17:30:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181126173030.GK2547@work-vm>
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-12-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115192446.17187-12-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v2 11/12] i2c: Add vmstate handling to the
 smbus eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, Peter Maydell <peter.maydell@linaro.org>

* minyard@acm.org (minyard@acm.org) wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Transfer the state of the EEPROM on a migration.  This way the
> data remains consistent on migration.
> 
> This required moving the actual data to a separate array and
> using the data provided in the init function as a separate
> initialization array, since a pointer property has to be a
> void * and the array needs to be uint8_t[].
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/i2c/smbus_eeprom.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 8e9b734c09..942057dc10 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -24,6 +24,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> +#include "hw/boards.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/i2c/smbus_slave.h"
>  #include "hw/i2c/smbus_eeprom.h"
> @@ -39,8 +40,10 @@
>  
>  typedef struct SMBusEEPROMDevice {
>      SMBusDevice smbusdev;
> -    void *data;
> +    uint8_t data[SMBUS_EEPROM_SIZE];
> +    void *init_data;
>      uint8_t offset;
> +    bool accessed;
>  } SMBusEEPROMDevice;
>  
>  static uint8_t eeprom_receive_byte(SMBusDevice *dev)
> @@ -49,6 +52,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
>      uint8_t *data = eeprom->data;
>      uint8_t val = data[eeprom->offset++];
>  
> +    eeprom->accessed = true;
>  #ifdef DEBUG
>      printf("eeprom_receive_byte: addr=0x%02x val=0x%02x\n",
>             dev->i2c.address, val);
> @@ -61,6 +65,7 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
>      SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
>      uint8_t *data = eeprom->data;
>  
> +    eeprom->accessed = true;
>  #ifdef DEBUG
>      printf("eeprom_write_byte: addr=0x%02x cmd=0x%02x val=0x%02x\n",
>             dev->i2c.address, cmd, buf[0]);
> @@ -78,15 +83,39 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
>      return 0;
>  }
>  
> +static bool smbus_eeprom_vmstate_needed(void *opaque)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> +    SMBusEEPROMDevice *eeprom = opaque;
> +
> +    return (eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev)) &&
> +        !mc->smbus_no_migration_support;
> +}
> +
> +static const VMStateDescription vmstate_smbus_eeprom = {
> +    .name = "smbus-eeprom",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = smbus_eeprom_vmstate_needed,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_SMBUS_DEVICE(smbusdev, SMBusEEPROMDevice),
> +        VMSTATE_UINT8_ARRAY(data, SMBusEEPROMDevice, SMBUS_EEPROM_SIZE),
> +        VMSTATE_UINT8(offset, SMBusEEPROMDevice),
> +        VMSTATE_BOOL(accessed, SMBusEEPROMDevice),
> +        VMSTATE_END_OF_LIST()

I think this is OK from the vmstate side of things.

Dave

> +    }
> +};
> +
>  static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>  {
>      SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
>  
> +    memcpy(eeprom->data, eeprom->init_data, SMBUS_EEPROM_SIZE);
>      eeprom->offset = 0;
>  }
>  
>  static Property smbus_eeprom_properties[] = {
> -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, data),
> +    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -99,6 +128,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>      sc->receive_byte = eeprom_receive_byte;
>      sc->write_data = eeprom_write_data;
>      dc->props = smbus_eeprom_properties;
> +    dc->vmsd = &vmstate_smbus_eeprom;
>      /* Reason: pointer property "data" */
>      dc->user_creatable = false;
>  }
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
