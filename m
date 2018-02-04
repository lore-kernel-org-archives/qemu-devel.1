Received: from eggs.gnu.org ([2001:4830:134:3::10]:38508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.duyck@gmail.com>) id 1eiSAX-0005Cj-KE
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 16:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.duyck@gmail.com>) id 1eiSAW-0007xt-9C
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 16:49:49 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
	id 1eiSAW-0007xb-48
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 16:49:48 -0500
Received: by mail-qk0-x244.google.com with SMTP id m130so5410215qke.1
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 13:49:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180126055759.vu4qwdpjbzf4mg4j@debian-xvivbkq.sh.intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
	<20180125040328.22867-7-tiwei.bie@intel.com>
	<20180126015553-mutt-send-email-mst@kernel.org>
	<28ab37d5-6cf6-866d-9167-e14e7441415f@redhat.com>
	<20180126055759.vu4qwdpjbzf4mg4j@debian-xvivbkq.sh.intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 4 Feb 2018 13:49:46 -0800
Message-ID: <CAKgT0UcCKxBmm23tOXreTQwKsY4wqLF1MwtQm7ND7Ee0Td0rjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Jan 25, 2018 at 9:57 PM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> On Fri, Jan 26, 2018 at 11:41:27AM +0800, Jason Wang wrote:
>> On 2018=E5=B9=B401=E6=9C=8826=E6=97=A5 07:59, Michael S. Tsirkin wrote:
>> > > The virtual IOMMU isn't supported by the accelerators for now.
>> > > Because vhost-user currently lacks of an efficient way to share
>> > > the IOMMU table in VM to vhost backend. That's why the software
>> > > implementation of virtual IOMMU support in vhost-user backend
>> > > can't support dynamic mapping well.
>> > What exactly is meant by that? vIOMMU seems to work for people,
>> > it's not that fast if you change mappings all the time,
>> > but e.g. dpdk within guest doesn't.
>>
>> Yes, software implementation support dynamic mapping for sure. I think t=
he
>> point is, current vhost-user backend can not program hardware IOMMU. So =
it
>> can not let hardware accelerator to cowork with software vIOMMU.
>
> Vhost-user backend can program hardware IOMMU. Currently
> vhost-user backend (or more precisely the vDPA driver in
> vhost-user backend) will use the memory table (delivered
> by the VHOST_USER_SET_MEM_TABLE message) to program the
> IOMMU via vfio, and that's why accelerators can use the
> GPA (guest physical address) in descriptors directly.
>
> Theoretically, we can use the IOVA mapping info (delivered
> by the VHOST_USER_IOTLB_MSG message) to program the IOMMU,
> and accelerators will be able to use IOVA. But the problem
> is that in vhost-user QEMU won't push all the IOVA mappings
> to backend directly. Backend needs to ask for those info
> when it meets a new IOVA. Such design and implementation
> won't work well for dynamic mappings anyway and couldn't
> be supported by hardware accelerators.
>
>> I think
>> that's another call to implement the offloaded path inside qemu which ha=
s
>> complete support for vIOMMU co-operated VFIO.
>
> Yes, that's exactly what we want. After revisiting the
> last paragraph in the commit message, I found it's not
> really accurate. The practicability of dynamic mappings
> support is a common issue for QEMU. It also exists for
> vfio (hw/vfio in QEMU). If QEMU needs to trap all the
> map/unmap events, the data path performance couldn't be
> high. If we want to thoroughly fix this issue especially
> for vfio (hw/vfio in QEMU), we need to have the offload
> path Jason mentioned in QEMU. And I think accelerators
> could use it too.
>
> Best regards,
> Tiwei Bie

I wonder if we couldn't look at coming up with an altered security
model for the IOMMU drivers to address some of the performance issues
seen with typical hardware IOMMU?

In the case of most network devices, we seem to be moving toward a
model where the Rx pages are mapped for an extended period of time and
see a fairly high rate of reuse. As such pages mapped as being
writable or read/write by the device are left mapped for an extended
period of time while Tx pages, which are read only, are often
mapped/unmapped since they are coming from some other location in the
kernel beyond the driver's control.

If we were to somehow come up with a model where the read-only(Tx)
pages had access to a pre-allocated memory mapped address, and the
read/write(descriptor rings), write-only(Rx) pages were provided with
dynamic addresses we might be able to come up with a solution that
would allow for fairly high network performance while at least
protecting from memory corruption. The only issue it would open up is
that the device would have the ability to read any/all memory on the
guest. I was wondering about doing something like this with the vIOMMU
with VFIO for the Intel NICs this way since an interface like igb,
ixgbe, ixgbevf, i40e, or i40evf would probably show pretty good
performance under such a model and as long as the writable pages were
being tracked by the vIOMMU. It could even allow for live migration
support if the vIOMMU provided the info needed for migratable/dirty
page tracking and we held off on migrating any of the dynamically
mapped pages until after they were either unmapped or an FLR reset the
device.

Thanks.

- Alex
