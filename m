Received: from eggs.gnu.org ([2001:4830:134:3::10]:49169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1e9mml-0000MJ-6H
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1e9mmg-0000X5-Bd
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:45:59 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:52973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiaoguangrong.eric@gmail.com>)
	id 1e9mmg-0000Wx-44
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:45:54 -0400
Received: by mail-io0-x244.google.com with SMTP id f20so3985254ioj.9
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 23:45:53 -0700 (PDT)
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
	<CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
	<1501016375.26846.21.camel@redhat.com>
	<1063764405.34607875.1501076841865.JavaMail.zimbra@redhat.com>
	<1501104453.26846.45.camel@redhat.com>
	<CAPcyv4hsqrqBxoipUHPAbSctuzbVWCRnT-gN08i9uhXTWY6iPQ@mail.gmail.com>
	<1501112787.4073.49.camel@redhat.com>
	<CAPcyv4gbC6Hx_4YsCfOd2t=fn=wPGp5h__1QH=-p40TPFNbFzA@mail.gmail.com>
	<0a26793f-86f7-29e7-f61b-dc4c1ef08c8e@gmail.com>
	<CAPcyv4iw2cCpDmr+4kxsFvdy+iGZiz=ok-kLhsDKpqDy+szf-Q@mail.gmail.com>
	<378b10f3-b32f-84f5-2bbc-50c2ec5bcdd4@gmail.com>
	<CAPcyv4jR_LdbsX-rAsHC7++C6d-WYC084uWXzr+08PSYwoXFMw@mail.gmail.com>
From: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Message-ID: <ca6aaa77-cca0-441e-be49-73133d8581cf@gmail.com>
Date: Wed, 1 Nov 2017 14:46:11 +0800
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jR_LdbsX-rAsHC7++C6d-WYC084uWXzr+08PSYwoXFMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Rik van Riel <riel@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>



On 11/01/2017 12:25 PM, Dan Williams wrote:
> On Tue, Oct 31, 2017 at 8:43 PM, Xiao Guangrong
> <xiaoguangrong.eric@gmail.com> wrote:
>>
>>
>> On 10/31/2017 10:20 PM, Dan Williams wrote:
>>>
>>> On Tue, Oct 31, 2017 at 12:13 AM, Xiao Guangrong
>>> <xiaoguangrong.eric@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 07/27/2017 08:54 AM, Dan Williams wrote:
>>>>
>>>>>> At that point, would it make sense to expose these special
>>>>>> virtio-pmem areas to the guest in a slightly different way,
>>>>>> so the regions that need virtio flushing are not bound by
>>>>>> the regular driver, and the regular driver can continue to
>>>>>> work for memory regions that are backed by actual pmem in
>>>>>> the host?
>>>>>
>>>>>
>>>>>
>>>>> Hmm, yes that could be feasible especially if it uses the ACPI NFIT
>>>>> mechanism. It would basically involve defining a new SPA (System
>>>>> Phyiscal Address) range GUID type, and then teaching libnvdimm to
>>>>> treat that as a new pmem device type.
>>>>
>>>>
>>>>
>>>> I would prefer a new flush mechanism to a new memory type introduced
>>>> to NFIT, e.g, in that mechanism we can define request queues and
>>>> completion queues and any other features to make virtualization
>>>> friendly. That would be much simpler.
>>>>
>>>
>>> No that's more confusing because now we are overloading the definition
>>> of persistent memory. I want this memory type identified from the top
>>> of the stack so it can appear differently in /proc/iomem and also
>>> implement this alternate flush communication.
>>>
>>
>> For the characteristic of memory, I have no idea why VM should know this
>> difference. It can be completely transparent to VM, that means, VM
>> does not need to know where this virtual PMEM comes from (for a really
>> nvdimm backend or a normal storage). The only discrepancy is the flush
>> interface.
> 
> It's not persistent memory if it requires a hypercall to make it
> persistent. Unless memory writes can be made durable purely with cpu
> instructions it's dangerous for it to be treated as a PMEM range.
> Consider a guest that tried to map it with device-dax which has no
> facility to route requests to a special flushing interface.
> 

Can we separate the concept of flush interface from persistent memory?
Say there are two APIs, one is used to indicate the memory type (i.e,
/proc/iomem) and another one indicates the flush interface.

So for existing nvdimm hardwares:
1: Persist-memory + CLFLUSH
2: Persiste-memory + flush-hint-table (I know Intel does not use it)

and for the virtual nvdimm which backended on normal storage:
Persist-memory + virtual flush interface

>>
>>> In what way is this "more complicated"? It was trivial to add support
>>> for the "volatile" NFIT range, this will not be any more complicated
>>> than that.
>>>
>>
>> Introducing memory type is easy indeed, however, a new flush interface
>> definition is inevitable, i.e, we need a standard way to discover the
>> MMIOs to communicate with host.
> 
> Right, the proposed way to do that for x86 platforms is a new SPA
> Range GUID type. in the NFIT.
> 

So this SPA is used for both persistent memory region and flush interface?
Maybe i missed it in previous mails, could you please detail how to do
it?

BTW, please note hypercall is not acceptable for standard, MMIO/PIO regions
are. (Oh, yes, it depends on Paolo. :))
