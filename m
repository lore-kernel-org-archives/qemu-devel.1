Received: from eggs.gnu.org ([2001:4830:134:3::10]:47301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMAO5-000504-Ot
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMAO1-0002zh-5c
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:41 -0500
Date: Tue, 5 Dec 2017 18:00:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205070004.GL3057@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-20-clg@kaod.org>
	<20171201040115.GC30161@umbus.fritz.box>
	<02120b7e-cd8b-af61-7d35-8289253828f6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline
In-Reply-To: <02120b7e-cd8b-af61-7d35-8289253828f6@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 19/25] spapr: add hcalls support for the
 XIVE interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 06:46:45PM +0100, C=E9dric Le Goater wrote:
> On 12/01/2017 05:01 AM, David Gibson wrote:
> > On Thu, Nov 23, 2017 at 02:29:49PM +0100, C=E9dric Le Goater wrote:
> >> A set of Hypervisor's call are used to configure the interrupt sources
> >> and the event/notification queues of the guest:
> >>
> >>  - H_INT_GET_SOURCE_INFO
> >>
> >>    used to obtain the address of the MMIO page of the Event State
> >>    Buffer (PQ bits) entry associated with the source.
> >>
> >>  - H_INT_SET_SOURCE_CONFIG
> >>
> >>    assigns a source to a "target".
> >>
> >>  - H_INT_GET_SOURCE_CONFIG
> >>
> >>    determines to which "target" and "priority" is assigned to a source
> >>
> >>  - H_INT_GET_QUEUE_INFO
> >>
> >>    returns the address of the notification management page associated
> >>    with the specified "target" and "priority".
> >>
> >>  - H_INT_SET_QUEUE_CONFIG
> >>
> >>    sets or resets the event queue for a given "target" and "priority".
> >>    It is also used to set the notification config associated with the
> >>    queue, only unconditional notification for the moment.  Reset is
> >>    performed with a queue size of 0 and queueing is disabled in that
> >>    case.
> >>
> >>  - H_INT_GET_QUEUE_CONFIG
> >>
> >>    returns the queue settings for a given "target" and "priority".
> >>
> >>  - H_INT_RESET
> >>
> >>    resets all of the partition's interrupt exploitation structures to
> >>    their initial state, losing all configuration set via the hcalls
> >>    H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
> >>
> >>  - H_INT_SYNC
> >>
> >>    issue a synchronisation on a source to make sure sure all
> >>    notifications have reached their queue.
> >>
> >> Calls that still need to be addressed :
> >>
> >>    H_INT_SET_OS_REPORTING_LINE
> >>    H_INT_GET_OS_REPORTING_LINE
> >>
> >> See the code for more documentation on each hcall.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/Makefile.objs       |   2 +-
> >>  hw/intc/spapr_xive_hcall.c  | 885 +++++++++++++++++++++++++++++++++++=
+++++++++
> >>  hw/ppc/spapr.c              |   2 +
> >>  include/hw/ppc/spapr.h      |  15 +-
> >>  include/hw/ppc/spapr_xive.h |   4 +
> >>  5 files changed, 906 insertions(+), 2 deletions(-)
> >>  create mode 100644 hw/intc/spapr_xive_hcall.c
> >>
> >> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> >> index 49e13e7aeeee..122e2ec77e8d 100644
> >> --- a/hw/intc/Makefile.objs
> >> +++ b/hw/intc/Makefile.objs
> >> @@ -35,7 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
> >>  obj-$(CONFIG_XICS) +=3D xics.o
> >>  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
> >>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
> >> -obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
> >> +obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o spapr_xive_hcall.o
> >>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
> >>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
> >>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
> >> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
> >> new file mode 100644
> >> index 000000000000..676fe0e2d5c7
> >> --- /dev/null
> >> +++ b/hw/intc/spapr_xive_hcall.c
> >> @@ -0,0 +1,885 @@
> >> +/*
> >> + * QEMU PowerPC sPAPR XIVE model
> >> + *
> >> + * Copyright (c) 2017, IBM Corporation.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy
> >> + * it under the terms of the GNU General Public License, version 2, as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, see <http://www.gnu.org/licenses/=
>.
> >> + */
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/log.h"
> >> +#include "qapi/error.h"
> >> +#include "cpu.h"
> >> +#include "hw/ppc/spapr.h"
> >> +#include "hw/ppc/spapr_xive.h"
> >> +#include "hw/ppc/fdt.h"
> >> +#include "monitor/monitor.h"
> >> +
> >> +#include "xive-internal.h"
> >> +
> >> +/* Priority ranges reserved by the hypervisor. The Linux driver is
> >> + * expected to choose priority 6.
> >> + */
> >> +static const uint32_t reserved_priorities[] =3D {
> >> +    7,    /* start */
> >> +    0xf8, /* count */
> >> +};
> >> +
> >> +static bool priority_is_valid(uint32_t priority)
> >> +{
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < ARRAY_SIZE(reserved_priorities) / 2; i++) {
> >> +        uint32_t base  =3D reserved_priorities[2 * i];
> >> +        uint32_t count =3D reserved_priorities[2 * i + 1];
> >> +
> >> +        if (priority >=3D base && priority < base + count) {
> >> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: priority %d is reserv=
ed\n",
> >> +                          __func__, priority);
> >> +            return false;
> >> +        }
> >> +    }
> >> +
> >> +    return true;
> >> +}
> >=20
> > This seems like overkill.  Aren't there only 0..7 levels supported in
> > hardware, in which case a one byte bitmap will suffice to store the
> > reserved levels.
>=20
> I was trying the use the same array that will be exposed in the device
> tree in the "ibm,plat-res-int-priorities" property, defined as=20
> follow in PAPR:
>=20
> 	property name that designates to the client program that the
> 	platform has reserved one or more interrupt priorities for its
> 	own use.
> =09
> 	prop-encoded-value: one or more (interrupt priority, range)
> 	pairs, where interrupt priority is a single cell hexidec- imal
> 	number between 0x00 and 0xFF, and range is an integer encoded as
> 	with encode-int that represents the number of contiguous
> 	interrupt priorities that have been reserved by the platform for
> 	its internal use.
>=20
>=20
> But I agree, it's a bit overkill to check for 0..7 levels ...

