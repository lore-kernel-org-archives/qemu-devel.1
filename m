Received: from eggs.gnu.org ([2001:4830:134:3::10]:45626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fudHz-0001KW-Fb
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fudHt-0003XY-IR
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:40:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fudHt-0003Ft-8k
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:40:01 -0400
Date: Tue, 28 Aug 2018 08:39:53 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <16583366.7193885.1535459993521.JavaMail.zimbra@redhat.com>
In-Reply-To: <1328e543-0276-8f33-1744-8baa053023c4@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<1328e543-0276-8f33-1744-8baa053023c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 0/2] kvm "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, riel@surriel.com, niteshnarayanlal@hotmail.com, mst@redhat.com, ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com, hch@infradead.org, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com


Hi David,

> > for review. This patchset has two parts:
> > 
> > - Guest virtio-pmem driver
> >   Guest driver reads persistent memory range from paravirt device
> >   and registers with 'nvdimm_bus'. 'nvdimm/pmem' driver uses this
> >   information to allocate persistent memory range. Also, we have
> >   implemented guest side of VIRTIO flushing interface.
> > 
> > - Qemu virtio-pmem device
> >   It exposes a persistent memory range to KVM guest which at host
> >   side is file backed memory and works as persistent memory device.
> >   In addition to this it provides virtio device handling of flushing
> >   interface. KVM guest performs Qemu side asynchronous sync using
> >   this interface.
> > 
> > Changes from RFC v2:
> > - Add flush function in the nd_region in place of switching
> >   on a flag - Dan & Stefan
> > - Add flush completion function with proper locking and wait
> >   for host side flush completion - Stefan & Dan
> > - Keep userspace API in uapi header file - Stefan, MST
> > - Use LE fields & New device id - MST
> > - Indentation & spacing suggestions - MST & Eric
> > - Remove extra header files & add licensing - Stefan
> > 
> > Changes from RFC v1:
> > - Reuse existing 'pmem' code for registering persistent
> >   memory and other operations instead of creating an entirely
> >   new block driver.
> > - Use VIRTIO driver to register memory information with
> >   nvdimm_bus and create region_type accordingly.
> > - Call VIRTIO flush from existing pmem driver.
> > 
> > Details of project idea for 'fake DAX' flushing interface is
> > shared [2] & [3].
> > 
> > Pankaj Gupta (2):
> >    Add virtio-pmem guest driver
> >    pmem: device flush over VIRTIO
> > 
> > [1] https://marc.info/?l=linux-mm&m=150782346802290&w=2
> > [2] https://www.spinics.net/lists/kvm/msg149761.html
> > [3] https://www.spinics.net/lists/kvm/msg153095.html
> > 
> >  drivers/nvdimm/nd.h              |    1
> >  drivers/nvdimm/pmem.c            |    4
> >  drivers/nvdimm/region_devs.c     |   24 +++-
> >  drivers/virtio/Kconfig           |    9 +
> >  drivers/virtio/Makefile          |    1
> >  drivers/virtio/virtio_pmem.c     |  190
> >  +++++++++++++++++++++++++++++++++++++++
> >  include/linux/libnvdimm.h        |    5 -
> >  include/linux/virtio_pmem.h      |   44 +++++++++
> >  include/uapi/linux/virtio_ids.h  |    1
> >  include/uapi/linux/virtio_pmem.h |   40 ++++++++
> >  10 files changed, 310 insertions(+), 9 deletions(-)
> > 
> 
> Hi Pankaj,
> 
> do you have a branch for the QEMU part somewhere available? I want to
> see how this works with MemoryDevice changes.

o.k I will update the guest virtio-pmem and Qemu current changes
and share with you. BTW previous version is here:

https://marc.info/?l=kvm&m=153146839627143&w=2

Thanks,
Pankaj
 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
> 
