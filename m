Received: from eggs.gnu.org ([2001:4830:134:3::10]:35419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fucsN-0001jd-4h
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fucsK-0004bu-19
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:13:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fucsJ-0004bY-Qs
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:13:35 -0400
References: <20180713075232.9575-1-pagupta@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1328e543-0276-8f33-1744-8baa053023c4@redhat.com>
Date: Tue, 28 Aug 2018 14:13:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180713075232.9575-1-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Pankaj Gupta <pagupta@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com, niteshnarayanlal@hotmail.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com

On 13.07.2018 09:52, Pankaj Gupta wrote:
> This is RFC V3 for 'fake DAX' flushing interface sharing
> for review. This patchset has two parts:
> 
> - Guest virtio-pmem driver
>   Guest driver reads persistent memory range from paravirt device 
>   and registers with 'nvdimm_bus'. 'nvdimm/pmem' driver uses this 
>   information to allocate persistent memory range. Also, we have 
>   implemented guest side of VIRTIO flushing interface.
> 
> - Qemu virtio-pmem device
>   It exposes a persistent memory range to KVM guest which at host 
>   side is file backed memory and works as persistent memory device. 
>   In addition to this it provides virtio device handling of flushing 
>   interface. KVM guest performs Qemu side asynchronous sync using 
>   this interface.
> 
> Changes from RFC v2:
> - Add flush function in the nd_region in place of switching
>   on a flag - Dan & Stefan
> - Add flush completion function with proper locking and wait
>   for host side flush completion - Stefan & Dan
> - Keep userspace API in uapi header file - Stefan, MST
> - Use LE fields & New device id - MST
> - Indentation & spacing suggestions - MST & Eric
> - Remove extra header files & add licensing - Stefan
> 
> Changes from RFC v1:
> - Reuse existing 'pmem' code for registering persistent 
>   memory and other operations instead of creating an entirely 
>   new block driver.
> - Use VIRTIO driver to register memory information with 
>   nvdimm_bus and create region_type accordingly. 
> - Call VIRTIO flush from existing pmem driver.
> 
> Details of project idea for 'fake DAX' flushing interface is 
> shared [2] & [3].
> 
> Pankaj Gupta (2):
>    Add virtio-pmem guest driver
>    pmem: device flush over VIRTIO
> 
> [1] https://marc.info/?l=linux-mm&m=150782346802290&w=2
> [2] https://www.spinics.net/lists/kvm/msg149761.html
> [3] https://www.spinics.net/lists/kvm/msg153095.html  
> 
>  drivers/nvdimm/nd.h              |    1 
>  drivers/nvdimm/pmem.c            |    4 
>  drivers/nvdimm/region_devs.c     |   24 +++-
>  drivers/virtio/Kconfig           |    9 +
>  drivers/virtio/Makefile          |    1 
>  drivers/virtio/virtio_pmem.c     |  190 +++++++++++++++++++++++++++++++++++++++
>  include/linux/libnvdimm.h        |    5 -
>  include/linux/virtio_pmem.h      |   44 +++++++++
>  include/uapi/linux/virtio_ids.h  |    1 
>  include/uapi/linux/virtio_pmem.h |   40 ++++++++
>  10 files changed, 310 insertions(+), 9 deletions(-)
> 

Hi Pankaj,

do you have a branch for the QEMU part somewhere available? I want to
see how this works with MemoryDevice changes.

-- 

Thanks,

David / dhildenb
