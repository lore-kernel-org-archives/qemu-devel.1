Received: from eggs.gnu.org ([2001:4830:134:3::10]:36911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gCrEZ-0003kW-MF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gCrEY-0004Yw-IT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1gCrEY-0004Ue-9T
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:11:54 -0400
Date: Wed, 17 Oct 2018 15:11:49 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <431127218.21694133.1539803509205.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4hroaVWA-HgjWCnr7QTd_y7U8sCvS+Up733ttnD6_cKzQ@mail.gmail.com>
References: <20181013050021.11962-1-pagupta@redhat.com>
	<20181013050021.11962-3-pagupta@redhat.com>
	<CAPcyv4hroaVWA-HgjWCnr7QTd_y7U8sCvS+Up733ttnD6_cKzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-pmem: Add virtio pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Jan Kara <jack@suse.cz>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, KVM list <kvm@vger.kernel.org>, Rik van Riel <riel@surriel.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, David Hildenbrand <david@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, Christoph Hellwig <hch@infradead.org>, Vishal L Verma <vishal.l.verma@intel.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, zwisler@kernel.org, lcapitulino@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>



> On Fri, Oct 12, 2018 at 10:01 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> >
> > This patch adds virtio-pmem driver for KVM guest.
> >
> > Guest reads the persistent memory range information from
> > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > creates a nd_region object with the persistent memory
> > range information so that existing 'nvdimm/pmem' driver
> > can reserve this into system memory map. This way
> > 'virtio-pmem' driver uses existing functionality of pmem
> > driver to register persistent memory compatible for DAX
> > capable filesystems.
> >
> > This also provides function to perform guest flush over
> > VIRTIO from 'pmem' driver when userspace performs flush
> > on DAX memory range.
> 
> Before we can move forward with this driver we need additional
> filesystem enabling to detect when the backing device is fronting DAX
> pmem or a paravirtualized page cache through virtio-pmem. Any
> interface that requires fsync() and a round trip to the hypervisor to
> flush host page cache is not DAX.

I saw your proposal[1] for new mmap flag MAP_DIRECT. IIUIC mapping should fail for 
MAP_DIRECT if it requires explicit flush or buffer indirection. So, if we disable 
MAP_SYNC flag for virtio-pmem this should fail MAP_DIRECT as well? Otherwise 
without MAP_DIRECT, virtio-pmem should be defaulted to VIRTIO flush mechanism.     

[1] https://marc.info/?l=linux-fsdevel&m=153953206330814&w=2

Thanks,
Pankaj
