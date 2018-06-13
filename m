Received: from eggs.gnu.org ([2001:4830:134:3::10]:33436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT1qp-00007A-B5
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT1qm-00075C-4E
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:13:59 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:35601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT1ql-00074B-TF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:13:56 -0400
Received: from player693.ha.ovh.net (unknown [10.109.120.58])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 532E11C0EC3
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 11:13:54 +0200 (CEST)
Date: Wed, 13 Jun 2018 11:13:49 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613111349.4be4857b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180613065707.30766-4-david@gibson.dropbear.id.au>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] pnv_core: Allocate cpu thread objects
 individually
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 13 Jun 2018 16:57:03 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently, we allocate space for all the cpu objects within a single core
> in one big block.  This was copied from an older version of the spapr code
> and requires some ugly pointer manipulation to extract the individual
> objects.
> 
> This design was due to a misunderstanding of qemu lifetime conventions and
> has already been changed in spapr (in 94ad93bd "spapr_cpu_core: instantiate
> CPUs separately".
> 
> Make an equivalent change in pnv_core to get rid of the nasty pointer
> arithmetic.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/pnv.c              |  4 ++--
>  hw/ppc/pnv_core.c         | 11 +++++------
>  include/hw/ppc/pnv_core.h |  2 +-
>  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0314881316..0b9508d94d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -121,9 +121,9 @@ static int get_cpus_node(void *fdt)
>   */
>  static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>  {
> -    CPUState *cs = CPU(DEVICE(pc->threads));
> +    PowerPCCPU *cpu = pc->threads[0];
> +    CPUState *cs = CPU(cpu);
>      DeviceClass *dc = DEVICE_GET_CLASS(cs);
> -    PowerPCCPU *cpu = POWERPC_CPU(cs);
>      int smt_threads = CPU_CORE(pc)->nr_threads;
>      CPUPPCState *env = &cpu->env;
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index efb68226bb..59309e149c 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -151,7 +151,6 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>      PnvCore *pc = PNV_CORE(OBJECT(dev));
>      CPUCore *cc = CPU_CORE(OBJECT(dev));
>      const char *typename = pnv_core_cpu_typename(pc);
> -    size_t size = object_type_get_instance_size(typename);
>      Error *local_err = NULL;
>      void *obj;
>      int i, j;
> @@ -165,11 +164,11 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    pc->threads = g_malloc0(size * cc->nr_threads);
> +    pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
>      for (i = 0; i < cc->nr_threads; i++) {
> -        obj = pc->threads + i * size;
> +        obj = object_new(typename);
>  
> -        object_initialize(obj, size, typename);
> +        pc->threads[i] = POWERPC_CPU(obj);
>  
>          snprintf(name, sizeof(name), "thread[%d]", i);
>          object_property_add_child(OBJECT(pc), name, obj, &local_err);
> @@ -185,7 +184,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>      }
>  
>      for (j = 0; j < cc->nr_threads; j++) {
> -        obj = pc->threads + j * size;
> +        obj = OBJECT(pc->threads[j]);
>  
>          pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
>          if (local_err) {
> @@ -200,7 +199,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>  
>  err:
>      while (--i >= 0) {
> -        obj = pc->threads + i * size;
> +        obj = OBJECT(pc->threads[i]);
>          object_unparent(obj);
>      }
>      g_free(pc->threads);
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index e337af7a3a..447ae761f7 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -34,7 +34,7 @@ typedef struct PnvCore {
>      CPUCore parent_obj;
>  
>      /*< public >*/
> -    void *threads;
> +    PowerPCCPU **threads;
>      uint32_t pir;
>  
>      MemoryRegion xscom_regs;
