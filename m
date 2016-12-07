Received: from eggs.gnu.org ([2001:4830:134:3::10]:48044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEVzf-0006yj-L8
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 01:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEVza-0006ZL-Gm
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 01:46:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cEVza-0006Z5-8P
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 01:46:14 -0500
Date: Wed, 7 Dec 2016 14:43:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161207064322.GA28693@pxdev.xzpeter.org>
References: <1480348315-13332-1-git-send-email-bd.aviv@gmail.com>
	<8188dd5e-2c71-dbd0-9a1a-9c8af6f74b96@intel.com>
	<20161202065214.GF21601@pxdev.xzpeter.org>
	<088c2afd-575e-99af-1686-023c116352ab@intel.com>
	<20161206065155.GB4344@pxdev.xzpeter.org>
	<6d37d046-8e5a-7662-baa6-445d3985fde7@intel.com>
	<20161206072228.GC4344@pxdev.xzpeter.org>
	<f9f9daab-519d-381b-c9e8-c6dcc139f1d3@intel.com>
	<20161206105914.GB3469@pxdev.xzpeter.org>
	<1b348745-3135-e28c-88f3-f45ed1855de3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b348745-3135-e28c-88f3-f45ed1855de3@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/5] IOMMU: intel_iommu support map and
 unmap notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Aviv B.D" <bd.aviv@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>

On Wed, Dec 07, 2016 at 02:09:16PM +0800, Lan Tianyu wrote:
> On 2016=E5=B9=B412=E6=9C=8806=E6=97=A5 18:59, Peter Xu wrote:
> > On Tue, Dec 06, 2016 at 04:27:39PM +0800, Lan Tianyu wrote:
> >=20
> > [...]
> >=20
> >>>
> >>>> User space driver(E.G DPDK) also can enable/disable
> >>>> IOVA for device dynamically.
> >>>
> >>> Could you provide more detailed (or any pointer) on how to do that?=
 I
> >>> did try to find it myself, I see an VFIO_IOMMU_ENABLE ioctl, but lo=
oks
> >>> like it is for ppc only.
> >>
> >> No, I just give an example that user space may do that but no more
> >> research. But since Qemu already can enable device's IOVA, other use=
r
> >> application also should can do that with the same VFIO interface, ri=
ght?
> >=20
> > AFAIU we can't do that at least on x86. We can use vfio interface to
> > bind group into container, but we should not be able to dynamically
> > disable IOMMU protection. IIUC That needs to taint the kernel.
> >=20
> > The only way I know is that we probe vfio-pci with no-iommu mode, in
> > that case, we disabled IOMMU, but we can never dynamically enable it
> > as well.
> >=20
> > Please correct me if I am wrong.
>=20
>=20
> Actually, disabling device's IOVA doesn't require to disable kernel
> global DMA protect and just clear device's VTD context entry in the
> context table. Go though IOMMU and VFIO code, find this will happen whe=
n
> call VFIO_GROUP_UNSET_CONTAINER ioctl and it will be called when destro=
y
> VM or unplug assigned device in Qemu. Please help to double check.
>=20
> Call trace:
> __vfio_group_unset_container()
> vfio_iommu_type1_detach_group()
> iommu_detach_group()
> dmar_remove_one_dev_info()
> __dmar_remove_one_dev_info()
> domain_context_clear()
>=20
>=20
> The legacy KVM device assign code also will call iommu_detach_device()
> when deassign a device.
>=20
> From device emulation view, we need to make sure correct register
> emulation regardless of guest behavior.

Even if the context entry is cleared and invalidated, IMHO it does not
mean that we should be using GPA address space, nor do we need to put
it into guest physical address space. Instead, it simply means this
device cannot do any IO at that time. If IO comes, IOMMU should do
fault reporting to guest OS, which should be treated as error.

So I think we are emulating the correct guest behavior here - we don't
need to do anything if a device is detached from an existing IOMMU
domain in guest. If we do (e.g., we replay the GPA address space on
that device when it is detached, so the shadow page table for that
device maps the whole guest memory), that is dangerous, because with
that the device can DMA to anywhere it wants to guest memory.

Thanks,

-- peterx
