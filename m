Received: from eggs.gnu.org ([2001:4830:134:3::10]:57923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dxp2C-0005ej-Rp
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 02:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dxp28-000209-Vh
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 02:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dxp28-0001zn-MF
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 02:44:24 -0400
Date: Fri, 29 Sep 2017 08:44:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170929084421.2417a519@nial.brq.redhat.com>
In-Reply-To: <20170927181834.76c5d2ef@bahia.lan>
References: <20170927062143.GN12504@umbus>
	<1506512957-196068-1-git-send-email-imammedo@redhat.com>
	<20170927181834.76c5d2ef@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] ppc: define spapr core types statically
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au
List-ID: <qemu-devel.nongnu.org>

On Wed, 27 Sep 2017 18:18:34 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 27 Sep 2017 13:49:17 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > --
> > patch does 3 things at the same time and should be split but
> > it has 'host' consolidation is it as well to demonstrate idea
> > --
> > 
> > spapr core type definition doesn't have any fields that
> > require it to be defined at runtime. So replace code
> > that fills in TypeInfo at runtime with static TypeInfo
> > array that does the same at complie time.
> > 
> > And replace sPAPRCPUCoreClass::cpu_class with cpu
> > type name since were used just to get that at points
> > it were accessed.
> > 
> > While at that, consolidate move 'host' core type
> > registration into spapr_cpu_core.c, similar like
> > it's done in x86 target.
> >   
> 
> This looks nice indeed (just one remark, see below).
> 
> Will you re-post as a patch series or do you prefer I do it ?
I'll repost it as part of cpu_model removal series (ppc part)

> 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/ppc/spapr_cpu_core.h |  5 ++-
> >  hw/ppc/spapr.c                  |  6 +--
> >  hw/ppc/spapr_cpu_core.c         | 93 ++++++++++++++++-------------------------
> >  target/ppc/kvm.c                | 11 -----
> >  4 files changed, 41 insertions(+), 74 deletions(-)
> > 
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> > index 93051e9..42765de 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -21,6 +21,8 @@
> >  #define SPAPR_CPU_CORE_GET_CLASS(obj) \
> >       OBJECT_GET_CLASS(sPAPRCPUCoreClass, (obj), TYPE_SPAPR_CPU_CORE)
> >  
> > +#define SPAPR_CPU_CORE_TYPE_NAME(model) model "-" TYPE_SPAPR_CPU_CORE
> > +
> >  typedef struct sPAPRCPUCore {
> >      /*< private >*/
> >      CPUCore parent_obj;
> > @@ -32,9 +34,8 @@ typedef struct sPAPRCPUCore {
> >  
> >  typedef struct sPAPRCPUCoreClass {
> >      DeviceClass parent_class;
> > -    ObjectClass *cpu_class;
> > +    const char *cpu_type;
> >  } sPAPRCPUCoreClass;
> >  
> >  char *spapr_get_cpu_core_type(const char *model);
> > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> >  #endif
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 8c1a437..00cfe9a 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3125,8 +3125,7 @@ void spapr_core_release(DeviceState *dev)
> >      if (smc->pre_2_10_has_unused_icps) {
> >          sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> >          sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> > -        const char *typename = object_class_get_name(scc->cpu_class);
> > -        size_t size = object_type_get_instance_size(typename);
> > +        size_t size = object_type_get_instance_size(scc->cpu_type);
> >          int i;
> >  
> >          for (i = 0; i < cc->nr_threads; i++) {
> > @@ -3222,8 +3221,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >  
> >      if (smc->pre_2_10_has_unused_icps) {
> >          sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> > -        const char *typename = object_class_get_name(scc->cpu_class);
> > -        size_t size = object_type_get_instance_size(typename);
> > +        size_t size = object_type_get_instance_size(scc->cpu_type);
> >          int i;
> >  
> >          for (i = 0; i < cc->nr_threads; i++) {
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 5bea4c9..8a18eaf 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -104,8 +104,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
> >  {
> >      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> >      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> > -    const char *typename = object_class_get_name(scc->cpu_class);
> > -    size_t size = object_type_get_instance_size(typename);
> > +    size_t size = object_type_get_instance_size(scc->cpu_type);
> >      CPUCore *cc = CPU_CORE(dev);
> >      int i;
> >  
> > @@ -166,8 +165,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
> >      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
> >      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> >      CPUCore *cc = CPU_CORE(OBJECT(dev));
> > -    const char *typename = object_class_get_name(scc->cpu_class);
> > -    size_t size = object_type_get_instance_size(typename);
> > +    size_t size = object_type_get_instance_size(scc->cpu_type);
> >      Error *local_err = NULL;
> >      void *obj;
> >      int i, j;
> > @@ -186,7 +184,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
> >  
> >          obj = sc->threads + i * size;
> >  
> > -        object_initialize(obj, size, typename);
> > +        object_initialize(obj, size, scc->cpu_type);
> >          cs = CPU(obj);
> >          cpu = POWERPC_CPU(cs);
> >          cs->cpu_index = cc->core_id + i;
> > @@ -231,42 +229,12 @@ err:
> >      error_propagate(errp, local_err);
> >  }
> >  
> > -static const char *spapr_core_models[] = {
> > -    /* 970 */
> > -    "970_v2.2",
> > -
> > -    /* 970MP variants */
> > -    "970mp_v1.0",
> > -    "970mp_v1.1",
> > -
> > -    /* POWER5+ */
> > -    "power5+_v2.1",
> > -
> > -    /* POWER7 */
> > -    "power7_v2.3",
> > -
> > -    /* POWER7+ */
> > -    "power7+_v2.1",
> > -
> > -    /* POWER8 */
> > -    "power8_v2.0",
> > -
> > -    /* POWER8E */
> > -    "power8e_v2.1",
> > -
> > -    /* POWER8NVL */
> > -    "power8nvl_v1.0",
> > -
> > -    /* POWER9 */
> > -    "power9_v1.0",
> > -};
> > -
> >  static Property spapr_cpu_core_properties[] = {
> >      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >  
> > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(oc);
> >      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
> > @@ -274,36 +242,47 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> >      dc->realize = spapr_cpu_core_realize;
> >      dc->unrealize = spapr_cpu_core_unrealizefn;
> >      dc->props = spapr_cpu_core_properties;
> > -    scc->cpu_class = cpu_class_by_name(TYPE_POWERPC_CPU, data);
> > -    g_assert(scc->cpu_class);
> > +    scc->cpu_type = data;  
> 
> Maybe assert data isn't NULL ?
I'll fix it up on respin
