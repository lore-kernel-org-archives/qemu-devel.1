Received: from eggs.gnu.org ([2001:4830:134:3::10]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejXlD-0008Tk-Fx
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejXl9-0007sA-IG
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:00:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejXl9-0007rm-Ak
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:00:07 -0500
Date: Wed, 7 Feb 2018 23:59:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180207202015-mutt-send-email-mst@kernel.org>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
	<20180125040328.22867-7-tiwei.bie@intel.com>
	<20180126015553-mutt-send-email-mst@kernel.org>
	<28ab37d5-6cf6-866d-9167-e14e7441415f@redhat.com>
	<20180126055759.vu4qwdpjbzf4mg4j@debian-xvivbkq.sh.intel.com>
	<CAKgT0UcCKxBmm23tOXreTQwKsY4wqLF1MwtQm7ND7Ee0Td0rjQ@mail.gmail.com>
	<20180207175416-mutt-send-email-mst@kernel.org>
	<CAKgT0UciD4XyAovFt0vyeJBCisjjE3i4_tFu3SMMYrmWpxos1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgT0UciD4XyAovFt0vyeJBCisjjE3i4_tFu3SMMYrmWpxos1A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
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
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Wed, Feb 07, 2018 at 10:02:24AM -0800, Alexander Duyck wrote:
> On Wed, Feb 7, 2018 at 8:43 AM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > On Sun, Feb 04, 2018 at 01:49:46PM -0800, Alexander Duyck wrote:
> >> On Thu, Jan 25, 2018 at 9:57 PM, Tiwei Bie <tiwei.bie@intel.com> wro=
te:
> >> > On Fri, Jan 26, 2018 at 11:41:27AM +0800, Jason Wang wrote:
> >> >> On 2018=E5=B9=B401=E6=9C=8826=E6=97=A5 07:59, Michael S. Tsirkin =
wrote:
> >> >> > > The virtual IOMMU isn't supported by the accelerators for now=
.
> >> >> > > Because vhost-user currently lacks of an efficient way to sha=
re
> >> >> > > the IOMMU table in VM to vhost backend. That's why the softwa=
re
> >> >> > > implementation of virtual IOMMU support in vhost-user backend
> >> >> > > can't support dynamic mapping well.
> >> >> > What exactly is meant by that? vIOMMU seems to work for people,
> >> >> > it's not that fast if you change mappings all the time,
> >> >> > but e.g. dpdk within guest doesn't.
> >> >>
> >> >> Yes, software implementation support dynamic mapping for sure. I =
think the
> >> >> point is, current vhost-user backend can not program hardware IOM=
MU. So it
> >> >> can not let hardware accelerator to cowork with software vIOMMU.
> >> >
> >> > Vhost-user backend can program hardware IOMMU. Currently
> >> > vhost-user backend (or more precisely the vDPA driver in
> >> > vhost-user backend) will use the memory table (delivered
> >> > by the VHOST_USER_SET_MEM_TABLE message) to program the
> >> > IOMMU via vfio, and that's why accelerators can use the
> >> > GPA (guest physical address) in descriptors directly.
> >> >
> >> > Theoretically, we can use the IOVA mapping info (delivered
> >> > by the VHOST_USER_IOTLB_MSG message) to program the IOMMU,
> >> > and accelerators will be able to use IOVA. But the problem
> >> > is that in vhost-user QEMU won't push all the IOVA mappings
> >> > to backend directly. Backend needs to ask for those info
> >> > when it meets a new IOVA. Such design and implementation
> >> > won't work well for dynamic mappings anyway and couldn't
> >> > be supported by hardware accelerators.
> >> >
> >> >> I think
> >> >> that's another call to implement the offloaded path inside qemu w=
hich has
> >> >> complete support for vIOMMU co-operated VFIO.
> >> >
> >> > Yes, that's exactly what we want. After revisiting the
> >> > last paragraph in the commit message, I found it's not
> >> > really accurate. The practicability of dynamic mappings
> >> > support is a common issue for QEMU. It also exists for
> >> > vfio (hw/vfio in QEMU). If QEMU needs to trap all the
> >> > map/unmap events, the data path performance couldn't be
> >> > high. If we want to thoroughly fix this issue especially
> >> > for vfio (hw/vfio in QEMU), we need to have the offload
> >> > path Jason mentioned in QEMU. And I think accelerators
> >> > could use it too.
> >> >
> >> > Best regards,
> >> > Tiwei Bie
> >>
> >> I wonder if we couldn't look at coming up with an altered security
> >> model for the IOMMU drivers to address some of the performance issue=
s
> >> seen with typical hardware IOMMU?
> >>
> >> In the case of most network devices, we seem to be moving toward a
> >> model where the Rx pages are mapped for an extended period of time a=
nd
> >> see a fairly high rate of reuse. As such pages mapped as being
> >> writable or read/write by the device are left mapped for an extended
> >> period of time while Tx pages, which are read only, are often
> >> mapped/unmapped since they are coming from some other location in th=
e
> >> kernel beyond the driver's control.
> >>
> >> If we were to somehow come up with a model where the read-only(Tx)
> >> pages had access to a pre-allocated memory mapped address, and the
> >> read/write(descriptor rings), write-only(Rx) pages were provided wit=
h
> >> dynamic addresses we might be able to come up with a solution that
> >> would allow for fairly high network performance while at least
> >> protecting from memory corruption. The only issue it would open up i=
s
> >> that the device would have the ability to read any/all memory on the
> >> guest. I was wondering about doing something like this with the vIOM=
MU
> >> with VFIO for the Intel NICs this way since an interface like igb,
> >> ixgbe, ixgbevf, i40e, or i40evf would probably show pretty good
> >> performance under such a model and as long as the writable pages wer=
e
> >> being tracked by the vIOMMU. It could even allow for live migration
> >> support if the vIOMMU provided the info needed for migratable/dirty
> >> page tracking and we held off on migrating any of the dynamically
> >> mapped pages until after they were either unmapped or an FLR reset t=
he
> >> device.
> >>
> >> Thanks.
> >>
> >> - Alex
> >
> >
> >
> > It might be a good idea to change the iommu instead - how about a
> > variant of strict in intel iommu which forces an IOTLB flush after
> > invalidating a writeable mapping but not a RO mapping?  Not sure what=
 the
> > name would be - relaxed-ro?
> >
> > This is probably easier than poking at the drivers and net core.
> >
> > Keeping the RX pages mapped in the IOMMU was envisioned for XDP.
> > That might be a good place to start.
>=20
> My plan is to update the Intel IOMMU driver first since it seems like
> something that shouldn't require too much expertise in the operation
> of the IOMMU to accomplish. My idea was more along the lines of
> something like a "iommu=3Dread-only-pt" or maybe "iommu=3Dpt-ro" where =
the
> Tx data would be identity mapped, and the descriptor rings and Rx data
> could be in the dynamic mapping setup. The idea is loosely based on
> the existing "iommu=3Dpt" option that is normally used on the host if
> you want to avoid the cost for dynamic mapping. Basically we just need
> to keep an eye on the number of mappings that the device can write to.
> Ideally if we leave the Tx as identity mapped that means we never have
> to actually write to update any mapping which would mean no having to
> jump into the hypervisor to deal with the update.

Just noting that updating page tables does not require jumping
to the hypervisor by itself. Only invalidation requires that.

> The fact that most
> of the drivers already leave the Rx buffers and descriptor rings
> statically mapped should essentially take care of the rest for us.
> What this would become is a version of "iommu=3Dpt" where the user care=
s
> about preventing the device from possibly corrupting memory, but would
> still like better performance at the cost of the device being able to
> ready and/all memory on the system.
>=20
> As far as if it is strict or not I don't know how much we would need
> to worry about that for the migration case. Essentially a deferred
> IOTLB flush would result in us having extra pages marked as dirty and
> non-migratable, but we would need to see how much overhead there is in
> the migration to deal with those extra pages versus the cost of having
> to do an IOTLB flush on every unmap call.
>=20
> Anyway this is an idea that just occurred to me the other day so I
> still need to do some more research into how easy/difficult
> implementing a solution like this would be.
>=20
> Thanks.
>=20
> - Alex

Right. And I think if you do a straight pt, then this is not
a security as much as a robustness feature. I guess both
have a place under the sun.

--=20
MST
