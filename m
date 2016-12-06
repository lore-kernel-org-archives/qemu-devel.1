Received: from eggs.gnu.org ([2001:4830:134:3::10]:33293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cE59T-0006zs-97
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cE59O-0006A9-1I
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:06:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:63791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cE59N-00069Q-P0
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:06:33 -0500
From: "Lan, Tianyu" <tianyu.lan@intel.com>
References: <1480348315-13332-1-git-send-email-bd.aviv@gmail.com>
	<20161130092359.GC4731@pxdev.xzpeter.org>
	<b5d782cb-22f3-1000-8424-b5af67d78f5b@intel.com>
	<20161202060859.GD21601@pxdev.xzpeter.org>
	<20161202103034.34651a52@t450s.home>
Message-ID: <76fc55de-f214-68fc-4c43-a660f2d64441@intel.com>
Date: Tue, 6 Dec 2016 10:03:15 +0800
MIME-Version: 1.0
In-Reply-To: <20161202103034.34651a52@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 0/5] IOMMU: intel_iommu support map and
 unmap notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: "Aviv B.D" <bd.aviv@gmail.com>, Jason Wang <jasowang@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 12/3/2016 1:30 AM, Alex Williamson wrote:
> On Fri, 2 Dec 2016 14:08:59 +0800
> Peter Xu <peterx@redhat.com> wrote:
>
>> On Thu, Dec 01, 2016 at 04:27:52PM +0800, Lan Tianyu wrote:
>>> On 2016年11月30日 17:23, Peter Xu wrote:
>>>> On Mon, Nov 28, 2016 at 05:51:50PM +0200, Aviv B.D wrote:
>>>>> * intel_iommu's replay op is not implemented yet (May come in different patch
>>>>>   set).
>>>>>   The replay function is required for hotplug vfio device and to move devices
>>>>>   between existing domains.
>>>>
>>>> I am thinking about this replay thing recently and now I start to
>>>> doubt whether the whole vt-d vIOMMU framework suites this...
>>>>
>>>> Generally speaking, current work is throwing away the IOMMU "domain"
>>>> layer here. We maintain the mapping only per device, and we don't care
>>>> too much about which domain it belongs. This seems problematic.
>>>>
>>>> A simplest wrong case for this is (let's assume cache-mode is
>>>> enabled): if we have two assigned devices A and B, both belong to the
>>>> same domain 1. Meanwhile, in domain 1 assume we have one mapping which
>>>> is the first page (iova range 0-0xfff). Then, if guest wants to
>>>> invalidate the page, it'll notify VT-d vIOMMU with an invalidation
>>>> message. If we do this invalidation per-device, we'll need to UNMAP
>>>> the region twice - once for A, once for B (if we have more devices, we
>>>> will unmap more times), and we can never know we have done duplicated
>>>> work since we don't keep domain info, so we don't know they are using
>>>> the same address space. The first unmap will work, and then we'll
>>>> possibly get some errors on the rest of dma unmap failures.
>>>
>>>
>>> Hi Peter:
>>
>> Hi, Tianyu,
>>
>>> According VTD spec 6.2.2.1, "Software must ensure that, if multiple
>>> context-entries (or extended-context-entries) are programmed
>>> with the same Domain-id (DID), such entries must be programmed with same
>>> value for the secondlevel page-table pointer (SLPTPTR) field, and same
>>> value for the PASID Table Pointer (PASIDTPTR) field.".
>>>
>>> So if two assigned device may have different IO page table, they should
>>> be put into different domains.
>>
>>
>> By default, devices will be put into different domains. However it
>> should be legal that we put two assigned devices into the same IOMMU
>> domain (in the guest), right? And we should handle both cases well
>> IMHO.
>>
>> Actually I just wrote a tool to do it based on vfio-pci:
>>
>>   https://github.com/xzpeter/clibs/blob/master/gpl/userspace/vfio-bind-group/vfio-bind-group.c
>>
>> If we run this tool in the guest with parameter like:
>>
>>   ./vfio-bind-groups 00:03.0 00:04.0
>>
>> It'll create one single domain, and put PCI device 00:03.0, 00:04.0
>> into the same IOMMU domain.
>
> On the host though, I'd expect we still have separate IOMMU domains,
> one for each device and we do DMA_{UN}MAP ioctls separately per
> container.  Thanks,

Agree. Guest may use different IO page tables for multi assigned devices
and this requires to put assigned device in different VTD domain on
host. I think we can't put assigned devices into the same VTD domain
before enabling dynamic containers.
