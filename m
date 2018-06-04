Received: from eggs.gnu.org ([2001:4830:134:3::10]:60193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fPiUM-0006jM-G3
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 01:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fPiUI-0006q5-L0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 01:57:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fPiUI-0006pN-By
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 01:57:02 -0400
Date: Mon, 4 Jun 2018 01:56:55 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1227242806.39629768.1528091815515.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180601142410.5c986f13@redhat.com>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180601142410.5c986f13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/2] kvm "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, nilal@redhat.com, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org, david@redhat.com, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, hch@infradead.org, linux-mm@kvack.org, mst@redhat.com, stefanha@redhat.com, niteshnarayanlal@hotmail.com, marcel@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com


Hi Igor,

> 
> [...]
> > - Qemu virtio-pmem device
> >   It exposes a persistent memory range to KVM guest which
> >   at host side is file backed memory and works as persistent
> >   memory device. In addition to this it provides virtio
> >   device handling of flushing interface. KVM guest performs
> >   Qemu side asynchronous sync using this interface.
> a random high level question,
> Have you considered using a separate (from memory itself)
> virtio device as controller for exposing some memory, async flushing.
> And then just slaving pc-dimm devices to it with notification/ACPI
> code suppressed so that guest won't touch them?

No.

> 
> That way it might be more scale-able, you consume only 1 PCI slot
> for controller vs multiple for virtio-pmem devices.

That sounds like a good suggestion. I will note it as an
enhancement once we have other concerns related to basic working 
of 'flush' interface addressed. Then probably we can work on
things 'need to optimize' with robust core flush functionality. 

BTW any sample code doing this right now in Qemu? 

> 
> 
> > Changes from previous RFC[1]:
> > 
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
> >  drivers/nvdimm/region_devs.c     |    7 ++
> >  drivers/virtio/Kconfig           |   12 +++
> >  drivers/virtio/Makefile          |    1
> >  drivers/virtio/virtio_pmem.c     |  118
> >  +++++++++++++++++++++++++++++++++++++++
> >  include/linux/libnvdimm.h        |    4 +
> >  include/uapi/linux/virtio_ids.h  |    1
> >  include/uapi/linux/virtio_pmem.h |   58 +++++++++++++++++++
> >  7 files changed, 201 insertions(+)
> > 
> 
> 
> 
