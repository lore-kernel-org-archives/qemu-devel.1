Received: from eggs.gnu.org ([2001:4830:134:3::10]:43573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g096d-0008Uh-Lh
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g096U-0000OU-8r
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:39:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1g096U-0000ON-2D
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:39:02 -0400
Date: Wed, 12 Sep 2018 13:38:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180912133355-mutt-send-email-mst@kernel.org>
References: <72e9368e256e81fd69e3f6c65e6dd435@unixzen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e9368e256e81fd69e3f6c65e6dd435@unixzen.com>
Subject: Re: [Qemu-devel] Debugging PCI Enhanced Allocation - IOMMU of a
 bridge?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander von Gluck IV <kallisti5@unixzen.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com

On Wed, Sep 12, 2018 at 05:30:29PM +0000, Alexander von Gluck IV wrote:
> Good morning!
> 
> I'm working through adding support (or at least ignoring) PCI Enhance
> Allocation devices under Haiku.
> We run into one of these devices, and crash at boot due to attempting to read
> an invalid address.
> 
> Our testing showed that with a USB C dongle plugged in, we don't crash. Without
> it plugged in we get
> invalid addresses from PCI
> 
> (for a long-drawn out debug ticket, see https://dev.haiku-os.org/ticket/12885 )
> 
> 
> So, i'm trying to see if I can emulate a PCI bridge with EA under QEMU, I found
> this patch, but it seems
> it wasn't accepted:
> https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg02073.html

v2 never surfaced I think.

> My other thought is since I have access to two laptops implementing this, I
> could attach the bridge to
> qemu via iommu, but the new vfio stuff doesn't seem to work with bridges. :-|

It's fixable, AFAIK no one bothered though. BTW old style kvm dev
assignment is still around but probably doesn't work with bridges
either.


> Anyone know of a way to:
> * emulate a PCI EA in qemu.

Start with above patch, add bios support?

> * attach the local PCI EA bridge to qemu to troubleshoot using real hardware.
> For context, here is the suspect EA device:
> 
> 
> (no USB C dongle)
> $ lspci -tvnn
> -[0000:00]-+-00.0 Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core
> Processor Host Bridge/DRAM Registers [8086:1910]
> +-1d.6-[06-3e]--
> 
> vs
> 
> (USB C dongle)
> $ lspci -tvnn
> -[0000:00]-+-00.0 Intel Corporation Skylake Host Bridge/DRAM Registers
> [8086:1904]
> +-1d.6-[06-3e]----00.0-[07-3e]--+-00.0-[08]--
> | +-01.0-[09-3d]--
> | \-02.0-[3e]----00.0 Intel Corporation DSL6340 USB 3.1 Controller [Alpine
> Ridge] [8086:15b5]
> 
> 
> The bride is at 1d.6 in it's own IOMMU group:
> 
> IOMMU group 12
> 00:1d.6 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset
> Family PCI Express Root Port #15 [8086:a11e] (rev f1)
> 
> -- Alex
