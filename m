Received: from eggs.gnu.org ([2001:4830:134:3::10]:50747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0Oz3-00039r-FT
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0Oyz-0005tv-2H
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:31:53 -0400
Date: Fri, 6 Oct 2017 11:31:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171006113145.7592ae5b@nial.brq.redhat.com>
In-Reply-To: <20171006084112.GY3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-21-git-send-email-imammedo@redhat.com>
	<20171006084112.GY3260@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/23] ppc: pnv: drop PnvCoreClass::cpu_oc
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?B?SGVy?= =?UTF-8?B?dsOp?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

On Fri, 6 Oct 2017 19:41:12 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 05, 2017 at 06:24:47PM +0200, Igor Mammedov wrote:
> > deduce cpu type directly from core type instead of
> > maintaining type mapping in PnvCoreClass::cpu_oc and doing
> > extra cpu_model parsing in pnv_core_class_init()
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/ppc/pnv_core.h |  1 -
> >  hw/ppc/pnv_core.c         | 18 ++++++++++++------
> >  2 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > index 3360c4b..a336a1f 100644
> > --- a/include/hw/ppc/pnv_core.h
> > +++ b/include/hw/ppc/pnv_core.h
> > @@ -42,7 +42,6 @@ typedef struct PnvCore {
> >  
> >  typedef struct PnvCoreClass {
> >      DeviceClass parent_class;
> > -    ObjectClass *cpu_oc;
> >  } PnvCoreClass;
> >  
> >  #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index b3e3f23..acdfa17 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -27,6 +27,16 @@
> >  #include "hw/ppc/pnv_xscom.h"
> >  #include "hw/ppc/xics.h"
> >  
> > +static const char *pvn_core_cpu_typename(PnvCore *pc)  
> 
> Uh.. s/pvn/pnv/ ..
thanks, I'll fix up on respin

> 
> > +{
> > +    const char *core_type = object_class_get_name(object_get_class(OBJECT(pc)));
> > +    int len = strlen(core_type) - strlen(PNV_CORE_TYPE_SUFFIX);
> > +    char *s = g_strdup_printf(POWERPC_CPU_TYPE_NAME("%.*s"), len, core_type);
> > +    const char *cpu_type = object_class_get_name(object_class_by_name(s));
> > +    g_free(s);
> > +    return cpu_type;
> > +}
> > +
> >  static void powernv_cpu_reset(void *opaque)
> >  {
> >      PowerPCCPU *cpu = opaque;
> > @@ -148,8 +158,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
> >  {
> >      PnvCore *pc = PNV_CORE(OBJECT(dev));
> >      CPUCore *cc = CPU_CORE(OBJECT(dev));
> > -    PnvCoreClass *pcc = PNV_CORE_GET_CLASS(OBJECT(dev));
> > -    const char *typename = object_class_get_name(pcc->cpu_oc);
> > +    const char *typename = pvn_core_cpu_typename(pc);
> >      size_t size = object_type_get_instance_size(typename);
> >      Error *local_err = NULL;
> >      void *obj;
> > @@ -211,11 +220,9 @@ static Property pnv_core_properties[] = {
> >  static void pnv_core_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(oc);
> > -    PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
> >  
> >      dc->realize = pnv_core_realize;
> >      dc->props = pnv_core_properties;
> > -    pcc->cpu_oc = cpu_class_by_name(TYPE_POWERPC_CPU, data);
> >  }
> >  
> >  static const TypeInfo pnv_core_info = {
> > @@ -223,6 +230,7 @@ static const TypeInfo pnv_core_info = {
> >      .parent         = TYPE_CPU_CORE,
> >      .instance_size  = sizeof(PnvCore),
> >      .class_size     = sizeof(PnvCoreClass),
> > +    .class_init = pnv_core_class_init,
> >      .abstract       = true,
> >  };
> >  
> > @@ -239,8 +247,6 @@ static void pnv_core_register_types(void)
> >          TypeInfo ti = {
> >              .parent = TYPE_PNV_CORE,
> >              .instance_size = sizeof(PnvCore),
> > -            .class_init = pnv_core_class_init,
> > -            .class_data = (void *) pnv_core_models[i],
> >          };
> >          ti.name = pnv_core_typename(pnv_core_models[i]);
> >          type_register(&ti);  
> 
