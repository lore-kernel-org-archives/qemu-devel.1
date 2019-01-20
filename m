Received: from eggs.gnu.org ([209.51.188.92]:54236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glDoc-00051P-7p
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glDob-000541-C7
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 09:11:10 -0500
MIME-Version: 1.0
References: <20190110094020.18354-1-stefanha@redhat.com>
	<20190110094020.18354-2-stefanha@redhat.com>
	<CAFEAcA9aypaAyroky0xpFzTUWp4PksqW17O8gkub2rLkS8o=ZQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9aypaAyroky0xpFzTUWp4PksqW17O8gkub2rLkS8o=ZQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 20 Jan 2019 14:10:55 +0000
Message-ID: <CAJSP0QXytC=y-rjuRahU0Whgm2x1mvRcvTZS7=yKHCVrMUSNNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] arm: Stub out NRF51 TWI
 magnetometer/accelerometer detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>

On Fri, Jan 18, 2019 at 1:59 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Thu, 10 Jan 2019 at 09:40, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> >
> > Recent microbit firmwares panic if the TWI magnetometer/accelerometer
> > devices are not detected during startup.  We don't implement TWI (I2C)
> > so let's stub out these devices just to let the firmware boot.
> >
>
> > --- a/hw/arm/microbit.c
> > +++ b/hw/arm/microbit.c
> > @@ -16,11 +16,13 @@
> >  #include "exec/address-spaces.h"
> >
> >  #include "hw/arm/nrf51_soc.h"
> > +#include "hw/i2c/microbit_i2c.h"
> >
> >  typedef struct {
> >      MachineState parent;
> >
> >      NRF51State nrf51;
> > +    MicrobitI2CState i2c;
> >  } MicrobitMachineState;
> >
> >  #define TYPE_MICROBIT_MACHINE MACHINE_TYPE_NAME("microbit")
> > @@ -32,7 +34,9 @@ static void microbit_init(MachineState *machine)
> >  {
> >      MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
> >      MemoryRegion *system_memory =3D get_system_memory();
> > +    MemoryRegion *mr;
> >      Object *soc =3D OBJECT(&s->nrf51);
> > +    Object *i2c =3D OBJECT(&s->i2c);
> >
> >      sysbus_init_child_obj(OBJECT(machine), "nrf51", soc, sizeof(s->nrf=
51),
> >                            TYPE_NRF51_SOC);
> > @@ -41,6 +45,17 @@ static void microbit_init(MachineState *machine)
> >                               &error_fatal);
> >      object_property_set_bool(soc, true, "realized", &error_fatal);
> >
> > +    /* Overlap the TWI stub device into the SoC.  This is a microbit-s=
pecific
> > +     * hack until we implement the nRF51 TWI controller properly and t=
he
> > +     * magnetometer/accelerometer devices.
> > +     */
> > +    sysbus_init_child_obj(OBJECT(machine), "microbit.twi", i2c,
> > +                          sizeof(s->i2c), TYPE_MICROBIT_I2C);
> > +    object_property_set_bool(i2c, true, "realized", &error_fatal);
> > +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(i2c), 0);
> > +    memory_region_add_subregion_overlap(&s->nrf51.container, NRF51_TWI=
_BASE,
> > +                                        mr, -1);
>
> This is an SoC device, right? Why are we creating it here
> in the board code rather than in the SoC object's code ?

Yes, this is a microbit-specific hack.  We don't implement a full
TWI/I2C bus for the nRF51 SoC.  This implementation is just aimed at
stubbing out the microbit-specific accelerometer/magnetometer devices.

Therefore I decided it was cleanest to place it in the microbit
machine type instead of dirtying the nRF51 SoC with a microbit hack.

If the I2C passthrough GSoC 2019 project happens we'll get proper
nRF51 TWI/I2C controller emulation and can eliminate this stub.  But
for now this allows the microbit to boot and doesn't mess up any other
potential machine types that will use the nRF51 SoC.

Stefan
