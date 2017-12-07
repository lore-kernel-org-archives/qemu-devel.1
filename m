Received: from eggs.gnu.org ([2001:4830:134:3::10]:56860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eN08T-0000Up-Mb
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eN08P-0007Ps-OS
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:39:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eN08P-0007Pk-Es
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:38:57 -0500
Date: Thu, 7 Dec 2017 19:38:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171207193003-mutt-send-email-mst@kernel.org>
References: <286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
	<5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
	<5A290398.60508@intel.com>
	<CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
	<20171207153454-mutt-send-email-mst@kernel.org>
	<CAJSP0QVu4iwAu01Sth84VZshQde97x3FW1E1ua_YXVKs-65vhQ@mail.gmail.com>
	<20171207183945-mutt-send-email-mst@kernel.org>
	<CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVnukGD3Afu9myv=v5OjqrPDpXu6JL3Tpf+Cdk=em9V3w@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On Thu, Dec 07, 2017 at 05:29:14PM +0000, Stefan Hajnoczi wrote:
> On Thu, Dec 7, 2017 at 4:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Dec 07, 2017 at 04:29:45PM +0000, Stefan Hajnoczi wrote:
> >> On Thu, Dec 7, 2017 at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> > On Thu, Dec 07, 2017 at 01:08:04PM +0000, Stefan Hajnoczi wrote:
> >> >> Instead of responding individually to these points, I hope this will
> >> >> explain my perspective.  Let me know if you do want individual
> >> >> responses, I'm happy to talk more about the points above but I think
> >> >> the biggest difference is our perspective on this:
> >> >>
> >> >> Existing vhost-user slave code should be able to run on top of
> >> >> vhost-pci.  For example, QEMU's
> >> >> contrib/vhost-user-scsi/vhost-user-scsi.c should work inside the guest
> >> >> with only minimal changes to the source file (i.e. today it explicitly
> >> >> opens a UNIX domain socket and that should be done by libvhost-user
> >> >> instead).  It shouldn't be hard to add vhost-pci vfio support to
> >> >> contrib/libvhost-user/ alongside the existing UNIX domain socket code.
> >> >>
> >> >> This seems pretty easy to achieve with the vhost-pci PCI adapter that
> >> >> I've described but I'm not sure how to implement libvhost-user on top
> >> >> of vhost-pci vfio if the device doesn't expose the vhost-user
> >> >> protocol.
> >> >>
> >> >> I think this is a really important goal.  Let's use a single
> >> >> vhost-user software stack instead of creating a separate one for guest
> >> >> code only.
> >> >>
> >> >> Do you agree that the vhost-user software stack should be shared
> >> >> between host userspace and guest code as much as possible?
> >> >
> >> >
> >> >
> >> > The sharing you propose is not necessarily practical because the security goals
> >> > of the two are different.
> >> >
> >> > It seems that the best motivation presentation is still the original rfc
> >> >
> >> > http://virtualization.linux-foundation.narkive.com/A7FkzAgp/rfc-vhost-user-enhancements-for-vm2vm-communication
> >> >
> >> > So comparing with vhost-user iotlb handling is different:
> >> >
> >> > With vhost-user guest trusts the vhost-user backend on the host.
> >> >
> >> > With vhost-pci we can strive to limit the trust to qemu only.
> >> > The switch running within a VM does not have to be trusted.
> >>
> >> Can you give a concrete example?
> >>
> >> I have an idea about what you're saying but it may be wrong:
> >>
> >> Today the iotlb mechanism in vhost-user does not actually enforce
> >> memory permissions.  The vhost-user slave has full access to mmapped
> >> memory regions even when iotlb is enabled.  Currently the iotlb just
> >> adds an indirection layer but no real security.  (Is this correct?)
> >
> > Not exactly. iotlb protects against malicious drivers within guest.
> > But yes, not against a vhost-user driver on the host.
> >
> >> Are you saying the vhost-pci device code in QEMU should enforce iotlb
> >> permissions so the vhost-user slave guest only has access to memory
> >> regions that are allowed by the iotlb?
> >
> > Yes.
> 
> Okay, thanks for confirming.
> 
> This can be supported by the approach I've described.  The vhost-pci
> QEMU code has control over the BAR memory so it can prevent the guest
> from accessing regions that are not allowed by the iotlb.
> 
> Inside the guest the vhost-user slave still has the memory region
> descriptions and sends iotlb messages.  This is completely compatible
> with the libvirt-user APIs and existing vhost-user slave code can run
> fine.  The only unique thing is that guest accesses to memory regions
> not allowed by the iotlb do not work because QEMU has prevented it.

I don't think this can work since suddenly you need
to map full IOMMU address space into BAR.

Besides, this means implementing iotlb in both qemu and guest.

> If better performance is needed then it might be possible to optimize
> this interface by handling most or even all of the iotlb stuff in QEMU
> vhost-pci code and not exposing it to the vhost-user slave in the
> guest.  But it doesn't change the fact that the vhost-user protocol
> can be used and the same software stack works.

For one, the iotlb part would be out of scope then.
Instead you would have code to offset from BAR.

> Do you have a concrete example of why sharing the same vhost-user
> software stack inside the guest can't work?

With enough dedication some code might be shared.  OTOH reusing virtio
gains you a ready feature negotiation and discovery protocol.

I'm not convinced which has more value, and the second proposal
has been implemented already.



> >> and QEMU generally doesn't
> >> implement things this way.
> >
> > Not sure what does this mean.
> 
> It's the reason why virtio-9p has a separate virtfs-proxy-helper
> program.  Root is needed to set file uid/gids.  Instead of running
> QEMU as root, there is a separate helper process that handles the
> privileged operations.  It slows things down and makes the codebase
> larger but it prevents the guest from getting root in case of QEMU
> bugs.
>
> The reason why VMs are considered more secure than containers is
> because of the extra level of isolation provided by running device
> emulation in an unprivileged userspace process.  If you change this
> model then QEMU loses the "security in depth" advantage.
> 
> Stefan

I don't see where vhost-pci needs QEMU to run as root though.
