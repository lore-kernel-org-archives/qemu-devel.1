Received: from eggs.gnu.org ([2001:4830:134:3::10]:43462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUrFQ-00047X-Kk
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cUrFM-0001Zt-LU
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:42:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cUrFM-0001YT-FC
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:42:04 -0500
Date: Sat, 21 Jan 2017 01:41:59 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170121014159.064030ee@t450s.home>
In-Reply-To: <1484968585.26205.2.camel@gmail.com>
References: <1484968585.26205.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Nested PCI passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fassl <superfassl@gmail.com>
Cc: qemu-devel@nongnu.org

On Sat, 21 Jan 2017 04:16:25 +0100
fassl <superfassl@gmail.com> wrote:

> Hello,
> 
> i am trying to pass through a graphic card to a guest within a guest.
> So far i can see a text console within the target vm which says
> "radeon: ring 0 test failed", so it times out in radeon_vce_ring_test
> function. I am using qemu 2.8.50 at revision
> 0f6bcf68a99efdc531b209551f2b760b0bdcc554.
> 
> The relevant lowermost host arguments are:
> -machine pc-q35-2.8,accel=kvm,kernel-irqchip=split
> -device intel-iommu,intremap=on,eim=on
> 
> If i dont set the x-vga flag for the passed through device in the
> lowermost host the VM within the VM does not reset(?) the device during
> shutdown and the screen freezes. If i do, the screen goes black and no
> signal is going to the screen anymore and i can restart the target VM
> without the whole machine freezing. (one has to set
> CONFIG_VFIO_PCI_VGA=y in the kernel of the first VM, or call
> pci_register_vga to get this)
> 
> Also with irqchip=split the first vm cannot shutdown gracefully and
> crashes during shutdown.
> 
> I also can see some IRTE vector and trigger mode inconsistencies, can
> they cause this?
> 
> Or are there some quirks to be done to get this going?
> 
> If anybody could lead me into the right direction or if there is work
> going on in this field i would be more than glad to help testing.
> 
> Thank you in advance

This shouldn't even be possible right now, vfio-pci should generate an
abort when used with intel-iommu.  There is work in progress to make
some form of vfio-pci work with intel-iommu, but devices that don't
support function level reset (such as graphics cards) are going to have
a more difficult time than most being supported in this configuration.
What is your use case that you're even attempting this (or consider it
a sane thing to do)?  Thanks,

Alex
