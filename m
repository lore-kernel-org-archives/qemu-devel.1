Received: from eggs.gnu.org ([2001:4830:134:3::10]:53496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f0imv-00074H-Hy
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f0ims-0006ah-CS
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:12:57 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:34887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f0ims-0006Xm-4L
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 03:12:54 -0400
Received: from player737.ha.ovh.net (unknown [10.109.108.172])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 24D60125E86
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:12:46 +0200 (CEST)
Date: Tue, 27 Mar 2018 09:12:36 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180327091236.08b3ada3@bahia.lan>
In-Reply-To: <20180327043741.7705-2-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 01/12] target/ppc: Standardize
 instance_init and realize function names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, clg@kaod.org

On Tue, 27 Mar 2018 15:37:30 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Because of the various hooks called some variant on "init" - and the rather
> greater number that used to exist, I'm always wondering when a function
> called simply "*_init" or "*_initfn" will be called.
> 
> To make it easier on myself, and maybe others, rename the instance_init
> hooks for ppc cpus to *_instance_init().  While we're at it rename the
> realize time hooks to *_realize() (from *_realizefn()) which seems to be
> the more common current convention.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/translate_init.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 391b94b97d..56b80a204a 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9726,7 +9726,7 @@ static inline bool ppc_cpu_is_valid(PowerPCCPUClass *pcc)
>  #endif
>  }
>  
> -static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
> +static void ppc_cpu_realize(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
>      PowerPCCPU *cpu = POWERPC_CPU(dev);
> @@ -9952,7 +9952,7 @@ unrealize:
>      cpu_exec_unrealizefn(cs);
>  }
>  
> -static void ppc_cpu_unrealizefn(DeviceState *dev, Error **errp)
> +static void ppc_cpu_unrealize(DeviceState *dev, Error **errp)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(dev);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> @@ -10438,7 +10438,7 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
>  }
>  #endif
>  
> -static void ppc_cpu_initfn(Object *obj)
> +static void ppc_cpu_instance_init(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
>      PowerPCCPU *cpu = POWERPC_CPU(obj);
> @@ -10561,9 +10561,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>      CPUClass *cc = CPU_CLASS(oc);
>      DeviceClass *dc = DEVICE_CLASS(oc);
>  
> -    device_class_set_parent_realize(dc, ppc_cpu_realizefn,
> +    device_class_set_parent_realize(dc, ppc_cpu_realize,
>                                      &pcc->parent_realize);
> -    device_class_set_parent_unrealize(dc, ppc_cpu_unrealizefn,
> +    device_class_set_parent_unrealize(dc, ppc_cpu_unrealize,
>                                        &pcc->parent_unrealize);
>      pcc->pvr_match = ppc_pvr_match_default;
>      pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_always;
> @@ -10623,7 +10623,7 @@ static const TypeInfo ppc_cpu_type_info = {
>      .name = TYPE_POWERPC_CPU,
>      .parent = TYPE_CPU,
>      .instance_size = sizeof(PowerPCCPU),
> -    .instance_init = ppc_cpu_initfn,
> +    .instance_init = ppc_cpu_instance_init,
>      .abstract = true,
>      .class_size = sizeof(PowerPCCPUClass),
>      .class_init = ppc_cpu_class_init,
