Received: from eggs.gnu.org ([2001:4830:134:3::10]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dmwIg-0005eW-Dp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dmwIb-0002Hn-NL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 02:16:30 -0400
Date: Wed, 30 Aug 2017 08:16:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170830081621.50dce717@nial.brq.redhat.com>
In-Reply-To: <20170830030501.GE3386@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-5-git-send-email-imammedo@redhat.com>
	<20170825041208.GA2772@umbus.fritz.box>
	<20170825093432.6e0d4512@nial.brq.redhat.com>
	<20170830030501.GE3386@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/6] ppc: replace inter-function
 cyclic dependency/recurssion with 2 simple lookups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On Wed, 30 Aug 2017 13:05:01 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Aug 25, 2017 at 09:34:32AM +0200, Igor Mammedov wrote:
> > On Fri, 25 Aug 2017 14:12:08 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Thu, Aug 24, 2017 at 10:21:49AM +0200, Igor Mammedov wrote:  
> > > > previous patches cleaned up cpu model/alias naming which
> > > > allows to simplify cpu model/alias to cpu type lookup a bit
> > > > byt removing recurssion and dependency of ppc_cpu_class_by_name() /
> > > > ppc_cpu_class_by_alias() on each other.
> > > > Besides of simplifying code it reduces it by ~15LOC.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> > > 
> > > Urm.. I think this is probably good.  But I'm having a little trouble
> > > convincing myself this really has the same effect as before.  
> > It's hard to wrap brain around current cyclic recursion and
> > how to 2 simple linear lookups could replace it.  
> 
> I noticed :)
> 
> > By itself this patch won't work, it depends on 2-3/6 for
> > normalized cpu type names and recursion-less alias table.
> > 
> > The only change in behavior here is that it does alias
> > translation first and only then cpu_model to type translation.  
> 
> I've had a closer look and convinced myself of that now.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> I'm sorry, I've lost track of these patches a bit, since I wasn't
> originally expecting to queue them.  I can't actually remember if
> there were any comments needing a respin.
> 
> Regardless, can you resend the series (including my R-bs) and I'll
> queue it for 2.11.
sure, I'll do it today

> 
> >   
> > >   
> > > > ---
> > > >  target/ppc/translate_init.c | 43 +++++++++++++------------------------------
> > > >  1 file changed, 13 insertions(+), 30 deletions(-)
> > > > 
> > > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > > > index 0325226..f1a559d 100644
> > > > --- a/target/ppc/translate_init.c
> > > > +++ b/target/ppc/translate_init.c
> > > > @@ -10176,22 +10176,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr)
> > > >      return pcc;
> > > >  }
> > > >  
> > > > -static gint ppc_cpu_compare_class_name(gconstpointer a, gconstpointer b)
> > > > -{
> > > > -    ObjectClass *oc = (ObjectClass *)a;
> > > > -    const char *name = b;
> > > > -    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> > > > -
> > > > -    if (strncasecmp(name, object_class_get_name(oc), strlen(name)) == 0 &&
> > > > -        ppc_cpu_is_valid(pcc) &&
> > > > -        strcmp(object_class_get_name(oc) + strlen(name),
> > > > -               POWERPC_CPU_TYPE_SUFFIX) == 0) {
> > > > -        return 0;
> > > > -    }
> > > > -    return -1;
> > > > -}
> > > > -
> > > > -
> > > >  static ObjectClass *ppc_cpu_class_by_name(const char *name);
> > > >  
> > > >  static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
> > > > @@ -10216,8 +10200,8 @@ static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
> > > >  
> > > >  static ObjectClass *ppc_cpu_class_by_name(const char *name)
> > > >  {
> > > > -    GSList *list, *item;
> > > > -    ObjectClass *ret = NULL;
> > > > +    char *cpu_model, *typename;
> > > > +    ObjectClass *oc;
> > > >      const char *p;
> > > >      int i, len;
> > > >  
> > > > @@ -10238,21 +10222,20 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
> > > >          }
> > > >      }
> > > >  
> > > > -    list = object_class_get_list(TYPE_POWERPC_CPU, false);
> > > > -    item = g_slist_find_custom(list, name, ppc_cpu_compare_class_name);
> > > > -    if (item != NULL) {
> > > > -        ret = OBJECT_CLASS(item->data);
> > > > +    cpu_model = g_ascii_strup(name, -1);
> > > > +    p = ppc_cpu_lookup_alias(cpu_model);
> > > > +    if (p) {
> > > > +        g_free(cpu_model);
> > > > +        cpu_model = g_strdup(p);
> > > >      }
> > > > -    g_slist_free(list);
> > > >  
> > > > -    if (ret) {
> > > > -        return ret;
> > > > -    }
> > > > +    typename = g_strdup_printf("%s" POWERPC_CPU_TYPE_SUFFIX, cpu_model);
> > > > +    oc = object_class_by_name(typename);
> > > > +    g_free(typename);
> > > > +    g_free(cpu_model);
> > > >  
> > > > -    for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
> > > > -        if (strcasecmp(ppc_cpu_aliases[i].alias, name) == 0) {
> > > > -            return ppc_cpu_class_by_alias(&ppc_cpu_aliases[i]);
> > > > -        }
> > > > +    if (oc && ppc_cpu_is_valid(POWERPC_CPU_CLASS(oc))) {
> > > > +        return oc;
> > > >      }
> > > >  
> > > >      return NULL;    
> > >   
> >   
> 
