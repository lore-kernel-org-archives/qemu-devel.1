Received: from eggs.gnu.org ([2001:4830:134:3::10]:38978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKQYf-0005Fc-Gy
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKQYZ-00035q-2n
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:15:25 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:59115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKQYY-00035A-Pz
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:15:19 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3CC1C1260CE
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 16:15:17 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
	<20171130055542.GG3023@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2cee93ff-060a-aa04-852c-d3585dba0c7f@kaod.org>
Date: Thu, 30 Nov 2017 15:15:09 +0000
MIME-Version: 1.0
In-Reply-To: <20171130055542.GG3023@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/30/2017 05:55 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:47PM +0100, C=E9dric Le Goater wrote:
>> The XIVE object is designed to be always available, so it is created
>> unconditionally on newer machines.
>=20
> There doesn't actually seem to be anything dependent on machine
> version here.

No. I thought that was too early in the patchset. This is handled=20
in the last patch with a 'xive_exploitation' bool which is set to=20
false on older machines.=20

But, nevertheless, the XIVE objects are always created even if not
used. Something to discuss.=20

>> Depending on the configuration and
>> the guest capabilities, the CAS negotiation process will decide which
>> interrupt model to use, legacy or XIVE.
>>
>> The XIVE model makes use of the full range of the IRQ number space
>> because the IRQ numbers for the CPU IPIs are allocated in the range
>> below XICS_IRQ_BASE, which is unused by XICS.
>=20
> Ok.  And I take it 4096 is enough space for the XIVE IPIs for the
> forseeable future?

The biggest real system I am aware of as 16 sockets, 192 cores, SMT8.=20
That's 1536 cpus. pseries has a max_cpus of 1024.=20

>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/spapr.c         | 34 ++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |  2 ++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 5d3325ca3c88..0e0107c8272c 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -56,6 +56,7 @@
>>  #include "hw/ppc/spapr_vio.h"
>>  #include "hw/pci-host/spapr.h"
>>  #include "hw/ppc/xics.h"
>> +#include "hw/ppc/spapr_xive.h"
>>  #include "hw/pci/msi.h"
>> =20
>>  #include "hw/pci/pci.h"
>> @@ -204,6 +205,29 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
>>      }
>>  }
>> =20
>> +static sPAPRXive *spapr_xive_create(sPAPRMachineState *spapr, int nr_=
irqs,
>> +                                    Error **errp)
>> +{
>> +    Error *local_err =3D NULL;
>> +    Object *obj;
>> +
>> +    obj =3D object_new(TYPE_SPAPR_XIVE);
>> +    object_property_add_child(OBJECT(spapr), "xive", obj, &error_abor=
t);
>> +    object_property_set_int(obj, nr_irqs, "nr-irqs",  &local_err);
>> +    if (local_err) {
>> +        goto error;
>> +    }
>> +    object_property_set_bool(obj, true, "realized", &local_err);
>> +    if (local_err) {
>> +        goto error;
>> +    }
>> +
>> +    return SPAPR_XIVE(obj);
>> +error:
>> +    error_propagate(errp, local_err);
>> +    return NULL;
>> +}
>> +
>>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *=
cpu,
>>                                    int smt_threads)
>>  {
>> @@ -2360,6 +2384,16 @@ static void ppc_spapr_init(MachineState *machin=
e)
>>      /* Set up Interrupt Controller before we create the VCPUs */
>>      xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
>> =20
>> +    /* We don't have KVM support yet, so check for irqchip=3Don */
>> +    if (kvm_enabled() && machine_kernel_irqchip_required(machine)) {
>> +        error_report("kernel_irqchip requested. no XIVE support");
>=20
> I think you want an actual exit(1) here, no?  error_report() will
> print an error but keep going.

yes. Today, it coredumps. I am not sure why. I will add an exit().

>=20
>> +    } else {
>> +        /* XIVE uses the full range of IRQ numbers. The CPU IPIs will
>> +         * use the range below XICS_IRQ_BASE, which is unused by XICS=
. */
>> +        spapr->xive =3D spapr_xive_create(spapr, XICS_IRQ_BASE + XICS=
_IRQS_SPAPR,
>> +                                        &error_fatal);
>=20
> XICS_IRQ_BASE =3D=3D 4096, and XICS_IRQS_SPAPR (which we should rename =
at
> some point) =3D=3D 1024.
>=20
> So we have a total irq space of 5k, which is a bit odd.  I'd be ok
> with rounding it out to 8k for newer machines if that's useful.
> Sparse allocations in there might make life easier for getting
> consistent irq numbers without an "allocator" per se (because we can
> use different regions for VIO, PCI intx, MSI, etc. etc.).
I will start another thread on that topic.

Thanks,

C.=20

>=20
>> +    }
>> +
>>      /* Set up containers for ibm,client-architecture-support negotiat=
ed options
>>       */
>>      spapr->ov5 =3D spapr_ovec_new();
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 9a3885593c86..90e2b0f6c678 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -14,6 +14,7 @@ struct sPAPRNVRAM;
>>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>>  typedef struct sPAPREventSource sPAPREventSource;
>>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
>> +typedef struct sPAPRXive sPAPRXive;
>> =20
>>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>>  #define SPAPR_ENTRY_POINT       0x100
>> @@ -127,6 +128,7 @@ struct sPAPRMachineState {
>>      MemoryHotplugState hotplug_memory;
>> =20
>>      const char *icp_type;
>> +    sPAPRXive  *xive;
>>  };
>> =20
>>  #define H_SUCCESS         0
>=20
