Received: from eggs.gnu.org ([2001:4830:134:3::10]:43924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ekC8L-00027s-IE
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ekC8K-00075b-FT
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:06:45 -0500
Date: Fri, 9 Feb 2018 10:06:34 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180209100634.7a908eb9@w520.home>
In-Reply-To: <CAMuHMdWaoutP+oFL0Vtw+Z-986_=3wLAu+58N9ZT7t+uZb1ycA@mail.gmail.com>
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
	<1518189456-2873-5-git-send-email-geert+renesas@glider.be>
	<20180209085024.004b6f9e@w520.home>
	<CAMuHMdWaoutP+oFL0Vtw+Z-986_=3wLAu+58N9ZT7t+uZb1ycA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 4/5] vfio: No-IOMMU mode support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, Auger Eric <eric.auger@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Fri, 9 Feb 2018 17:06:34 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Alex,
> 
> On Fri, Feb 9, 2018 at 4:50 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Fri,  9 Feb 2018 16:17:35 +0100
> > Geert Uytterhoeven <geert+renesas@glider.be> wrote:  
> >> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> >>
> >> Add qemu support for the newly introduced VFIO No-IOMMU driver.
> >>
> >> We need to add special handling for:
> >> - Group character device is /dev/vfio/noiommu-$GROUP.
> >> - No-IOMMU does not rely on a memory listener.
> >> - No IOMMU will be set for its group, so no need to call
> >>   vfio_kvm_device_add_group.
> >>
> >> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> >> [geert: Rebase]
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >>  hw/vfio/common.c              | 61 ++++++++++++++++++++++++++++++++++---------
> >>  include/hw/vfio/vfio-common.h |  2 ++
> >>  2 files changed, 50 insertions(+), 13 deletions(-)  
> >
> > NAK.  I'm opposed to no-iommu support in QEMU in general, but accepting
> > vfio devices with no-iommu (which provide no DMA translation!!!)
> > transparently as if they might actually work like a regular vfio device
> > is absolutely unacceptable.  Without DMA translation and isolation, you
> > might want to think about another interface, I'm not keen on the idea  
> 
> What if the device cannot do DMA?
> 
> There are other devices that cannot do DMA, but that can be useful to
> access from a guest in an embedded system.
> E.g. smart ADC monitor blocks that monitor and average several ADCs in an
> automotive environment (drivers/iio/adc/rcar-gyroadc.c).
> 
> Should all such devices be paravirtualized?

How do we know that a device is not capable of DMA?  The moment we add
no-iommu support generically to QEMU, I get to deal with a swarm of
people trying to use it to assign DMA capable PCI devices to VMs and
failing miserably.  We added no-iommu support because the UIO PCI driver
was under pressure to add support for MSI/X interrupts and we figured
we could at least taint the kernel an give people a path to a more
secure setup with an IOMMU by allowing use of the vfio device
interface.  For PCI, this makes some sense because PCI has architected
interrupts and config space and standard layouts.  What's the value of
vfio over UIO for ad-hoc, non-DMA platform devices?  UIO is intended for
non-DMA devices.  vfio is intended for IOMMU protected, DMA capable
devices.  vfio no-IOMMU is a band-aide that hopefully goes away
eventually.

> > of corrupting vfio support in order to blink some LEDs.  Thanks,  
> 
> This GPIO+LED prototype is just a proof-of-concept. There's no plan to
> upstream it.

If vfio with no-IOMMU is to be used, it must not enable users to
casually assign DMA capable devices.  Certainly any PCI/e device needs
to be assumed to be DMA capable.  I don't know how you tell with
platform devices since there's no standard interface.  Thanks,

Alex
