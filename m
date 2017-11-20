Received: from eggs.gnu.org ([2001:4830:134:3::10]:46093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eGnVJ-0004JT-CM
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eGnVE-0008BN-Hz
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:56:57 -0500
Date: Mon, 20 Nov 2017 15:56:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171120155648.21bcbe5b@redhat.com>
In-Reply-To: <151116959472.32765.11476730637006052305.stgit@bahia.lan>
References: <151116959472.32765.11476730637006052305.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 REPOST] spapr_cpu_core:
 instantiate CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Mon, 20 Nov 2017 10:19:54 +0100
Greg Kurz <groug@kaod.org> wrote:

> The current code assumes that only the CPU core object holds a
> reference on each individual CPU object, and happily frees their
> allocated memory when the core is unrealized. This is dangerous
> as some other code can legitimely keep a pointer to a CPU if it
> calls object_ref(), but it would end up with a dangling pointer.
> 
> Let's allocate all CPUs with object_new() and let QOM frees them
s/frees/free/

> when their reference count reaches zero. This greatly simplify the
> code as we don't have to fiddle with the instance size anymore.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/ppc/spapr.c                  |   11 +++--------
>  hw/ppc/spapr_cpu_core.c         |   19 +++++++------------
>  include/hw/ppc/spapr_cpu_core.h |    2 +-
>  3 files changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 174e7ff0678d..fc92b9d914a5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3173,12 +3173,10 @@ void spapr_core_release(DeviceState *dev)
>  
>      if (smc->pre_2_10_has_unused_icps) {
>          sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> -        sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> -        size_t size = object_type_get_instance_size(scc->cpu_type);
>          int i;
>  
>          for (i = 0; i < cc->nr_threads; i++) {
> -            CPUState *cs = CPU(sc->threads + i * size);
> +            CPUState *cs = CPU(sc->threads[i]);
>  
>              pre_2_10_vmstate_register_dummy_icp(cs->cpu_index);
>          }
> @@ -3224,7 +3222,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>      sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));
>      CPUCore *cc = CPU_CORE(dev);
> -    CPUState *cs = CPU(core->threads);
> +    CPUState *cs = CPU(core->threads[0]);
>      sPAPRDRConnector *drc;
>      Error *local_err = NULL;
>      int smt = kvmppc_smt_threads();
> @@ -3269,15 +3267,12 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      core_slot->cpu = OBJECT(dev);
>  
>      if (smc->pre_2_10_has_unused_icps) {
> -        sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> -        size_t size = object_type_get_instance_size(scc->cpu_type);
>          int i;
>  
>          for (i = 0; i < cc->nr_threads; i++) {
>              sPAPRCPUCore *sc = SPAPR_CPU_CORE(dev);
> -            void *obj = sc->threads + i * size;
>  
> -            cs = CPU(obj);
> +            cs = CPU(sc->threads[i]);
>              pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
>          }
>      }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3a4c17401226..588f9b45714a 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -79,13 +79,11 @@ const char *spapr_get_cpu_core_type(const char *cpu_type)
>  static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>  {
>      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> -    sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> -    size_t size = object_type_get_instance_size(scc->cpu_type);
>      CPUCore *cc = CPU_CORE(dev);
>      int i;
>  
>      for (i = 0; i < cc->nr_threads; i++) {
> -        void *obj = sc->threads + i * size;
> +        Object *obj = OBJECT(sc->threads[i]);
>          DeviceState *dev = DEVICE(obj);
>          CPUState *cs = CPU(dev);
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
> @@ -146,9 +144,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc = CPU_CORE(OBJECT(dev));
> -    size_t size;
>      Error *local_err = NULL;
> -    void *obj;
> +    Object *obj;
>      int i, j;
>  
>      if (!spapr) {
> @@ -156,18 +153,16 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    size = object_type_get_instance_size(scc->cpu_type);
> -    sc->threads = g_malloc0(size * cc->nr_threads);
> +    sc->threads = g_new(PowerPCCPU *, cc->nr_threads);
>      for (i = 0; i < cc->nr_threads; i++) {
>          char id[32];
>          CPUState *cs;
>          PowerPCCPU *cpu;
>  
> -        obj = sc->threads + i * size;
> +        obj = object_new(scc->cpu_type);
>  
> -        object_initialize(obj, size, scc->cpu_type);
>          cs = CPU(obj);
> -        cpu = POWERPC_CPU(cs);
> +        cpu = sc->threads[i] = POWERPC_CPU(obj);
>          cs->cpu_index = cc->core_id + i;
>          cpu->vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i;
>          if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
> @@ -192,7 +187,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>      }
>  
>      for (j = 0; j < cc->nr_threads; j++) {
> -        obj = sc->threads + j * size;
> +        obj = OBJECT(sc->threads[j]);
>  
>          spapr_cpu_core_realize_child(obj, spapr, &local_err);
>          if (local_err) {
> @@ -203,7 +198,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>  
>  err:
>      while (--i >= 0) {
> -        obj = sc->threads + i * size;
> +        obj = OBJECT(sc->threads[i]);
>          object_unparent(obj);
>      }
>      g_free(sc->threads);
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index f2d48d6a6786..1129f344aa0c 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -28,7 +28,7 @@ typedef struct sPAPRCPUCore {
>      CPUCore parent_obj;
>  
>      /*< public >*/
> -    void *threads;
> +    PowerPCCPU **threads;
>      int node_id;
>  } sPAPRCPUCore;
>  
> 
> 