Ok, I do see the point here.  Hmm.. not sure where best to go with
this.  One source of data is always good, and this is probably less
complex than deriving the DT list from a bitmap.

On the other hand I am wary these days of over-generalizing, since it
can lead to nightmares for migration consistency.

> > To check my understanding again, if you're running this with KVM, the
> > host kernel and qemu will need to agree on which are the reserved
> > levels, yes?
>=20
> Hmm, these values are quite static. So I don't think there will be=20
> any sort of exchange between KVM and QEMU to define the range to=20
> expose to the guest.=20
>=20
> For the moment, Linux only uses one priority, the lowest, and Ben
> has introduced in OPAL an automatic interrupt escalation feature
> using queue 7 for all other queues (DD2.0 cpus). So we only expose=20
> range 0..6 to the guest for this purpose.
>=20
> So we agreed orally.

Ok, that's fine, just making sure I understand the situation.
> >> +static target_ulong h_int_get_source_info(PowerPCCPU *cpu,
> >> +                                          sPAPRMachineState *spapr,
> >> +                                          target_ulong opcode,
> >> +                                          target_ulong *args)
> >> +{
> >> +    sPAPRXive *xive =3D spapr->xive;
> >> +    XiveIVE *ive;
> >> +    target_ulong flags  =3D args[0];
> >> +    target_ulong lisn   =3D args[1];
> >> +    uint64_t mmio_base;
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >=20
> > Is H_FUNCTION required by the PAPR ACRs here? =20
>=20
> yes. quoting the specs :
>=20
> 	/* H_Function: The calling OS is not in exploitation mode */
>=20
> I need to review once more all of the return errors but, last time
> I checked they looked sane.=20

Ok.

> > Usually we only use
> > H_FUNCTION if the hypercall doesn't exist at all, and if unavailable
> > for other reasons use H_AUTHORITY or something.
> >=20
> >> +    }
> >> +
> >> +    if (flags) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    ive =3D spapr_xive_get_ive(spapr->xive, lisn);
> >> +    if (!ive || !(ive->w & IVE_VALID)) {
> >> +        return H_P2;
> >> +    }
> >> +
> >> +    mmio_base =3D (uint64_t)xive->esb_base + (1ull << xive->esb_shift=
) * lisn;
> >=20
> > Hrm.. why was xive->esb_base not already a u64?
>=20
> its an 'hwaddr'. Yes I can remove it.

Right.  mmio_base should be a hwaddr too, so you shouldn't need a cast.

> >> +    args[0] =3D 0;
> >> +    if (spapr_xive_irq_is_lsi(xive, lisn)) {
> >> +        args[0] |=3D XIVE_SRC_LSI;
> >> +    }
> >> +    if (xive->flags & XIVE_SRC_TRIGGER) {
> >> +        args[0] |=3D XIVE_SRC_TRIGGER;
> >> +    }
> >> +
> >> +    if (xive->flags & XIVE_SRC_H_INT_ESB) {
>=20
> btw, this is why I have the ->flags field. Do you still want me to=20
> remove it ? because I would like to keep the logic below. No big=20
> deal if not.
>=20
> >> +        args[1] =3D -1; /* never used in QEMU  */
> >> +        args[2] =3D -1;
> >> +    } else {
> >> +        args[1] =3D mmio_base;
> >> +        if (xive->flags & XIVE_SRC_TRIGGER) {
> >> +            args[2] =3D -1; /* No specific trigger page */
> >> +        } else {
> >> +            args[2] =3D -1; /* TODO: support for specific trigger pag=
e */
> >> +        }
> >> +    }
> >=20
> > What does the availability of SRC_TRIGGER (and INT_ESB) depend on?=20
>=20
> The CPU revision. But we won't introduce XIVE exploitation mode on=20
> anything else than DD2.0 which has full XIVE support. Even STORE_EOI=20
> that we should be adding.

Hrm.  Host CPU?  That's a problem - if guest visible properties like
this vary with the host CPU, migration breaks.

>=20
> > If it varies with host capabilities, that's going to be real pain for
> > migration.
>=20
> Yes. I am not aware of any future extension but I agree this is
> something we need to keep an eye on.

I'm not talking about future extension, I'm meaning right now.

