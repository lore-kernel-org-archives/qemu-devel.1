Received: from eggs.gnu.org ([2001:4830:134:3::10]:44994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKo9C-0003Sx-GR
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKo98-00039Z-Fs
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:26:42 -0500
Date: Fri, 1 Dec 2017 15:01:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171201040115.GC30161@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-20-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-20-clg@kaod.org>
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


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:49PM +0100, C=E9dric Le Goater wrote:
> A set of Hypervisor's call are used to configure the interrupt sources
> and the event/notification queues of the guest:
>=20
>  - H_INT_GET_SOURCE_INFO
>=20
>    used to obtain the address of the MMIO page of the Event State
>    Buffer (PQ bits) entry associated with the source.
>=20
>  - H_INT_SET_SOURCE_CONFIG
>=20
>    assigns a source to a "target".
>=20
>  - H_INT_GET_SOURCE_CONFIG
>=20
>    determines to which "target" and "priority" is assigned to a source
>=20
>  - H_INT_GET_QUEUE_INFO
>=20
>    returns the address of the notification management page associated
>    with the specified "target" and "priority".
>=20
>  - H_INT_SET_QUEUE_CONFIG
>=20
>    sets or resets the event queue for a given "target" and "priority".
>    It is also used to set the notification config associated with the
>    queue, only unconditional notification for the moment.  Reset is
>    performed with a queue size of 0 and queueing is disabled in that
>    case.
>=20
>  - H_INT_GET_QUEUE_CONFIG
>=20
>    returns the queue settings for a given "target" and "priority".
>=20
>  - H_INT_RESET
>=20
>    resets all of the partition's interrupt exploitation structures to
>    their initial state, losing all configuration set via the hcalls
>    H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
>=20
>  - H_INT_SYNC
>=20
>    issue a synchronisation on a source to make sure sure all
>    notifications have reached their queue.
>=20
> Calls that still need to be addressed :
>=20
>    H_INT_SET_OS_REPORTING_LINE
>    H_INT_GET_OS_REPORTING_LINE
>=20
> See the code for more documentation on each hcall.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/Makefile.objs       |   2 +-
>  hw/intc/spapr_xive_hcall.c  | 885 ++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr.c              |   2 +
>  include/hw/ppc/spapr.h      |  15 +-
>  include/hw/ppc/spapr_xive.h |   4 +
>  5 files changed, 906 insertions(+), 2 deletions(-)
>  create mode 100644 hw/intc/spapr_xive_hcall.c
>=20
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index 49e13e7aeeee..122e2ec77e8d 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -35,7 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
>  obj-$(CONFIG_XICS) +=3D xics.o
>  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
> -obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
> +obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o spapr_xive_hcall.o
>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
> new file mode 100644
> index 000000000000..676fe0e2d5c7
> --- /dev/null
> +++ b/hw/intc/spapr_xive_hcall.c
> @@ -0,0 +1,885 @@
> +/*
> + * QEMU PowerPC sPAPR XIVE model
> + *
> + * Copyright (c) 2017, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_xive.h"
> +#include "hw/ppc/fdt.h"
> +#include "monitor/monitor.h"
> +
> +#include "xive-internal.h"
> +
> +/* Priority ranges reserved by the hypervisor. The Linux driver is
> + * expected to choose priority 6.
> + */
> +static const uint32_t reserved_priorities[] =3D {
> +    7,    /* start */
> +    0xf8, /* count */
> +};
> +
> +static bool priority_is_valid(uint32_t priority)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(reserved_priorities) / 2; i++) {
> +        uint32_t base  =3D reserved_priorities[2 * i];
> +        uint32_t count =3D reserved_priorities[2 * i + 1];
> +
> +        if (priority >=3D base && priority < base + count) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: priority %d is reserved\=
n",
> +                          __func__, priority);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}

This seems like overkill.  Aren't there only 0..7 levels supported in
hardware, in which case a one byte bitmap will suffice to store the
reserved levels.

To check my understanding again, if you're running this with KVM, the
host kernel and qemu will need to agree on which are the reserved
levels, yes?

