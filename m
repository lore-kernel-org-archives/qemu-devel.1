Received: from eggs.gnu.org ([2001:4830:134:3::10]:44970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eiksR-0001lI-FK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 12:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eiksO-0007oP-Cf
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 12:48:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eiksO-0007mY-5d
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 12:48:20 -0500
References: <20180125040328.22867-1-tiwei.bie@intel.com>
	<20180125040328.22867-7-tiwei.bie@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e83b7fa-8cec-4c13-003f-f753a13fbfe2@redhat.com>
Date: Mon, 5 Feb 2018 18:47:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180125040328.22867-7-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v1 6/6] vhost-user: add VFIO
 based accelerators support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On 25/01/2018 05:03, Tiwei Bie wrote:
> The key difference with PCI passthru is that, in this case only
> the data path of the device (e.g. DMA ring, notify region and
> queue interrupt) is pass-throughed to the VM, the device control
> path (e.g. PCI configuration space and MMIO regions) is still
> defined and emulated by QEMU.
> 
> The benefits of keeping virtio device emulation in QEMU compared
> with virtio device PCI passthru include (but not limit to):
> 
> - consistent device interface for guest OS in the VM;
> - max flexibility on the hardware (i.e. the accelerators) design;
> - leveraging the existing virtio live-migration framework;
> 
> The virtual IOMMU isn't supported by the accelerators for now.
> Because vhost-user currently lacks of an efficient way to share
> the IOMMU table in VM to vhost backend. That's why the software
> implementation of virtual IOMMU support in vhost-user backend
> can't support dynamic mapping well. Once this problem is solved
> in vhost-user, virtual IOMMU can be supported by accelerators
> too, and the IOMMU feature bit checking in this patch can be
> removed.

I don't understand why this would use vhost-user.  vhost-user is meant
for connecting to e.g. a user-space switch that is shared between
multiple virtual machines.

In this case, there would be one VFIO device per VM (because different
VM must be in different VFIO groups).  So I don't understand the benefit
of configuring the control path of the VFIO device outside QEMU.

Paolo
