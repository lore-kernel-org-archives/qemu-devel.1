Received: from eggs.gnu.org ([2001:4830:134:3::10]:35668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYusQ-0004Gj-1M
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYusM-0004HL-1f
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:59:58 -0400
Date: Fri, 29 Jun 2018 16:59:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180629165946.4ca31187@redhat.com>
In-Reply-To: <293c189c-3034-f002-ca90-698e6ecf0c09@redhat.com>
References: <20180628121417.1980-1-david@redhat.com>
	<20180628121417.1980-5-david@redhat.com>
	<20180629011933.GJ23134@umbus.fritz.box>
	<293c189c-3034-f002-ca90-698e6ecf0c09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] pc-dimm: assign and verify the
 "addr" property during pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S .
	Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>

On Fri, 29 Jun 2018 09:14:52 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.06.2018 03:19, David Gibson wrote:
> > On Thu, Jun 28, 2018 at 02:14:17PM +0200, David Hildenbrand wrote:  
> >> We can assign and verify the slot before realizing and trying to plug.
> >> reading/writing the address property should never fail, so let's reduce
> >> error handling a bit by using &error_abort. Getting access to the memory
> >> region now might however fail. So forward errors from
> >> get_memory_region() properly.
> >>
> >> Keep tracing the assigned address for now in the plug code, as that's the
> >> point we are sure plugging succeeded and the address willa ctually be
> >> used.
> >>
> >> As all memory devices should use the alignment of the underlying memory
> >> region for guest physical address asignment, do detection of the
> >> alignment in pc_dimm_pre_plug(), but allow pc.c to overwrite the
> >> alignment for compatibility handling.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/i386/pc.c             | 16 ++++--------
> >>  hw/mem/pc-dimm.c         | 53 +++++++++++++++++++++++-----------------
> >>  hw/ppc/spapr.c           |  7 +++---
> >>  include/hw/mem/pc-dimm.h |  6 ++---
> >>  4 files changed, 41 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 934b7155b1..16e4b5baff 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -1678,7 +1678,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >>                                 Error **errp)
> >>  {
> >>      const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >> +    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> >>      const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> >> +    const uint64_t compat_align = TARGET_PAGE_SIZE;
> >>  
> >>      /*
> >>       * When -no-acpi is used with Q35 machine type, no ACPI is built,
> >> @@ -1696,7 +1698,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >>          return;
> >>      }
> >>  
> >> -    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
> >> +    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev),
> >> +                     pcmc->enforce_aligned_dimm ? NULL : &compat_align, errp);  
> > 
> > Why would you pass a const pointer, rather than just a value?  
> 
> We could do that if we make "0" -> "no compat alignment, detect
> alignment yourself". That should work here.
I'd prefer pointer as it doesn't give any special meaning to 0 value
and more visible showing that something non trivial happens here 

> 
> Thanks!
> 