> +
> +/*
> + * The H_INT_GET_SOURCE_INFO hcall() is used to obtain the logical
> + * real address of the MMIO page through which the Event State Buffer
> + * entry associated with the value of the "lisn" parameter is managed.
> + *
> + * Parameters:
> + * Input
> + * - "flags"
> + *       Bits 0-63 reserved
> + * - "lisn" is per "interrupts", "interrupt-map", or
> + *       "ibm,xive-lisn-ranges" properties, or as returned by the
> + *       ibm,query-interrupt-source-number RTAS call, or as returned
> + *       by the H_ALLOCATE_VAS_WINDOW hcall
> + *
> + * Output
> + * - R4: "flags"
> + *       Bits 0-59: Reserved
> + *       Bit 60: H_INT_ESB must be used for Event State Buffer
> + *               management
> + *       Bit 61: 1 =3D=3D LSI  0 =3D=3D MSI
> + *       Bit 62: the full function page supports trigger
> + *       Bit 63: Store EOI Supported
> + * - R5: Logical Real address of full function Event State Buffer
> + *       management page, -1 if ESB hcall flag is set to 1.
> + * - R6: Logical Real Address of trigger only Event State Buffer
> + *       management page or -1.
> + * - R7: Power of 2 page size for the ESB management pages returned in
> + *       R5 and R6.
> + */
> +static target_ulong h_int_get_source_info(PowerPCCPU *cpu,
> +                                          sPAPRMachineState *spapr,
> +                                          target_ulong opcode,
> +                                          target_ulong *args)
> +{
> +    sPAPRXive *xive =3D spapr->xive;
> +    XiveIVE *ive;
> +    target_ulong flags  =3D args[0];
> +    target_ulong lisn   =3D args[1];
> +    uint64_t mmio_base;
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;

Is H_FUNCTION required by the PAPR ACRs here?  Usually we only use
H_FUNCTION if the hypercall doesn't exist at all, and if unavailable
for other reasons use H_AUTHORITY or something.

> +    }
> +
> +    if (flags) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    ive =3D spapr_xive_get_ive(spapr->xive, lisn);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        return H_P2;
> +    }
> +
> +    mmio_base =3D (uint64_t)xive->esb_base + (1ull << xive->esb_shift) *=
 lisn;

Hrm.. why was xive->esb_base not already a u64?

> +    args[0] =3D 0;
> +    if (spapr_xive_irq_is_lsi(xive, lisn)) {
> +        args[0] |=3D XIVE_SRC_LSI;
> +    }
> +    if (xive->flags & XIVE_SRC_TRIGGER) {
> +        args[0] |=3D XIVE_SRC_TRIGGER;
> +    }
> +
> +    if (xive->flags & XIVE_SRC_H_INT_ESB) {
> +        args[1] =3D -1; /* never used in QEMU  */
> +        args[2] =3D -1;
> +    } else {
> +        args[1] =3D mmio_base;
> +        if (xive->flags & XIVE_SRC_TRIGGER) {
> +            args[2] =3D -1; /* No specific trigger page */
> +        } else {
> +            args[2] =3D -1; /* TODO: support for specific trigger page */
> +        }
> +    }

What does the availability of SRC_TRIGGER (and INT_ESB) depend on?  If
it varies with host capabilities, that's going to be real pain for
migration.

> +
> +    args[3] =3D xive->esb_shift;
> +
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * The H_INT_SET_SOURCE_CONFIG hcall() is used to assign a Logical
> + * Interrupt Source to a target. The Logical Interrupt Source is
> + * designated with the "lisn" parameter and the target is designated
> + * with the "target" and "priority" parameters.  Upon return from the
> + * hcall(), no additional interrupts will be directed to the old EQ.
> + *
> + * TODO: The old EQ should be investigated for interrupts that
> + * occurred prior to or during the hcall().
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-61: Reserved
> + *      Bit 62: set the "eisn" in the EA
> + *      Bit 63: masks the interrupt source in the hardware interrupt
> + *      control structure. An interrupt masked by this mechanism will
> + *      be dropped, but it's source state bits will still be
> + *      set. There is no race-free way of unmasking and restoring the
> + *      source. Thus this should only be used in interrupts that are
> + *      also masked at the source, and only in cases where the
> + *      interrupt is not meant to be used for a large amount of time
> + *      because no valid target exists for it for example
> + * - "lisn" is per "interrupts", "interrupt-map", or
> + *      "ibm,xive-lisn-ranges" properties, or as returned by the
> + *      ibm,query-interrupt-source-number RTAS call, or as returned by
> + *      the H_ALLOCATE_VAS_WINDOW hcall
> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> + *      "ibm,ppc-interrupt-gserver#s"
> + * - "priority" is a valid priority not in
> + *      "ibm,plat-res-int-priorities"
> + * - "eisn" is the guest EISN associated with the "lisn"
> + *
> + * Output:
> + * - None
> + */
> +
> +#define XIVE_SRC_SET_EISN (1ull << (63 - 62))
> +#define XIVE_SRC_MASK     (1ull << (63 - 63))

