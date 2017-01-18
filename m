Received: from eggs.gnu.org ([2001:4830:134:3::10]:55094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtir-0005oZ-3D
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtin-0005Hm-SQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:08:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtin-0005HO-Jb
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:08:29 -0500
Date: Wed, 18 Jan 2017 18:08:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170118180824.52d84031@nial.brq.redhat.com>
In-Reply-To: <20170118151945.GY3491@thinpad.lan.raisama.net>
References: <1484750925-176844-1-git-send-email-imammedo@redhat.com>
	<20170118151945.GY3491@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

On Wed, 18 Jan 2017 13:19:45 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jan 18, 2017 at 03:48:45PM +0100, Igor Mammedov wrote:
> > Move vcpu's assocciated numa_node field out of generic CPUState
> > into inherited classes that actually care about cpu<->numa mapping
> > and make monitor 'info numa' get vcpu's assocciated node id via
> > node-id property.
> > It allows to drop implicit node id intialization in
> > numa_post_machine_init() and would allow switching to mapping
> > defined by target's CpuInstanceProperties instead of global
> > numa_info[i].node_cpu bitmaps.  
> 
> I agree to allow the node-id assignment logic to be defined by
> arch-specific code, but:
> 
> Considering that we still have the generic CPU<->node mapping in
> numa_info[].node_cpu, I don't see the benefit of moving the
> numa_info[].node_cpu => node-id translation from common generic
> code to duplicated arch-specific code.
it's duplicated for a time being until all targets that use
node_cpu are internally converted to socket/core/thread-id interface.
This patch is a part if re-factoring RFC which I'm about to post.


> What about adding this to cpu_generic_realize():
> 
>   node = (numa_get_node_for_cpu(cpu)
>   if (node >= 0) {
>      int cur_node = object_property_find(cpu, "node-id") ?
>                     object_property_get_int(cpu, "node-id") : -1;
>      if (cur_node >= 0 && cur_node != node) {
>          error_setg(&err, "Conflict between -numa option and CPU node-id");
>          goto out;
>      }
>      object_property_set_int(cpu, "node-id", node, &err);
>   }
What I don't like here is that putting above snippet into
cpu_generic_realize() is just doing the same implicit init
that numa_post_machine_init() has been doing before just
a bit later. It looks like a quick fix for 'info numa' issues.

However it would add stumble block on getting rid of 
numa_get_node_for_cpu() { numa_info[].node_cpu } and keeping
node-mapping along with the rest of topology in Machine object
instead of globals.

I'm in process of getting rid of numa_info[].node_cpu/numa_get_node_for_cpu()
altogether. And incrementally done it for PC, so I'd be forced
to reduplicate above snippet from cpu_generic_realize() in concrete
users anyway to do conversion without breaking other users.
 
[...]
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1978,6 +1978,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >  
> >      cs = CPU(cpu);
> >      cs->cpu_index = idx;
> > +
> > +    idx = numa_get_node_for_cpu(cs->cpu_index);
> > +    if (idx < nb_numa_nodes) {
> > +        cpu->numa_nid = idx;
> > +    }
this is the only place where I add above mentioned duplication,
which sort of compensated by removed numa_post_machine_init().
And it's here only to keep working+fix 'info numa'.
The other targets currently already do numa_get_node_for_cpu(),
lookup so I'm not changing there anything.
Later(not in this patch) I'm removing numa_get_node_for_cpu() from
pc_cpu_pre_plug() and from PC code altogether and replacing it
with node-id from possible_cpus.

PS:
since travis-ci seems to be broken, I'll post re-factoring
RFC without building there and it includes this patch as well.
