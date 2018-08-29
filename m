Received: from eggs.gnu.org ([2001:4830:134:3::10]:43907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuytj-0005U9-2f
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuytc-00017t-Bk
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:44:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fuytc-00017p-76
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:44:24 -0400
Date: Wed, 29 Aug 2018 12:44:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180829114418.GB2412@work-vm>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
	<1534796770-10295-11-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534796770-10295-11-git-send-email-minyard@acm.org>
Subject: Re: [Qemu-devel] [PATCH v2 10/10] i2c: Add vmstate handling to the
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

* minyard@acm.org (minyard@acm.org) wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Michael S . Tsirkin" <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/i2c/smbus_eeprom.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index f18aa3d..d4430b0 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -29,6 +29,8 @@
>  
>  //#define DEBUG
>  
> +#define TYPE_SMBUS_EEPROM_DEVICE "smbus-eeprom"
> +
>  typedef struct SMBusEEPROMDevice {
>      SMBusDevice smbusdev;
>      void *data;
> @@ -97,6 +99,17 @@ static uint8_t eeprom_read_data(SMBusDevice *dev, uint8_t cmd, int n)
>      return eeprom_receive_byte(dev);
>  }
>  
> +static const VMStateDescription vmstate_smbus_eeprom = {
> +    .name = TYPE_SMBUS_EEPROM_DEVICE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,

Can you add a .needed and wire it up to a property that we can then wire
to machine types; that way we don't break migration compatibility.

> +    .fields      = (VMStateField[]) {
> +        VMSTATE_SMBUS_DEVICE(smbusdev, SMBusEEPROMDevice),
> +        VMSTATE_UINT8(offset, SMBusEEPROMDevice),

What about the data?

Dave

> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>  {
>      SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
> @@ -121,12 +134,13 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>      sc->write_data = eeprom_write_data;
>      sc->read_data = eeprom_read_data;
>      dc->props = smbus_eeprom_properties;
> +    dc->vmsd = &vmstate_smbus_eeprom;
>      /* Reason: pointer property "data" */
>      dc->user_creatable = false;
>  }
>  
>  static const TypeInfo smbus_eeprom_info = {
> -    .name          = "smbus-eeprom",
> +    .name          = TYPE_SMBUS_EEPROM_DEVICE,
>      .parent        = TYPE_SMBUS_DEVICE,
>      .instance_size = sizeof(SMBusEEPROMDevice),
>      .class_init    = smbus_eeprom_class_initfn,
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
