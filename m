Received: from eggs.gnu.org ([2001:4830:134:3::10]:42745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fERnr-0001Oq-1D
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fERnm-0004y2-Hw
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:54:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fERnm-0004vk-AM
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:54:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id f18-v6so3329156lfc.5
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 20:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1519856998.git.alistair.francis@xilinx.com>
	<938a6b79c658dcdba39ed5b7f5a36806b25b655f.1519856998.git.alistair.francis@xilinx.com>
	<31e618dc-23ac-6e8a-76ed-ccad0bdc121a@amsat.org>
In-Reply-To: <31e618dc-23ac-6e8a-76ed-ccad0bdc121a@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 04 May 2018 03:54:07 +0000
Message-ID: <CAKmqyKOF4dGR01digowAfB8u4q14WWzQtJT60R48BrW0kmd+5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] xlnx-zynqmp-pmu: Connect the IOMOD
 GPI/GPO devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>

On Thu, Mar 1, 2018 at 10:03 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> On 02/28/2018 07:32 PM, Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > ---
> >
> >  hw/microblaze/xlnx-zynqmp-pmu.c | 77
+++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 75 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c
b/hw/microblaze/xlnx-zynqmp-pmu.c
> > index 35a2314ffb..fa5f0bfcf1 100644
> > --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> > +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> > @@ -27,6 +27,7 @@
> >  #include "hw/intc/xlnx-zynqmp-ipi.h"
> >  #include "hw/intc/xlnx-pmu-iomod-intc.h"
> >  #include "hw/timer/xlnx-pmu-iomod-pit.h"
> > +#include "hw/gpio/xlnx-pmu-iomod-gp.h"
> >
> >  /* Define the PMU device */
> >
> > @@ -43,6 +44,9 @@
> >  #define XLNX_ZYNQMP_PMU_NUM_IPIS    4
> >  #define XLNX_ZYNQMP_PMU_NUM_PITS    4
> >
> > +#define XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS    4
> > +#define XLNX_ZYNQMP_PMU_NUM_IOMOD_GPOS    4
> > +
> >  static const uint64_t ipi_addr[XLNX_ZYNQMP_PMU_NUM_IPIS] =3D {
> >      0xFF340000, 0xFF350000, 0xFF360000, 0xFF370000,
> >  };
> > @@ -57,6 +61,17 @@ static const uint64_t
pit_irq[XLNX_ZYNQMP_PMU_NUM_PITS] =3D {
> >      3, 4, 5, 6,
> >  };
> >
> > +static const uint64_t iomod_gpi_addr[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS] =
=3D
{
> > +    0xFFD40020, 0xFFD40024, 0xFFD40028, 0xFFD4002C,
> > +};
> > +static const uint64_t iomod_gpi_irq[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS] =
=3D {
> > +    11, 12, 13, 14,
> > +};
> > +
> > +static const uint64_t iomod_gpo_addr[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPOS] =
=3D
{
> > +    0xFFD40010, 0xFFD40014, 0xFFD40018, 0xFFD4001C,
> > +};
> > +
> >  typedef struct XlnxZynqMPPMUSoCState {
> >      /*< private >*/
> >      DeviceState parent_obj;
> > @@ -156,6 +171,8 @@ static void xlnx_zynqmp_pmu_init(MachineState
*machine)
> >      MemoryRegion *pmu_rom =3D g_new(MemoryRegion, 1);
> >      MemoryRegion *pmu_ram =3D g_new(MemoryRegion, 1);
> >      XlnxZynqMPIPI *ipi[XLNX_ZYNQMP_PMU_NUM_IPIS];
> > +    XlnxPMUIOGPIO *iomod_gpi[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS];
> > +    XlnxPMUIOGPIO *iomod_gpo[XLNX_ZYNQMP_PMU_NUM_IOMOD_GPOS];
> >      XlnxPMUPIT *pit[XLNX_ZYNQMP_PMU_NUM_PITS];
> >      qemu_irq irq[32];
> >      qemu_irq tmp_irq;
> > @@ -197,10 +214,60 @@ static void xlnx_zynqmp_pmu_init(MachineState
*machine)
> >          sysbus_connect_irq(SYS_BUS_DEVICE(ipi[i]), 0, irq[ipi_irq[i]])=
;
> >      }
> >
> > +    /* Create and connect the IOMOD GPI device */
> > +    for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS; i++) {
> > +        iomod_gpi[i] =3D g_new0(XlnxPMUIOGPIO, 1);
> > +        object_initialize(iomod_gpi[i], sizeof(XlnxPMUIOGPIO),
> > +                          TYPE_XLNX_ZYNQMP_IOMOD_GPIO);
> > +        qdev_set_parent_bus(DEVICE(iomod_gpi[i]),
sysbus_get_default());
> > +    }
> > +
> > +    for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IOMOD_GPIS; i++) {
> > +        object_property_set_bool(OBJECT(iomod_gpi[i]), true, "input",
> > +                                 &error_abort);
> > +        object_property_set_uint(OBJECT(iomod_gpi[i]), 0x20, "size",
> > +                                 &error_abort);

> I previously misread this, you are initializing the 4 GPIs as GPI0, it
> may be cleaner to add an index property to select the correct GPI
> RegisterAccessInfo, or add a 'reserved' bitmask property and use a
> generic GPI.
> In particular GPI3 is read-only.

I'm not sure what you mean here.

Alistair
