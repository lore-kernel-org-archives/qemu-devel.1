Received: from eggs.gnu.org ([2001:4830:134:3::10]:52341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1db7Uv-0001jv-V5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1db7Us-0001uS-DF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:48:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1db7Us-0001tC-3q
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:48:14 -0400
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<0a7cd2a8-45ff-11d1-ddb5-036ce36af163@redhat.com>
	<CAPcyv4iYdEAv7wqun5L1C-gT7fMDpO+M918or-bg5XiWLnM3=w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d5a1f1d2-f7c8-cacc-3267-ed6f7d2507ca@redhat.com>
Date: Fri, 28 Jul 2017 17:48:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iYdEAv7wqun5L1C-gT7fMDpO+M918or-bg5XiWLnM3=w@mail.gmail.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: KVM <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Rik van Riel <riel@redhat.com>

On 28.07.2017 17:16, Dan Williams wrote:
> On Fri, Jul 28, 2017 at 4:09 AM, David Hildenbrand <david@redhat.com> wrote:
>> Btw, I am thinking about the following addition to the concept:
>>
>> 1. Add a type to each virtio-mem device.
>>
>> This describes the type of the memory region we expose to the guest.
>> Initially, we could have RAM and RAM_HUGE. The latter one would be
>> interesting, because the guest would know that this memory is based on
>> huge pages in case we would ever want to expose different RAM types to a
>> guest (the guest could conclude that this memory might be faster and
>> would also best be used with huge pages in the guest). But we could also
>> simply start only with RAM.
> 
> I think it's up to the hypervisor to manage whether the guest is
> getting huge pages or not and the guest need not know. As for
> communicating differentiated memory media performance we have the ACPI
> HMAT (Heterogeneous Memory Attributes Table) for that.

Yes, in the world of ACPI I agree.

> 
>> 2. Adding also a guest -> host command queue.
>>
>> That can be used to request/notify the host about something. As written
>> in the original proposal, for ordinary RAM this could be used to request
>> more/less memory out of the guest.
> 
> I would hope that where possible we minimize paravirtualized
> interfaces and just use standardized interfaces. In the case of memory
> hotplug, ACPI already defines that interface.

I partly agree in the world of ACPI. If you just want to add/remove
memory in the form of DIMMs, yes. This already works just fine. For
other approaches in the context of virtualization (e.g. ballooners that
XEN or Hyper-V use, or also what virtio-mem tries to achieve), this is
not enough. They need a different way of memory hotplug (as e.g. XEN and
Hyper-V already have).

Especially when trying to standardize stuff in form of virtio - binding
it to a technology specific to a handful of architectures is not
desired. Until now (as far as I remember), all but 2 virtio types
(virtio-balloon and virtio-iommu) operate on their own system resources
only, not on some resources exposed/detected via different interfaces.

> 
>> This might come in handy for other memory regions we just want to expose
>> to the guest via a paravirtualized interface. The resize features
>> (adding/removing memory) might not apply to these, but we can simply
>> restrict that to certain types.
>>
>> E.g. if we want to expose PMEM memory region to a guest using a
>> paravirtualized interface (or anything else that can be mapped into
>> guest memory in the form of memory regions), we could use this. The
>> guest->host control queue can be used for tasks that typically cannot be
>> done if moddeling something like this using ordinary ACPI DIMMs
>> (flushing etc).
>>
>> CCing a couple of people that just thought about something like this in
>> the concept of fake DAX.
> 
> I'm not convinced that there is a use case for paravirtualized PMEM
> commands beyond this "fake-DAX" use case. Everything would seem to
> have a path through the standard ACPI platform communication
> mechanisms.

I don't know about further commands, most likely not really many more in
this scenario. I just pinged you guys to have a look when I heard the
term virtio-pmem.

In general, a paravirtualized interface (for detection of PMEM regions)
might have one big advantage: not limited to certain architectures.

With a paravirtualized interface, we can even support* fake DAX on
architectures that don't provide a "real HW" interface for it. I think
this sounds interesting.

*quite some effort will most likely be necessary for other architectures.

-- 

Thanks,

David
