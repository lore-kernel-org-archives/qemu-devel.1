Received: from eggs.gnu.org ([2001:4830:134:3::10]:54227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eijsI-0006Ea-KM
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eijsE-00081q-Kj
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:44:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:28407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1eijsE-0007yF-Bi
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:44:06 -0500
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Message-ID: <ff3a2289-2b54-2f55-0f9c-f504282376da@intel.com>
Date: Tue, 6 Feb 2018 00:44:03 +0800
MIME-Version: 1.0
In-Reply-To: <502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>



On 2/6/2018 12:19 AM, Paolo Bonzini wrote:
> On 05/02/2018 17:12, Tan, Jianfeng wrote:
>> Hi Paolo,
>>
>> On 2/5/2018 11:53 PM, Paolo Bonzini wrote:
>>> On 05/02/2018 15:58, Jianfeng Tan wrote:
>>>> Here are some options to fix this:
>>>>
>>>> 1. When we do ram name comparison, we truncate the prefix as this
>>>> patch shows.
>>>> It cannot cover the corner case: the source VM could have two ram blocks
>>>> with name of "pc.ram" and "/object/pc.ram".
>>> That shouldn't happen ("pc.ram" exists even in the "-numa
>>> node,memdev=..." case, but it has no RAM block).
>> Suppose we have a VM started with "-m xG", and then hot plugged with a
>> ram block:
>>    (qemu) object_add
>> memory-backend-file,id=pc.ram,size=1G,mem-path=/dev/hugepages
>>    (qemu) device_add pc-dimm,id=pc.ram,memdev=pc.ram
>>
>> Then we would have both ram block named pc.ram:
>>                Block Name    PSize
>>                        pc.ram     4 KiB
>>        /objects/pc.ram    2 MiB
>>
>> But I assume it's a corner case which not really happen.
> Yeah, you're right. :/  I hadn't thought of hotplug.  It can happen indeed.
>
>>> However, note that
>>>
>>>     -m xG -numa node,memdev=pc.ram \
>>>     -object memory-backend-file,id=pc.ram,...
>>>
>>> works for both vhost-kernel and vhost-user, so I'd rather consider this
>>> a configuration problem and not do anything.
>> That configuration indeed works for both. But in the production env,
>> lots of VMs are already started with previous mem config. If we do
>> nothing, it will take a long time (shutdown/start for each VM) to
>> migrate to the new setup. This patch is to make this process more smooth
>> without any bad effect if possible.
> I understand.  However it's not as bad as "there's no possibility at all
> to migrate from vhost-kernel to vhost-user".  There are cases that are
> more problematic: for example, there's no possibility at all to add
> memory NUMA policy during a live migration, unless -object
> memory-backend-* was used on the source.

Please help me to understand: Are you saying it's always recommended to 
use -object memory-backend-* configuration even with vhost-kernel 
backend for the reason you mentioned? Or just another more serious 
problem that we shall work on in priority?

Thanks,
Jianfeng
