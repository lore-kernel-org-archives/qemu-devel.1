Received: from eggs.gnu.org ([2001:4830:134:3::10]:54135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2dhE-0007Lz-Uk
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2dh8-0003z5-Dj
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:38:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39506
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2dh8-0003yT-3F
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:38:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9CDZaS6083996
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 09:38:34 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dj8rhjj5e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 09:38:33 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 12 Oct 2017 14:38:32 +0100
Date: Thu, 12 Oct 2017 15:10:30 +0200
From: Greg Kurz <groug@kaod.org>
In-Reply-To: <20171010092946.02beddd2@bahia.lan>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-14-git-send-email-imammedo@redhat.com>
	<20171010092946.02beddd2@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171012143400.555ba3c0@bahia>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 13/24] ppc: spapr: define
 core types statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, "open
	list:ppce500" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 10 Oct 2017 09:29:46 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Mon,  9 Oct 2017 21:51:00 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > spapr core type definition doesn't have any fields that
> > require it to be defined at runtime. So replace code
> > that fills in TypeInfo at runtime with static TypeInfo
> > array that does the same at complie time.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >   - fix rebase conflict: add newly added power9_v2 core
> > ---  
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 

Oops, this patch causes a regression when you try to pass a sPAPR core to
a non-pseries machine.

Without this patch:

$ ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core 
qemu-system-ppc64: -device host-spapr-cpu-core:
 'host-spapr-cpu-core' is not a valid device model name

With this patch:

$ ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core 
**
ERROR:qom/object.c:217:object_type_get_instance_size:
 assertion failed: (type != NULL)
Aborted

#0  0x00007ffff760eff0 in raise () from /lib64/libc.so.6
#1  0x00007ffff761136c in abort () from /lib64/libc.so.6
#2  0x00007ffff78caa04 in g_assertion_message () from /lib64/libglib-2.0.so.0
#3  0x00007ffff78cab0c in g_assertion_message_expr () from /lib64/libglib-2.0.so.0
#4  0x00000000106abaac in object_type_get_instance_size (typename=0x108a3ac0 "host-powerpc64-cpu") at qom/object.c:217
#5  0x00000000101bb018 in spapr_cpu_core_realize (dev=0x111bcc10, errp=0x7fffffffe730) at hw/ppc/spapr_cpu_core.c:154
#6  0x000000001043e8b4 in device_set_realized (obj=0x111bcc10, value=true, errp=0x7fffffffe9f0) at hw/core/qdev.c:914
#7  0x00000000106b1390 in property_set_bool (obj=0x111bcc10, v=0x111c16a0, name=0x108cd520 "realized", opaque=0x111bcb60, errp=0x7fffffffe9f0) at qom/object.c:1906
#8  0x00000000106aeab8 in object_property_set (obj=0x111bcc10, v=0x111c16a0, name=0x108cd520 "realized", errp=0x7fffffffe9f0) at qom/object.c:1102
#9  0x00000000106b3068 in object_property_set_qobject (obj=0x111bcc10, value=0x111c1660, name=0x108cd520 "realized", errp=0x7fffffffe9f0) at qom/qom-qobject.c:27
#10 0x00000000106aee5c in object_property_set_bool (obj=0x111bcc10, value=true, name=0x108cd520 "realized", errp=0x7fffffffe9f0) at qom/object.c:1171
#11 0x000000001036b8cc in qdev_device_add (opts=0x110f4b30, errp=0x7fffffffea78) at qdev-monitor.c:630
#12 0x0000000010378e40 in device_init_func (opaque=0x0, opts=0x110f4b30, errp=0x0) at vl.c:2432
#13 0x0000000010850464 in qemu_opts_foreach (list=0x10abbaa8 <qemu_device_opts>, func=0x10378df4 <device_init_func>, opaque=0x0, errp=0x0) at util/qemu-option.c:1104
#14 0x000000001037fe0c in main (argc=5, argv=0x7ffffffff298, envp=0x7ffffffff2c8) at vl.c:4767

