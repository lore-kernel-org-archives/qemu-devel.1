Received: from eggs.gnu.org ([2001:4830:134:3::10]:48013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0Onn-0000Kx-7F
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0Onh-0005Rm-0N
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:20:15 -0400
Date: Fri, 6 Oct 2017 11:20:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171006112005.11850a76@nial.brq.redhat.com>
In-Reply-To: <20171006050439.GV3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-18-git-send-email-imammedo@redhat.com>
	<20171006050439.GV3260@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/23] ppc: spapr: use generic cpu_model
 parsing
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

On Fri, 6 Oct 2017 16:04:39 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 05, 2017 at 06:24:44PM +0200, Igor Mammedov wrote:
> > use generic cpu_model parsing introduced by
> >  (6063d4c0f vl.c: convert cpu_model to cpu type and set of global properties before machine_init())
> > 
> > it allows to:
> >   * replace sPAPRMachineClass::tcg_default_cpu with
> >     MachineClass::default_cpu_type
> >   * drop cpu_parse_cpu_model() from hw/ppc/spapr.c and reuse
> >     one in vl.c
> >   * simplify spapr_get_cpu_core_type() by removing
> >     not needed anymore recurrsion since alias look up
> >     happens earlier at vl.c and spapr_get_cpu_core_type()
> >     works only with resulted from that cpu type.
> >   * spapr no more needs to parse/depend on being phased out
> >     MachineState::cpu_model, all tha parsing done by generic
> >     code and target specific callback.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > PS:
> >   patch is a little bit big but it's hard to split it due
> >   to dependencies, so pls bear with it.  
> 
> [snip]
> > -static int kvm_ppc_register_host_cpu_type(void)
> > +static int kvm_ppc_register_host_cpu_type(MachineState *ms)
> >  {
> >      TypeInfo type_info = {
> >          .name = TYPE_HOST_POWERPC_CPU,
> >          .class_init = kvmppc_host_cpu_class_init,
> >      };
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> >      PowerPCCPUClass *pvr_pcc;
> >      ObjectClass *oc;
> >      DeviceClass *dc;
> > @@ -2504,6 +2505,8 @@ static int kvm_ppc_register_host_cpu_type(void)
> >      }
> >      type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
> >      type_register(&type_info);
> > +    /* override TCG default cpu type with 'host' cpu model */
> > +    mc->default_cpu_type = TYPE_HOST_POWERPC_CPU;  
> 
> Ugh.  I dislike this, it changes the default cpu type to 'host' for
> *all* machine types, whereas previously it was just true for pseries.
> That wasn't by accident.
> 
> In general, I think we want there to be a single default CPU type for
> a machine, regardless of TCG vs. KVM.  This is particularly true for
> many of the ppc machine types - they will only work with a CPU in the
> right "family" (e500 / 440 / POWERx, wahtever); in many of these cases
> KVM PR is usable, but using -cpu host could easily break the machine
> type.
> 
> 'pseries' is different, it (and only it) can be used with KVM HV - and
> usually is.  And KVM HV *only* works with -cpu host, due to hardware
> limitations.
I'd keep override in spapr_machine_class_init() but it's not possible
since it's called before kvm option is parsed and machine is prerequisite for kvm option

how about following fixup?

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index abc222e..48dc3f7 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2505,8 +2505,10 @@ static int kvm_ppc_register_host_cpu_type(MachineState *ms)
     }
     type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
     type_register(&type_info);
-    /* override TCG default cpu type with 'host' cpu model */
-    mc->default_cpu_type = TYPE_HOST_POWERPC_CPU;
+    if (object_dynamic_cast(ms, TYPE_SPAPR_MACHINE)) {
+        /* override TCG default cpu type with 'host' cpu model */
+        mc->default_cpu_type = TYPE_HOST_POWERPC_CPU;
+    }
 
     oc = object_class_by_name(type_info.name);
     g_assert(oc);


> >      oc = object_class_by_name(type_info.name);
> >      g_assert(oc);
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index 5ee91e8..a968e86 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -10277,6 +10277,19 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr)
> >      return pcc;
> >  }
> >  
> > +static const char *ppc_cpu_lookup_alias(const char *alias)
> > +{
> > +    int ai;
> > +
> > +    for (ai = 0; ppc_cpu_aliases[ai].alias != NULL; ai++) {
> > +        if (strcmp(ppc_cpu_aliases[ai].alias, alias) == 0) {
> > +            return ppc_cpu_aliases[ai].model;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> >  static ObjectClass *ppc_cpu_class_by_name(const char *name)
> >  {
> >      char *cpu_model, *typename;
> > @@ -10370,19 +10383,6 @@ static void ppc_cpu_parse_featurestr(const char *typename, char *features,
> >      pcc->parent_parse_features(typename, features, errp);
> >  }
> >  
> > -const char *ppc_cpu_lookup_alias(const char *alias)
> > -{
> > -    int ai;
> > -
> > -    for (ai = 0; ppc_cpu_aliases[ai].alias != NULL; ai++) {
> > -        if (strcmp(ppc_cpu_aliases[ai].alias, alias) == 0) {
> > -            return ppc_cpu_aliases[ai].model;
> > -        }
> > -    }
> > -
> > -    return NULL;
> > -}
> > -  
> 
> This code motion of ppc_cpu_lookup_alias appears to be unrelated to
> the rest of the patch.
> 
> >  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
> >  {
> >      ObjectClass *oc = OBJECT_CLASS(pcc);  
> 
