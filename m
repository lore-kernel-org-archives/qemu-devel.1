Received: from eggs.gnu.org ([2001:4830:134:3::10]:48313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ctCPY-0003XO-Gx
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 08:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ctCPX-00021h-AE
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 08:09:12 -0400
Date: Wed, 29 Mar 2017 14:08:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170329140858.0e8b7e24@nial.brq.redhat.com>
In-Reply-To: <20170329022723.GO21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-23-git-send-email-imammedo@redhat.com>
	<20170328051602.GK21068@umbus.fritz.box>
	<20170328130911.78c2edc6@Igors-MacBook-Pro.local>
	<20170329022723.GO21068@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 22/23] numa: add '-numa cpu,
 ...' option for property based node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, 29 Mar 2017 13:27:23 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Mar 28, 2017 at 01:09:11PM +0200, Igor Mammedov wrote:
> > On Tue, 28 Mar 2017 16:16:02 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Wed, Mar 22, 2017 at 02:32:47PM +0100, Igor Mammedov wrote:  
> > > > legacy cpu to node mapping is using cpu index values to map
> > > > VCPU to node with help of '-numa node,nodeid=node,cpus=x[-y]'
> > > > option. However cpu index is internal concept and QEMU users
> > > > have to guess /reimplement qemu's logic/ to map it to
> > > > a concrete cpu socket/core/thread to make sane CPUs
> > > > placement across numa nodes.
> > > > 
> > > > This patch allows to map cpu objects to numa nodes using
> > > > the same properties as used for cpus with -device/device_add
> > > > (socket-id/core-id/thread-id/node-id).
> > > > 
> > > > At present valid properties/values to address CPUs could be
> > > > fetched using hotpluggable-cpus monitor/qmp command, it will
> > > > require user to start qemu twice when creating domain to fetch
> > > > possible CPUs for a machine type/-smp layout first and
> > > > then the second time with numa explicit mapping for actual
> > > > usage. The first step results could be saved and reused to
> > > > set/change mapping later as far as machine type/-smp stays
> > > > the same.
> > > > 
> > > > Proposed impl. supports exact and wildcard matching to
> > > > simplify CLI and allow to set mapping for a specific cpu
> > > > or group of cpu objects specified by matched properties.
> > > > 
> > > > For example:
> > > > 
> > > >    # exact mapping x86
> > > >    -numa cpu,node-id=x,socket-id=y,core-id=z,thread-id=n
> > > > 
> > > >    # exact mapping SPAPR
> > > >    -numa cpu,node-id=x,core-id=y
> > > > 
> > > >    # wildcard mapping, all cpu objects that match socket-id=y
> > > >    # are mapped to node-id=x
> > > >    -numa cpu,node-id=x,socket-id=y
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > > 
> > > What's the rationale for adding a new CLI, rather than adding node-id
> > > properties to the appropriate objects with -device, -global or -set as
> > > appropriate?  
> >  '-global' applies to all cpus, while '-device,-set' applies to present
> >  at boot time cpus only. So they do not work for the case of possible but
> >  not present at boot time objects.  
> 
> Ah!  Of course.
> 
> > For ACPI based targets, we need to have
> >  numa mapping at boot time to build ACPI SRAT table.
> >  I don't know if it's important for spapr/fdt,  
> 
> Not in the same way.  For spapr the device tree fragment for the new
> cpu is supplied to the guest at hotplug time rather than having to be
> in the initial device tree.  So for us, node could be supplied with
> device_add.
I've implemented cpu.node-id check in the same way for all targets
for spapr it's patch patch 06/23 which forces cpu.node-id to match
whatever mapping has been provided with -numa cpu[s]
OR
with implied default /0/ if mapping for cpu hasn't been specified
with -numa explicitly.

That way it won't break legacy machines and on compat code is necessary,
I'd would leave it up to you with patch on top of this to lift restriction/make
it more relaxed for spapr if you think it won't break anything.

Although from libvirt pov, I'd prefer to treat all targets uniformly,
which narrows choice down to '-numa' mapping approach that it uses now.

> > but it uses current predefined
> >  mapping with -numa node,cpus=x-y and new CLI hides from user internal
> >  cpu_index and allows to use the same properties as we use for -device cpu,...
> >  to define mapping to numa nodes for present/possible cpus.
...
