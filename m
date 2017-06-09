Received: from eggs.gnu.org ([2001:4830:134:3::10]:41509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dJIck-0005Si-Hh
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dJIcf-0006zN-Gg
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:02:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53566
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dJIcf-0006zD-9n
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:02:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v59BxMBb127384
	for <qemu-devel@nongnu.org>; Fri, 9 Jun 2017 08:02:36 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ayqjvk2vt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 08:02:35 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 9 Jun 2017 09:02:33 -0300
References: <20170609110810.3951-1-lvivier@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 9 Jun 2017 09:02:25 -0300
MIME-Version: 1.0
In-Reply-To: <20170609110810.3951-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <01fbe6da-711a-ea69-4c31-d33c5b08d690@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: manage hotplugged devices while
 the VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>



On 06/09/2017 08:08 AM, Laurent Vivier wrote:
> For QEMU, a hotlugged device is a device added using the HMP/QMP
> interface.
> For SPAPR, a hotplugged device is a device added while the
> machine is running. In this case QEMU doesn't update internal
> state but relies on the OS for this part
>
> In the case of migration, when we (libvirt) hotplug a device
> on the source guest, we (libvirt) generally hotplug the same
> device on the destination guest. But in this case, the machine
> is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
> the OS will manage it as an hotplugged device as it will
> be "imported" by the migration.
>
> This patch changes the meaning of "hotplugged" in spapr.c
> to manage a QEMU hotplugged device like a "coldplugged" one
> when the machine is awaiting an incoming migration.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
> v2: fix the minor nit reported by dgibson
>
>      I repost the patch as I think it is good to have
>      devices in a good state before migration (it is
>      generally a pre-requisite for migration),
>      so a hotplugged CPU before incoming migration
>      appears like a coldplugged one, and moreover
>      it fixes the use case in which CPU are hotplugged
>      on both side (src and dest), and we try to unplug
>      the CPU after the migration.

Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>


>
>   hw/ppc/spapr.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 91b4057..d5a3587 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2518,6 +2518,12 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
>       }
>   }
>
> +static bool spapr_coldplugged(DeviceState *dev)
> +{
> +    return runstate_check(RUN_STATE_INMIGRATE) ||
> +           !dev->hotplugged;
> +}
> +
>   static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>                              uint32_t node, bool dedicated_hp_event_source,
>                              Error **errp)
> @@ -2528,6 +2534,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>       int i, fdt_offset, fdt_size;
>       void *fdt;
>       uint64_t addr = addr_start;
> +    bool coldplugged = spapr_coldplugged(dev);
>
>       for (i = 0; i < nr_lmbs; i++) {
>           drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> @@ -2539,9 +2546,9 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>                                                   SPAPR_MEMORY_BLOCK_SIZE);
>
>           drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
> +        drck->attach(drc, dev, fdt, fdt_offset, coldplugged, errp);
>           addr += SPAPR_MEMORY_BLOCK_SIZE;
> -        if (!dev->hotplugged) {
> +        if (coldplugged) {
>               /* guests expect coldplugged LMBs to be pre-allocated */
>               drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
>               drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
> @@ -2550,7 +2557,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
>       /* send hotplug notification to the
>        * guest only in case of hotplugged memory
>        */
> -    if (dev->hotplugged) {
> +    if (!coldplugged) {
>           if (dedicated_hp_event_source) {
>               drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
>                                     addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> @@ -2863,6 +2870,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       int smt = kvmppc_smt_threads();
>       CPUArchId *core_slot;
>       int index;
> +    bool coldplugged = spapr_coldplugged(dev);
>
>       core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
>       if (!core_slot) {
> @@ -2884,7 +2892,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>
>       if (drc) {
>           sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local_err);
> +        drck->attach(drc, dev, fdt, fdt_offset, coldplugged, &local_err);
>           if (local_err) {
>               g_free(fdt);
>               error_propagate(errp, local_err);
> @@ -2892,7 +2900,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           }
>       }
>
> -    if (dev->hotplugged) {
> +    if (!coldplugged) {
>           /*
>            * Send hotplug notification interrupt to the guest only in case
>            * of hotplugged CPUs.
