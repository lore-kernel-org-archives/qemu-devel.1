Received: from eggs.gnu.org ([2001:4830:134:3::10]:35290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g6u51-00006m-S9
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g6u4q-0005Vm-Ku
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:01:25 -0400
Date: Mon, 1 Oct 2018 11:01:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181001110107.15fdd032@redhat.com>
In-Reply-To: <e4318388-9f2d-584e-c486-296394ba53ec@redhat.com>
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-15-david@redhat.com>
	<99ab8baf-37c9-2df1-7292-8e0ac4f31137@redhat.com>
	<500af147-f496-7fb4-47f8-183bd45f4cb4@redhat.com>
	<e4318388-9f2d-584e-c486-296394ba53ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/24] memory-device: complete factoring
 out plug handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 1 Oct 2018 10:18:20 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 01/10/2018 10:15, David Hildenbrand wrote:
> > On 30/09/2018 17:55, Auger Eric wrote:  
> >> Hi David,
> >>
> >> On 9/26/18 11:42 AM, David Hildenbrand wrote:  
> >>> With the new memory device functions in place, we can factor out
> >>> plugging of memory devices completely.
> >>>
> >>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>  hw/mem/memory-device.c         | 13 ++++++++++---
> >>>  hw/mem/pc-dimm.c               |  9 +--------
> >>>  include/hw/mem/memory-device.h |  3 +--
> >>>  3 files changed, 12 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> >>> index 54e3f23b15..3914e2fe6f 100644
> >>> --- a/hw/mem/memory-device.c
> >>> +++ b/hw/mem/memory-device.c
> >>> @@ -275,10 +275,17 @@ out:
> >>>      error_propagate(errp, local_err);
> >>>  }
> >>>  
> >>> -void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
> >>> -                               uint64_t addr)
> >>> +void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
> >>>  {
> >>> -    /* we expect a previous call to memory_device_get_free_addr() */
> >>> +    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
> >>> +    const uint64_t addr = mdc->get_addr(md);
> >>> +    MemoryRegion *mr;
> >>> +
> >>> +    /*
> >>> +     * We expect a previous call to memory_device_pre_plug() succeeded so
> >>> +     * it and can't fail at this point.  
> >> comment to be reworded
> >>  
> > 
> > Igor requested that rewording. I can turn that into "We expect that a
> > previous call ... succeeded, so " ..
> >   
> 
> "We expect that a previous call to memory_device_pre_plug() succeeded,
> so it can't fail at this point."
looks good to me

> 
> to be precise :)
> 
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> Thanks
> >>
> >> Eric  
> > 
> >   
> 
> 
