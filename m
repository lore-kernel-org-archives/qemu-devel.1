Received: from eggs.gnu.org ([2001:4830:134:3::10]:48095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eiv3f-0000sR-MW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 23:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eiv3a-0001ES-Pq
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 23:40:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:47058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1eiv3a-0001CV-FR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 23:40:34 -0500
Date: Tue, 6 Feb 2018 12:40:05 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180206044005.louuil5etk6vsy4z@debian-xvivbkq.sh.intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
	<20180125040328.22867-7-tiwei.bie@intel.com>
	<2e83b7fa-8cec-4c13-003f-f753a13fbfe2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e83b7fa-8cec-4c13-003f-f753a13fbfe2@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Mon, Feb 05, 2018 at 06:47:51PM +0100, Paolo Bonzini wrote:
> On 25/01/2018 05:03, Tiwei Bie wrote:
> > The key difference with PCI passthru is that, in this case only
> > the data path of the device (e.g. DMA ring, notify region and
> > queue interrupt) is pass-throughed to the VM, the device control
> > path (e.g. PCI configuration space and MMIO regions) is still
> > defined and emulated by QEMU.
> > 
> > The benefits of keeping virtio device emulation in QEMU compared
> > with virtio device PCI passthru include (but not limit to):
> > 
> > - consistent device interface for guest OS in the VM;
> > - max flexibility on the hardware (i.e. the accelerators) design;
> > - leveraging the existing virtio live-migration framework;
> > 
> > The virtual IOMMU isn't supported by the accelerators for now.
> > Because vhost-user currently lacks of an efficient way to share
> > the IOMMU table in VM to vhost backend. That's why the software
> > implementation of virtual IOMMU support in vhost-user backend
> > can't support dynamic mapping well. Once this problem is solved
> > in vhost-user, virtual IOMMU can be supported by accelerators
> > too, and the IOMMU feature bit checking in this patch can be
> > removed.
> 
> I don't understand why this would use vhost-user.  vhost-user is meant
> for connecting to e.g. a user-space switch that is shared between
> multiple virtual machines.

Yeah, you're right!

The commit log you quoted is talking about the benefits
of vDPA (i.e. only passthru the data path), which is not
related to vhost-user.

The usage of vhost-user you described is exactly why we
want to use vhost-user. In our case, the accelerator for
each VM is a PCI VF device and the PCI card has vswitch
logic (the VFs are the ports of switch to connect VMs).
So the card is a vswitch accelerator which will be shared
between multiple VMs. If we extend vhost-user, QEMU can
keep using the vhost-user interface to connect to the
user-space switch which has an optional accelerator.

More details can be found in the "Why extend vhost-user
for vDPA" section of the cover letter:

----- START -----

Why extend vhost-user for vDPA
==============================

We have already implemented various virtual switches (e.g. OVS-DPDK)
based on vhost-user for VMs in the Cloud. They are purely software
running on CPU cores. When we have accelerators for such NFVi applications,
it's ideal if the applications could keep using the original interface
(i.e. vhost-user netdev) with QEMU, and infrastructure is able to decide
when and how to switch between CPU and accelerators within the interface.
And the switching (i.e. switch between CPU and accelerators) can be done
flexibly and quickly inside the applications.

----- END -----

I'll try to add these infos into the commit log. Thanks!

Best regards,
Tiwei Bie

> 
> In this case, there would be one VFIO device per VM (because different
> VM must be in different VFIO groups).  So I don't understand the benefit
> of configuring the control path of the VFIO device outside QEMU.
> 
> Paolo
