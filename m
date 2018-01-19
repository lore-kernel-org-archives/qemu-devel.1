Received: from eggs.gnu.org ([2001:4830:134:3::10]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecbCp-0002u5-Gl
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecbCl-00051y-JV
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:15:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecbCl-00051Z-DV
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:15:55 -0500
Date: Fri, 19 Jan 2018 16:15:48 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119181548.GL15832@localhost.localdomain>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180116131555.14242-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/11] smbus_eeprom: replace
 SMBusDeviceClass::init by DeviceClass::reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On Tue, Jan 16, 2018 at 10:15:46AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/i2c/smbus_eeprom.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index b13ec0fe7a..7e81ae4fe5 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -97,12 +97,11 @@ static uint8_t eeprom_read_data(SMBusDevice *dev, u=
int8_t cmd, int n)
>      return eeprom_receive_byte(dev);
>  }
> =20
> -static int smbus_eeprom_initfn(SMBusDevice *dev)
> +static void smbus_eeprom_reset(DeviceState *dev)
>  {
>      SMBusEEPROMDevice *eeprom =3D (SMBusEEPROMDevice *)dev;
> =20
>      eeprom->offset =3D 0;
> -    return 0;
>  }
> =20
>  static Property smbus_eeprom_properties[] =3D {
> @@ -115,7 +114,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *=
klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      SMBusDeviceClass *sc =3D SMBUS_DEVICE_CLASS(klass);
> =20
> -    sc->init =3D smbus_eeprom_initfn;
> +    dc->reset =3D smbus_eeprom_reset;

Trying to track down when each of these methods is called:

sc->init (SMBusDeviceClass::init)
 -> called by i2c_slave_qdev_init() (DeviceClass:init)
   -> called by device_realize() (DeviceClass::realize)
     -> called by device_set_realized()
       -> QOM setter for "realized" property
         -> (multiple callers)

(eww, so many indirections)

dc->reset (DeviceClass::reset)
  -> called by device_reset()
    -> (multiple callers)

(much better!)


It looks like this changes how the device behaves.  Is this
fixing a device emulation bug?  If not, why should the device set
offset=3D0 on DeviceClass::reset, and not DeviceClass::realize?


>      sc->quick_cmd =3D eeprom_quick_cmd;
>      sc->send_byte =3D eeprom_send_byte;
>      sc->receive_byte =3D eeprom_receive_byte;
> --=20
> 2.15.1
>=20
>=20

--=20
Eduardo
