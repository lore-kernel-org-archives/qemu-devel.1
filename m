Received: from eggs.gnu.org ([2001:4830:134:3::10]:44692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0ObK-00034s-77
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0ObG-0002Nd-5N
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:07:22 -0400
Date: Fri, 6 Oct 2017 11:07:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171006110714.4f9d21ab@nial.brq.redhat.com>
In-Reply-To: <20171006044104.GT3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-16-git-send-email-imammedo@redhat.com>
	<20171006044104.GT3260@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/23] ppc: spapr: register 'host' core
 type along with the rest of core types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "open list:ppce500" <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On Fri, 6 Oct 2017 15:41:04 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 05, 2017 at 06:24:42PM +0200, Igor Mammedov wrote:
> > consolidate 'host' core type registration by moving it from
> > KVM specific code into spapr_cpu_core.c, similar like it's
> > done in x86 target.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> IIUC this will change behaviour slightly: with this patch the 'host'
> core type will show up whenever CONFIG_KVM is set, even if the KVM
> accelerator is disabled on the command line.  Previously it would not.
> 
> Is this change intentional?
yep, we do the same on x86

> 
> > ---
> >  include/hw/ppc/spapr_cpu_core.h |  1 -
> >  hw/ppc/spapr_cpu_core.c         |  5 ++++-
> >  target/ppc/kvm.c                | 11 -----------
> >  3 files changed, 4 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> > index 264ce68..42765de 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -38,5 +38,4 @@ typedef struct sPAPRCPUCoreClass {
> >  } sPAPRCPUCoreClass;
> >  
> >  char *spapr_get_cpu_core_type(const char *model);
> > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> >  #endif
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 8e13e52..f2da4be 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -220,7 +220,7 @@ static Property spapr_cpu_core_properties[] = {
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >  
> > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(oc);
> >      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
> > @@ -257,6 +257,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
> >      DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
> >      DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
> >      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
> > +#ifdef CONFIG_KVM
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("host"),
> > +#endif
> >  };
> >  
> >  DEFINE_TYPES(spapr_cpu_core_type_infos)
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index c2152ed..cb5777a 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2508,17 +2508,6 @@ static int kvm_ppc_register_host_cpu_type(void)
> >      oc = object_class_by_name(type_info.name);
> >      g_assert(oc);
> >  
> > -#if defined(TARGET_PPC64)
> > -    type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
> > -    type_info.parent = TYPE_SPAPR_CPU_CORE,
> > -    type_info.instance_size = sizeof(sPAPRCPUCore);
> > -    type_info.instance_init = NULL;
> > -    type_info.class_init = spapr_cpu_core_class_init;
> > -    type_info.class_data = (void *) POWERPC_CPU_TYPE_NAME("host");
> > -    type_register(&type_info);
> > -    g_free((void *)type_info.name);
> > -#endif
> > -
> >      /*
> >       * Update generic CPU family class alias (e.g. on a POWER8NVL host,
> >       * we want "POWER8" to be a "family" alias that points to the current  
> 
