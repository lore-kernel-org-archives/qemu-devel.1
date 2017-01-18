Received: from eggs.gnu.org ([2001:4830:134:3::10]:43034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTucq-0003BC-SI
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTucp-0003n9-Hn
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTucp-0003mk-A7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:06:23 -0500
Date: Wed, 18 Jan 2017 16:06:19 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118180619.GG3491@thinpad.lan.raisama.net>
References: <1484750925-176844-1-git-send-email-imammedo@redhat.com>
	<20170118151945.GY3491@thinpad.lan.raisama.net>
	<20170118180824.52d84031@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118180824.52d84031@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] numa: access CPU's node id via property in
 hmp_info_numa()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

On Wed, Jan 18, 2017 at 06:08:24PM +0100, Igor Mammedov wrote:
> On Wed, 18 Jan 2017 13:19:45 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Jan 18, 2017 at 03:48:45PM +0100, Igor Mammedov wrote:
> > > Move vcpu's assocciated numa_node field out of generic CPUState
> > > into inherited classes that actually care about cpu<->numa mapping
> > > and make monitor 'info numa' get vcpu's assocciated node id via
> > > node-id property.
> > > It allows to drop implicit node id intialization in
> > > numa_post_machine_init() and would allow switching to mapping
> > > defined by target's CpuInstanceProperties instead of global
> > > numa_info[i].node_cpu bitmaps.  
> > 
> > I agree to allow the node-id assignment logic to be defined by
> > arch-specific code, but:
> > 
> > Considering that we still have the generic CPU<->node mapping in
> > numa_info[].node_cpu, I don't see the benefit of moving the
> > numa_info[].node_cpu => node-id translation from common generic
> > code to duplicated arch-specific code.
> it's duplicated for a time being until all targets that use
> node_cpu are internally converted to socket/core/thread-id interface.
> This patch is a part if re-factoring RFC which I'm about to post.
> 
> 

Maybe the duplication will be OK if it's temporary, and going to
be removed immediately by the same series. But if it is a
standalone patch, I don't want to make the existing duplication
worse.

> > What about adding this to cpu_generic_realize():
> > 
> >   node = (numa_get_node_for_cpu(cpu)
> >   if (node >= 0) {
> >      int cur_node = object_property_find(cpu, "node-id") ?
> >                     object_property_get_int(cpu, "node-id") : -1;
> >      if (cur_node >= 0 && cur_node != node) {
> >          error_setg(&err, "Conflict between -numa option and CPU node-id");
> >          goto out;
> >      }
> >      object_property_set_int(cpu, "node-id", node, &err);
> >   }
> What I don't like here is that putting above snippet into
> cpu_generic_realize() is just doing the same implicit init
> that numa_post_machine_init() has been doing before just
> a bit later. It looks like a quick fix for 'info numa' issues.

Yes, it is. But I still don't see what's the problem with it. If
numa_info[].node_cpu still exists in generic code, I don't see
why not handle it in generic code.

> 
> However it would add stumble block on getting rid of 
> numa_get_node_for_cpu() { numa_info[].node_cpu } and keeping
> node-mapping along with the rest of topology in Machine object
> instead of globals.

Removing duplication would make it easier: then you'll have only
one user of numa_info[].node_cpu/numa_get_node_for_cpu() to get
rid of, instead of 4.

> 
> I'm in process of getting rid of numa_info[].node_cpu/numa_get_node_for_cpu()
> altogether. And incrementally done it for PC, so I'd be forced
> to reduplicate above snippet from cpu_generic_realize() in concrete
> users anyway to do conversion without breaking other users.

If you manage to get rid of numa_info[].node_cpu somehow, then we
could get rid of numa_post_machine_init()/numa_get_node_for_cpu()
at the same time. But I don't see the benefit of duplicating
existing generic code into arch-specific code while keeping the
existing generic numa_info[].node_cpu data structure untouched.

>  
> [...]
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -1978,6 +1978,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> > >  
> > >      cs = CPU(cpu);
> > >      cs->cpu_index = idx;
> > > +
> > > +    idx = numa_get_node_for_cpu(cs->cpu_index);
> > > +    if (idx < nb_numa_nodes) {
> > > +        cpu->numa_nid = idx;
> > > +    }
> this is the only place where I add above mentioned duplication,
> which sort of compensated by removed numa_post_machine_init().

Is it? I see the same logic duplicated in 3 places (see below).
Not all cases were added by you, but that doesn't mean it is OK
to make it worse.

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f721fde..9d2b265 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1978,6 +1978,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cs = CPU(cpu);
     cs->cpu_index = idx;
+
+    idx = numa_get_node_for_cpu(cs->cpu_index);
+    if (idx < nb_numa_nodes) {
+        cpu->numa_nid = idx;
+    }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c18632b..7f6661b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -71,7 +71,7 @@ void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu, Error **errp)
     /* Set NUMA node for the added CPUs  */
     i = numa_get_node_for_cpu(cs->cpu_index);
     if (i < nb_numa_nodes) {
-            cs->numa_node = i;
+        cpu->numa_nid = i;
     }
 
     xics_cpu_setup(spapr->xics, cpu);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7a03f84..b86b5fd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1333,6 +1332,11 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
+        if (nb_numa_nodes) {
+            object_property_set_int(cpuobj, numa_get_node_for_cpu(n),
+                                    "node-id", NULL);
+        }
+
         object_property_set_bool(cpuobj, true, "realized", NULL);
     }
     fdt_add_timer_nodes(vms);


> And it's here only to keep working+fix 'info numa'.
> The other targets currently already do numa_get_node_for_cpu(),
> lookup so I'm not changing there anything.
> Later(not in this patch) I'm removing numa_get_node_for_cpu() from
> pc_cpu_pre_plug() and from PC code altogether and replacing it
> with node-id from possible_cpus.

I will look at the whole series to re-evaluate this patch, then.

> 
> PS:
> since travis-ci seems to be broken, I'll post re-factoring
> RFC without building there and it includes this patch as well.

No problem to me, if it's a RFC.

-- 
Eduardo
