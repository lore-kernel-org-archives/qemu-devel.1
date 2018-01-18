Received: from eggs.gnu.org ([2001:4830:134:3::10]:43124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ecFCE-0002N0-IJ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ecFCD-00051p-Jn
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:45:54 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:43390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1ecFCD-00051S-EK
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:45:53 -0500
Received: by mail-ot0-x22e.google.com with SMTP id p36so12935666otd.10
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:45:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <72839100-7fdf-693c-e9c2-348a5add8a56@redhat.com>
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
	<CAPcyv4j9b6ARvKcJkE25eNHatWACscMJTN_kCLSM6D+bfu_msA@mail.gmail.com>
	<72839100-7fdf-693c-e9c2-348a5add8a56@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Jan 2018 10:45:51 -0800
Message-ID: <CAPcyv4iHvXJAiUiaBFPFc98+3BepR1+YeVOqH3imq4Zq2d+iAw@mail.gmail.com>
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

On Thu, Jan 18, 2018 at 9:48 AM, David Hildenbrand <david@redhat.com> wrote:
>>> I'd like to emphasize again, that I would prefer a virtio-pmem only
>>> solution.
>>>
>>> There are architectures out there (e.g. s390x) that don't support
>>> NVDIMMs - there is no HW interface to expose any such stuff.
>>>
>>> However, with virtio-pmem, we could make it work also on architectures
>>> not having ACPI and friends.
>>
>> ACPI and virtio-only can share the same pmem driver. There are two
>> parts to this, region discovery and setting up the pmem driver. For
>> discovery you can either have an NFIT-bus defined range, or a new
>> virtio-pmem-bus define it. As far as the pmem driver itself it's
>> agnostic to how the range is discovered.
>>
>
> And in addition to discovery + setup, we need the flush via virtio.
>
>> In other words, pmem consumes 'regions' from libnvdimm and the a bus
>> provider like nfit, e820, or a new virtio-mechansim produce 'regions'.
>>
>
> That sounds good to me. I would like to see how the ACPI discovery
> variant connects to a virtio ring.
>
> The natural way for me would be:
>
> A virtio-X device supplies a memory region ("discovery") and also the
> interface for flushes for this device. So one virtio-X corresponds to
> one pmem device. No ACPI to be involved (also not on architectures that
> have ACPI)

Hmm, yes, it seems if ACPI is just going to be used as a trigger for
"go find the virtio-X interface for this range" we could have started
from a virtio device in the first place.
