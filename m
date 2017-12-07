Received: from eggs.gnu.org ([2001:4830:134:3::10]:48086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMwkv-00065T-RE
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMwkm-0000Xe-D8
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:02:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eMwkm-0000XJ-6H
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:02:20 -0500
Date: Thu, 7 Dec 2017 16:02:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171207153454-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
	<5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
	<5A290398.60508@intel.com>
	<CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QURjdD8BnOmJo83fzJn_zCijSKQh==Pz+Xu4r6Q2i3SkQ@mail.gmail.com>
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

On Thu, Dec 07, 2017 at 01:08:04PM +0000, Stefan Hajnoczi wrote:
> Instead of responding individually to these points, I hope this will
> explain my perspective.  Let me know if you do want individual
> responses, I'm happy to talk more about the points above but I think
> the biggest difference is our perspective on this:
> 
> Existing vhost-user slave code should be able to run on top of
> vhost-pci.  For example, QEMU's
> contrib/vhost-user-scsi/vhost-user-scsi.c should work inside the guest
> with only minimal changes to the source file (i.e. today it explicitly
> opens a UNIX domain socket and that should be done by libvhost-user
> instead).  It shouldn't be hard to add vhost-pci vfio support to
> contrib/libvhost-user/ alongside the existing UNIX domain socket code.
> 
> This seems pretty easy to achieve with the vhost-pci PCI adapter that
> I've described but I'm not sure how to implement libvhost-user on top
> of vhost-pci vfio if the device doesn't expose the vhost-user
> protocol.
> 
> I think this is a really important goal.  Let's use a single
> vhost-user software stack instead of creating a separate one for guest
> code only.
> 
> Do you agree that the vhost-user software stack should be shared
> between host userspace and guest code as much as possible?



The sharing you propose is not necessarily practical because the security goals
of the two are different.

It seems that the best motivation presentation is still the original rfc

http://virtualization.linux-foundation.narkive.com/A7FkzAgp/rfc-vhost-user-enhancements-for-vm2vm-communication

So comparing with vhost-user iotlb handling is different:

With vhost-user guest trusts the vhost-user backend on the host.

With vhost-pci we can strive to limit the trust to qemu only.
The switch running within a VM does not have to be trusted.

-- 
MST
