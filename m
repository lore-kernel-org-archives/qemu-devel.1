Received: from eggs.gnu.org ([2001:4830:134:3::10]:59329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gCoKP-00086d-VT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gCoKG-0002n4-AF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:05:42 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gCoK9-0002S3-UA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:05:32 -0400
Date: Wed, 17 Oct 2018 19:05:21 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20181017160521.76yozcu7pka5fqqg@SPB-NB-133.local>
References: <20181016152712.qpvjter6w47azcri@SPB-NB-133.local>
	<20181017094740.GJ22755@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181017094740.GJ22755@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] modern virtio on HVF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Oct 17, 2018 at 10:47:40AM +0100, Stefan Hajnoczi wrote:
> On Tue, Oct 16, 2018 at 06:27:12PM +0300, Roman Bolshakov wrote:
> > 
> > It looks like virtio backend doesn't return 0 device status after
> > vp_iowrite8 and vp_reset blocks udev:
> >         while (vp_ioread8(&vp_dev->common->device_status))
> >                         msleep(1)
> > 
> > What could be the cause of the issue?
> > Any advices how to triage it are appreciated.
> 
> I wonder what happened in virtio_pci_probe() ->
> virtio_pci_modern_probe().  For example, were the BARs properly set up?
> 
> For starters you can debug the QEMU process to check if
> virtio_pci_common_read/write() get called for this device (disable all
> other virtio devices to make life easy).  If these functions aren't
> being called then the guest either got the address wrong or dispatch
> isn't working for some other reason (hvf?).
> 

Thank you Stefan. That explains why it doesn't quit:

virtio_pci_common_write: hwaddr 0x14 val 0x8 size 0x1
38552@1539791595.072718:virtio_set_status vdev 0x7f92d5ef4170 val 8
virtio_pci_common_read: hwaddr 0x14 val 0x8 size 0x1
virtio_pci_common_read: hwaddr 0x14 val 0x8 size 0x1
virtio_pci_common_read: hwaddr 0x14 val 0x8 size 0x1
virtio_pci_common_read: hwaddr 0x14 val 0x8 size 0x1
virtio_pci_common_read: hwaddr 0x14 val 0x8 size 0x1
virtio_pci_common_read: hwaddr 0x14 val 0x8 size 0x1


I executed QEMU a number of times, each time vpirtio_pci_common_write
writes different value but virtio_pci code clearly writes 0:
    /* 0 status means a reset. */
    vp_iowrite8(0, &vp_dev->common->device_status);

Maybe the value somehow got corrupted or it was taken from wrong location.

-Roman