> =20
> >> +
> >> +    args[3] =3D xive->esb_shift;
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_SET_SOURCE_CONFIG hcall() is used to assign a Logical
> >> + * Interrupt Source to a target. The Logical Interrupt Source is
> >> + * designated with the "lisn" parameter and the target is designated
> >> + * with the "target" and "priority" parameters.  Upon return from the
> >> + * hcall(), no additional interrupts will be directed to the old EQ.
> >> + *
> >> + * TODO: The old EQ should be investigated for interrupts that
> >> + * occurred prior to or during the hcall().
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-61: Reserved
> >> + *      Bit 62: set the "eisn" in the EA
> >> + *      Bit 63: masks the interrupt source in the hardware interrupt
> >> + *      control structure. An interrupt masked by this mechanism will
> >> + *      be dropped, but it's source state bits will still be
> >> + *      set. There is no race-free way of unmasking and restoring the
> >> + *      source. Thus this should only be used in interrupts that are
> >> + *      also masked at the source, and only in cases where the
> >> + *      interrupt is not meant to be used for a large amount of time
> >> + *      because no valid target exists for it for example
> >> + * - "lisn" is per "interrupts", "interrupt-map", or
> >> + *      "ibm,xive-lisn-ranges" properties, or as returned by the
> >> + *      ibm,query-interrupt-source-number RTAS call, or as returned by
> >> + *      the H_ALLOCATE_VAS_WINDOW hcall
> >> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> >> + *      "ibm,ppc-interrupt-gserver#s"
> >> + * - "priority" is a valid priority not in
> >> + *      "ibm,plat-res-int-priorities"
> >> + * - "eisn" is the guest EISN associated with the "lisn"
> >> + *
> >> + * Output:
> >> + * - None
> >> + */
> >> +
> >> +#define XIVE_SRC_SET_EISN (1ull << (63 - 62))
> >> +#define XIVE_SRC_MASK     (1ull << (63 - 63))
> >=20
> > Aren't there already a bunch of macros you have for defining things in
> > terms of IBM bit numbers, so you can avoid open coding (63 - whatever).
>=20
> Yes.=20
>=20
> On that topic, could we include the PPC_BIT* macros somewhere under ppc ?=
=20

Uh, sure, why not. target/ppc/cpu.h seems the logical place.

