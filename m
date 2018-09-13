Received: from eggs.gnu.org ([2001:4830:134:3::10]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0KjV-0001R1-G3
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0KjU-0001H2-Qr
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:04:05 -0400
Date: Thu, 13 Sep 2018 14:03:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180913060351.GK2526@lemon.usersys.redhat.com>
References: <20180910145616.8598-1-famz@redhat.com>
	<20180910145616.8598-3-famz@redhat.com>
	<9f4907a3-e96e-131c-a032-1669d0c09bc8@redhat.com>
	<20180911141245.GQ19292@lemon.usersys.redhat.com>
	<271b24b6-c8eb-1425-3e73-e0ec734bafc6@redhat.com>
	<20180912013134.GA2526@lemon.usersys.redhat.com>
	<3266e1a2-d4af-e8b3-1239-21778396718e@redhat.com>
	<20180912115020.GH2526@lemon.usersys.redhat.com>
	<ea9cb5ce-823b-a40f-701e-bce6d4cb2eeb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9cb5ce-823b-a40f-701e-bce6d4cb2eeb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-scsi/virtio-blk: Disable poll
 handlers when stopping vq handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 09/12 14:42, Paolo Bonzini wrote:
> On 12/09/2018 13:50, Fam Zheng wrote:
> >> I think it's okay if it is invoked.  The sequence is first you stop the
> >> vq, then you drain the BlockBackends, then you switch AioContext.  All
> >> that matters is the outcome when virtio_scsi_dataplane_stop returns.
> > Yes, but together with vIOMMU, it also effectively leads to a virtio_error(),
> > which is not clean. QEMU stderr when this call happens (with patch 1 but not
> > this patch):
> > 
> > 2018-09-12T11:48:10.193023Z qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=02:00:00, iova=0x0)
> > 2018-09-12T11:48:10.193044Z qemu-system-x86_64: New fault is not recorded due to compression of faults
> > 2018-09-12T11:48:10.193061Z qemu-system-x86_64: virtio: zero sized buffers are not allowed
> 
> But with iothread, virtio_scsi_dataplane_stop runs in another thread
> than the iothread; in that case you still have a race where the iothread
> can process the vq before aio_disable_external and print the error.
> 
> IIUC the guest has cleared the IOMMU page tables _before_ clearing the
> DRIVER_OK bit in the status field.  Could this be a guest bug?
> 

I'm not sure if it is a bug or not. I think what happens is the device is left
enabled by Seabios, and then reset by kernel.

Fam
