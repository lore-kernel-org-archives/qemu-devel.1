Received: from eggs.gnu.org ([2001:4830:134:3::10]:54073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0l1r-0000aP-3p
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d0l1m-0005WT-Oj
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:31:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:28587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d0l1m-0005Vs-EF
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:31:54 -0400
Message-ID: <58F720E0.6070709@intel.com>
Date: Wed, 19 Apr 2017 16:33:36 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<CAJ+F1CL3P96gSVcZCCPatZGp7yUGeryEVSV4aX4rDXRjVBo0uw@mail.gmail.com>
In-Reply-To: <CAJ+F1CL3P96gSVcZCCPatZGp7yUGeryEVSV4aX4rDXRjVBo0uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>

On 04/19/2017 03:31 PM, Marc-André Lureau wrote:
> Hi
>
> On Wed, Apr 19, 2017 at 10:38 AM Wang, Wei W <wei.w.wang@intel.com 
> <mailto:wei.w.wang@intel.com>> wrote:
>
>     Hi,
>     We made some design changes to the original vhost-pci design, and
>     want to open
>     a discussion about the latest design (labelled 2.0) and its
>     extension (2.1).
>     2.0 design: One VM shares the entire memory of another VM
>     2.1 design: One VM uses an intermediate memory shared with another
>     VM for
>                          packet transmission.
>     For the convenience of discussion, I have some pictures presented
>     at this link:
>     _https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-rfc2.0.pdf_
>     Fig. 1 shows the common driver frame that we want use to build the
>     2.0 and 2.1
>     design. A TX/RX engine consists of a local ring and an exotic ring.
>
>
> Isn't "external" (or "remote") more appropriate than "exotic" ?

OK, probably we can use "remote" here.

>
>     Local ring:
>     1) allocated by the driver itself;
>     2) registered with the device (i.e. virtio_add_queue())
>     Exotic ring:
>     1) ring memory comes from the outside (of the driver), and exposed
>     to the driver
>          via a BAR MMIO;
>     2) does not have a registration in the device, so no
>     ioeventfd/irqfd, configuration
>     registers allocated in the device
>     Fig. 2 shows how the driver frame is used to build the 2.0 design.
>     1) Asymmetric: vhost-pci-net <-> virtio-net
>     2) VM1 shares the entire memory of VM2, and the exotic rings are
>     the rings
>         from VM2.
>     3) Performance (in terms of copies between VMs):
>         TX: 0-copy (packets are put to VM2’s RX ring directly)
>         RX: 1-copy (the green arrow line in the VM1’s RX engine)
>
>
> Why is the copy necessary?

Because the packet from the remote ring can't be delivered to the
network stack directly. To be more precise,
1)  The buffer from the remote ring is not allocated by the guest 
driver. If the
      buffer is directly delivered to the network stack, the network 
stack will free
      the buffer that is not allocated by the guest;
2) When we think about the vring operation, after getting the buffer 
from the
     avail ring, we need to put back the used buffer to the used ring to 
tell the
     other end that the buffer has been used. The network stack won't do 
this
     operation.

So, based on the two points. I think we need to use a local ring, and 
copy the
packet to the buffer from the local ring (i.e. buffer memory allocated 
by the
guest driver), and the driver will do the "give back used buffer" operation
as explained in 2).


>     Fig. 3 shows how the driver frame is used to build the 2.1 design.
>     1) Symmetric: vhost-pci-net <-> vhost-pci-net
>     2) Share an intermediate memory, allocated by VM1’s vhost-pci device,
>     for data exchange, and the exotic rings are built on the shared memory
>     3) Performance:
>         TX: 1-copy
>     RX: 1-copy
>     Fig. 4 shows the inter-VM notification path for 2.0 (2.1 is similar).
>     The four eventfds are allocated by virtio-net, and shared with
>     vhost-pci-net:
>     Uses virtio-net’s TX/RX kickfd as the vhost-pci-net’s RX/TX callfd
>     Uses virtio-net’s TX/RX callfd as the vhost-pci-net’s RX/TX kickfd
>     Example of how it works:
>     After packets are put into vhost-pci-net’s TX, the driver kicks
>     TX, which
>     causes the an interrupt associated with fd3 to be injected to
>     virtio-net
>     The draft code of the 2.0 design is ready, and can be found here:
>     Qemu: _https://github.com/wei-w-wang/vhost-pci-device_
>
>
> The repository contains a single big commit 
> (https://github.com/wei-w-wang/vhost-pci-device/commit/fa01ec5e41de176197dae505c05b659f5483187f). 
> Please try to provide a seperate patch or series of patch from an 
> upstream commit/release point.

It's the test-able version of the 2.0 design. I will separate it.
If possible, hope we can review the design first, especially the common
driver frame. Then I can make the related changes from the
discussion, and post out the patch series.

Best,
Wei
