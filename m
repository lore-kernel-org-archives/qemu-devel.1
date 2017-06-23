Received: from eggs.gnu.org ([2001:4830:134:3::10]:57622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOG2b-00075u-KZ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dOG2Y-0006HK-GJ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:17:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dOG2Y-0006Gt-9H
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 00:17:50 -0400
Date: Fri, 23 Jun 2017 12:17:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170623041743.GC3936@pxdev.xzpeter.org>
References: <CAB995MvCYo=tWGg-tC5R-GmRqtdiaLaU_rHTprpRJ_hMJK6Rtw@mail.gmail.com>
	<20170622105935.2dbd574d@w520.home>
	<CAB995Mv3naMDu1e2zvzDn77GGNqwPXWUoJOrO0ZMs8B5YooRAQ@mail.gmail.com>
	<20170622112709.51bd4885@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170622112709.51bd4885@w520.home>
Subject: Re: [Qemu-devel] Query on VFIO in Virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Nitin Saxena <nitin.lnx@gmail.com>, linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>

On Thu, Jun 22, 2017 at 11:27:09AM -0600, Alex Williamson wrote:
> On Thu, 22 Jun 2017 22:42:19 +0530
> Nitin Saxena <nitin.lnx@gmail.com> wrote:
> 
> > Thanks Alex.
> > 
> > >> Without an iommu in the VM, you'd be limited to no-iommu support for VM userspace,  
> > So are you trying to say VFIO NO-IOMMU should work inside VM. Does
> > that mean VFIO NO-IOMMU in VM and VFIO IOMMU in host for same device
> > is a legitimate configuration? I did tried this configuration and the
> > application (in VM) seems to get container_fd, group_fd, device_fd
> > successfully but after VFIO_DEVICE_RESET ioctl the PCI link breaks
> > from VM as well as from host. This could be specific to PCI endpoint
> > device which I can dig.
> > 
> > I will be happy if VFIO NO-IOMMU in VM and IOMMU in host for same
> > device is legitimate configuration.
> 
> Using no-iommu in the guest should work in that configuration, however
> there's no isolation from the user to the rest of VM memory, so the VM
> kernel will be tainted.  Host memory does have iommu isolation.  Device
> reset from VM userspace sounds like another bug to investigate.  Thanks,
> 
> Alex

Besides what Alex has mentioned, there is a wiki page for the usage.
The command line will be slightly different on QEMU side comparing to
without vIOMMU:

  http://wiki.qemu.org/Features/VT-d#With_Assigned_Devices

One more thing to mention is that, when vfio-pci devices in the guest
are used with emulated VT-d, huge performance degradation will be
expected for dynamic allocations at least for now. While for mostly
static allocations (like DPDK) the performance should be merely the
same as no-IOMMU mode. It's just a hint on performance, and I believe
for your own case it should mostly depend on how the application is
managing DMA map/unmaps.

Thanks,

-- 
Peter Xu