We're crashing because the host CPU type wasn't registered... Before, we would
gently fail to add the CPU core because its type wouldn't be registered either.

There's a strong correlation between the CPU type and CPU core type. I don't
believe we can handle this cleanly in the sPAPR code.

So I only see two options here: either drop this patch, or find a way to register
the host CPU type at QOM init time as well. It would be really unfortunate to bury
Igor's cleanup... I'd rather go forward so I started looking at the latter.

As explained in another mail recently, we cannot rely on the object class hierarchy
to do that since object_class_get_list() cannot be safely called during the QOM init
phase. It really needs all the parent types to be registered, because it will try
to initialize them at some point (look for type_initialize in qom/object.c).

https://lists.nongnu.org/archive/html/qemu-ppc/2017-09/msg00794.html

But since we only need CPU model names to register CPU types, building a PVR<->CPU model
table in the PPC code seem to be enough. Some more tweaking in the POWERPC_FAMILY() magic
is also needed to support migration on heterogeneous-but-compatible HW (eg, POWER8 <->
POWER8E).

I think that this patch should be reverted from David's staging tree for now, I'll
repost it when I have a proposal for the host CPU.

Cheers,

--
Greg

> >  include/hw/ppc/spapr_cpu_core.h |  2 +
> >  hw/ppc/spapr_cpu_core.c         | 87 +++++++++++++----------------------------
> >  2 files changed, 30 insertions(+), 59 deletions(-)
> > 
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> > index 93051e9..66dcf52 100644
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
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index b6610dd..550d320 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -217,37 +217,6 @@ err:
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
> > -    "power9_v2.0",
> > -};
> > -
> >  static Property spapr_cpu_core_properties[] = {
> >      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
> >      DEFINE_PROP_END_OF_LIST()
> > @@ -265,33 +234,33 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> >      g_assert(scc->cpu_class);
> >  }
> >  
> > -static const TypeInfo spapr_cpu_core_type_info = {
> > -    .name = TYPE_SPAPR_CPU_CORE,
> > -    .parent = TYPE_CPU_CORE,
> > -    .abstract = true,
> > -    .instance_size = sizeof(sPAPRCPUCore),
> > -    .class_size = sizeof(sPAPRCPUCoreClass),
> > -};
> > -
> > -static void spapr_cpu_core_register_types(void)
> > -{
> > -    int i;
> > -
> > -    type_register_static(&spapr_cpu_core_type_info);
> > -
> > -    for (i = 0; i < ARRAY_SIZE(spapr_core_models); i++) {
> > -        TypeInfo type_info = {
> > -            .parent = TYPE_SPAPR_CPU_CORE,
> > -            .instance_size = sizeof(sPAPRCPUCore),
> > -            .class_init = spapr_cpu_core_class_init,
> > -            .class_data = (void *) spapr_core_models[i],
> > -        };
> > -
> > -        type_info.name = g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
> > -                                         spapr_core_models[i]);
> > -        type_register(&type_info);
> > -        g_free((void *)type_info.name);
> > +#define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
> > +    {                                                   \
> > +        .parent = TYPE_SPAPR_CPU_CORE,                  \587
> > +        .class_data = (void *) cpu_model,               \
> > +        .class_init = spapr_cpu_core_class_init,        \
> > +        .name = SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
> >      }
> > -}
> >  
> > -type_init(spapr_cpu_core_register_types)
> > +static const TypeInfo spapr_cpu_core_type_infos[] = {
> > +    {
> > +        .name = TYPE_SPAPR_CPU_CORE,
> > +        .parent = TYPE_CPU_CORE,
> > +        .abstract = true,
> > +        .instance_size = sizeof(sPAPRCPUCore),
> > +        .class_size = sizeof(sPAPRCPUCoreClass),
> > +    },
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
> > +};
> > +
> > +DEFINE_TYPES(spapr_cpu_core_type_infos)  
> 
> 
