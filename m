Received: from eggs.gnu.org ([2001:4830:134:3::10]:59546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1ejatQ-0005sy-Gc
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1ejatM-0003Ev-Gy
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:20:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:27393)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1ejatM-0003EZ-8B
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:20:48 -0500
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
	<5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E36514317E8@SHSMSX103.ccr.corp.intel.com>
	<20180207130635.4033f8b8@redhat.com>
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Message-ID: <8474af94-7bff-a7b5-e316-b8a0e332467e@intel.com>
Date: Thu, 8 Feb 2018 09:20:45 +0800
MIME-Version: 1.0
In-Reply-To: <20180207130635.4033f8b8@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>



On 2/7/2018 8:06 PM, Igor Mammedov wrote:
> On Wed, 7 Feb 2018 07:49:58 +0000
> "Tan, Jianfeng" <jianfeng.tan@intel.com> wrote:
>
>>> -----Original Message-----
>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>> Sent: Tuesday, February 6, 2018 1:32 AM
>>> To: Igor Mammedov
>>> Cc: Tan, Jianfeng; qemu-devel@nongnu.org; Jason Wang; Maxime Coquelin;
>>> Michael S . Tsirkin
>>> Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as
>>> migration
>>>
>>> On 05/02/2018 18:15, Igor Mammedov wrote:
>>>>>> Then we would have both ram block named pc.ram:
>>>>>>                Block Name    PSize
>>>>>>                        pc.ram     4 KiB
>>>>>>        /objects/pc.ram    2 MiB
>>>>>>
>>>>>> But I assume it's a corner case which not really happen.
>>>>> Yeah, you're right. :/  I hadn't thought of hotplug.  It can happen indeed.
>>>> perhaps we should fail object_add memory-backend-foo if it resulted
>>>> in creating ramblock with duplicate id
>>> Note that it would only be duplicated with Jianfeng's patch.  So I'm
>>> worried that his patch is worse than what we have now, because it may
>>> create conflicts with system RAMBlock names are not necessarily
>>> predictable.  Right now, -object creates RAMBlock names that are nicely
>>> constrained within /object/.
>> So we are trading off between the benefit it takes and the bad effect it brings.
>>
>> I'm wondering if the above example is the only failed case this patch leads to, i.e, only there is a ram named "pc.ram" and "/object/pc.ram" in the src VM?
>>
>> Please also consider the second option, that adding an alias name for RAMBlock; I'm not a big fan for that one, as it just pushes the problem to OpenStack/Libvirt.
> looking at provided CLI examples it's configuration issue on src and dst,
> one shall not mix numa and non numa variants.

Aha, that's another thing we also want to change. We now add numa at dst 
node, only because without -numa, we cannot set up the file-baked memory 
with share=on.

For example, "-m xG -mem-path xxx" can set up a file-baked memory, but 
the file is not share-able.

>
>> Or any other suggestions?
> Fix configuration, namely dst side of it (i.e. use the same -m only variant
> without -numa as it's on src).
>
> BTW, what are you trying to achieve adding -numa on dst?

See above reply.

Thanks,
Jianfeng
