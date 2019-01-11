Received: from eggs.gnu.org ([209.51.188.92]:52651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1ghzfN-0005bu-KS
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1ghzfM-0001JU-PQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:28:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:54024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <keith.busch@intel.com>)
	id 1ghzfM-0001G7-D2
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:28:16 -0500
Date: Fri, 11 Jan 2019 09:26:42 -0700
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20190111162642.GE21095@localhost.localdomain>
References: <20190110083753.GA31730@yangzhon-Virtual>
	<20190110103636.GG19025@stefanha-x1.localdomain>
	<20190111054604.GA1038@yangzhon-Virtual>
	<a7e15215-e2df-309b-b1f6-6741bfff7247@redhat.com>
	<20190111155824.GB14776@stefanha-x1.localdomain>
	<72a500b8-4681-94c5-a258-5ba8b0e8fa9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a500b8-4681-94c5-a258-5ba8b0e8fa9b@redhat.com>
Subject: Re: [Qemu-devel] If Qemu support NVMe over Fabrics ?y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net

On Fri, Jan 11, 2019 at 05:07:26PM +0100, Paolo Bonzini wrote:
> On 11/01/19 16:58, Stefan Hajnoczi wrote:
> > Before investing time in doing that, what is the goal?
> > 
> > Is this for test and bring-up of NVMe-oF?  Or why does the guest need to
> > know that the storage is NVMe-oF?
> > 
> > As I mentioned before, if your host supports NVMe-oF you can simply give
> > the block device to QEMU and let the guest access it via virtio-blk,
> > virtio-scsi, NVMe, etc.
> 
> NVMe-OF is an RDMA protocol, basically a different transport for the
> NVMe command set and queue abstraction.  It would allow QEMU to access
> the device directly (similar to what block/nvme.c does for PCI using
> VFIO) without going through the host kernel.  The guest would see the
> device as virtio-blk/scsi, NVMe or anything else.
> 
> Paolo

I think there's multiple ways to interpret the original request, and I'm
not sure which is the right one.

If he just wants a guest's backing storage to be an nvmeof target,
then Stefan's response sounds right with qemu abstracted from the
underlying protocol as long as the host supports it.

The other way I interpreted this is he wants a guest to connect to an
nvmeof target. If so, then the guest just needs to be provisioned with an
RDMA NIC or fibre channel, or even a virtio-nic may work if the fabric
target is NVMe-over-TCP. You'd just need a capable nvmeof driver stack
in the guest.

If the request is really to implement a vfio based solution to bypass
the host kernel ... that sounds like an interesting project. :)
