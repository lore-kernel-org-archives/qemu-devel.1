Received: from eggs.gnu.org ([2001:4830:134:3::10]:48265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g0U3E-000427-KT
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 12:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g0U3B-0001Jw-0Z
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 12:01:04 -0400
Date: Thu, 13 Sep 2018 10:00:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180913100043.3a9fa0e3@t450s.home>
In-Reply-To: <bcae773c-195d-32ff-da1e-23629ed65c06@redhat.com>
References: <20180910145616.8598-1-famz@redhat.com>
	<20180910145616.8598-3-famz@redhat.com>
	<9f4907a3-e96e-131c-a032-1669d0c09bc8@redhat.com>
	<20180911141245.GQ19292@lemon.usersys.redhat.com>
	<271b24b6-c8eb-1425-3e73-e0ec734bafc6@redhat.com>
	<20180912013134.GA2526@lemon.usersys.redhat.com>
	<3266e1a2-d4af-e8b3-1239-21778396718e@redhat.com>
	<20180912115020.GH2526@lemon.usersys.redhat.com>
	<ea9cb5ce-823b-a40f-701e-bce6d4cb2eeb@redhat.com>
	<20180913060351.GK2526@lemon.usersys.redhat.com>
	<44c472ba-a9ff-7c64-6406-f528a7e0f463@redhat.com>
	<bcae773c-195d-32ff-da1e-23629ed65c06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] virtio-scsi/virtio-blk:
 Disable poll handlers when stopping vq handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 13 Sep 2018 12:04:34 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 13/09/2018 11:11, Paolo Bonzini wrote:
> > On 13/09/2018 08:03, Fam Zheng wrote:  
> >> On Wed, 09/12 14:42, Paolo Bonzini wrote:  
> >>> On 12/09/2018 13:50, Fam Zheng wrote:  
> >>>>> I think it's okay if it is invoked.  The sequence is first you stop the
> >>>>> vq, then you drain the BlockBackends, then you switch AioContext.  All
> >>>>> that matters is the outcome when virtio_scsi_dataplane_stop returns.  
> >>>> Yes, but together with vIOMMU, it also effectively leads to a virtio_error(),
> >>>> which is not clean. QEMU stderr when this call happens (with patch 1 but not
> >>>> this patch):
> >>>>
> >>>> 2018-09-12T11:48:10.193023Z qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=02:00:00, iova=0x0)
> >>>> 2018-09-12T11:48:10.193044Z qemu-system-x86_64: New fault is not recorded due to compression of faults
> >>>> 2018-09-12T11:48:10.193061Z qemu-system-x86_64: virtio: zero sized buffers are not allowed  
> >>>
> >>> But with iothread, virtio_scsi_dataplane_stop runs in another thread
> >>> than the iothread; in that case you still have a race where the iothread
> >>> can process the vq before aio_disable_external and print the error.
> >>>
> >>> IIUC the guest has cleared the IOMMU page tables _before_ clearing the
> >>> DRIVER_OK bit in the status field.  Could this be a guest bug?  
> >>
> >> I'm not sure if it is a bug or not. I think what happens is the device is left
> >> enabled by Seabios, and then reset by kernel.  
> > 
> > That makes sense, though I'm not sure why QEMU needs to process a
> > request long after SeaBIOS has left control to Linux.  Maybe it's just
> > that the messages should not go on QEMU stderr, and rather trace-point
> > should be enough.  
> 
> Aha, it's not that QEMU needs to poll, it's just that polling mode is
> enabled, and it decides to do one last iteration.  In general the virtio
> spec allows the hardware to poll whenever it wants, hence:
> 
> 1) I'm not sure that translation failures should mark the device as
> broken---definitely not when doing polling, possibly not even in
> response to the guest "kicking" the virtqueue.  Alex, does the PCI spec
> say anything about this?

AFAIK the PCI spec doesn't define anything about the IOMMU or response
to translation failures.  Depending on whether it's a read or write,
the device might see an unsupported request or not even be aware of the
error.  It's really a platform RAS question whether to have any more
significant response, most don't, but at least one tends to consider
IOMMU faults to be a data integrity issue worth bring the system down.
We've struggled with handling ongoing DMA generating IOMMU faults
during kexec for a long time, so any sort of marking a device broken
for a fault should be thoroughly considered, especially when a device
could be assigned to a user who can trivially trigger a fault.
 
> 2) translation faliures should definitely not print messages to stderr.

Yep, easy DoS vector for a malicious guest, or malicious userspace
driver within the guest.  Thanks,

Alex
