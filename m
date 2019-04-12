Received: from eggs.gnu.org ([209.51.188.92]:57650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hEsTd-0006UN-EF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hEsTc-0002za-4A
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:28:05 -0400
References: <87va06kvm6.fsf@dusky.pond.sub.org>
	<59f100b4-f6e9-973d-532b-58fb172a7009@redhat.com>
	<87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
	<87bm1fiuo8.fsf@dusky.pond.sub.org>
	<20190409082852.GB6610@localhost.localdomain>
	<c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
	<87ef693tci.fsf@dusky.pond.sub.org>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <1c7373b5-f6c2-ec3c-b07d-c8eb73a355af@huawei.com>
Date: Fri, 12 Apr 2019 17:26:44 +0800
MIME-Version: 1.0
In-Reply-To: <87ef693tci.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU
	Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com, Laszlo Ersek <lersek@redhat.com>



On 2019/4/11 15:15, Markus Armbruster wrote:
>> For some historical reasons such as compatibility and extensibility[2], we
>> restrict both their size to 64MB -- both UEFI and qemu have cold hard
>> constants.
> These reasons aren't historical.  But they're valid, and that's all that
> matters :)
> 
>> This will consume a large amount of memory when running multiple VM
>> simultaneously (each guest needs 128MB).
> Understood.
> 
>> There are accepted ideas proposed by Markus and Laszlo from prior discussion[3]:
>>
>> 1) Getting flash memory size from a machine type or property.
>>
>> 2) Map the read-only part so it is shared among guests; Map the read-write
>> part normally.
>>
>> The first idea called explicit configuration which may break migration.
> For any configuration that can break migration, the solution is to have
> identical configuration on source and destination.
> 
>> For the second idea, the only way I can imagine is using a file mapping to
>> read or write pflash devices so that we can allocate memory on demand. So I
>> tried to fit mmap() actions into the block layer[4]. However I am not sure
>> that maping image file whether can work fine for block layer.
> It adds an odd special case to the block layer.  But then flash devices
> are an odd user of the block layer.
> 
> Normal users use the block layer as a *block* layer: to read and write
> blocks.
> 
> Our flash devices don't do that.  They are *memory* devices, not *block*
> devices.  Pretty much the only thing the two have in common is
> persistence of data.  The block layer provides persistence, and I figure
> that's why it got pressed into service here.
> 
> What the flash devices do is keep the complete image contents in memory,
> with changes written through to disk.
> 
> This is pretty much exactly what mmap() does, so using it suggests
> itself.
> 
> It's very much *not* what the block layer does.  mmap() is not even
> possible for anything but a file backend.
> 
> With mmap(), memory gets faulted in on demand, and sharing read-only
> memory with other VMs should be feasible.  The question is how to use it
> here.  Is there a sane way to use it without rewriting the flash devices
> not to use the block layer?

There are two important changes we may need to pay more attention to if we
use mmap():

1) Sync/Update flash content from guest memory to a file backend. With mmap()
we might not have to do the extra sync/update as the block layer do in
pflash_write().
2) Live migration.

> 
>> On the other hand, Laszlo had mentioned the features of QCOW2 and sparse
>> files which may be nice for pflash block backends. But I am not familiar with
>> it.
> Offhand, two QCOW2 features come to mind:
> 
> 1. Sparse storage even when the storage substrate can't do sparse.  I
> consider this one largely irrelevant.  Any decent file system can do
> sparse.  Archival and network transfer can compress instead.
> 
> 2. Snapshots to go with disk snapshots.  *Live* snapshots (the ones that
> include memory) already have the flash contents in the memory part, so
> this sems only relevant for "dead" snapshots.
> 
> Anything else?
> 

No more, thanks.:D

Kevin came up with a good idea which might solve my problem.
See https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg01865.html

-- 

Thanks,
Xiang
