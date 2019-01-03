Received: from eggs.gnu.org ([208.118.235.92]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gf0Uv-00026m-G1
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gf0Ur-0002Ey-Mu
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gf0Uq-0002Dm-Vo
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 05:45:05 -0500
Date: Thu, 3 Jan 2019 10:44:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190103104450.GE2316@work-vm>
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-15-minyard@acm.org>
	<20181129132939.GH2333@work-vm>
	<64256efc-d0e4-1828-bf67-81c46984f387@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <64256efc-d0e4-1828-bf67-81c46984f387@acm.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/16] i2c:smbus_eeprom: Add vmstate
 handling to the smbus eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

* Corey Minyard (minyard@acm.org) wrote:
> On 11/29/18 7:29 AM, Dr. David Alan Gilbert wrote:
> > * minyard@acm.org (minyard@acm.org) wrote:
> > > From: Corey Minyard <cminyard@mvista.com>
> > >=20
> > > Transfer the state of the EEPROM on a migration.  This way the
> > > data remains consistent on migration.
> > >=20
> > > This required moving the actual data to a separate array and
> > > using the data provided in the init function as a separate
> > > initialization array, since a pointer property has to be a
> > > void * and the array needs to be uint8_t[].
> > So I think I'm OK with this, but I'd like other peoples comments as
> > well; see comments.
>=20
>=20
> Well, no comments so far.
>=20
> I have a question on this.=A0 If this particular device were modified t=
o be
> able
> to support different size eeproms, would this need a new version of the
> vmstate structure?=A0 I know the vmstate structure itself would have to
> change to have an array size, but would it have to change in such a
> way that the array size would need to be transmitted?
>=20
> I ask because someday, someone might need an eeprom of a different
> size, and it would be nice if it could be done now in a way that avoide=
d
> creating a new version.

That depends; for example one way to do it would be to keep the existing
structure for cases where the PROM was the current default size, and
then add the extra data in a subsection that was only transmitted for a
PROM that was a different size.

However, it's probably simpler - the size of the eprom comes from the
configuration from the command line etc - it's not a dynamic thing;
So you'd probably end up going back to a void *data, making sure that's
allocated before thefields are loaded, and then replacing the
VMSTATE_UINT8_ARRAY by a VMSTATE_BUFFER;  note that if the sizes don't
match on source/destination then that would fail rather messily
where as the subsection would fail cleanly.

Dave

> Thanks,
>=20
> -corey
>=20
> > > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >   hw/i2c/smbus_eeprom.c | 34 ++++++++++++++++++++++++++++++++--
> > >   1 file changed, 32 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> > > index 8e9b734c09..942057dc10 100644
> > > --- a/hw/i2c/smbus_eeprom.c
> > > +++ b/hw/i2c/smbus_eeprom.c
> > > @@ -24,6 +24,7 @@
> > >   #include "qemu/osdep.h"
> > >   #include "hw/hw.h"
> > > +#include "hw/boards.h"
> > >   #include "hw/i2c/i2c.h"
> > >   #include "hw/i2c/smbus_slave.h"
> > >   #include "hw/i2c/smbus_eeprom.h"
> > > @@ -39,8 +40,10 @@
> > >   typedef struct SMBusEEPROMDevice {
> > >       SMBusDevice smbusdev;
> > > -    void *data;
> > > +    uint8_t data[SMBUS_EEPROM_SIZE];
> > > +    void *init_data;
> > >       uint8_t offset;
> > > +    bool accessed;
> > >   } SMBusEEPROMDevice;
> > >   static uint8_t eeprom_receive_byte(SMBusDevice *dev)
> > > @@ -49,6 +52,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *d=
ev)
> > >       uint8_t *data =3D eeprom->data;
> > >       uint8_t val =3D data[eeprom->offset++];
> > > +    eeprom->accessed =3D true;
> > >   #ifdef DEBUG
> > >       printf("eeprom_receive_byte: addr=3D0x%02x val=3D0x%02x\n",
> > >              dev->i2c.address, val);
> > > @@ -61,6 +65,7 @@ static int eeprom_write_data(SMBusDevice *dev, ui=
nt8_t *buf, uint8_t len)
> > >       SMBusEEPROMDevice *eeprom =3D SMBUS_EEPROM(dev);
> > >       uint8_t *data =3D eeprom->data;
> > > +    eeprom->accessed =3D true;
> > >   #ifdef DEBUG
> > >       printf("eeprom_write_byte: addr=3D0x%02x cmd=3D0x%02x val=3D0=
x%02x\n",
> > >              dev->i2c.address, cmd, buf[0]);
> > > @@ -78,15 +83,39 @@ static int eeprom_write_data(SMBusDevice *dev, =
uint8_t *buf, uint8_t len)
> > >       return 0;
> > >   }
> > > +static bool smbus_eeprom_vmstate_needed(void *opaque)
> > > +{
> > > +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> > > +    SMBusEEPROMDevice *eeprom =3D opaque;
> > > +
> > > +    return (eeprom->accessed || smbus_vmstate_needed(&eeprom->smbu=
sdev)) &&
> > > +        !mc->smbus_no_migration_support;
> > That's a little complx, but OK.
> >=20
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_smbus_eeprom =3D {
> > > +    .name =3D "smbus-eeprom",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .needed =3D smbus_eeprom_vmstate_needed,
> > > +    .fields      =3D (VMStateField[]) {
> > > +        VMSTATE_SMBUS_DEVICE(smbusdev, SMBusEEPROMDevice),
> > > +        VMSTATE_UINT8_ARRAY(data, SMBusEEPROMDevice, SMBUS_EEPROM_=
SIZE),
> > > +        VMSTATE_UINT8(offset, SMBusEEPROMDevice),
> > > +        VMSTATE_BOOL(accessed, SMBusEEPROMDevice),
> > OK, good - including 'accessed' means that if we migrate a->b->c and
> > it's not changed while it's on b, then 'c' still gets the updated
> > version.
> >=20
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > >   static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
> > >   {
> > >       SMBusEEPROMDevice *eeprom =3D SMBUS_EEPROM(dev);
> > > +    memcpy(eeprom->data, eeprom->init_data, SMBUS_EEPROM_SIZE);
> > >       eeprom->offset =3D 0;
> > >   }
> > >   static Property smbus_eeprom_properties[] =3D {
> > > -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, data),
> > > +    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
> > >       DEFINE_PROP_END_OF_LIST(),
> > >   };
> > > @@ -99,6 +128,7 @@ static void smbus_eeprom_class_initfn(ObjectClas=
s *klass, void *data)
> > >       sc->receive_byte =3D eeprom_receive_byte;
> > >       sc->write_data =3D eeprom_write_data;
> > >       dc->props =3D smbus_eeprom_properties;
> > > +    dc->vmsd =3D &vmstate_smbus_eeprom;
> > >       /* Reason: pointer property "data" */
> > >       dc->user_creatable =3D false;
> > >   }
> > so from migration side:
> >=20
> >=20
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
> > > --=20
> > > 2.17.1
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
