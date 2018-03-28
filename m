Received: from eggs.gnu.org ([2001:4830:134:3::10]:38979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f1A9J-00017y-2r
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 08:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f1A9E-0000up-GC
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 08:25:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:50721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f1A9E-0000pN-7s
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 08:25:48 -0400
Date: Wed, 28 Mar 2018 20:24:07 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180328122407.gc6yba26gijlm5g6@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
	<20180322181952-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322181952-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Extend vhost-user to support VFIO
 based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Mar 22, 2018 at 06:40:18PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2018 at 03:15:31PM +0800, Tiwei Bie wrote:
[...]
> > 
> > Below link is an example showing how to setup a such environment
> > via nested VM. In this case, the virtio device in the outer VM is
> > the accelerator. It will be used to accelerate the virtio device
> > in the inner VM. In reality, we could use virtio ring compatible
> > hardware device as the accelerators.
> > 
> > http://dpdk.org/ml/archives/dev/2017-December/085044.html
> 
> I understand that it might be challenging due to
> the tight coupling with VFIO. Still - isn't there
> a way do make it easier to set a testing rig up?
> 
> In particular can we avoid the dpdk requirement for testing?
> 

If we want to try vDPA (e.g. use one virtio device to accelerate
another virtio device of a VM), I think we need vDPA. Otherwise
we will need to write a VFIO based userspace virtio driver and
find another vhost-user backend.

> 
> 
> > In above example, it doesn't require any changes to QEMU, but
> > it has lower performance compared with the traditional VFIO
> > based PCI passthru. And that's the problem this patch set wants
> > to solve.
> > 
> > The performance issue of vDPA/vhost-user and solutions
> > ======================================================
> > 
> > For vhost-user backend, the critical issue in vDPA is that the
> > data path performance is relatively low and some host threads are
> > needed for the data path, because some necessary mechanisms are
> > missing to support:
> > 
> > 1) guest driver notifies the device directly;
> > 2) device interrupts the guest directly;
> > 
> > So this patch set does some small extensions to the vhost-user
> > protocol to make both of them possible. It leverages the same
> > mechanisms (e.g. EPT and Posted-Interrupt on Intel platform) as
> > the PCI passthru.
> 
> Not all platforms support posted interrupts, and EPT isn't
> required for MMIO to be mapped to devices.
> 
> It probably makes sense to separate the more portable
> host notification offload from the less portable
> guest notification offload.
> 

Make sense. I'll split the two types of offloads. Thanks for
the suggestion!

> 
> 
> > A new protocol feature bit is added to negotiate the accelerator
> > feature support. Two new slave message types are added to control
> > the notify region and queue interrupt passthru for each queue.
> > >From the view of vhost-user protocol design, it's very flexible.
> > The passthru can be enabled/disabled for each queue individually,
> > and it's possible to accelerate each queue by different devices.
> > More design and implementation details can be found from the last
> > patch.
> > 
> > Difference between vDPA and PCI passthru
> > ========================================
> > 
> > The key difference between PCI passthru and vDPA is that, in vDPA
> > only the data path of the device (e.g. DMA ring, notify region and
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
> > Why extend vhost-user for vDPA
> > ==============================
> > 
> > We have already implemented various virtual switches (e.g. OVS-DPDK)
> > based on vhost-user for VMs in the Cloud. They are purely software
> > running on CPU cores. When we have accelerators for such NFVi applications,
> > it's ideal if the applications could keep using the original interface
> > (i.e. vhost-user netdev) with QEMU, and infrastructure is able to decide
> > when and how to switch between CPU and accelerators within the interface.
> > And the switching (i.e. switch between CPU and accelerators) can be done
> > flexibly and quickly inside the applications.
> > 
> > More details about this can be found from the Cunming's discussions on
> > the RFC patch set.
> > 
> > Update notes
> > ============
> > 
> > IOMMU feature bit check is removed in this version, because:
> > 
> > The IOMMU feature is negotiable, when an accelerator is used and
> > it doesn't support virtual IOMMU, its driver just won't provide
> > this feature bit when vhost library querying its features. And if
> > it supports the virtual IOMMU, its driver can provide this feature
> > bit. It's not reasonable to add this limitation in this patch set.
> 
> Fair enough. Still:
> Can hardware on intel platforms actually support IOTLB requests?
> Don't you need to add support for vIOMMU shadowing instead?
> 

For the hardware I have, I guess they can't for now.

Best regards,
Tiwei Bie
