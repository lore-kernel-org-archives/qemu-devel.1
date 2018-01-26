Received: from eggs.gnu.org ([2001:4830:134:3::10]:57473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eexBY-00030Y-OM
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 01:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eexBT-00089Y-IU
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 01:08:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:7977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1eexBT-00087v-Al
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 01:08:19 -0500
Date: Fri, 26 Jan 2018 13:57:59 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180126055759.vu4qwdpjbzf4mg4j@debian-xvivbkq.sh.intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
	<20180125040328.22867-7-tiwei.bie@intel.com>
	<20180126015553-mutt-send-email-mst@kernel.org>
	<28ab37d5-6cf6-866d-9167-e14e7441415f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28ab37d5-6cf6-866d-9167-e14e7441415f@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v1 6/6] vhost-user: add
 VFIO based accelerators support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Fri, Jan 26, 2018 at 11:41:27AM +0800, Jason Wang wrote:
> On 2018年01月26日 07:59, Michael S. Tsirkin wrote:
> > > The virtual IOMMU isn't supported by the accelerators for now.
> > > Because vhost-user currently lacks of an efficient way to share
> > > the IOMMU table in VM to vhost backend. That's why the software
> > > implementation of virtual IOMMU support in vhost-user backend
> > > can't support dynamic mapping well.
> > What exactly is meant by that? vIOMMU seems to work for people,
> > it's not that fast if you change mappings all the time,
> > but e.g. dpdk within guest doesn't.
> 
> Yes, software implementation support dynamic mapping for sure. I think the
> point is, current vhost-user backend can not program hardware IOMMU. So it
> can not let hardware accelerator to cowork with software vIOMMU.

Vhost-user backend can program hardware IOMMU. Currently
vhost-user backend (or more precisely the vDPA driver in
vhost-user backend) will use the memory table (delivered
by the VHOST_USER_SET_MEM_TABLE message) to program the
IOMMU via vfio, and that's why accelerators can use the
GPA (guest physical address) in descriptors directly.

Theoretically, we can use the IOVA mapping info (delivered
by the VHOST_USER_IOTLB_MSG message) to program the IOMMU,
and accelerators will be able to use IOVA. But the problem
is that in vhost-user QEMU won't push all the IOVA mappings
to backend directly. Backend needs to ask for those info
when it meets a new IOVA. Such design and implementation
won't work well for dynamic mappings anyway and couldn't
be supported by hardware accelerators.

> I think
> that's another call to implement the offloaded path inside qemu which has
> complete support for vIOMMU co-operated VFIO.

Yes, that's exactly what we want. After revisiting the
last paragraph in the commit message, I found it's not
really accurate. The practicability of dynamic mappings
support is a common issue for QEMU. It also exists for
vfio (hw/vfio in QEMU). If QEMU needs to trap all the
map/unmap events, the data path performance couldn't be
high. If we want to thoroughly fix this issue especially
for vfio (hw/vfio in QEMU), we need to have the offload
path Jason mentioned in QEMU. And I think accelerators
could use it too.

Best regards,
Tiwei Bie

> 
> Thanks
> 
> > 
> > > Once this problem is solved
> > > in vhost-user, virtual IOMMU can be supported by accelerators
> > > too, and the IOMMU feature bit checking in this patch can be
> > > removed.
> > Given it works with software backends right now, I suspect
> > this will be up to you guys to address.
> > 
> 
