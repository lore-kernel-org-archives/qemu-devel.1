Received: from eggs.gnu.org ([2001:4830:134:3::10]:47410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKkza-0001LK-Nk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKkzN-0003qD-2Z
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:09:06 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKkzM-0003pj-SW
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:08:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id g10so18187508otl.12
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:08:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181107155405.24013-4-minyard@acm.org>
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-4-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 14:08:31 +0000
Message-ID: <CAFEAcA9hp0VzN484uugfc4kzh3pSDMn3PU+ozfc_XPT5P-QsBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] i2c: Add vmstate handling to the smbus
 eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 7 November 2018 at 15:54,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> This was if the eeprom is accessed during a state transfer, the
> transfer will be reliable.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/i2c/smbus_eeprom.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index f18aa3de35..d4430b0c5d 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -29,6 +29,8 @@
>
>  //#define DEBUG
>
> +#define TYPE_SMBUS_EEPROM_DEVICE "smbus-eeprom"

The part of this patch which is adding the usual QOM
macros is good, but we should provide also the
cast-macro (the one that's an OBJECT_CHECK(...)).
And this should be separate from adding the vmstate.

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

Generally we don't use the TYPE_FOO constant for the vmstate
name, because we can usually freely change the TYPE_FOO string without
breaking back-compat, but we can't change the vmstate name.
So we decouple them to make it more obvious when a change might
be changing the migration on-the-wire format.

> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_SMBUS_DEVICE(smbusdev, SMBusEEPROMDevice),
> +        VMSTATE_UINT8(offset, SMBusEEPROMDevice),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

This doesn't do anything for migration of the actual data contents.
The current users of this device (hw/arm/aspeed.c and the
smbus_eeprom_init() function) doesn't do anything
to migrate the contents. For that matter, "user of the device
passes a pointer to a random lump of memory via a device property"
is a bit funky as an interface. The device should allocate its
own memory and migrate it, and the user should just pass the
initial required contents (default being "zero-initialize",
which is what everybody except the mips_fulong2e, mips_malta
and sam460ex want).

Does this also break migration from an old QEMU to a new one?
(For Aspeed that's probably ok, but we should flag it up in the
commit message if so. x86 uses need care...)

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
> 2.17.1

thanks
-- PMM
