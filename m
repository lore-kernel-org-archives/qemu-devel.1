Received: from eggs.gnu.org ([2001:4830:134:3::10]:42781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejqsH-0008Gr-OK
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejqsD-0000xm-Oi
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:24:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ejqsD-0000xG-GY
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:24:41 -0500
Date: Thu, 8 Feb 2018 11:24:36 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180208112436.35ac74a1@w520.home>
In-Reply-To: <983af1c6-a57a-43d8-2237-88e0d736905f@redhat.com>
References: <20180207001615.1156.10547.stgit@gimli.home>
	<20180207002632.1156.53770.stgit@gimli.home>
	<983af1c6-a57a-43d8-2237-88e0d736905f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/5] vfio/quirks: Automatic ioeventfd
 enabling for NVIDIA BAR0 quirks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, 8 Feb 2018 12:10:02 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 07/02/18 01:26, Alex Williamson wrote:
> > Record data writes that come through the NVIDIA BAR0 quirk, if we get
> > enough in a row that we're only passing through, automatically enable
> > an ioeventfd for it.  The primary target for this is the MSI-ACK
> > that NVIDIA uses to allow the MSI interrupt to re-trigger, which is a
> > 4-byte write, data value 0x0 to offset 0x704 into the quirk, 0x88704
> > into BAR0 MMIO space.  For an interrupt latency sensitive micro-
> > benchmark, this takes us from 83% of performance versus disabling the
> > quirk entirely (which GeForce cannot do), to to almost 90%.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/vfio/pci-quirks.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  hw/vfio/pci.h        |    2 +
> >  2 files changed, 89 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index e4cf4ea2dd9c..e739efe601b1 100644lg  
> 
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -203,6 +203,7 @@ typedef struct VFIOConfigMirrorQuirk {
> >      uint32_t offset;
> >      uint8_t bar;
> >      MemoryRegion *mem;
> > +    uint8_t data[];  
> Do you foresee other usages of data besides the LastDataSet?

Sure, LastDataSet is just a very crude tracking mechanism, I could
imagine some kind of device specific LRU array.  Any quirk wanting to
add additional analytics on top of this generic quirk could make use of
it.  I didn't want to pollute the generic quirk with LastDataSet since
there are other users, but I also didn't want to complicate the shared
free'ing path we have by simply adding a pointer.  Thus embedding quirk
specific data is what I went with here.

> >  } VFIOConfigMirrorQuirk;
> >  
> >  static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
> > @@ -297,6 +298,50 @@ static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
> >      g_free(ioeventfd);
> >  }
> >    
> add a comment? user handler in case kvm ioeventfd setup failed?

As you correctly updated later, we're only setting up the kvm-user
ioeventfd handler in this patch.  This is the handler when that
succeeds.  Once we add vfio ioeventfd support, this handler will
hopefully never get used, but we still need to support kernels that
won't have vfio ioeventfd support and this alone does still provide a
performance improvement.