Aren't there already a bunch of macros you have for defining things in
terms of IBM bit numbers, so you can avoid open coding (63 - whatever).

> +
> +static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
> +                                            sPAPRMachineState *spapr,
> +                                            target_ulong opcode,
> +                                            target_ulong *args)
> +{
> +    XiveIVE *ive;
> +    uint64_t new_ive;
> +    target_ulong flags    =3D args[0];
> +    target_ulong lisn     =3D args[1];
> +    target_ulong target   =3D args[2];
> +    target_ulong priority =3D args[3];
> +    target_ulong eisn     =3D args[4];
> +    uint32_t eq_idx;
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags & ~(XIVE_SRC_SET_EISN | XIVE_SRC_MASK)) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    ive =3D spapr_xive_get_ive(spapr->xive, lisn);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        return H_P2;
> +    }
> +
> +    /* priority 0xff is used to reset the IVE */
> +    if (priority =3D=3D 0xff) {
> +        new_ive =3D IVE_VALID | IVE_MASKED;
> +        goto out;
> +    }
> +
> +    new_ive =3D ive->w;
> +
> +    if (flags & XIVE_SRC_MASK) {
> +        new_ive =3D ive->w | IVE_MASKED;
> +    } else {
> +        new_ive =3D ive->w & ~IVE_MASKED;
> +    }
> +
> +    if (!priority_is_valid(priority)) {
> +        return H_P4;
> +    }
> +
> +    /* TODO: If the partition thread count is greater than the
> +     * hardware thread count, validate the "target" has a
> +     * corresponding hardware thread else return H_NOT_AVAILABLE.
> +     */

What's this about?  I thought the point of XIVE was you could set up
target queues for your vcpus regardless of mapping to physical cpus.

