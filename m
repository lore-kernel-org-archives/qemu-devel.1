Received: from eggs.gnu.org ([2001:4830:134:3::10]:53544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e9uoM-0001AJ-Cd
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1e9uoL-0001Mi-Et
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:20:10 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:53260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1e9uoL-0001K3-8I
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:20:09 -0400
Received: by mail-oi0-x242.google.com with SMTP id h6so4939464oia.10
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 08:20:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ca6aaa77-cca0-441e-be49-73133d8581cf@gmail.com>
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
	<ca6aaa77-cca0-441e-be49-73133d8581cf@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Nov 2017 08:20:06 -0700
Message-ID: <CAPcyv4gKzvd39WbnKjbs3Bn9+o1tt=vz90CYMFu0DF5PsfHUig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

> On 11/01/2017 12:25 PM, Dan Williams wrote:
[..]
>> It's not persistent memory if it requires a hypercall to make it
>> persistent. Unless memory writes can be made durable purely with cpu
>> instructions it's dangerous for it to be treated as a PMEM range.
>> Consider a guest that tried to map it with device-dax which has no
>> facility to route requests to a special flushing interface.
>>
>
> Can we separate the concept of flush interface from persistent memory?
> Say there are two APIs, one is used to indicate the memory type (i.e,
> /proc/iomem) and another one indicates the flush interface.
>
> So for existing nvdimm hardwares:
> 1: Persist-memory + CLFLUSH
> 2: Persiste-memory + flush-hint-table (I know Intel does not use it)
>
> and for the virtual nvdimm which backended on normal storage:
> Persist-memory + virtual flush interface

I see the flush interface as fundamental to identifying the media
properties. It's not byte-addressable persistent memory if the
application needs to call a sideband interface to manage writes. This
is why we have pushed for something like the MAP_SYNC interface to
make filesystem-dax actually behave in a way that applications can
safely treat it as persistent memory, and this is also the guarantee
that device-dax provides. Changing the flush interface makes it
distinct and unusable for applications that want to manage data
persistence in userspace.

>>>
>>>> In what way is this "more complicated"? It was trivial to add support
>>>> for the "volatile" NFIT range, this will not be any more complicated
>>>> than that.
>>>>
>>>
>>> Introducing memory type is easy indeed, however, a new flush interface
>>> definition is inevitable, i.e, we need a standard way to discover the
>>> MMIOs to communicate with host.
>>
>>
>> Right, the proposed way to do that for x86 platforms is a new SPA
>> Range GUID type. in the NFIT.
>>
>
> So this SPA is used for both persistent memory region and flush interface?
> Maybe i missed it in previous mails, could you please detail how to do
> it?

Yes, the GUID will specifically identify this range as "Virtio Shared
Memory" (or whatever name survives after a bikeshed debate). The
libnvdimm core then needs to grow a new region type that mostly
behaves the same as a "pmem" region, but drivers/nvdimm/pmem.c grows a
new flush interface to perform the host communication. Device-dax
would be disallowed from attaching to this region type, or we could
grow a new device-dax type that does not allow the raw device to be
mapped, but allows a filesystem mounted on top to manage the flush
interface.

> BTW, please note hypercall is not acceptable for standard, MMIO/PIO regions
> are. (Oh, yes, it depends on Paolo. :))

MMIO/PIO regions works for me, that's not the part of the proposal I'm
concerned about.
