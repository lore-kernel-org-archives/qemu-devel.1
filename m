Received: from eggs.gnu.org ([2001:4830:134:3::10]:44954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQvsK-0001KL-9R
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQvsG-0006WY-Bk
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:26:52 -0400
Date: Thu, 7 Jun 2018 16:26:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180607162632.2c2258de@redhat.com>
In-Reply-To: <fbd2d738-7356-e991-7c15-f9cc436a9378@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-7-david@redhat.com>
	<20180605010840.GF5140@umbus.fritz.box>
	<fbd2d738-7356-e991-7c15-f9cc436a9378@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/14] spapr: prepare for multi stage
 hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On Tue, 5 Jun 2018 09:51:26 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 05.06.2018 03:08, David Gibson wrote:
> > On Thu, May 17, 2018 at 10:15:19AM +0200, David Hildenbrand wrote:  
> >> For multi stage hotplug handlers, we'll have to do some error handling
> >> in some hotplug functions, so let's use a local error variable (except
> >> for unplug requests).
> >>
> >> Also, add code to pass control to the final stage hotplug handler at the
> >> parent bus.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/ppc/spapr.c | 54 +++++++++++++++++++++++++++++++++++++++++++-----------
> >>  1 file changed, 43 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index ebf30dd60b..b7c5c95f7a 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -3571,27 +3571,48 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
> >>  {
> >>      MachineState *ms = MACHINE(hotplug_dev);
> >>      sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
> >> +    Error *local_err = NULL;
> >>  
> >> +    /* final stage hotplug handler */
> >>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >>          int node;
> >>  
> >>          if (!smc->dr_lmb_enabled) {
> >> -            error_setg(errp, "Memory hotplug not supported for this machine");
> >> -            return;
> >> +            error_setg(&local_err,
> >> +                       "Memory hotplug not supported for this machine");
> >> +            goto out;
> >>          }
> >> -        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, errp);
> >> -        if (*errp) {
> >> -            return;
> >> +        node = object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
> >> +                                        &local_err);
> >> +        if (local_err) {
> >> +            goto out;
> >>          }
> >>          if (node < 0 || node >= MAX_NODES) {
> >> -            error_setg(errp, "Invaild node %d", node);
> >> -            return;
> >> +            error_setg(&local_err, "Invaild node %d", node);
> >> +            goto out;
> >>          }
> >>  
> >> -        spapr_memory_plug(hotplug_dev, dev, node, errp);
> >> +        spapr_memory_plug(hotplug_dev, dev, node, &local_err);
> >>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> >> -        spapr_core_plug(hotplug_dev, dev, errp);
> >> +        spapr_core_plug(hotplug_dev, dev, &local_err);
> >> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> >> +        hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
> >> +    }
> >> +out:
> >> +    error_propagate(errp, local_err);
> >> +}
> >> +
> >> +static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
> >> +                                        DeviceState *dev, Error **errp)
> >> +{
> >> +    Error *local_err = NULL;
> >> +
> >> +    /* final stage hotplug handler */
> >> +    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {  
> > 
> > As I think Igor said on the equivalent PC patch, I don't quite get
> > this.  Isn't this already handled by the generic hotplug code picking
> > up the bus's hotplug handler if the machine doesn't supply one?  
> 
> See my reply to patch nr 4.
> 
> What we do is, we install the machine hotplug handler as an
> "intermediate" hotplug handler.
> 
> E.g. if we have a VIRTIO based MemoryDevice, we have to initialize the
> MemoryDevice specific stuff in the machine hotplug handler, but then
> pass the device onto the last stage hotplug handler (which will
> eventually attach it to a bus and notify the guest).
as said in v4, pls don't do this implicit routing as it's hard to
read and maintain. Do explicit routing within concrete device helper
(virtio_mem_[un|pre]plug()) keeping un/pre/plug handlers simple.

And then you won't need if check as well, just call to bus handler
directly.

[...]
