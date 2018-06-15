Received: from eggs.gnu.org ([2001:4830:134:3::10]:48095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTl88-0001jv-91
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTl84-0004Z3-Aq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:34:52 -0400
Date: Fri, 15 Jun 2018 11:34:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180615113440.56844675@redhat.com>
In-Reply-To: <569f9534-162c-29c1-a097-51427e028b4e@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-11-david@redhat.com>
	<20180613151056.6ebbccc2@redhat.com>
	<569f9534-162c-29c1-a097-51427e028b4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/11] pc-dimm: introduce and use
 pc_dimm_memory_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Wed, 13 Jun 2018 16:15:48 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 13.06.2018 15:10, Igor Mammedov wrote:
> > On Mon, 11 Jun 2018 14:16:54 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> We'll be factoring out some pc-dimm specific and some memory-device
> >> checks next.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/i386/pc.c             | 2 ++
> >>  hw/mem/pc-dimm.c         | 5 +++++
> >>  hw/ppc/spapr.c           | 1 +
> >>  include/hw/mem/pc-dimm.h | 2 ++
> >>  4 files changed, 10 insertions(+)
> >>
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 017396fe84..dc8e7b033b 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -1695,6 +1695,8 @@ static void pc_dimm_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,  
> > keeping                              ^^^^^
> > similar to newly introduced pc_dimm_memory_pre_plug()
> > and I have no clue what to suggest as alternative  
> 
> Can you elaborate?

It's just that pc_dimm_pre_plug and pc_dimm_memory_pre_plug
are very similar so it become confusing and with name alone
you can't figure if both do the same or different things.

Looking at 11/11 maybe you could just drop this and the next
patch for now as there isn't obvious (if any) demand for it
within this series at all.
And introduce similar patch when it's actually required.

I might imagine following naming in future:

   pc_dimm_pre_plug()
       memory_device_pre_plug()
       ... some pc-dimm only stuff ...

   virtio_mem_pre_plug()
       memory_device_pre_plug()
       ... some virtio-mem only stuff ...

> In pc.c we now have:
> - static void pc_dimm_plug()
> - static void pc_dimm_unplug_request()
> - static void pc_dimm_unplug()
> 
> And I add
> - static void pc_dimm_pre_plug()
> 
> I am sticking to the existing naming scheme.
> 
> (maybe the problem is that PC_DIMM should never have been named PC_DIMM
> but simply DIMM, then the "pc_" prefix would be unique)
Agreed,
but now type name is part of interface so we are stuck with it.


> >>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> >>          return;
> >>      }
> >> +
> >> +    pc_dimm_memory_pre_plug(dev, MACHINE(hotplug_dev), errp);
> >>  }
> >>  
> >>  static void pc_dimm_plug(HotplugHandler *hotplug_dev,
> >> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> >> index bc79dd04d8..995ce22d8d 100644
> >> --- a/hw/mem/pc-dimm.c
> >> +++ b/hw/mem/pc-dimm.c
> >> @@ -27,6 +27,11 @@
> >>  #include "sysemu/numa.h"
> >>  #include "trace.h"
> >>  
> >> +void pc_dimm_memory_pre_plug(DeviceState *dev, MachineState *machine,
> >> +                             Error **errp)
> >> +{
> >> +}  
> > why introducing shim without anything?  
> 
> Because you requested for review to split things up :)
> 
> I can easily squash this.
> 
> > I'd just merge it with following patch and clarify (in commit message)
> > why the rest of pre_plug code isn't moved here as well.  
> 
> 
