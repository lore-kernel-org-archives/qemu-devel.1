Received: from eggs.gnu.org ([2001:4830:134:3::10]:48068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ecE8n-0006QG-Nc
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ecE8m-0001ub-PK
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:38:17 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1ecE8m-0001tL-JA
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:38:16 -0500
Received: by mail-ot0-x242.google.com with SMTP id x4so5140984otg.7
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 09:38:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f1ca60cc-5506-a161-b473-f0de363b7e95@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<86754966-281f-c3ed-938c-f009440de563@gmail.com>
	<CAPcyv4iH==cqVAdd8i1y-8A6SuXU75OH1EZzgNMvtA21wfxPpQ@mail.gmail.com>
	<ec5ff7c2-864e-5020-0aaa-6663e78e3756@gmail.com>
	<1511288389.1080.14.camel@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
	<336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
	<f1ca60cc-5506-a161-b473-f0de363b7e95@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Jan 2018 09:38:13 -0800
Message-ID: <CAPcyv4j9b6ARvKcJkE25eNHatWACscMJTN_kCLSM6D+bfu_msA@mail.gmail.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On Thu, Jan 18, 2018 at 8:53 AM, David Hildenbrand <david@redhat.com> wrote:
> On 24.11.2017 13:40, Pankaj Gupta wrote:
>>
>> Hello,
>>
>> Thank you all for all the useful suggestions.
>> I want to summarize the discussions so far in the
>> thread. Please see below:
>>
>>>>>
>>>>>> We can go with the "best" interface for what
>>>>>> could be a relatively slow flush (fsync on a
>>>>>> file on ssd/disk on the host), which requires
>>>>>> that the flushing task wait on completion
>>>>>> asynchronously.
>>>>>
>>>>>
>>>>> I'd like to clarify the interface of "wait on completion
>>>>> asynchronously" and KVM async page fault a bit more.
>>>>>
>>>>> Current design of async-page-fault only works on RAM rather
>>>>> than MMIO, i.e, if the page fault caused by accessing the
>>>>> device memory of a emulated device, it needs to go to
>>>>> userspace (QEMU) which emulates the operation in vCPU's
>>>>> thread.
>>>>>
>>>>> As i mentioned before the memory region used for vNVDIMM
>>>>> flush interface should be MMIO and consider its support
>>>>> on other hypervisors, so we do better push this async
>>>>> mechanism into the flush interface design itself rather
>>>>> than depends on kvm async-page-fault.
>>>>
>>>> I would expect this interface to be virtio-ring based to queue flush
>>>> requests asynchronously to the host.
>>>
>>> Could we reuse the virtio-blk device, only with a different device id?
>>
>> As per previous discussions, there were suggestions on main two parts of the project:
>>
>> 1] Expose vNVDIMM memory range to KVM guest.
>>
>>    - Add flag in ACPI NFIT table for this new memory type. Do we need NVDIMM spec
>>      changes for this?
>>
>>    - Guest should be able to add this memory in system memory map. Name of the added memory in
>>      '/proc/iomem' should be different(shared memory?) than persistent memory as it
>>      does not satisfy exact definition of persistent memory (requires an explicit flush).
>>
>>    - Guest should not allow 'device-dax' and other fancy features which are not
>>      virtualization friendly.
>>
>> 2] Flushing interface to persist guest changes.
>>
>>    - As per suggestion by ChristophH (CCed), we explored options other then virtio like MMIO etc.
>>      Looks like most of these options are not use-case friendly. As we want to do fsync on a
>>      file on ssd/disk on the host and we cannot make guest vCPU's wait for that time.
>>
>>    - Though adding new driver(virtio-pmem) looks like repeated work and not needed so we can
>>      go with the existing pmem driver and add flush specific to this new memory type.
>
> I'd like to emphasize again, that I would prefer a virtio-pmem only
> solution.
>
> There are architectures out there (e.g. s390x) that don't support
> NVDIMMs - there is no HW interface to expose any such stuff.
>
> However, with virtio-pmem, we could make it work also on architectures
> not having ACPI and friends.

ACPI and virtio-only can share the same pmem driver. There are two
parts to this, region discovery and setting up the pmem driver. For
discovery you can either have an NFIT-bus defined range, or a new
virtio-pmem-bus define it. As far as the pmem driver itself it's
agnostic to how the range is discovered.

In other words, pmem consumes 'regions' from libnvdimm and the a bus
provider like nfit, e820, or a new virtio-mechansim produce 'regions'.
