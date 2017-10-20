Received: from eggs.gnu.org ([2001:4830:134:3::10]:41400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5XiN-0006Ta-DD
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e5XiJ-00028d-GP
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e5XiJ-00026l-7Y
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:51:51 -0400
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
	<87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
	<0aab6dae-a926-c106-9bc5-68561a9bef5c@redhat.com>
	<0dae2b6c-9164-efc7-5c67-0e4aa5eb4a21@de.ibm.com>
	<fcf03f16-389e-83b5-77bf-d7a50151005c@redhat.com>
	<2bfd5f45-3db1-b6c7-3162-43be564cfa05@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fb0b2486-706c-c7af-0e38-ddea1faa7b92@redhat.com>
Date: Fri, 20 Oct 2017 15:51:42 +0200
MIME-Version: 1.0
In-Reply-To: <2bfd5f45-3db1-b6c7-3162-43be564cfa05@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 20.10.2017 15:49, Christian Borntraeger wrote:
> 
> 
> On 10/20/2017 03:43 PM, David Hildenbrand wrote:
>> On 20.10.2017 15:36, Christian Borntraeger wrote:
>>>
>>>
>>> On 10/20/2017 03:16 PM, David Hildenbrand wrote:
>>>>
>>>>> Hi all,
>>>>>
>>>>> we recently encountered the problem that the 'host-model' [1] has to be
>>>>> related to the machine type of a domain. We have following problem:
>>>>>
>>>>>    Let's assume we've a z13 system with a QEMU 2.9 and we define a
>>>>>    domain using the default s390-virtio-ccw machine together with the
>>>>>    host-model CPU mode [1]. The definition will have the machine
>>>>>    expanded to s390-virtio-ccw-2.9 but retain the host-model CPU mode
>>>>>    in the domain definition. In a next step we upgrade to QEMU 2.10
>>>>>    (first version to recognize z14). Everything is still fine, even
>>>>>    though the machine runs in 2.9 compatibility mode. Finally we
>>>>>    upgrade to a z14. As a consequence it is not possible to start the
>>>>>    domain anymore as the machine type doesn't support our CPU host
>>>>>    model (which is expanded at start time of the domain).
>>>>
>>>> Actually, what is the cause of that problem? I assume it is the gs
>>>> feature (gs_allowed)?
>>>>
>>>> We should really avoid such things (..._allowed) for CPU model features
>>>> in the future and clue all new such stuff to cpumodel_allowed.
>>>
>>> Yes, starting a guest with
>>>    <os>
>>>     <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
>>>   </os>
>>>   <cpu mode='host-model'/>
>>>
>>> results in
>>>
>>> qemu-system-s390x: Some features requested in the CPU model are not available in the configuration: gs 
>>>
>>> Tying it to cpumodel_allowed would not help, migration-wise though.
>>> libvirt would still transform
>>>
>>>    <os>
>>>     <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
>>>   </os>
>>>   <cpu mode='host-model'/>
>>
>> My point was, that the host model would have to be copied and _remain_
>> there when s390-ccw-virtio was expanded to s390-ccw-virtio-2.9.
>>
>> So really replacing <cpu mode='host-model'/> by the model z13-base....
>> This would at least fix this issue. Just like s390-ccw-virtio get's
>> replaced and remains thats way.
>>
>> But this might for sure have other problems.
> 
> The problem goes much further.
> A fresh guest with
> 
>     <os>
>      <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
>    </os>
>    <cpu mode='host-model'/>
> 
> does not start. No migration from an older system is necessary.
> 

Yes, as stated in the documentation "copying host CPU definition from
capabilities XML" this can not work. And it works just as documented.
Not saying this is a nice thing :)

I think we should try to fix gs_allowed (if possible) and avoid
something like that in the future. This would avoid other complexity
involved when suddenly having X host models.

-- 

Thanks,

David
