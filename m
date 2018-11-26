Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRNbZ-0005SR-Sj
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRNbW-0007JA-BA
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:35:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRNbW-0007Iv-5F
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:35:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so20404122wrw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:35:38 -0800 (PST)
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-13-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5dca813b-7431-466a-c775-2cb96ed2dcae@redhat.com>
Date: Mon, 26 Nov 2018 21:35:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200435.23408-13-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 12/16] i2c:smbus_eeprom: Add normal type
 name and cast to smbus_eeprom.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 26/11/18 21:04, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Create a type name and a cast macro and use those through the
> code.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/i2c/smbus_eeprom.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 4d25222e23..8d4eed129f 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -30,6 +30,11 @@
>  
>  //#define DEBUG
>  
> +#define TYPE_SMBUS_EEPROM "smbus-eeprom"
> +
> +#define SMBUS_EEPROM(obj) \
> +    OBJECT_CHECK(SMBusEEPROMDevice, (obj), TYPE_SMBUS_EEPROM)
> +
>  typedef struct SMBusEEPROMDevice {
>      SMBusDevice smbusdev;
>      void *data;
> @@ -38,7 +43,7 @@ typedef struct SMBusEEPROMDevice {
>  
>  static uint8_t eeprom_receive_byte(SMBusDevice *dev)
>  {
> -    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
> +    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
>      uint8_t *data = eeprom->data;
>      uint8_t val = data[eeprom->offset++];
>  
> @@ -51,7 +56,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
>  
>  static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
>  {
> -    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
> +    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
>      uint8_t *data = eeprom->data;
>  
>  #ifdef DEBUG
> @@ -73,7 +78,7 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
>  
>  static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>  {
> -    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
> +    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
>  
>      eeprom->offset = 0;
>  }
> @@ -97,7 +102,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo smbus_eeprom_info = {
> -    .name          = "smbus-eeprom",
> +    .name          = TYPE_SMBUS_EEPROM,
>      .parent        = TYPE_SMBUS_DEVICE,
>      .instance_size = sizeof(SMBusEEPROMDevice),
>      .class_init    = smbus_eeprom_class_initfn,
> @@ -114,7 +119,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
>  {
>      DeviceState *dev;
>  
> -    dev = qdev_create((BusState *) smbus, "smbus-eeprom");
> +    dev = qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
>      qdev_prop_set_uint8(dev, "address", address);
>      qdev_prop_set_ptr(dev, "data", eeprom_buf);
>      qdev_init_nofail(dev);
> 
