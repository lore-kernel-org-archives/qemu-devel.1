Received: from eggs.gnu.org ([2001:4830:134:3::10]:54678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUDug-0002hQ-NC
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUDub-0004jP-Qm
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:42:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cUDub-0004j6-Hr
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:42:01 -0500
Date: Thu, 19 Jan 2017 15:41:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170119154156.3e7fa31d@nial.brq.redhat.com>
In-Reply-To: <20170118181820.GH3491@thinpad.lan.raisama.net>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-2-git-send-email-imammedo@redhat.com>
	<20170118181820.GH3491@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 01/13] numa: access CPU's node id via
 property in hmp_info_numa()
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

On Wed, 18 Jan 2017 16:18:20 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jan 18, 2017 at 06:13:17PM +0100, Igor Mammedov wrote:
> > Move vcpu's assocciated numa_node field out of generic CPUState
> > into inherited classes that actually care about cpu<->numa mapping
> > and make monitor 'info numa' get vcpu's assocciated node id via
> > node-id property.
> > It allows to drop implicit node id intialization in
> > numa_post_machine_init() and would allow switching to mapping
> > defined by target's CpuInstanceProperties instead of global
> > numa_info[i].node_cpu bitmaps.
> > 
> > As side effect it fixes 'info numa' displaying wrong mapping
> > for CPUs specified with -device/device_add.
> > Before patch following CLI would produce:
> > QEMU -smp 1,sockets=3,maxcpus=3 \
> >        -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0 \
> >        -numa node,nodeid=0,cpus=0 \
> >        -numa node,nodeid=1,cpus=1 \
> >        -numa node,nodeid=2,cpus=2
> > (qemu) device_add qemu64-x86_64-cpu,socket-id=2,core-id=0,thread-id=0
> > (qemu) info numa
> > 3 nodes
> > node 0 cpus: 0 1 2
> > node 0 size: 40 MB
> > node 1 cpus:
> > node 1 size: 40 MB
> > node 2 cpus:
> > node 2 size: 48 MB
> > 
> > after patch all CPUs are on nodes they are supposed to be:
> > (qemu) device_add qemu64-x86_64-cpu,socket-id=2,core-id=0,thread-id=0
> > (qemu) info numa
> > 3 nodes
> > node 0 cpus: 0
> > node 0 size: 40 MB
> > node 1 cpus: 1
> > node 1 size: 40 MB
> > node 2 cpus: 2
> > node 2 size: 48 MB
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> So, in addition to the other comments I had, it looks like this
> patch is doing 3 things at the same time:
> 
> 1) Adding a "node-id" property to CPU objects.
> 2) Moving CPUState::numa_node to arch-specific CPU structs.
> 3) Fixing the bug where the NUMA node info isn't initialized
>    for PC on CPUs created by -device/device_add.
ok, I'll split this in 3 patches

> 
> All of them are independent from each other. For example, all you
> need to fix the bug you describe above is (3), which is contained
> in a single hunk from this patch, that is:
> 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index f721fde..9d2b265 100644
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
> >  }  
> 
> All the rest seems irrelevant to fix the bug. (1) and (2) may be
> useful, but they need separate justification.
rationale for (1) and (2) is the first 2 paragraphs of this commit message
