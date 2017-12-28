Received: from eggs.gnu.org ([2001:4830:134:3::10]:33431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eUXpa-00051Q-WB
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 08:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eUXpX-0005cq-Rn
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 08:02:43 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:24797)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eUXpX-0005aT-D8
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 08:02:39 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Thu, 28 Dec 2017 14:02:04 +0100
References: <6f7f4691-1755-d4bd-5f38-6f2e3cc3be17@rempel-privat.de>
	<aec8d44e-114d-0dc4-8697-ba9c078f2c00@rempel-privat.de>
	<201712111524.13653.pisa@cmp.felk.cvut.cz>
In-Reply-To: <201712111524.13653.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201712281402.05139.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] QEMU CAN bus work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org, Konrad Frederic <frederic.konrad@adacore.com>

Hello Oleksij and Philippe,

I have found some time to update QEMU CAN
patch series and test it with actual QEMU master.

As QEMU 2.11 is realeased now, I hope that
it is time to disscuss integration of initial/simple
CAN bus emulation now.

The actual version can be found on branch
can-pci in our faculty GitLab

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus

I have followed SJA1000 manual to implement (hopefully)
complete logic in can_sja_accept_filter().
Linux driver in standard setup does not use
it to limit range of received messages
so the functionality is not so important.
But because can_bus_client_set_filters()
is not implemented in QEMU CAN core yet as well.
SJA1000 filters handling is quite specific anyway
so keep exact final filtering in SJA1000 code
is reasonable if used by some guest drivers
in futire.

I have followed Philippe's comments where
I have no questions.

I hope I find some time in January to follow
development and Oleksij has offered some time
as well.

On Thursday 02 of November 2017 02:53:46 Philippe Mathieu-Daud=C3=A9 wrote:
> - separate CAN bus emulation core functions and connection to Linux
> SocketCAN host (as suggested by Frederic Konrad).

> Hmm Id rather start having this part in hw/can/linux_socketcan.c but
> this can indeed be moved later.
>

Yes that is the right solution and relatively easy
if I get hint how should the commandline look like.

The host connection is (can be) part of device specification now

  -device kvaser_pci,canbus=3Dcanbus0,host=3Dcan0

The concept of bus works so it is possible to connect
multiple QOM devices to it and host interface can be
reimplemented as QOM object too. So I have no problem
change setup to something like

  -device kvaser_pci,canbus=3Dcanbus0 \
  -device can_to_host,canbus=3Dcanbus0,host=3Dcan0

or some other syntax. I am not sure if such infrastructure
object should be organized under "device" and what is the
best parent for such object, it should not be "PCIDevice"
for sure.

What is order of calling of QOM object methods?

If I do something like=20

  type_init(can_socketcan_host_register_types)

it it is quaranteed that some class init method is called
before other class properties are delivered into

  kvaser_pci_init(PCIDevice *pci_dev)

Because if that is a case then I can call
some registering of default host interface from

  can_socketcan_host_register_types

type/class initialization registration before=20
Kvaser PCI instance is called and reads host
property.

This way can be preserved even simpler single "device"
parameter initialization even after separation
of host connection to another object and source file.

> > diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> > index e514bdef42..bbe11887a1 100644
> > --- a/default-configs/pci.mak
> > +++ b/default-configs/pci.mak
> > @@ -31,6 +31,7 @@ CONFIG_ESP_PCI=3Dy
> >  CONFIG_SERIAL=3Dy
> >  CONFIG_SERIAL_ISA=3Dy
> >  CONFIG_SERIAL_PCI=3Dy
> > +CONFIG_CAN_CORE=3Dy
>
> CAN Bus is not PCI specific, your model (MF624) uses the PCI.
>
> This looks weird to me here, but why not.
>

I have seen that others devices classes (which do not have
their own top level make and are used on PCI only for now)
use this solution as well. But if there is better option then
I would follow it.

> > +#else /*__linux__*/
> > +int can_bus_connect_to_host_device(CanBusState *bus, const char *name)
> > +{
> > +    error_report("CAN bus connect to host device not supported on this
> > system"); +    exit(1);
> > +}
>
> This would be normally be in 'can-stubs.c'
>
> > +#endif /*__linux__*/

Stub and ifdefs are not required if host support is separated.

> > diff --git a/include/can/can_emu.h b/include/can/can_emu.h
> > new file mode 100644
> > index 0000000000..86b35aef32
> > --- /dev/null
> > +++ b/include/can/can_emu.h
> > @@ -0,0 +1,133 @@
> > +/*

> > +#ifndef NET_CAN_EMU_H
> > +#define NET_CAN_EMU_H
> > +
> > +#include "qemu/queue.h"
> > +
> > +/* NOTE: the following two structures is copied from <linux/can.h>. */
> > +
>
> maybe you can import it in include/standard-headers/
>
> (see scripts/update-linux-headers.sh)
>
> > +/*

> > + * The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it
> > can + * filter for error message frames (CAN_ERR_FLAG bit set in mask).=
 +
> > */
> > +typedef struct qemu_can_filter {
> > +    qemu_canid_t    can_id;
> > +    qemu_canid_t    can_mask;
> > +} qemu_can_filter;
> > +
> > +#define CAN_INV_FILTER 0x20000000U /* to be set in
> > qemu_can_filter.can_id */
>
> ^ this part should go in "include/hw/can/can.h"
>
> and the following in "include/sysemu/can.h"?
>

I am not sure if hard fixing of QEMU CAN frame format to Linux
one is an optimal solution. I have introduced new defines
with QEMU_CAN_ as temporal solution and to document
two meaning of the defines and structures still
in can_emu.h

#define QEMU_CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
#define QEMU_CAN_RTR_FLAG 0x40000000U /* remote transmission request */
#define QEMU_CAN_ERR_FLAG 0x20000000U /* error message frame */

#define QEMU_CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
#define QEMU_CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */

and have added asserts in socketcan specific code which
has to see Linux definitions to check that they are the same
for now

    /* Check that QEMU and Linux kernel flags encoding matches */
    assert(QEMU_CAN_EFF_FLAG =3D=3D CAN_EFF_FLAG);
    assert(QEMU_CAN_RTR_FLAG =3D=3D CAN_RTR_FLAG);
    assert(QEMU_CAN_ERR_FLAG =3D=3D CAN_ERR_FLAG);

    assert(QEMU_CAN_INV_FILTER =3D=3D CAN_INV_FILTER);

It is possible to do there transformation if they change/diverge
in future and flags and whole message format transformation is necessary
for other host systems anyway. There are many other CAN APIs even for
Linux (Peak etc.). It is great that Linux is heading to consolidation
but it is Linux case only.

I would appreciate suggestions what should go to which header
file and how to maintain functionality in long term.

I hope to find time to prepare and submit updated patch
series in January. I am heading to mountains to rest
a little now till January 2.

Best wishes and strong health to you and your bellowed,
happy New year,

Pavel
