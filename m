Received: from eggs.gnu.org ([2001:4830:134:3::10]:39284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dl9NN-0001Ba-Oz
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dl9NI-0001ix-NN
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:49:57 -0400
Date: Fri, 25 Aug 2017 09:49:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170825094948.5a7315fd@nial.brq.redhat.com>
In-Reply-To: <20170825042203.GC2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-7-git-send-email-imammedo@redhat.com>
	<20170825042203.GC2772@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 6/6] ppc: drop caching ObjectClass
 from PowerPCCPUAlias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Fri, 25 Aug 2017 14:22:03 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Aug 24, 2017 at 10:21:51AM +0200, Igor Mammedov wrote:
> > Caching there practically doesn't give any benefits
> > and that at slow path druring querying supported CPU list.
> > But it introduces non conventional path of where from
> > comes used CPU type name (kvm_ppc_register_host_cpu_type).
> > 
> > Taking in account that kvm_ppc_register_host_cpu_type()
> > fixes up models the aliases point to, it's sufficient to
> > make ppc_cpu_class_by_name() translate cpu alias to
> > correct cpu type name.
> > So drop PowerPCCPUAlias::oc field + ppc_cpu_class_by_alias()
> > and let ppc_cpu_class_by_name() do conversion to cpu type name,
> > which simplifies code a little bit saving ~20LOC and trouble
> > wondering why ppc_cpu_class_by_alias() is necessary.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Unfortunately, this will break things.  This isn't purely a cache, in
> the case handled by kvm_ppc_register_host_cpu_type(), 'oc' is *not*
> redundant with the name.  The name is based on the specific CPU
> description, but the oc points to the information for the "host" cpu.
> 
> There may well be a better way to do this, but this isn't it.
> 
> The problem we're trying to solve here is that KVM HV basically only
> works with -cpu host.  But for the benefit of libvirt (and others), we
> want, say, -cpu POWER8 to also work if the host *is* a POWER8.  But we
> *don't* want to require that the host be exactly the same model of
> POWER8 as "POWER8" would be aliased to with TCG.

here is snippet from kvm_ppc_register_host_cpu_type()

1:
            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));      
            suffix = strstr(ppc_cpu_aliases[i].model, "-"TYPE_POWERPC_CPU);      
            if (suffix) {                                                        
                *suffix = 0;                                                     
            }
2:                                                        
            ppc_cpu_aliases[i].oc = oc;

where model is fixed up (1) to the name that corresponds to
exactly the same 'oc' that is cached into (2)

any follow up attempt to translate fixed up alias will end up resolving
it into model => the same 'oc' that would be cached in ppc_cpu_aliases[i].oc

isn't it?

> 
> So basically we take the "family" name of the host CPU and make it an
> alias to the host cpu definition.
> 
> It's certainly mucky, but there is a reason for it.
> 
> > ---
> >  target/ppc/cpu-models.h     |  1 -
> >  target/ppc/kvm.c            |  1 -
> >  target/ppc/translate_init.c | 26 ++------------------------
> >  3 files changed, 2 insertions(+), 26 deletions(-)
> > 
> > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> > index d748c68..e9c6015 100644
> > --- a/target/ppc/cpu-models.h
> > +++ b/target/ppc/cpu-models.h
> > @@ -31,7 +31,6 @@
> >  typedef struct PowerPCCPUAlias {
> >      const char *alias;
> >      const char *model;
> > -    ObjectClass *oc;
> >  } PowerPCCPUAlias;
> >  
> >  extern PowerPCCPUAlias ppc_cpu_aliases[];
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 3f21190..995c2da 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2488,7 +2488,6 @@ static int kvm_ppc_register_host_cpu_type(void)
> >              if (suffix) {
> >                  *suffix = 0;
> >              }
> > -            ppc_cpu_aliases[i].oc = oc;
> >              break;
> >          }
> >      }
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index ca9f1e3..c06f34b 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -10177,28 +10177,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr)
> >      return pcc;
> >  }
> >  
> > -static ObjectClass *ppc_cpu_class_by_name(const char *name);
> > -
> > -static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
> > -{
> > -    ObjectClass *invalid_class = (void*)ppc_cpu_class_by_alias;
> > -
> > -    /* Cache target class lookups in the alias table */
> > -    if (!alias->oc) {
> > -        alias->oc = ppc_cpu_class_by_name(alias->model);
> > -        if (!alias->oc) {
> > -            /* Fast check for non-existing aliases */
> > -            alias->oc = invalid_class;
> > -        }
> > -    }
> > -
> > -    if (alias->oc == invalid_class) {
> > -        return NULL;
> > -    } else {
> > -        return alias->oc;
> > -    }
> > -}
> > -
> >  static ObjectClass *ppc_cpu_class_by_name(const char *name)
> >  {
> >      char *cpu_model, *typename;
> > @@ -10310,7 +10288,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
> >                        name, pcc->pvr);
> >      for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
> >          PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
> > -        ObjectClass *alias_oc = ppc_cpu_class_by_alias(alias);
> > +        ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);
> >  
> >          if (alias_oc != oc) {
> >              continue;
> > @@ -10390,7 +10368,7 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
> >          CpuDefinitionInfoList *entry;
> >          CpuDefinitionInfo *info;
> >  
> > -        oc = ppc_cpu_class_by_alias(alias);
> > +        oc = ppc_cpu_class_by_name(alias->model);
> >          if (oc == NULL) {
> >              continue;
> >          }  
> 