> > +static void vfio_ioeventfd_handler(void *opaque)
> > +{
> > +    VFIOIOEventFD *ioeventfd = opaque;
> > +
> > +    if (event_notifier_test_and_clear(&ioeventfd->e)) {
> > +        vfio_region_write(ioeventfd->region, ioeventfd->region_addr,
> > +                          ioeventfd->data, ioeventfd->size);
> > +    }
> > +}
> > +
> > +static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
> > +                                          MemoryRegion *mr, hwaddr addr,
> > +                                          unsigned size, uint64_t data,
> > +                                          VFIORegion *region,
> > +                                          hwaddr region_addr)
> > +{
> > +    VFIOIOEventFD *ioeventfd = g_malloc0(sizeof(*ioeventfd));
> > +
> > +    if (event_notifier_init(&ioeventfd->e, 0)) {
> > +        g_free(ioeventfd);
> > +        return NULL;
> > +    }
> > +
> > +    ioeventfd->mr = mr;
> > +    ioeventfd->addr = addr;
> > +    ioeventfd->size = size;
> > +    ioeventfd->match_data = true;
> > +    ioeventfd->data = data;
> > +    ioeventfd->region = region;
> > +    ioeventfd->region_addr = region_addr;  
> I found difficult to follow the different addr semantic.
> I understand region_add is the offset % bar and addr is the offset %
> mirror region. Maybe more explicit names would help (region = bar_region
> and region_addr = bar_offset)

I was trying to avoid PCI specific fields for VFIOIOEventFD, but
basically we're dealing with two different sets of base and offset.
The first is the MemoryRegion of the quirk and the offset relative to
that MemoryRegion.  Those are used by memory_region_add_eventfd() for
establishing the kvm ioeventfd.  The second is the region and
region_addr, which identify the vfio region and offset relative to the
region so that we can actually handle it with vfio_region_write().

I agree though that these are confusing and maybe comments are a
solution as I can't think of better names:

    /*
     * MemoryRegion and relative offset, plus additional ioeventfd setup
     * parameters for configuring and later tearing down KVM ioeventfd.
     */
    ioeventfd->mr = mr;
    ioeventfd->addr = addr;
    ioeventfd->size = size;
    ioeventfd->match_data = true;
    ioeventfd->data = data;
    /*
     * VFIORegion and relative offset for implementing the userspace
     * handler.  data & size fields shared for both uses.
     */
    ioeventfd->region = region;
    ioeventfd->region_addr = region_addr;


> > +
> > +    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
> > +                        vfio_ioeventfd_handler, NULL, ioeventfd);
> > +    memory_region_add_eventfd(ioeventfd->mr, ioeventfd->addr,
> > +                              ioeventfd->size, ioeventfd->match_data,
> > +                              ioeventfd->data, &ioeventfd->e);
> > +
> > +    info_report("Enabled automatic ioeventfd acceleration for %s region %d, "
> > +                "offset 0x%"HWADDR_PRIx", data 0x%"PRIx64", size %u",
> > +                vdev->vbasedev.name, region->nr, region_addr, data, size);
> > +
> > +    return ioeventfd;
> > +}
> > +
> >  static void vfio_vga_probe_ati_3c3_quirk(VFIOPCIDevice *vdev)
> >  {
> >      VFIOQuirk *quirk;
> > @@ -732,6 +777,13 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice *vdev, int nr)
> >      trace_vfio_quirk_nvidia_bar5_probe(vdev->vbasedev.name);
> >  }
> >  
> > +typedef struct LastDataSet {
> > +    hwaddr addr;
> > +    uint64_t data;
> > +    unsigned size;
> > +    int count;
> > +} LastDataSet;
> > +
> >  /*
> >   * Finally, BAR0 itself.  We want to redirect any accesses to either
> >   * 0x1800 or 0x88000 through the PCI config space access functions.
> > @@ -742,6 +794,7 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
> >      VFIOConfigMirrorQuirk *mirror = opaque;
> >      VFIOPCIDevice *vdev = mirror->vdev;
> >      PCIDevice *pdev = &vdev->pdev;
> > +    LastDataSet *last = (LastDataSet *)&mirror->data;
> >  
> >      vfio_generic_quirk_mirror_write(opaque, addr, data, size);
> >  
> > @@ -756,6 +809,38 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
> >                            addr + mirror->offset, data, size);
> >          trace_vfio_quirk_nvidia_bar0_msi_ack(vdev->vbasedev.name);
> >      }
> > +
> > +    /*
> > +     * Automatically add an ioeventfd to handle any repeated write with the
> > +     * same data and size above the standard PCI config space header.  This is
> > +     * primarily expected to accelerate the MSI-ACK behavior, such as noted
> > +     * above.  Current hardware/drivers should trigger an ioeventfd at config
> > +     * offset 0x704 (region offset 0x88704), with data 0x0, size 4.
> > +     */
> > +    if (addr > PCI_STD_HEADER_SIZEOF) {
> > +        if (addr != last->addr || data != last->data || size != last->size) {
> > +            last->addr = addr;
> > +            last->data = data;
> > +            last->size = size;
> > +            last->count = 1;
> > +        } else if (++last->count > 10) {  
> So here is the naive question about the "10" choice and also the fact
> this needs to be consecutive accesses. I guess you observed this works
> but at first sight this is not obvious to me.

Initially when I started working on this I used the previously known
MSI-ACK behavior, which was a write to the MSI capability ID register,
but I quickly figured out it didn't do anything because my current guest
setup uses the 0x704 offset noted in the comment above.  So I continued
developing with 0x704 hard coded.  But I have no idea if everything
uses 0x704 now or some drivers might still use the capability ID, or
what NVIDIA might switch to next.  So I wanted to make this dynamic and
I figured that shouldn't anything that gets repeated calls through here
with the same data that we're not modifying on the way to hardware
benefit from this acceleration.  Then I started thinking about what
frequency of write should trigger this switch-over, but the time
component of that is hard to deal with, so I found that I could just
drop it.  The MSI-ACK behavior means that we see a pretty continuous
stream of writes to the same offset, same data, so that triggers right
away.  Interestingly, after the MSI-ACK triggers the ioeventfd, we even
add another for a relatively low frequency write.  I wouldn't have
bothered with this one otherwise, but I don't see the harm in leaving
it since we're setup for a datamatch we'll only trigger the ioeventfd
if it remains the same.  So basically to answer your question, it's 10
because it seemed like a reasonable watermark and it works.  If we had
to, we could use some sort of LRU array, but this is simple.

> Does anyone check potential overlaps between ioeventfd's [addr, addr +
> size -1]?

Do we need to?  KVM will only trigger the ioeventfd if we match the
address, data, and size, so AIUI we could have multiple ioeventfds
covering the same area with different data or size and there's nothing
wrong with that.  I wondered whether we need some sort of pruning
algorithm, but once we've enabled kvm-vfio acceleration, QEMU no longer
has any idea which are being used.  Maybe we could arbitrarily decide
some fixed number limit for a device, but currently I think the limit
is based on the user's open file limit.  Thanks,

Alex
