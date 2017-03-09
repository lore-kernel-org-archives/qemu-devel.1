Received: from eggs.gnu.org ([2001:4830:134:3::10]:49390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1clxEv-0001XI-KB
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1clxEr-0005dR-MN
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:32:17 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1clxEr-0005bD-G0
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:32:13 -0500
Received: by mail-wm0-x243.google.com with SMTP id u132so10679463wmg.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 04:32:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<20170222103047.2c1b63f2@t450s.home>
	<20170223030647.GB4015@pxdev.xzpeter.org>
	<7cd743a2-b4c2-1d96-892e-c3a7db07da16@redhat.com>
	<20170223081616.GI4015@pxdev.xzpeter.org>
	<52e4d43f-c51f-0ac5-7409-f3087f61f44e@redhat.com>
	<20170223083533.17899e2f@t450s.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7bd30e6-c166-24c8-3cf2-31bb0d4f6525@redhat.com>
Date: Thu, 9 Mar 2017 13:31:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170223083533.17899e2f@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: make sure its init before PCI
 dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: yi.l.liu@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>



On 23/02/2017 16:35, Alex Williamson wrote:
> It's the architecture of vfio, the user only gets access to the device
> when the container has iommu protection, therefore vfio needs to look
> at the device address space to determine if it can share a container
> with other devices.  Without an iommu all devices share the system
> address space and use the same container.  With an iommu, each device
> is in a separate address space and each gets its own container.
> Without a container, the user doesn't get access to the device.
> Deferring the address space to machine done would essentially defer the
> entire vfio device initialization or else we'd need to close the
> device and re-open and initialize it through a new container at that
> time.  Thanks,

If you used only one container you could still provide a working VFIO
configuration to the guest, even if the guest had an IOMMU.  All devices
ending up in one IOMMU domain is not particularly useful, but it would work.

If VFIO had an iommu property, to be used like "-device
intel_iommu,id=iommu0 -device vfio-pci,iommu=iommu0", It could tell VFIO
to use separate containers and also ensure proper ordering of command
line arguments.

Paolo
