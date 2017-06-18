Received: from eggs.gnu.org ([2001:4830:134:3::10]:57167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMXGn-0005rz-HP
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 06:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMXGk-0006g4-Be
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 06:17:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dMXGk-0006fS-2A
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 06:17:22 -0400
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<20170616175748-mutt-send-email-mst@kernel.org>
	<4cdf547c-079b-6b44-484f-e1132e960364@redhat.com>
	<20170616231036-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c852ce3a-2313-d2ea-b67e-7c0e26dc4c24@redhat.com>
Date: Sun, 18 Jun 2017 12:17:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170616231036-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] virtio-mem: paravirtualized memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>

>> A Linux guest will deflate the balloon (all or some pages) in the
>> following scenarios:
>> a) page migration
> 
> It inflates it first, doesn't it?

Yes, that that is true. I was just listing all scenarios.

> 
>> b) unload virtio-balloon kernel module
>> c) hibernate/suspension
>> d) (DEFLATE_ON_OOM)
> 
> You need to set a flag in the balloon to allow this, right?

Yes, has to be enabled in QEMU and will propagate to the guest. It is
used in various setups and you could either go for DEFLATE_ON_OOM
(cooperative memory manangement) or memory unplug, not both.

> 
>> A Linux guest will touch memory without deflating:
>> a) During a kexec() dump
>> d) On reboots (regular, after kexec(), system_reset)
>>>
>>>> Any change we
>>>>    introduce will break backwards compatibility.
>>>
>>> Why does this have to be the case
>> If we suddenly enforce the existing virtio-balloon, we will break legacy
>> guests.
> 
> Can't we do it with a feature flag?

I haven't found an easy way to do that, without turning all existing
virtio-balloon implementations useless. But honestly, whatever you do,
you will be confronted with the very basic problems of this approach:

Random memory holes on a reboot and the chance that the guest that comes up

a) contains a legacy virtio-balloon
b) contains no virtio-balloon at all
c) starts up virtio-balloon too late to fill the holes

Now, there are various possible approaches that require their own hacks
and only solve a subset of these problems. Just a very short version of
it all:

1) very early virtio-balloon that queries a bitmap of inflated memory
via some interface. This is just a giant hack (e.g. what about Windows?)
and even the bios might already touch inflated memory. Still breaks at
least b) and c). No good.

2) Do "implicit" balloon inflation on a reboot. Any page the guest
touches is marked as inflated. This requires a lot of quirks in the host
and still breaks at least b) and c). Basically no good for us.

Yo can read more about the involved problems at
https://blog.xenproject.org/2014/02/14/ballooning-rebooting-and-the-feature-youve-never-heard-of/

3) Try to mark inflated pages as reserved in the a820 bitmap and make
the balloon hotplug these. Well, this is x86 special and has some other
problems (e.g. what to do with ACPI hotplugged memory?). Also, how to
handle this on windows? Exploding size of the a820 map. No good.

4) Try to resize the guest main memory, to compensate unplugged memory.
While this sounds promising, there are elementary problems to solve: How
to deal with ACPI hotplugged memory? What to resize? And there has to be
ACPI hotplug, otherwise you cannot add more memory to a guest. While we
could solve some x86 specific problems here, migration on the QEMU side
will also be "fun". virtio-mem heavily simplifies that all by only
working on its own memory.

But again, these are all hacks, and at least I don't want to create a
giant hack and call it virtio-*, that is restricted to some very
specific use cases and/or architectures. Let's just do it in a clean way
if possible.

[...]

> I agree there's a large # of requirements here not addressed by the
> balloon.

Exactly, and it tries to solve the basic problem of rebooting into a
guest that does not contain a fitting guest driver.

>
> One other thing that would be helpful here is pointing out the
> similarities between virtio-mem and the balloon. I'll ponder it
> over the weekend.

There is much more difference here than similarity. The only thing they
share is allocating/freeing memory and tell the host about it. But
already how/from where memory is allocated is different. I think even
the general use case is different. Again, I think both concepts make
sense to coexist.

> 
> The biggest worry for me is inability to support DMA into this memory.
> Is this hard to fix?

As a short term solution: Always give your (x86) guest at least 3.x G of
base memory. And I mean that is the exact same thing you have with
ordinary ACPI based memory hotplug right now. That will also never
become DMA memory. So it is not worse compared to what we have right now.

Long term solution: I think this was never a use case. Usually, all
memory you "add", you theoretically want to be able to "remove" again.
So from that point, it does not make sense to mark it as DMA and feed it
to some driver that will not let go of it. I haven't had a deep look at
it, but I at least think it could be done with some effort. Not sure
about Windows.

Thanks!

-- 

Thanks,

David
