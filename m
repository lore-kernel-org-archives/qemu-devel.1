Received: from eggs.gnu.org ([2001:4830:134:3::10]:42609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNBpR-0001EF-09
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNBpP-00043R-Gu
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:08:08 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:45061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eNBpP-00042R-81
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 01:08:07 -0500
Received: by mail-wm0-x233.google.com with SMTP id 9so1541725wme.4
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 22:08:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207213420-mutt-send-email-mst@kernel.org>
References: <5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
	<5A290398.60508@intel.com>
	<CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
	<20171207153454-mutt-send-email-mst@kernel.org>
	<CAJSP0QVu4iwAu01Sth84VZshQde97x3FW1E1ua_YXVKs-65vhQ@mail.gmail.com>
	<20171207183945-mutt-send-email-mst@kernel.org>
	<CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
	<20171207193003-mutt-send-email-mst@kernel.org>
	<CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Dec 2017 06:08:05 +0000
Message-ID: <CAJSP0QXYMVBidUd5-NJb5FDYbc6wSkNYgdadjk8+NXvwosLMPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On Thu, Dec 7, 2017 at 11:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Dec 07, 2017 at 06:28:19PM +0000, Stefan Hajnoczi wrote:
>> On Thu, Dec 7, 2017 at 5:38 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Thu, Dec 07, 2017 at 05:29:14PM +0000, Stefan Hajnoczi wrote:
>> >> On Thu, Dec 7, 2017 at 4:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Thu, Dec 07, 2017 at 04:29:45PM +0000, Stefan Hajnoczi wrote:
>> >> >> On Thu, Dec 7, 2017 at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> >> > On Thu, Dec 07, 2017 at 01:08:04PM +0000, Stefan Hajnoczi wrote:
>> >> >> >> Instead of responding individually to these points, I hope this will
>> >> >> >> explain my perspective.  Let me know if you do want individual
>> >> >> >> responses, I'm happy to talk more about the points above but I think
>> >> >> >> the biggest difference is our perspective on this:
>> >> >> >>
>> >> >> >> Existing vhost-user slave code should be able to run on top of
>> >> >> >> vhost-pci.  For example, QEMU's
>> >> >> >> contrib/vhost-user-scsi/vhost-user-scsi.c should work inside the guest
>> >> >> >> with only minimal changes to the source file (i.e. today it explicitly
>> >> >> >> opens a UNIX domain socket and that should be done by libvhost-user
>> >> >> >> instead).  It shouldn't be hard to add vhost-pci vfio support to
>> >> >> >> contrib/libvhost-user/ alongside the existing UNIX domain socket code.
>> >> >> >>
>> >> >> >> This seems pretty easy to achieve with the vhost-pci PCI adapter that
>> >> >> >> I've described but I'm not sure how to implement libvhost-user on top
>> >> >> >> of vhost-pci vfio if the device doesn't expose the vhost-user
>> >> >> >> protocol.
>> >> >> >>
>> >> >> >> I think this is a really important goal.  Let's use a single
>> >> >> >> vhost-user software stack instead of creating a separate one for guest
>> >> >> >> code only.
>> >> >> >>
>> >> >> >> Do you agree that the vhost-user software stack should be shared
>> >> >> >> between host userspace and guest code as much as possible?
>> >> >> >
>> >> >> >
>> >> >> >
>> >> >> > The sharing you propose is not necessarily practical because the security goals
>> >> >> > of the two are different.
>> >> >> >
>> >> >> > It seems that the best motivation presentation is still the original rfc
>> >> >> >
>> >> >> > http://virtualization.linux-foundation.narkive.com/A7FkzAgp/rfc-vhost-user-enhancements-for-vm2vm-communication
>> >> >> >
>> >> >> > So comparing with vhost-user iotlb handling is different:
>> >> >> >
>> >> >> > With vhost-user guest trusts the vhost-user backend on the host.
>> >> >> >
>> >> >> > With vhost-pci we can strive to limit the trust to qemu only.
>> >> >> > The switch running within a VM does not have to be trusted.
>> >> >>
>> >> >> Can you give a concrete example?
>> >> >>
>> >> >> I have an idea about what you're saying but it may be wrong:
>> >> >>
>> >> >> Today the iotlb mechanism in vhost-user does not actually enforce
>> >> >> memory permissions.  The vhost-user slave has full access to mmapped
>> >> >> memory regions even when iotlb is enabled.  Currently the iotlb just
>> >> >> adds an indirection layer but no real security.  (Is this correct?)
>> >> >
>> >> > Not exactly. iotlb protects against malicious drivers within guest.
>> >> > But yes, not against a vhost-user driver on the host.
>> >> >
>> >> >> Are you saying the vhost-pci device code in QEMU should enforce iotlb
>> >> >> permissions so the vhost-user slave guest only has access to memory
>> >> >> regions that are allowed by the iotlb?
>> >> >
>> >> > Yes.
>> >>
>> >> Okay, thanks for confirming.
>> >>
>> >> This can be supported by the approach I've described.  The vhost-pci
>> >> QEMU code has control over the BAR memory so it can prevent the guest
>> >> from accessing regions that are not allowed by the iotlb.
>> >>
>> >> Inside the guest the vhost-user slave still has the memory region
>> >> descriptions and sends iotlb messages.  This is completely compatible
>> >> with the libvirt-user APIs and existing vhost-user slave code can run
>> >> fine.  The only unique thing is that guest accesses to memory regions
>> >> not allowed by the iotlb do not work because QEMU has prevented it.
>> >
>> > I don't think this can work since suddenly you need
>> > to map full IOMMU address space into BAR.
>>
>> The BAR covers all guest RAM
>> but QEMU can set up MemoryRegions that
>> hide parts from the guest (e.g. reads produce 0xff).  I'm not sure how
>> expensive that is but implementing a strict IOMMU is hard to do
>> without performance overhead.
>
> I'm worried about leaking PAs.
> fundamentally if you want proper protection you
> need your device driver to use VA for addressing,
>
> On the one hand BAR only needs to be as large as guest PA then.
> On the other hand it must cover all of guest PA,
> not just what is accessible to the device.

A more heavyweight iotlb implementation in QEMU's vhost-pci device
could present only VAs to the vhost-pci driver.  It would use
MemoryRegions to map pieces of shared guest memory dynamically.  The
only information leak would be the overall guest RAM size because we
still need to set the correct BAR size.

>>
>> > Besides, this means implementing iotlb in both qemu and guest.
>>
>> It's free in the guest, the libvhost-user stack already has it.
>
> That library is designed to work with a unix domain socket
> though. We'll need extra kernel code to make a device
> pretend it's a socket.

A kernel vhost-pci driver isn't necessary because I don't think there
are in-kernel users.

A vfio vhost-pci backend can go alongside the UNIX domain socket
backend that exists today in libvhost-user.

If we want to expose kernel vhost devices via vhost-pci then a
libvhost-user program can translate the vhost-user protocol into
kernel ioctls.  For example:
$ vhost-pci-proxy --vhost-pci-addr 00:04.0 --vhost-fd 3 3<>/dev/vhost-net

The vhost-pci-proxy implements the vhost-user protocol callbacks and
submits ioctls on the vhost kernel device fd.  I haven't compared the
kernel ioctl interface vs the vhost-user protocol to see if everything
maps cleanly though.

Stefan
