Received: from eggs.gnu.org ([2001:4830:134:3::10]:46359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPmDP-0007FH-4i
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPmDK-0000u2-Lm
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:55:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fPmDK-0000rI-Ft
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:55:46 -0400
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180601142410.5c986f13@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a36137df-d2f6-39d5-318e-9006415b8ca2@redhat.com>
Date: Mon, 4 Jun 2018 11:55:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180601142410.5c986f13@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Igor Mammedov <imammedo@redhat.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org, kwolf@redhat.com, haozhong.zhang@intel.com, jack@suse.cz, xiaoguangrong.eric@gmail.com, riel@surriel.com, niteshnarayanlal@hotmail.com, ross.zwisler@intel.com, lcapitulino@redhat.com, hch@infradead.org, mst@redhat.com, stefanha@redhat.com, marcel@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, nilal@redhat.com

On 01.06.2018 14:24, Igor Mammedov wrote:
> On Wed, 25 Apr 2018 16:54:12 +0530
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> [...]
>> - Qemu virtio-pmem device
>>   It exposes a persistent memory range to KVM guest which 
>>   at host side is file backed memory and works as persistent 
>>   memory device. In addition to this it provides virtio 
>>   device handling of flushing interface. KVM guest performs
>>   Qemu side asynchronous sync using this interface.
> a random high level question,
> Have you considered using a separate (from memory itself)
> virtio device as controller for exposing some memory, async flushing.
> And then just slaving pc-dimm devices to it with notification/ACPI
> code suppressed so that guest won't touch them?

I don't think slaving pc-dimm would be the right thing to do (e.g.
slots, pcdimm vs nvdimm, bus(less), etc..). However the general idea is
interesting for virtio-pmem (as we might have a bigger number of disks).

We could have something like a virtio-pmem-bus to which you attach
virtio-pmem devices. By specifying the mapping, e.g. the thread that
will be used for async flushes will be implicit.

> 
> That way it might be more scale-able, you consume only 1 PCI slot
> for controller vs multiple for virtio-pmem devices.>
> 
>> Changes from previous RFC[1]:
>>
>> - Reuse existing 'pmem' code for registering persistent 
>>   memory and other operations instead of creating an entirely 
>>   new block driver.
>> - Use VIRTIO driver to register memory information with 
>>   nvdimm_bus and create region_type accordingly. 
>> - Call VIRTIO flush from existing pmem driver.
>>
>> Details of project idea for 'fake DAX' flushing interface is 
>> shared [2] & [3].
>>
>> Pankaj Gupta (2):
>>    Add virtio-pmem guest driver
>>    pmem: device flush over VIRTIO
>>
>> [1] https://marc.info/?l=linux-mm&m=150782346802290&w=2
>> [2] https://www.spinics.net/lists/kvm/msg149761.html
>> [3] https://www.spinics.net/lists/kvm/msg153095.html  
>>
>>  drivers/nvdimm/region_devs.c     |    7 ++
>>  drivers/virtio/Kconfig           |   12 +++
>>  drivers/virtio/Makefile          |    1 
>>  drivers/virtio/virtio_pmem.c     |  118 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/libnvdimm.h        |    4 +
>>  include/uapi/linux/virtio_ids.h  |    1 
>>  include/uapi/linux/virtio_pmem.h |   58 +++++++++++++++++++
>>  7 files changed, 201 insertions(+)
>>
> 


-- 

Thanks,

David / dhildenb