> +    /* Validate that "target" is part of the list of threads allocated
> +     * to the partition. For that, find the EQ corresponding to the
> +     * target.
> +     */
> +    if (!spapr_xive_eq_for_server(spapr->xive, target, priority, &eq_idx=
)) {
> +        return H_P3;
> +    }
> +
> +    new_ive =3D SETFIELD(IVE_EQ_BLOCK, new_ive, 0ul);
> +    new_ive =3D SETFIELD(IVE_EQ_INDEX, new_ive, eq_idx);
> +
> +    if (flags & XIVE_SRC_SET_EISN) {
> +        new_ive =3D SETFIELD(IVE_EQ_DATA, new_ive, eisn);
> +    }
> +
> +out:
> +    /* TODO: handle syncs ? */
> +
> +    /* And update */
> +    ive->w =3D new_ive;
> +
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * The H_INT_GET_SOURCE_CONFIG hcall() is used to determine to which
> + * target/priority pair is assigned to the specified Logical Interrupt
> + * Source.
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-63 Reserved
> + * - "lisn" is per "interrupts", "interrupt-map", or
> + *      "ibm,xive-lisn-ranges" properties, or as returned by the
> + *      ibm,query-interrupt-source-number RTAS call, or as
> + *      returned by the H_ALLOCATE_VAS_WINDOW hcall
> + *
> + * Output:
> + * - R4: Target to which the specified Logical Interrupt Source is
> + *       assigned
> + * - R5: Priority to which the specified Logical Interrupt Source is
> + *       assigned
> + * - R6: EISN for the specified Logical Interrupt Source (this will be
> + *       equivalent to the LISN if not changed by H_INT_SET_SOURCE_CONFI=
G)
> + */
> +static target_ulong h_int_get_source_config(PowerPCCPU *cpu,
> +                                            sPAPRMachineState *spapr,
> +                                            target_ulong opcode,
> +                                            target_ulong *args)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong lisn =3D args[1];
> +    XiveIVE *ive;
> +    XiveEQ *eq;
> +    uint32_t eq_idx;
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    ive =3D spapr_xive_get_ive(spapr->xive, lisn);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        return H_P2;
> +    }
> +
> +    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
> +    eq =3D spapr_xive_get_eq(spapr->xive, eq_idx);
> +    if (!eq) {
> +        return H_HARDWARE;
> +    }
> +
> +    args[0] =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
> +
> +    if (ive->w & IVE_MASKED) {
> +        args[1] =3D 0xff;
> +    } else {
> +        args[1] =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
> +    }
> +
> +    args[2] =3D GETFIELD(IVE_EQ_DATA, ive->w);
> +
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * The H_INT_GET_QUEUE_INFO hcall() is used to get the logical real
> + * address of the notification management page associated with the
> + * specified target and priority.
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *       Bits 0-63 Reserved
> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> + *       "ibm,ppc-interrupt-gserver#s"
> + * - "priority" is a valid priority not in
> + *       "ibm,plat-res-int-priorities"
> + *
> + * Output:
> + * - R4: Logical real address of notification page
> + * - R5: Power of 2 page size of the notification page
> + */
> +static target_ulong h_int_get_queue_info(PowerPCCPU *cpu,
> +                                         sPAPRMachineState *spapr,
> +                                         target_ulong opcode,
> +                                         target_ulong *args)
> +{
> +    target_ulong flags    =3D args[0];
> +    target_ulong target   =3D args[1];
> +    target_ulong priority =3D args[2];
> +    uint32_t eq_idx;
> +    XiveEQ *eq;
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    if (!priority_is_valid(priority)) {
> +        return H_P3;
> +    }
> +
> +    /* Validate that "target" is part of the list of threads allocated
> +     * to the partition. For that, find the EQ corresponding to the
> +     * target.
> +     */
> +    if (!spapr_xive_eq_for_server(spapr->xive, target, priority, &eq_idx=
)) {
> +        return H_P2;
> +    }
> +
> +    /* TODO: If the partition thread count is greater than the
> +     * hardware thread count, validate the "target" has a
> +     * corresponding hardware thread else return H_NOT_AVAILABLE.
> +     */
> +
> +    eq =3D spapr_xive_get_eq(spapr->xive, eq_idx);
> +    if (!eq)  {
> +        return H_HARDWARE;
> +    }
> +
> +    args[0] =3D -1; /* TODO: return ESn page */
> +    if (eq->w0 & EQ_W0_ENQUEUE) {
> +        args[1] =3D GETFIELD(EQ_W0_QSIZE, eq->w0) + 12;
> +    } else {
> +        args[1] =3D 0;
> +    }
> +
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * The H_INT_SET_QUEUE_CONFIG hcall() is used to set or reset a EQ for
> + * a given "target" and "priority".  It is also used to set the
> + * notification config associated with the EQ.  An EQ size of 0 is
> + * used to reset the EQ config for a given target and priority. If
> + * resetting the EQ config, the END associated with the given "target"
> + * and "priority" will be changed to disable queueing.
> + *
> + * Upon return from the hcall(), no additional interrupts will be
> + * directed to the old EQ (if one was set). The old EQ (if one was
> + * set) should be investigated for interrupts that occurred prior to
> + * or during the hcall().
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-62: Reserved
> + *      Bit 63: Unconditional Notify (n) per the XIVE spec
> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> + *       "ibm,ppc-interrupt-gserver#s"
> + * - "priority" is a valid priority not in
> + *       "ibm,plat-res-int-priorities"
> + * - "eventQueue": The logical real address of the start of the EQ
> + * - "eventQueueSize": The power of 2 EQ size per "ibm,xive-eq-sizes"
> + *
> + * Output:
> + * - None
> + */
> +
> +#define XIVE_EQ_ALWAYS_NOTIFY (1ull << (63 - 63))
> +
> +static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
> +                                           sPAPRMachineState *spapr,
> +                                           target_ulong opcode,
> +                                           target_ulong *args)
> +{
> +    target_ulong flags    =3D args[0];
> +    target_ulong target   =3D args[1];
> +    target_ulong priority =3D args[2];
> +    target_ulong qpage    =3D args[3];
> +    target_ulong qsize    =3D args[4];
> +    uint32_t eq_idx;
> +    XiveEQ *old_eq;
> +    XiveEQ eq;
> +    uint32_t qdata;
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags & ~XIVE_EQ_ALWAYS_NOTIFY) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    if (!priority_is_valid(priority)) {
> +        return H_P3;
> +    }
> +
> +    /* Validate that "target" is part of the list of threads allocated
> +     * to the partition. For that, find the EQ corresponding to the
> +     * target.
> +     */
> +    if (!spapr_xive_eq_for_server(spapr->xive, target, priority, &eq_idx=
)) {
> +        return H_P2;
> +    }
> +
> +    /* TODO: If the partition thread count is greater than the
> +     * hardware thread count, validate the "target" has a
> +     * corresponding hardware thread else return H_NOT_AVAILABLE.
> +     */
> +
> +    old_eq =3D spapr_xive_get_eq(spapr->xive, eq_idx);
> +    if (!old_eq)  {
> +        return H_HARDWARE;
> +    }
> +
> +    eq =3D *old_eq;
> +
> +    switch (qsize) {
> +    case 12:
> +    case 16:
> +    case 21:
> +    case 24:
> +        eq.w3 =3D ((uint64_t)qpage) & 0xffffffff;
> +        eq.w2 =3D (((uint64_t)qpage)) >> 32 & 0x0fffffff;
> +        eq.w0 |=3D EQ_W0_ENQUEUE;
> +        eq.w0 =3D SETFIELD(EQ_W0_QSIZE, eq.w0, qsize - 12);
> +        break;
> +    case 0:
> +        /* reset queue and disable queueing */
> +        eq.w2 =3D eq.w3 =3D 0;
> +        eq.w0 &=3D ~EQ_W0_ENQUEUE;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid EQ size %"PRIx64"\n",
> +                      __func__, qsize);
> +        return H_P5;
> +    }
> +
> +    if (qsize) {
> +        /*
> +         * Let's validate the EQ address with a read of the first EQ
> +         * entry. We could also check that the full queue has been
> +         * zeroed by the OS.
> +         */
> +        if (address_space_read(&address_space_memory, qpage,
> +                               MEMTXATTRS_UNSPECIFIED,
> +                               (uint8_t *) &qdata, sizeof(qdata))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read EQ data @=
0x%"
> +                          HWADDR_PRIx "\n", __func__, qpage);
> +            return H_P4;
> +        }
> +    }
> +
> +    /* Ensure the priority and target are correctly set (they will not
> +     * be right after allocation)
> +     */
> +    eq.w6 =3D SETFIELD(EQ_W6_NVT_BLOCK, 0ul, 0ul) |
> +        SETFIELD(EQ_W6_NVT_INDEX, 0ul, target);
> +    eq.w7 =3D SETFIELD(EQ_W7_F0_PRIORITY, 0ul, priority);
> +
> +    /* TODO: depends on notitification page (ESn) from H_INT_GET_QUEUE_I=
NFO */
> +    if (flags & XIVE_EQ_ALWAYS_NOTIFY) {
> +        eq.w0 |=3D EQ_W0_UCOND_NOTIFY;

Do you need to also clear if the flag is not set?  AFAICT eq.w0 is
inherited from teh old queue and enver reset from scratch.

> +    }
> +
> +    /* The generation bit for the EQ starts at 1 and The EQ page
> +     * offset counter starts at 0.
> +     */
> +    eq.w1 =3D EQ_W1_GENERATION | SETFIELD(EQ_W1_PAGE_OFF, 0ul, 0ul);
> +    eq.w0 |=3D EQ_W0_VALID;
> +
> +    /* TODO: issue syncs required to ensure all in-flight interrupts
> +     * are complete on the old EQ */
> +
> +    /* Update EQ */
> +    *old_eq =3D eq;

