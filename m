Received: from eggs.gnu.org ([2001:4830:134:3::10]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fPk5J-0004Vj-40
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fPk5G-0006sB-1M
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:39:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:12944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fPk5F-0006rT-JY
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:39:17 -0400
Message-ID: <5B14ED85.6080005@intel.com>
Date: Mon, 04 Jun 2018 15:43:01 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-4-git-send-email-wei.w.wang@intel.com>
	<20180601040049.GG14867@xz-mi> <5B10F761.60509@intel.com>
	<20180601100617.GK14867@xz-mi> <5B113CDB.2090109@intel.com>
	<20180604024958.GA15534@xz-mi>
In-Reply-To: <20180604024958.GA15534@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 3/5] migration: API to clear bits of
 guest free pages from the dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On 06/04/2018 10:49 AM, Peter Xu wrote:
>
>>
>>
>>>>>> +
>>>>>> +    for (; len > 0; len -= used_len) {
>>>>>> +        block = qemu_ram_block_from_host(addr, false, &offset);
>>>>>> +        if (unlikely(!block)) {
>>>>>> +            return;
>>>>> We should never reach here, should we?  Assuming the callers of this
>>>>> function should always pass in a correct host address. If we are very
>>>>> sure that the host addr should be valid, could we just assert?
>>>> Probably not the case, because of the corner case that the memory would be
>>>> hot unplugged after the free page is reported to QEMU.
>>> Question: Do we allow to do hot plug/unplug for memory during
>>> migration?
>> I think so. From the code, I don't find where it forbids memory hotplug
>> during migration.
> I don't play with that much; do we need to do "device_add" after all?
>
>    (qemu) object_add memory-backend-file,id=mem1,size=1G,mem-path=/mnt/hugepages-1GB
>    (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
>
> If so, we may not allow that since in qdev_device_add() we don't allow
> that:
>
>      if (!migration_is_idle()) {
>          error_setg(errp, "device_add not allowed while migrating");
>          return NULL;
>      }
>

OK, I missed that part, and thanks for correcting it. I'll use an assert 
there if no objections from others.


Best,
Wei
