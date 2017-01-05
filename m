Received: from eggs.gnu.org ([2001:4830:134:3::10]:45800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cPF79-0002ea-Pq
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cPF74-0002rk-UJ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:58:23 -0500
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<1483049536-21548-5-git-send-email-hpoussin@reactos.org>
	<20170103044529.GP12761@umbus.fritz.box>
	<be8ddafc-de53-325b-9acf-4c31214a6dc9@reactos.org>
	<20170105004116.GB13763@umbus.fritz.box>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <98e3e4bf-dfe9-44a1-2c1e-31b1a7ea6e7b@reactos.org>
Date: Thu, 5 Jan 2017 21:57:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170105004116.GB13763@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] prep: QOM'ify System I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>

Le 05/01/2017 =E0 01:41, David Gibson a =E9crit :
> On Wed, Jan 04, 2017 at 10:17:10PM +0100, Herv=E9 Poussineau wrote:
>> Le 03/01/2017 =E0 05:45, David Gibson a =E9crit :
>>> On Thu, Dec 29, 2016 at 11:12:14PM +0100, Herv=E9 Poussineau wrote:
>>>> Part of the functionality is copied from hw/ppc/prep.c.
>>>> Also add support for board identification/equipment registers.
>>>>
>>>> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
>>>> ---
>>>>  hw/ppc/Makefile.objs   |   1 +
>>>>  hw/ppc/prep_systemio.c | 302 ++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>>>  hw/ppc/trace-events    |   4 +
>>>>  3 files changed, 307 insertions(+)
>>>>  create mode 100644 hw/ppc/prep_systemio.c
>>>>
>>>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>>>> index 8025129..db72297 100644
>>>> --- a/hw/ppc/Makefile.objs
>>>> +++ b/hw/ppc/Makefile.objs
>>>> @@ -16,6 +16,7 @@ obj-y +=3D ppc405_boards.o ppc4xx_devs.o ppc405_uc=
.o ppc440_bamboo.o
>>>>  obj-y +=3D ppc4xx_pci.o
>>>>  # PReP
>>>>  obj-$(CONFIG_PREP) +=3D prep.o
>>>> +obj-$(CONFIG_PREP) +=3D prep_systemio.o
>>>>  # OldWorld PowerMac
>>>>  obj-$(CONFIG_MAC) +=3D mac_oldworld.o
>>>>  # NewWorld PowerMac
>>>> diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
>>>> new file mode 100644
>>>> index 0000000..449056c
>>>> --- /dev/null
>>>> +++ b/hw/ppc/prep_systemio.c
>>>> @@ -0,0 +1,302 @@
>>>> +/*
>>>> + * QEMU PReP System I/O emulation
>>>> + *
>>>> + * Copyright (c) 2016 Herve Poussineau
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person obta=
ining a copy
>>>> + * of this software and associated documentation files (the "Softwa=
re"), to deal
>>>> + * in the Software without restriction, including without limitatio=
n the rights
>>>> + * to use, copy, modify, merge, publish, distribute, sublicense, an=
d/or sell
>>>> + * copies of the Software, and to permit persons to whom the Softwa=
re is
>>>> + * furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be i=
ncluded in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVEN=
T SHALL
>>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGE=
S OR OTHER
>>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,
>>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DE=
ALINGS IN
>>>> + * THE SOFTWARE.
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/isa/isa.h"
>>>> +#include "exec/address-spaces.h"
>>>> +#include "qemu/error-report.h" /* for error_report() */
>>>> +#include "sysemu/sysemu.h" /* for vm_stop() */
>>>> +#include "cpu.h"
>>>> +#include "trace.h"
>>>> +
>>>> +#define TYPE_PREP_SYSTEMIO "prep-systemio"
>>>> +#define PREP_SYSTEMIO(obj) \
>>>> +    OBJECT_CHECK(PrepSystemIoState, (obj), TYPE_PREP_SYSTEMIO)
>>>> +
>>>> +/* Bit as defined in PowerPC Reference Plaform v1.1, sect. 6.1.5, p=
. 132 */
>>>> +#define PREP_BIT(n) (1 << (7 - (n)))
>>>> +
>>>> +typedef struct PrepSystemIoState {
>>>> +    ISADevice parent_obj;
>>>> +    MemoryRegion ppc_parity_mem;
>>>> +
>>>> +    qemu_irq non_contiguous_io_map_irq;
>>>> +    uint8_t sreset; /* 0x0092 */
>>>> +    uint8_t equipment; /* 0x080c */
>>>> +    uint8_t system_control; /* 0x081c */
>>>> +    uint8_t iomap_type; /* 0x0850 */
>>>> +    uint8_t ibm_planar_id; /* 0x0852 */
>>>> +    qemu_irq softreset_irq;
>>>> +    PortioList portio;
>>>> +} PrepSystemIoState;
>>>> +
>>>> +/* PORT 0092 -- Special Port 92 (Read/Write) */
>>>> +
>>>> +enum {
>>>> +    PORT0092_SOFTRESET  =3D PREP_BIT(7),
>>>> +    PORT0092_LE_MODE    =3D PREP_BIT(6),
>>>> +};
>>>> +
>>>> +static void prep_port0092_write(void *opaque, uint32_t addr, uint32=
_t val)
>>>> +{
>>>> +    PrepSystemIoState *s =3D opaque;
>>>> +
>>>> +    trace_prep_systemio_write(addr, val);
>>>> +
>>>> +    if ((val & PORT0092_SOFTRESET) !=3D 0) {
>>>> +        qemu_irq_raise(s->softreset_irq);
>>>> +        s->sreset =3D 1;
>>>> +    } else {
>>>> +        qemu_irq_lower(s->softreset_irq);
>>>> +        s->sreset =3D 0;
>>>
>>> You could just use
>>> 	s->sreset =3D val & PORT0092_SOFTRESET;
>>> 	qemu_set_irq(irq, s->sreset);
>>> here, rather than the if.
>>
>> OK
>>
>>>
>>>> +    }
>>>> +
>>>> +    if ((val & PORT0092_LE_MODE) !=3D 0) {
>>>> +        /* XXX Not supported yet */
>>>> +        error_report("little-endian mode not supported");
>>>> +        vm_stop(RUN_STATE_PAUSED);
>>>> +    } else {
>>>> +        /* Nothing to do */
>>>> +    }
>>>> +}
>>>> +
>>>> +static uint32_t prep_port0092_read(void *opaque, uint32_t addr)
>>>> +{
>>>> +    PrepSystemIoState *s =3D opaque;
>>>> +    /* XXX LE mode unsupported */
>>>> +    trace_prep_systemio_read(addr, 0);
>>>> +    return s->sreset;
>>>
>>> This doesn't seem to quite logically match the write side.  On the
>>> write side you convert the PORT0092_SOFTRESET bit into an explicit
>>> 0/1, here you return the raw 0/1.  It ends up being the same thing
>>> because PORT0092_SOFTRESET =3D=3D 0x01, but that's not terribly obvio=
us.
>>
>> OK, will change that.
>>
>>>
>>>> +}
>>>> +
>>>> +/* PORT 0808 -- Hardfile Light Register (Write Only) */
>>>> +
>>>> +enum {
>>>> +    PORT0808_HARDFILE_LIGHT_ON  =3D PREP_BIT(7),
>>>> +};
>>>> +
>>>> +static void prep_port0808_write(void *opaque, uint32_t addr, uint32=
_t val)
>>>> +{
>>>> +    trace_prep_systemio_write(addr, val);
>>>> +}
>>>> +
>>>> +/* PORT 0810 -- Password Protect 1 Register (Write Only) */
>>>> +
>>>> +/* reset by port 0x4D in the SIO */
>>>> +static void prep_port0810_write(void *opaque, uint32_t addr, uint32=
_t val)
>>>> +{
>>>> +    trace_prep_systemio_write(addr, val);
>>>> +}
>>>> +
>>>> +/* PORT 0812 -- Password Protect 2 Register (Write Only) */
>>>> +
>>>> +/* reset by port 0x4D in the SIO */
>>>> +static void prep_port0812_write(void *opaque, uint32_t addr, uint32=
_t val)
>>>> +{
>>>> +    trace_prep_systemio_write(addr, val);
>>>> +}
>>>> +
>>>> +/* PORT 0814 -- L2 Invalidate Register (Write Only) */
>>>> +
>>>> +static void prep_port0814_write(void *opaque, uint32_t addr, uint32=
_t val)
>>>> +{
>>>> +    trace_prep_systemio_write(addr, val);
>>>> +}
>>>> +
>>>> +/* PORT 0818 -- Reserved for Keylock (Read Only) */
>>>> +
>>>> +enum {
>>>> +    PORT0818_KEYLOCK_SIGNAL_HIGH    =3D PREP_BIT(7),
>>>> +};
>>>> +
>>>> +static uint32_t prep_port0818_read(void *opaque, uint32_t addr)
>>>> +{
>>>> +    uint32_t val =3D 0;
>>>> +    trace_prep_systemio_read(addr, val);
>>>> +    return val;
>>>> +}
>>>> +
>>>> +/* PORT 080C -- Equipment */
>>>> +
>>>> +enum {
>>>> +    PORT080C_SCSIFUSE               =3D PREP_BIT(1),
>>>> +    PORT080C_L2_COPYBACK            =3D PREP_BIT(4),
>>>> +    PORT080C_L2_256                 =3D PREP_BIT(5),
>>>> +    PORT080C_UPGRADE_CPU            =3D PREP_BIT(6),
>>>> +    PORT080C_L2                     =3D PREP_BIT(7),
>>>> +};
>>>> +
>>>> +static uint32_t prep_port080c_read(void *opaque, uint32_t addr)
>>>> +{
>>>> +    PrepSystemIoState *s =3D opaque;
>>>> +    trace_prep_systemio_read(addr, s->equipment);
>>>> +    return s->equipment;
>>>> +}
>>>> +
>>>> +/* PORT 081C -- System Control Register (Read/Write) */
>>>> +
>>>> +enum {
>>>> +    PORT081C_FLOPPY_MOTOR_INHIBIT   =3D PREP_BIT(3),
>>>> +    PORT081C_MASK_TEA               =3D PREP_BIT(2),
>>>> +    PORT081C_L2_UPDATE_INHIBIT      =3D PREP_BIT(1),
>>>> +    PORT081C_L2_CACHEMISS_INHIBIT   =3D PREP_BIT(0),
>>>> +};
>>>> +
>>>> +static void prep_port081c_write(void *opaque, uint32_t addr, uint32=
_t val)
>>>> +{
>>>> +    PrepSystemIoState *s =3D opaque;
>>>> +    trace_prep_systemio_write(addr, val);
>>>> +    s->system_control =3D val;
>>>
>>> Should this value be masked to restrict it to the valid bits?
>>
>> Some bits are reserved according to specification, and must be
>> written as 0.
>
> Right, so I assumed.
>
>> I think we can still take them unconditionally.
>
> Hrm.. allowing reserved bits to be set and retrieved is usually a bad
> idea.  Do you have a particular reason to allow this?

Not much. I've changed it to ignore reserved bits in write handler, so th=
ey are read back as 0.

Herv=E9