> >> +
> >> +static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
> >> +                                            sPAPRMachineState *spapr,
> >> +                                            target_ulong opcode,
> >> +                                            target_ulong *args)
> >> +{
> >> +    XiveIVE *ive;
> >> +    uint64_t new_ive;
> >> +    target_ulong flags    =3D args[0];
> >> +    target_ulong lisn     =3D args[1];
> >> +    target_ulong target   =3D args[2];
> >> +    target_ulong priority =3D args[3];
> >> +    target_ulong eisn     =3D args[4];
> >> +    uint32_t eq_idx;
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    if (flags & ~(XIVE_SRC_SET_EISN | XIVE_SRC_MASK)) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    ive =3D spapr_xive_get_ive(spapr->xive, lisn);
> >> +    if (!ive || !(ive->w & IVE_VALID)) {
> >> +        return H_P2;
> >> +    }
> >> +
> >> +    /* priority 0xff is used to reset the IVE */
> >> +    if (priority =3D=3D 0xff) {
> >> +        new_ive =3D IVE_VALID | IVE_MASKED;
> >> +        goto out;
> >> +    }
> >> +
> >> +    new_ive =3D ive->w;
> >> +
> >> +    if (flags & XIVE_SRC_MASK) {
> >> +        new_ive =3D ive->w | IVE_MASKED;
> >> +    } else {
> >> +        new_ive =3D ive->w & ~IVE_MASKED;
> >> +    }
> >> +
> >> +    if (!priority_is_valid(priority)) {
> >> +        return H_P4;
> >> +    }
> >> +
> >> +    /* TODO: If the partition thread count is greater than the
> >> +     * hardware thread count, validate the "target" has a
> >> +     * corresponding hardware thread else return H_NOT_AVAILABLE.
> >> +     */
> >=20
> > What's this about? =20
>=20
> That is from the specs and I haven't quite figured out what it meant.
> I need to ask.
>=20
> > I thought the point of XIVE was you could set up
> > target queues for your vcpus regardless of mapping to physical cpus.
>=20
> yes.
>=20
> >> +    /* Validate that "target" is part of the list of threads allocated
> >> +     * to the partition. For that, find the EQ corresponding to the
> >> +     * target.
> >> +     */
> >> +    if (!spapr_xive_eq_for_server(spapr->xive, target, priority, &eq_=
idx)) {
> >> +        return H_P3;
> >> +    }
> >> +
> >> +    new_ive =3D SETFIELD(IVE_EQ_BLOCK, new_ive, 0ul);
> >> +    new_ive =3D SETFIELD(IVE_EQ_INDEX, new_ive, eq_idx);
> >> +
> >> +    if (flags & XIVE_SRC_SET_EISN) {
> >> +        new_ive =3D SETFIELD(IVE_EQ_DATA, new_ive, eisn);
> >> +    }
> >> +
> >> +out:
> >> +    /* TODO: handle syncs ? */
> >> +
> >> +    /* And update */
> >> +    ive->w =3D new_ive;
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_GET_SOURCE_CONFIG hcall() is used to determine to which
> >> + * target/priority pair is assigned to the specified Logical Interrupt
> >> + * Source.
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-63 Reserved
> >> + * - "lisn" is per "interrupts", "interrupt-map", or
> >> + *      "ibm,xive-lisn-ranges" properties, or as returned by the
> >> + *      ibm,query-interrupt-source-number RTAS call, or as
> >> + *      returned by the H_ALLOCATE_VAS_WINDOW hcall
> >> + *
> >> + * Output:
> >> + * - R4: Target to which the specified Logical Interrupt Source is
> >> + *       assigned
> >> + * - R5: Priority to which the specified Logical Interrupt Source is
> >> + *       assigned
> >> + * - R6: EISN for the specified Logical Interrupt Source (this will be
> >> + *       equivalent to the LISN if not changed by H_INT_SET_SOURCE_CO=
NFIG)
> >> + */
> >> +static target_ulong h_int_get_source_config(PowerPCCPU *cpu,
> >> +                                            sPAPRMachineState *spapr,
> >> +                                            target_ulong opcode,
> >> +                                            target_ulong *args)
> >> +{
> >> +    target_ulong flags =3D args[0];
> >> +    target_ulong lisn =3D args[1];
> >> +    XiveIVE *ive;
> >> +    XiveEQ *eq;
> >> +    uint32_t eq_idx;
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    if (flags) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    ive =3D spapr_xive_get_ive(spapr->xive, lisn);
> >> +    if (!ive || !(ive->w & IVE_VALID)) {
> >> +        return H_P2;
> >> +    }
> >> +
> >> +    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
> >> +    eq =3D spapr_xive_get_eq(spapr->xive, eq_idx);
> >> +    if (!eq) {
> >> +        return H_HARDWARE;
> >> +    }
> >> +
> >> +    args[0] =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
> >> +
> >> +    if (ive->w & IVE_MASKED) {
> >> +        args[1] =3D 0xff;
> >> +    } else {
> >> +        args[1] =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
> >> +    }
> >> +
> >> +    args[2] =3D GETFIELD(IVE_EQ_DATA, ive->w);
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_GET_QUEUE_INFO hcall() is used to get the logical real
> >> + * address of the notification management page associated with the
> >> + * specified target and priority.
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *       Bits 0-63 Reserved
> >> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> >> + *       "ibm,ppc-interrupt-gserver#s"
> >> + * - "priority" is a valid priority not in
> >> + *       "ibm,plat-res-int-priorities"
> >> + *
> >> + * Output:
> >> + * - R4: Logical real address of notification page
> >> + * - R5: Power of 2 page size of the notification page
> >> + */
> >> +static target_ulong h_int_get_queue_info(PowerPCCPU *cpu,
> >> +                                         sPAPRMachineState *spapr,
> >> +                                         target_ulong opcode,
> >> +                                         target_ulong *args)
> >> +{
> >> +    target_ulong flags    =3D args[0];
> >> +    target_ulong target   =3D args[1];
> >> +    target_ulong priority =3D args[2];
> >> +    uint32_t eq_idx;
> >> +    XiveEQ *eq;
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    if (flags) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    if (!priority_is_valid(priority)) {
> >> +        return H_P3;
> >> +    }
> >> +
> >> +    /* Validate that "target" is part of the list of threads allocated
> >> +     * to the partition. For that, find the EQ corresponding to the
> >> +     * target.
> >> +     */
> >> +    if (!spapr_xive_eq_for_server(spapr->xive, target, priority, &eq_=
idx)) {
> >> +        return H_P2;
> >> +    }
> >> +
> >> +    /* TODO: If the partition thread count is greater than the
> >> +     * hardware thread count, validate the "target" has a
> >> +     * corresponding hardware thread else return H_NOT_AVAILABLE.
> >> +     */
> >> +
> >> +    eq =3D spapr_xive_get_eq(spapr->xive, eq_idx);
> >> +    if (!eq)  {
> >> +        return H_HARDWARE;
> >> +    }
> >> +
> >> +    args[0] =3D -1; /* TODO: return ESn page */
> >> +    if (eq->w0 & EQ_W0_ENQUEUE) {
> >> +        args[1] =3D GETFIELD(EQ_W0_QSIZE, eq->w0) + 12;
> >> +    } else {
> >> +        args[1] =3D 0;
> >> +    }
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_SET_QUEUE_CONFIG hcall() is used to set or reset a EQ for
> >> + * a given "target" and "priority".  It is also used to set the
> >> + * notification config associated with the EQ.  An EQ size of 0 is
> >> + * used to reset the EQ config for a given target and priority. If
> >> + * resetting the EQ config, the END associated with the given "target"
> >> + * and "priority" will be changed to disable queueing.
> >> + *
> >> + * Upon return from the hcall(), no additional interrupts will be
> >> + * directed to the old EQ (if one was set). The old EQ (if one was
> >> + * set) should be investigated for interrupts that occurred prior to
> >> + * or during the hcall().
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-62: Reserved
> >> + *      Bit 63: Unconditional Notify (n) per the XIVE spec
> >> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> >> + *       "ibm,ppc-interrupt-gserver#s"
> >> + * - "priority" is a valid priority not in
> >> + *       "ibm,plat-res-int-priorities"
> >> + * - "eventQueue": The logical real address of the start of the EQ
> >> + * - "eventQueueSize": The power of 2 EQ size per "ibm,xive-eq-sizes"
> >> + *
> >> + * Output:
> >> + * - None
> >> + */
> >> +
> >> +#define XIVE_EQ_ALWAYS_NOTIFY (1ull << (63 - 63))
> >> +
> >> +static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
> >> +                                           sPAPRMachineState *spapr,
> >> +                                           target_ulong opcode,
> >> +                                           target_ulong *args)
> >> +{
> >> +    target_ulong flags    =3D args[0];
> >> +    target_ulong target   =3D args[1];
> >> +    target_ulong priority =3D args[2];
> >> +    target_ulong qpage    =3D args[3];
> >> +    target_ulong qsize    =3D args[4];
> >> +    uint32_t eq_idx;
> >> +    XiveEQ *old_eq;
> >> +    XiveEQ eq;
> >> +    uint32_t qdata;
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    if (flags & ~XIVE_EQ_ALWAYS_NOTIFY) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    if (!priority_is_valid(priority)) {
> >> +        return H_P3;
> >> +    }
> >> +
> >> +    /* Validate that "target" is part of the list of threads allocated
> >> +     * to the partition. For that, find the EQ corresponding to the
> >> +     * target.
> >> +     */
> >> +    if (!spapr_xive_eq_for_server(spapr->xive, target, priority, &eq_=
idx)) {
> >> +        return H_P2;
> >> +    }
> >> +
> >> +    /* TODO: If the partition thread count is greater than the
> >> +     * hardware thread count, validate the "target" has a
> >> +     * corresponding hardware thread else return H_NOT_AVAILABLE.
> >> +     */
> >> +
> >> +    old_eq =3D spapr_xive_get_eq(spapr->xive, eq_idx);
> >> +    if (!old_eq)  {
> >> +        return H_HARDWARE;
> >> +    }
> >> +
> >> +    eq =3D *old_eq;
> >> +
> >> +    switch (qsize) {
> >> +    case 12:
> >> +    case 16:
> >> +    case 21:
> >> +    case 24:
> >> +        eq.w3 =3D ((uint64_t)qpage) & 0xffffffff;
> >> +        eq.w2 =3D (((uint64_t)qpage)) >> 32 & 0x0fffffff;
> >> +        eq.w0 |=3D EQ_W0_ENQUEUE;
> >> +        eq.w0 =3D SETFIELD(EQ_W0_QSIZE, eq.w0, qsize - 12);
> >> +        break;
> >> +    case 0:
> >> +        /* reset queue and disable queueing */
> >> +        eq.w2 =3D eq.w3 =3D 0;
> >> +        eq.w0 &=3D ~EQ_W0_ENQUEUE;
> >> +        break;
> >> +    default:
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid EQ size %"PRIx64"=
\n",
> >> +                      __func__, qsize);
> >> +        return H_P5;
> >> +    }
> >> +
> >> +    if (qsize) {
> >> +        /*
> >> +         * Let's validate the EQ address with a read of the first EQ
> >> +         * entry. We could also check that the full queue has been
> >> +         * zeroed by the OS.
> >> +         */
> >> +        if (address_space_read(&address_space_memory, qpage,
> >> +                               MEMTXATTRS_UNSPECIFIED,
> >> +                               (uint8_t *) &qdata, sizeof(qdata))) {
> >> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read EQ dat=
a @0x%"
> >> +                          HWADDR_PRIx "\n", __func__, qpage);
> >> +            return H_P4;
> >> +        }
> >> +    }
> >> +
> >> +    /* Ensure the priority and target are correctly set (they will not
> >> +     * be right after allocation)
> >> +     */
> >> +    eq.w6 =3D SETFIELD(EQ_W6_NVT_BLOCK, 0ul, 0ul) |
> >> +        SETFIELD(EQ_W6_NVT_INDEX, 0ul, target);
> >> +    eq.w7 =3D SETFIELD(EQ_W7_F0_PRIORITY, 0ul, priority);
> >> +
> >> +    /* TODO: depends on notitification page (ESn) from H_INT_GET_QUEU=
E_INFO */
> >> +    if (flags & XIVE_EQ_ALWAYS_NOTIFY) {
> >> +        eq.w0 |=3D EQ_W0_UCOND_NOTIFY;
> >=20
> > Do you need to also clear if the flag is not set?  AFAICT eq.w0 is
> > inherited from teh old queue and enver reset from scratch.
>=20
> True. It is always on if the EQ is not reseted. I also need=20
> to be more precise in spapr_xive_irq() when dealing with the=20
> reseted EQs. The model has not fallen in to that trap yet.
>=20
> >> +    }
> >> +
> >> +    /* The generation bit for the EQ starts at 1 and The EQ page
> >> +     * offset counter starts at 0.
> >> +     */
> >> +    eq.w1 =3D EQ_W1_GENERATION | SETFIELD(EQ_W1_PAGE_OFF, 0ul, 0ul);
> >> +    eq.w0 |=3D EQ_W0_VALID;
> >> +
> >> +    /* TODO: issue syncs required to ensure all in-flight interrupts
> >> +     * are complete on the old EQ */
> >> +
> >> +    /* Update EQ */
> >> +    *old_eq =3D eq;
> >=20
> > Hrm.  The BQL probably saves you, but in general do you need to make
> > sure the ENQUEUE bit is set after updating everything else?
>=20
> There is a rather complex procedure to update the HW, cache and=20
> memory. See xive_eqc_cache_update() in OPAL. I will need to dig=20
> in for the PowerNV support ...
>=20
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_GET_QUEUE_CONFIG hcall() is used to get a EQ for a given
> >> + * target and priority.
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-62: Reserved
> >> + *      Bit 63: Debug: Return debug data
> >> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> >> + *       "ibm,ppc-interrupt-gserver#s"
> >> + * - "priority" is a valid priority not in
> >> + *       "ibm,plat-res-int-priorities"
> >> + *
> >> + * Output:
> >> + * - R4: "flags":
> >> + *       Bits 0-62: Reserved
> >> + *       Bit 63: The value of Unconditional Notify (n) per the XIVE s=
pec
> >> + * - R5: The logical real address of the start of the EQ
> >> + * - R6: The power of 2 EQ size per "ibm,xive-eq-sizes"
> >> + * - R7: The value of Event Queue Offset Counter per XIVE spec
> >> + *       if "Debug" =3D 1, else 0
> >> + *
> >> + */
> >> +
> >> +#define XIVE_EQ_DEBUG     (1ull << (63 - 63))
> >> +
> >> +static target_ulong h_int_get_queue_config(PowerPCCPU *cpu,
> >> +                                           sPAPRMachineState *spapr,
> >> +                                           target_ulong opcode,
> >> +                                           target_ulong *args)
> >> +{
> >> +    target_ulong flags    =3D args[0];
> >> +    target_ulong target   =3D args[1];
> >> +    target_ulong priority =3D args[2];
> >> +    uint32_t eq_idx;
> >> +    XiveEQ *eq;
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    if (flags & ~XIVE_EQ_DEBUG) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    if (!priority_is_valid(priority)) {
> >> +        return H_P3;
> >> +    }
> >> +
> >> +    /* Validate that "target" is part of the list of threads allocated
> >> +     * to the partition. For that, find the EQ corresponding to the
> >> +     * target.
> >> +     */
> >> +    if (!spapr_xive_eq_for_server(spapr->xive, target, priority, &eq_=
idx)) {
> >> +        return H_P2;
> >> +    }
> >> +
> >> +    /* TODO: If the partition thread count is greater than the
> >> +     * hardware thread count, validate the "target" has a
> >> +     * corresponding hardware thread else return H_NOT_AVAILABLE.
> >> +     */
> >> +
> >> +    eq =3D spapr_xive_get_eq(spapr->xive, eq_idx);
> >> +    if (!eq)  {
> >> +        return H_HARDWARE;
> >> +    }
> >> +
> >> +    args[0] =3D 0;
> >> +    if (eq->w0 & EQ_W0_UCOND_NOTIFY) {
> >> +        args[0] |=3D XIVE_EQ_ALWAYS_NOTIFY;
> >> +    }
> >> +
> >> +    if (eq->w0 & EQ_W0_ENQUEUE) {
> >> +        args[1] =3D
> >> +            (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | eq->w3;
> >> +        args[2] =3D GETFIELD(EQ_W0_QSIZE, eq->w0) + 12;
> >> +    } else {
> >> +        args[1] =3D 0;
> >> +        args[2] =3D 0;
> >> +    }
> >> +
> >> +    /* TODO: do we need any locking on the EQ ? */
> >=20
> > Probably not if you're designating it as protected by the BQL.
>=20
> OK.
>=20
> Thanks,
>=20
> C.=20
> =20
> >> +    if (flags & XIVE_EQ_DEBUG) {
> >> +        /* Load the event queue generation number into the return fla=
gs */
> >> +        args[0] |=3D GETFIELD(EQ_W1_GENERATION, eq->w1);
> >> +
> >> +        /* Load R7 with the event queue offset counter */
> >> +        args[3] =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
> >> +    }
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_SET_OS_REPORTING_LINE hcall() is used to set the
> >> + * reporting cache line pair for the calling thread.  The reporting
> >> + * cache lines will contain the OS interrupt context when the OS
> >> + * issues a CI store byte to @TIMA+0xC10 to acknowledge the OS
> >> + * interrupt. The reporting cache lines can be reset by inputting -1
> >> + * in "reportingLine".  Issuing the CI store byte without reporting
> >> + * cache lines registered will result in the data not being accessible
> >> + * to the OS.
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-63: Reserved
> >> + * - "reportingLine": The logical real address of the reporting cache
> >> + *    line pair
> >> + *
> >> + * Output:
> >> + * - None
> >> + */
> >> +static target_ulong h_int_set_os_reporting_line(PowerPCCPU *cpu,
> >> +                                                sPAPRMachineState *sp=
apr,
> >> +                                                target_ulong opcode,
> >> +                                                target_ulong *args)
> >> +{
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    /* TODO: H_INT_SET_OS_REPORTING_LINE */
> >> +    return H_FUNCTION;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_GET_OS_REPORTING_LINE hcall() is used to get the logical
> >> + * real address of the reporting cache line pair set for the input
> >> + * "target".  If no reporting cache line pair has been set, -1 is
> >> + * returned.
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-63: Reserved
> >> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> >> + *       "ibm,ppc-interrupt-gserver#s"
> >> + * - "reportingLine": The logical real address of the reporting cache
> >> + *   line pair
> >> + *
> >> + * Output:
> >> + * - R4: The logical real address of the reporting line if set, else =
-1
> >> + */
> >> +static target_ulong h_int_get_os_reporting_line(PowerPCCPU *cpu,
> >> +                                                sPAPRMachineState *sp=
apr,
> >> +                                                target_ulong opcode,
> >> +                                                target_ulong *args)
> >> +{
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    /* TODO: H_INT_GET_OS_REPORTING_LINE */
> >> +    return H_FUNCTION;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_ESB hcall() is used to issue a load or store to the ESB
> >> + * page for the input "lisn".  This hcall is only supported for LISNs
> >> + * that have the ESB hcall flag set to 1 when returned from hcall()
> >> + * H_INT_GET_SOURCE_INFO.
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-62: Reserved
> >> + *      bit 63: Store: Store=3D1, store operation, else load operation
> >> + * - "lisn" is per "interrupts", "interrupt-map", or
> >> + *      "ibm,xive-lisn-ranges" properties, or as returned by the
> >> + *      ibm,query-interrupt-source-number RTAS call, or as
> >> + *      returned by the H_ALLOCATE_VAS_WINDOW hcall
> >> + * - "esbOffset" is the offset into the ESB page for the load or stor=
e operation
> >> + * - "storeData" is the data to write for a store operation
> >> + *
> >> + * Output:
> >> + * - R4: R4: The value of the load if load operation, else -1
> >> + */
> >> +
> >> +#define XIVE_ESB_STORE (1ull << (63 - 63))
> >> +
> >> +static target_ulong h_int_esb(PowerPCCPU *cpu,
> >> +                              sPAPRMachineState *spapr,
> >> +                              target_ulong opcode,
> >> +                              target_ulong *args)
> >> +{
> >> +    sPAPRXive *xive =3D spapr->xive;
> >> +    XiveIVE *ive;
> >> +    target_ulong flags   =3D args[0];
> >> +    target_ulong lisn    =3D args[1];
> >> +    target_ulong offset  =3D args[2];
> >> +    target_ulong data    =3D args[3];
> >> +    uint64_t esb_base;
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    if (flags & ~XIVE_ESB_STORE) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    ive =3D spapr_xive_get_ive(xive, lisn);
> >> +    if (!ive || !(ive->w & IVE_VALID)) {
> >> +        return H_P2;
> >> +    }
> >> +
> >> +    if (offset > (1ull << xive->esb_shift)) {
> >> +        return H_P3;
> >> +    }
> >> +
> >> +    esb_base =3D (uint64_t)xive->esb_base + (1ull << xive->esb_shift)=
 * lisn;
> >> +    esb_base +=3D offset;
> >> +
> >> +    if (dma_memory_rw(&address_space_memory, esb_base, &data, 8,
> >> +                      (flags & XIVE_ESB_STORE))) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to rw data @0x%"
> >> +                      HWADDR_PRIx "\n", __func__, esb_base);
> >> +        return H_HARDWARE;
> >> +    }
> >> +    args[0] =3D (flags & XIVE_ESB_STORE) ? -1 : data;
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_SYNC hcall() is used to issue hardware syncs that will
> >> + * ensure any in flight events for the input lisn are in the event
> >> + * queue.
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-63: Reserved
> >> + * - "lisn" is per "interrupts", "interrupt-map", or
> >> + *      "ibm,xive-lisn-ranges" properties, or as returned by the
> >> + *      ibm,query-interrupt-source-number RTAS call, or as
> >> + *      returned by the H_ALLOCATE_VAS_WINDOW hcall
> >> + *
> >> + * Output:
> >> + * - None
> >> + */
> >> +static target_ulong h_int_sync(PowerPCCPU *cpu,
> >> +                               sPAPRMachineState *spapr,
> >> +                               target_ulong opcode,
> >> +                               target_ulong *args)
> >> +{
> >> +    XiveIVE *ive;
> >> +    target_ulong flags   =3D args[0];
> >> +    target_ulong lisn    =3D args[1];
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    if (flags) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    ive =3D spapr_xive_get_ive(spapr->xive, lisn);
> >> +    if (!ive || !(ive->w & IVE_VALID)) {
> >> +        return H_P2;
> >> +    }
> >> +
> >> +    /*
> >> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> >> +     * This is not needed when running the emulation under QEMU
> >> +     */
> >> +
> >> +    /* This is not real hardware. Nothing to be done */
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +/*
> >> + * The H_INT_RESET hcall() is used to reset all of the partition's
> >> + * interrupt exploitation structures to their initial state.  This
> >> + * means losing all previously set interrupt state set via
> >> + * H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
> >> + *
> >> + * Parameters:
> >> + * Input:
> >> + * - "flags"
> >> + *      Bits 0-63: Reserved
> >> + *
> >> + * Output:
> >> + * - None
> >> + */
> >> +static target_ulong h_int_reset(PowerPCCPU *cpu,
> >> +                                sPAPRMachineState *spapr,
> >> +                                target_ulong opcode,
> >> +                                target_ulong *args)
> >> +{
> >> +    target_ulong flags   =3D args[0];
> >> +
> >> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >> +        return H_FUNCTION;
> >> +    }
> >> +
> >> +    if (flags) {
> >> +        return H_PARAMETER;
> >> +    }
> >> +
> >> +    spapr_xive_reset(spapr->xive);
> >> +    return H_SUCCESS;
> >> +}
> >> +
> >> +void spapr_xive_hcall_init(sPAPRMachineState *spapr)
> >> +{
> >> +    spapr_register_hypercall(H_INT_GET_SOURCE_INFO, h_int_get_source_=
info);
> >> +    spapr_register_hypercall(H_INT_SET_SOURCE_CONFIG, h_int_set_sourc=
e_config);
> >> +    spapr_register_hypercall(H_INT_GET_SOURCE_CONFIG, h_int_get_sourc=
e_config);
> >> +    spapr_register_hypercall(H_INT_GET_QUEUE_INFO, h_int_get_queue_in=
fo);
> >> +    spapr_register_hypercall(H_INT_SET_QUEUE_CONFIG, h_int_set_queue_=
config);
> >> +    spapr_register_hypercall(H_INT_GET_QUEUE_CONFIG, h_int_get_queue_=
config);
> >> +    spapr_register_hypercall(H_INT_SET_OS_REPORTING_LINE,
> >> +                             h_int_set_os_reporting_line);
> >> +    spapr_register_hypercall(H_INT_GET_OS_REPORTING_LINE,
> >> +                             h_int_get_os_reporting_line);
> >> +    spapr_register_hypercall(H_INT_ESB, h_int_esb);
> >> +    spapr_register_hypercall(H_INT_SYNC, h_int_sync);
> >> +    spapr_register_hypercall(H_INT_RESET, h_int_reset);
> >> +}
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index ca4e72187f60..8b15c0b500d0 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -222,6 +222,8 @@ static sPAPRXive *spapr_xive_create(sPAPRMachineSt=
ate *spapr, int nr_irqs,
> >>          goto error;
> >>      }
> >> =20
> >> +    spapr_xive_hcall_init(spapr);
> >> +
> >>      return SPAPR_XIVE(obj);
> >>  error:
> >>      error_propagate(errp, local_err);
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 90e2b0f6c678..a25e218b34e2 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -387,7 +387,20 @@ struct sPAPRMachineState {
> >>  #define H_INVALIDATE_PID        0x378
> >>  #define H_REGISTER_PROC_TBL     0x37C
> >>  #define H_SIGNAL_SYS_RESET      0x380
> >> -#define MAX_HCALL_OPCODE        H_SIGNAL_SYS_RESET
> >> +
> >> +#define H_INT_GET_SOURCE_INFO   0x3A8
> >> +#define H_INT_SET_SOURCE_CONFIG 0x3AC
> >> +#define H_INT_GET_SOURCE_CONFIG 0x3B0
> >> +#define H_INT_GET_QUEUE_INFO    0x3B4
> >> +#define H_INT_SET_QUEUE_CONFIG  0x3B8
> >> +#define H_INT_GET_QUEUE_CONFIG  0x3BC
> >> +#define H_INT_SET_OS_REPORTING_LINE 0x3C0
> >> +#define H_INT_GET_OS_REPORTING_LINE 0x3C4
> >> +#define H_INT_ESB               0x3C8
> >> +#define H_INT_SYNC              0x3CC
> >> +#define H_INT_RESET             0x3D0
> >> +
> >> +#define MAX_HCALL_OPCODE        H_INT_RESET
> >> =20
> >>  /* The hcalls above are standardized in PAPR and implemented by pHyp
> >>   * as well.
> >> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> >> index 6e8a189e723f..3f822220647f 100644
> >> --- a/include/hw/ppc/spapr_xive.h
> >> +++ b/include/hw/ppc/spapr_xive.h
> >> @@ -79,4 +79,8 @@ bool spapr_xive_irq_unset(sPAPRXive *xive, uint32_t =
lisn);
> >>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> >>  void spapr_xive_icp_pic_print_info(sPAPRXiveICP *xicp, Monitor *mon);
> >> =20
> >> +typedef struct sPAPRMachineState sPAPRMachineState;
> >> +
> >> +void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> >> +
> >>  #endif /* PPC_SPAPR_XIVE_H */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlomQ/MACgkQbDjKyiDZ
s5Ls4w/+Jmb4rv1XHB3BO/5bIX2acgoKzY/ZU7INEzc9uKIlwqUARbjJH+N710y4
Vj89ELZI167a2ZZPO0hvz831INtH1pUQluyyqaubv0n+tI/BBZXCuSymAxQusMht
ZPSjpCAiEY8s5WA3f2FEhu/jpYqfi5UUrri7c+uejFOhzAdmBFuTGNgMo4bSEM7j
NcP2VEAALeukU/WMSwqmj1kMIQfkupdwAj+C1IG7O0yjC0gP4F80GXDcaLDNMpXP
Kf5qReKl6gob+x2QtJsa1aNykqCaP+lZOpo0fKYX6+cDzIgcaKxJwE5QWJEiD9//
6VeQNf2WhGeJ/VeDMPb50IjiNbSqkSpxcpLkkP0A/dEbaND+GLd27ER6hvJQIIGB
Fd/3oQcGA1/5ce8Ko+FGg5IFoF3ITNXMLc1ldpYP1+6rOUokIyJiGZdL7s23+RV3
IUbrO6uSppliaK4CAd8l0D8kiraYis3t5qA3R/aDlxXvCJUQ23QCHu+VzR1B4wdS
V87vKQoEw2+SAerpzJdDCJ7t5h491wAq2janBeEKi2JhUdx2sL52i2r0+thA9aa/
pPD+Hfg/VE1+5B75C4Iz8Ivv+sUK/cp9KreMb9uVgDQoBJ0ijZZ0Fyy21rNUPrQZ
+IZTClGQ/VL4wmBe5dNkD2T6xU8z4WMB96Ikfj/JxLCUBtPlktM=
=GSVp
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
