Received: from eggs.gnu.org ([2001:4830:134:3::10]:39488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZZq0-0003Yo-AQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZZpx-0003AL-5b
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:39:40 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:36168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dZZpw-000398-Tu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:39:37 -0400
Received: by mail-io0-x22d.google.com with SMTP id g35so8294429ioi.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 02:39:36 -0700 (PDT)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-18-git-send-email-clg@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <64a506b0-9ba0-0fce-9285-534710a492b4@ozlabs.ru>
Date: Mon, 24 Jul 2017 19:39:31 +1000
MIME-Version: 1.0
In-Reply-To: <1499274819-15607-18-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 17/26] ppc/xive: add hcalls
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/07/17 03:13, Cédric Le Goater wrote:
> A set of Hypervisor's call are used to configure the interrupt sources
> and the event/notification queues of the guest:
> 
>    H_INT_GET_SOURCE_INFO
>    H_INT_SET_SOURCE_CONFIG
>    H_INT_GET_SOURCE_CONFIG
>    H_INT_GET_QUEUE_INFO
>    H_INT_SET_QUEUE_CONFIG
>    H_INT_GET_QUEUE_CONFIG
>    H_INT_RESET
>    H_INT_ESB
> 
> Calls that still need to be addressed :
> 
>    H_INT_SET_OS_REPORTING_LINE
>    H_INT_GET_OS_REPORTING_LINE
>    H_INT_SYNC
> 
> See below for the documentation on each hcall.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  default-configs/ppc64-softmmu.mak |   1 +
>  hw/intc/Makefile.objs             |   1 +
>  hw/intc/xive_spapr.c              | 745 ++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h            |  17 +-
>  include/hw/ppc/xive.h             |   4 +
>  5 files changed, 767 insertions(+), 1 deletion(-)
>  create mode 100644 hw/intc/xive_spapr.c
> 
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
> index 1179c07e6e9f..3888168adf95 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -57,6 +57,7 @@ CONFIG_XICS=$(CONFIG_PSERIES)
>  CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
>  CONFIG_XICS_KVM=$(and $(CONFIG_PSERIES),$(CONFIG_KVM))
>  CONFIG_XIVE=$(CONFIG_PSERIES)
> +CONFIG_XIVE_SPAPR=$(CONFIG_PSERIES)
>  # For PReP
>  CONFIG_SERIAL_ISA=y
>  CONFIG_MC146818RTC=y
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index 28b83456bfcc..31b4fae2d1a8 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -36,6 +36,7 @@ obj-$(CONFIG_XICS) += xics.o
>  obj-$(CONFIG_XICS_SPAPR) += xics_spapr.o
>  obj-$(CONFIG_XICS_KVM) += xics_kvm.o
>  obj-$(CONFIG_XIVE) += xive.o
> +obj-$(CONFIG_XIVE_SPAPR) += xive_spapr.o
>  obj-$(CONFIG_POWERNV) += xics_pnv.o
>  obj-$(CONFIG_ALLWINNER_A10_PIC) += allwinner-a10-pic.o
>  obj-$(CONFIG_S390_FLIC) += s390_flic.o
> diff --git a/hw/intc/xive_spapr.c b/hw/intc/xive_spapr.c
> new file mode 100644
> index 000000000000..b634d1f28f10
> --- /dev/null
> +++ b/hw/intc/xive_spapr.c
> @@ -0,0 +1,745 @@
> +/*
> + * QEMU PowerPC XIVE model for pSeries
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
> +#include "hw/ppc/xive.h"
> +#include "hw/ppc/fdt.h"
> +#include "monitor/monitor.h"
> +
> +#include "xive-internal.h"
> +
> +static XiveICSState *xive_ics_find(sPAPRMachineState *spapr, uint32_t lisn)
> +{
> +    XICSFabricClass *xic = XICS_FABRIC_GET_CLASS(spapr);
> +    ICSState *ics = xic->ics_get(XICS_FABRIC(spapr), lisn);
> +
> +    return ICS_XIVE(ics);
> +}
> +
> +static bool priority_is_valid(int priority)
> +{
> +    return priority >= 0 && priority < 8;
> +}
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
> + *       Bit 61: 1 == LSI  0 == MSI
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
> +    target_ulong flags  = args[0];
> +    target_ulong lisn   = args[1];
> +    XiveICSState *xs;
> +    uint32_t srcno;
> +    uint64_t mmio_base;
> +    ICSIRQState *irq;
> +
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return H_FUNCTION;
> +    }
> +
> +    if (flags) {
> +        return H_PARAMETER;
> +    }
> +
> +    xs = xive_ics_find(spapr, lisn);
> +    if (!xs) {
> +        return H_P2;
> +    }
> +
> +    srcno = lisn - ICS_BASE(xs)->offset;
> +    mmio_base = (uint64_t)xs->esb_base + (1ull << xs->esb_shift) * srcno;
> +    irq = &ICS_BASE(xs)->irqs[srcno];
> +
> +    args[0] = 0;
> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> +        args[0] |= XIVE_SRC_LSI;
> +    }
> +    if (xs->flags & XIVE_SRC_TRIGGER) {
> +        args[0] |= XIVE_SRC_TRIGGER;
> +    }
> +
> +    /* never used in QEMU  */
> +    if (xs->flags & XIVE_SRC_H_INT_ESB) {
> +        args[1] = -1;


args[2] in undefined here.


> +    } else {
> +        args[1] = mmio_base;
> +        if (xs->flags & XIVE_SRC_TRIGGER) {
> +            args[2] = -1; /* No specific trigger page */
> +        } else {
> +            args[2] = -1; /* TODO: support for specific trigger page */
> +        }
> +    }
> +
> +    args[3] = xs->esb_shift;
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
> + * The old EQ should be investigated for interrupts that occurred
> + * prior to or during the hcall().
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
> +
> +static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
> +                                            sPAPRMachineState *spapr,
> +                                            target_ulong opcode,
> +                                            target_ulong *args)
> +{
> +    XiveIVE *ive;
> +    uint64_t new_ive;
> +    target_ulong flags    = args[0];
> +    target_ulong lisn     = args[1];
> +    target_ulong target   = args[2];
> +    target_ulong priority = args[3];
> +    target_ulong eisn     = args[4];
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
> +    ive = xive_get_ive(spapr->xive, lisn);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        return H_P2;
> +    }
> +    new_ive = ive->w;
> +
> +    /* Let's handle 0xff priority as if the interrupt was masked */
> +    if (priority == 0xff || (flags & XIVE_SRC_MASK)) {
> +        new_ive |= IVE_MASKED;
> +        priority = 7;
> +    } else {
> +        new_ive = ive->w & ~IVE_MASKED;
> +    }
> +
> +    if (!priority_is_valid(priority)) {
> +        return H_P4;
> +    }
> +
> +    /* First find the EQ corresponding to the target */
> +    if (!xive_eq_for_target(spapr->xive, target, priority, &eq_idx)) {
> +        return H_P3;
> +    }
> +
> +    /* And update */
> +    new_ive = SETFIELD(IVE_EQ_BLOCK, new_ive, 0ul);
> +    new_ive = SETFIELD(IVE_EQ_INDEX, new_ive, eq_idx);
> +
> +    if (flags & XIVE_SRC_SET_EISN) {
> +        new_ive = SETFIELD(IVE_EQ_DATA, new_ive, eisn);
> +    }
> +
> +    ive->w = new_ive;
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
> + */
> +static target_ulong h_int_get_source_config(PowerPCCPU *cpu,
> +                                            sPAPRMachineState *spapr,
> +                                            target_ulong opcode,
> +                                            target_ulong *args)
> +{
> +    target_ulong flags = args[0];
> +    target_ulong lisn = args[1];
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
> +    ive = xive_get_ive(spapr->xive, lisn);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        return H_P2;
> +    }
> +
> +    eq_idx = GETFIELD(IVE_EQ_INDEX, ive->w);
> +    eq = xive_get_eq(spapr->xive, eq_idx);
> +    if (!eq) {
> +        return H_P2;
> +    }
> +
> +    if (ive->w & IVE_MASKED) {
> +        args[1] = 0xff;
> +    } else {
> +        args[1] = GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
> +    }
> +
> +    args[0] = GETFIELD(EQ_W6_NVT_INDEX, eq->w6);



R6 is missing but you added it in your github tree so never mind :)





-- 
Alexey