Hrm.  The BQL probably saves you, but in general do you need to make
sure the ENQUEUE bit is set after updating everything else?

> +
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * The H_INT_GET_QUEUE_CONFIG hcall() is used to get a EQ for a given
> + * target and priority.
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-62: Reserved
> + *      Bit 63: Debug: Return debug data
> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> + *       "ibm,ppc-interrupt-gserver#s"
> + * - "priority" is a valid priority not in
> + *       "ibm,plat-res-int-priorities"
> + *
> + * Output:
> + * - R4: "flags":
> + *       Bits 0-62: Reserved
> + *       Bit 63: The value of Unconditional Notify (n) per the XIVE spec
> + * - R5: The logical real address of the start of the EQ
> + * - R6: The power of 2 EQ size per "ibm,xive-eq-sizes"
> + * - R7: The value of Event Queue Offset Counter per XIVE spec
> + *       if "Debug" =3D 1, else 0
> + *
> + */
> +
> +#define XIVE_EQ_DEBUG     (1ull << (63 - 63))
> +
> +static target_ulong h_int_get_queue_config(PowerPCCPU *cpu,
> +                                           sPAPRMachineState *spapr,
> +                                           target_ulong opcode,
> +                                           target_ulong *args)
> +{
> +    target_ulong flags    =3D args[0];
> +    target_ulong target   =3D args[1];
> +    target_ulong priority =3D args[2];
> +    uint32_t eq_idx;
> +    XiveEQ *eq;
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags & ~XIVE_EQ_DEBUG) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    if (!priority_is_valid(priority)) {
> +        return H_P3;
> +    }
> +
> +    /* Validate that "target" is part of the list of threads allocated
> +     * to the partition. For that, find the EQ corresponding to the
> +     * target.
> +     */
> +    if (!spapr_xive_eq_for_server(spapr->xive, target, priority, &eq_idx=
)) {
> +        return H_P2;
> +    }
> +
> +    /* TODO: If the partition thread count is greater than the
> +     * hardware thread count, validate the "target" has a
> +     * corresponding hardware thread else return H_NOT_AVAILABLE.
> +     */
> +
> +    eq =3D spapr_xive_get_eq(spapr->xive, eq_idx);
> +    if (!eq)  {
> +        return H_HARDWARE;
> +    }
> +
> +    args[0] =3D 0;
> +    if (eq->w0 & EQ_W0_UCOND_NOTIFY) {
> +        args[0] |=3D XIVE_EQ_ALWAYS_NOTIFY;
> +    }
> +
> +    if (eq->w0 & EQ_W0_ENQUEUE) {
> +        args[1] =3D
> +            (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | eq->w3;
> +        args[2] =3D GETFIELD(EQ_W0_QSIZE, eq->w0) + 12;
> +    } else {
> +        args[1] =3D 0;
> +        args[2] =3D 0;
> +    }
> +
> +    /* TODO: do we need any locking on the EQ ? */

Probably not if you're designating it as protected by the BQL.

> +    if (flags & XIVE_EQ_DEBUG) {
> +        /* Load the event queue generation number into the return flags =
*/
> +        args[0] |=3D GETFIELD(EQ_W1_GENERATION, eq->w1);
> +
> +        /* Load R7 with the event queue offset counter */
> +        args[3] =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
> +    }
> +
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * The H_INT_SET_OS_REPORTING_LINE hcall() is used to set the
> + * reporting cache line pair for the calling thread.  The reporting
> + * cache lines will contain the OS interrupt context when the OS
> + * issues a CI store byte to @TIMA+0xC10 to acknowledge the OS
> + * interrupt. The reporting cache lines can be reset by inputting -1
> + * in "reportingLine".  Issuing the CI store byte without reporting
> + * cache lines registered will result in the data not being accessible
> + * to the OS.
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-63: Reserved
> + * - "reportingLine": The logical real address of the reporting cache
> + *    line pair
> + *
> + * Output:
> + * - None
> + */
> +static target_ulong h_int_set_os_reporting_line(PowerPCCPU *cpu,
> +                                                sPAPRMachineState *spapr,
> +                                                target_ulong opcode,
> +                                                target_ulong *args)
> +{
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    /* TODO: H_INT_SET_OS_REPORTING_LINE */
> +    return H_FUNCTION;
> +}
> +
> +/*
> + * The H_INT_GET_OS_REPORTING_LINE hcall() is used to get the logical
> + * real address of the reporting cache line pair set for the input
> + * "target".  If no reporting cache line pair has been set, -1 is
> + * returned.
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-63: Reserved
> + * - "target" is per "ibm,ppc-interrupt-server#s" or
> + *       "ibm,ppc-interrupt-gserver#s"
> + * - "reportingLine": The logical real address of the reporting cache
> + *   line pair
> + *
> + * Output:
> + * - R4: The logical real address of the reporting line if set, else -1
> + */
> +static target_ulong h_int_get_os_reporting_line(PowerPCCPU *cpu,
> +                                                sPAPRMachineState *spapr,
> +                                                target_ulong opcode,
> +                                                target_ulong *args)
> +{
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    /* TODO: H_INT_GET_OS_REPORTING_LINE */
> +    return H_FUNCTION;
> +}
> +
> +/*
> + * The H_INT_ESB hcall() is used to issue a load or store to the ESB
> + * page for the input "lisn".  This hcall is only supported for LISNs
> + * that have the ESB hcall flag set to 1 when returned from hcall()
> + * H_INT_GET_SOURCE_INFO.
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-62: Reserved
> + *      bit 63: Store: Store=3D1, store operation, else load operation
> + * - "lisn" is per "interrupts", "interrupt-map", or
> + *      "ibm,xive-lisn-ranges" properties, or as returned by the
> + *      ibm,query-interrupt-source-number RTAS call, or as
> + *      returned by the H_ALLOCATE_VAS_WINDOW hcall
> + * - "esbOffset" is the offset into the ESB page for the load or store o=
peration
> + * - "storeData" is the data to write for a store operation
> + *
> + * Output:
> + * - R4: R4: The value of the load if load operation, else -1
> + */
> +
> +#define XIVE_ESB_STORE (1ull << (63 - 63))
> +
> +static target_ulong h_int_esb(PowerPCCPU *cpu,
> +                              sPAPRMachineState *spapr,
> +                              target_ulong opcode,
> +                              target_ulong *args)
> +{
> +    sPAPRXive *xive =3D spapr->xive;
> +    XiveIVE *ive;
> +    target_ulong flags   =3D args[0];
> +    target_ulong lisn    =3D args[1];
> +    target_ulong offset  =3D args[2];
> +    target_ulong data    =3D args[3];
> +    uint64_t esb_base;
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags & ~XIVE_ESB_STORE) {
> +        return H_PARAMETER;
> +    }
> +
> +    ive =3D spapr_xive_get_ive(xive, lisn);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        return H_P2;
> +    }
> +
> +    if (offset > (1ull << xive->esb_shift)) {
> +        return H_P3;
> +    }
> +
> +    esb_base =3D (uint64_t)xive->esb_base + (1ull << xive->esb_shift) * =
lisn;
> +    esb_base +=3D offset;
> +
> +    if (dma_memory_rw(&address_space_memory, esb_base, &data, 8,
> +                      (flags & XIVE_ESB_STORE))) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to rw data @0x%"
> +                      HWADDR_PRIx "\n", __func__, esb_base);
> +        return H_HARDWARE;
> +    }
> +    args[0] =3D (flags & XIVE_ESB_STORE) ? -1 : data;
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * The H_INT_SYNC hcall() is used to issue hardware syncs that will
> + * ensure any in flight events for the input lisn are in the event
> + * queue.
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-63: Reserved
> + * - "lisn" is per "interrupts", "interrupt-map", or
> + *      "ibm,xive-lisn-ranges" properties, or as returned by the
> + *      ibm,query-interrupt-source-number RTAS call, or as
> + *      returned by the H_ALLOCATE_VAS_WINDOW hcall
> + *
> + * Output:
> + * - None
> + */
> +static target_ulong h_int_sync(PowerPCCPU *cpu,
> +                               sPAPRMachineState *spapr,
> +                               target_ulong opcode,
> +                               target_ulong *args)
> +{
> +    XiveIVE *ive;
> +    target_ulong flags   =3D args[0];
> +    target_ulong lisn    =3D args[1];
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags) {
> +        return H_PARAMETER;
> +    }
> +
> +    ive =3D spapr_xive_get_ive(spapr->xive, lisn);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        return H_P2;
> +    }
> +
> +    /*
> +     * H_STATE should be returned if a H_INT_RESET is in progress.
> +     * This is not needed when running the emulation under QEMU
> +     */
> +
> +    /* This is not real hardware. Nothing to be done */
> +    return H_SUCCESS;
> +}
> +
> +/*
> + * The H_INT_RESET hcall() is used to reset all of the partition's
> + * interrupt exploitation structures to their initial state.  This
> + * means losing all previously set interrupt state set via
> + * H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
> + *
> + * Parameters:
> + * Input:
> + * - "flags"
> + *      Bits 0-63: Reserved
> + *
> + * Output:
> + * - None
> + */
> +static target_ulong h_int_reset(PowerPCCPU *cpu,
> +                                sPAPRMachineState *spapr,
> +                                target_ulong opcode,
> +                                target_ulong *args)
> +{
> +    target_ulong flags   =3D args[0];
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags) {
> +        return H_PARAMETER;
> +    }
> +
> +    spapr_xive_reset(spapr->xive);
> +    return H_SUCCESS;
> +}
> +
> +void spapr_xive_hcall_init(sPAPRMachineState *spapr)
> +{
> +    spapr_register_hypercall(H_INT_GET_SOURCE_INFO, h_int_get_source_inf=
o);
> +    spapr_register_hypercall(H_INT_SET_SOURCE_CONFIG, h_int_set_source_c=
onfig);
> +    spapr_register_hypercall(H_INT_GET_SOURCE_CONFIG, h_int_get_source_c=
onfig);
> +    spapr_register_hypercall(H_INT_GET_QUEUE_INFO, h_int_get_queue_info);
> +    spapr_register_hypercall(H_INT_SET_QUEUE_CONFIG, h_int_set_queue_con=
fig);
> +    spapr_register_hypercall(H_INT_GET_QUEUE_CONFIG, h_int_get_queue_con=
fig);
> +    spapr_register_hypercall(H_INT_SET_OS_REPORTING_LINE,
> +                             h_int_set_os_reporting_line);
> +    spapr_register_hypercall(H_INT_GET_OS_REPORTING_LINE,
> +                             h_int_get_os_reporting_line);
> +    spapr_register_hypercall(H_INT_ESB, h_int_esb);
> +    spapr_register_hypercall(H_INT_SYNC, h_int_sync);
> +    spapr_register_hypercall(H_INT_RESET, h_int_reset);
> +}
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ca4e72187f60..8b15c0b500d0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -222,6 +222,8 @@ static sPAPRXive *spapr_xive_create(sPAPRMachineState=
 *spapr, int nr_irqs,
>          goto error;
>      }
> =20
> +    spapr_xive_hcall_init(spapr);
> +
>      return SPAPR_XIVE(obj);
>  error:
>      error_propagate(errp, local_err);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 90e2b0f6c678..a25e218b34e2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -387,7 +387,20 @@ struct sPAPRMachineState {
>  #define H_INVALIDATE_PID        0x378
>  #define H_REGISTER_PROC_TBL     0x37C
>  #define H_SIGNAL_SYS_RESET      0x380
> -#define MAX_HCALL_OPCODE        H_SIGNAL_SYS_RESET
> +
> +#define H_INT_GET_SOURCE_INFO   0x3A8
> +#define H_INT_SET_SOURCE_CONFIG 0x3AC
> +#define H_INT_GET_SOURCE_CONFIG 0x3B0
> +#define H_INT_GET_QUEUE_INFO    0x3B4
> +#define H_INT_SET_QUEUE_CONFIG  0x3B8
> +#define H_INT_GET_QUEUE_CONFIG  0x3BC
> +#define H_INT_SET_OS_REPORTING_LINE 0x3C0
> +#define H_INT_GET_OS_REPORTING_LINE 0x3C4
> +#define H_INT_ESB               0x3C8
> +#define H_INT_SYNC              0x3CC
> +#define H_INT_RESET             0x3D0
> +
> +#define MAX_HCALL_OPCODE        H_INT_RESET
> =20
>  /* The hcalls above are standardized in PAPR and implemented by pHyp
>   * as well.
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 6e8a189e723f..3f822220647f 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -79,4 +79,8 @@ bool spapr_xive_irq_unset(sPAPRXive *xive, uint32_t lis=
n);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>  void spapr_xive_icp_pic_print_info(sPAPRXiveICP *xicp, Monitor *mon);
> =20
> +typedef struct sPAPRMachineState sPAPRMachineState;
> +
> +void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> +
>  #endif /* PPC_SPAPR_XIVE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlog1AkACgkQbDjKyiDZ
s5L+kg//YShWerK4NOexMwacnSptiFBy+C0ANbgUYmyORJe0mFIyGrDEuI9i6C9L
ebfz4JSIU9apdANDsX0jtsQ3KmTcZ/p8mbc99ifBds/uiakbU4cQ1WKLFc3Jb9uM
HpXdyEIiEbMDkPSQK4Ddy/CXCWKJz0OaVjvjffuk/9Q7IkdLG8uG10ZZTT2bYACC
kMboDD35XgkC8xwf03a1DhVIj1y6hiqf4unwQpkK6aeNasn/CA278BrL+BmHreak
LyTxrXuBg6tTzowfvz6X8uds+00GYPGg2EMb1Yks5d2cF7h6lQ9D3hbsQJIvlFDx
N6UgrtceN19saw+VGV6ugN6WiYe46zozTaS8G7KQX3NuKB6JrOPnM7Euvif2dAql
jMTWHSTMoX5uyBuxU5USPo9vrDnY4QrJZTNbXFSgJ2JAWpzUZ/8+UmqfSTThZ5nY
77nblMkB+L4Xotg2TjoSnrdtjd2k5+hikRzyRHqNY49vBCRpOU89kQs2/zzqwD5u
v2u0zUKsjt2U3BLAmvcEZIwk5T8klTqkxgd8zCPOaQQsZUoqBF27LDrrz6rqy137
V+1P20IfGPIzUNGUVP0SAF9dAjNZ8Rhh+VzDD+BBpyCAL1EYfp9BpRjHF99GRu/l
2temlXHSDNYfHNEdCPo/3jGnOSIq113KkzoZ+rrgwfT5vX969sE=
=L66Z
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
