Received: from eggs.gnu.org ([2001:4830:134:3::10]:60532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ecGAr-0003g3-2r
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ecGAq-0007hi-5l
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:48:33 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:40471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1ecGAp-0007hV-Tj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:48:32 -0500
Received: by mail-oi0-x231.google.com with SMTP id a184so1642223oif.7
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 11:48:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386805697.1758284.1516304161333.JavaMail.zimbra@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
	<336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
	<f1ca60cc-5506-a161-b473-f0de363b7e95@redhat.com>
	<CAPcyv4j9b6ARvKcJkE25eNHatWACscMJTN_kCLSM6D+bfu_msA@mail.gmail.com>
	<72839100-7fdf-693c-e9c2-348a5add8a56@redhat.com>
	<1419599412.1747020.1516301689815.JavaMail.zimbra@redhat.com>
	<CAPcyv4hso5FYCyxYBHRhHvsU+M_wrkQBwVKurK-i6BQYzQduPw@mail.gmail.com>
	<1386805697.1758284.1516304161333.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Jan 2018 11:48:30 -0800
Message-ID: <CAPcyv4gO37neHvo_TktaNQHj9YK3dmpWJpDQ2iTDr_xv99y8jg@mail.gmail.com>
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
To: Pankaj Gupta <pagupta@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>, Rik van Riel <riel@surriel.com>

On Thu, Jan 18, 2018 at 11:36 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
>
>>
>> On Thu, Jan 18, 2018 at 10:54 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
>> >
>> >>
>> >> >> I'd like to emphasize again, that I would prefer a virtio-pmem only
>> >> >> solution.
>> >> >>
>> >> >> There are architectures out there (e.g. s390x) that don't support
>> >> >> NVDIMMs - there is no HW interface to expose any such stuff.
>> >> >>
>> >> >> However, with virtio-pmem, we could make it work also on architectures
>> >> >> not having ACPI and friends.
>> >> >
>> >> > ACPI and virtio-only can share the same pmem driver. There are two
>> >> > parts to this, region discovery and setting up the pmem driver. For
>> >> > discovery you can either have an NFIT-bus defined range, or a new
>> >> > virtio-pmem-bus define it. As far as the pmem driver itself it's
>> >> > agnostic to how the range is discovered.
>> >> >
>> >>
>> >> And in addition to discovery + setup, we need the flush via virtio.
>> >>
>> >> > In other words, pmem consumes 'regions' from libnvdimm and the a bus
>> >> > provider like nfit, e820, or a new virtio-mechansim produce 'regions'.
>> >> >
>> >>
>> >> That sounds good to me. I would like to see how the ACPI discovery
>> >> variant connects to a virtio ring.
>> >>
>> >> The natural way for me would be:
>> >>
>> >> A virtio-X device supplies a memory region ("discovery") and also the
>> >> interface for flushes for this device. So one virtio-X corresponds to
>> >> one pmem device. No ACPI to be involved (also not on architectures that
>> >> have ACPI)
>> >
>> > I agree here if we discover regions with virtio-X we don't need to worry
>> > about
>> > NFIT ACPI. Actually, there are three ways to do it with pros and cons of
>> > these
>> > approaches:
>> >
>> > 1] Existing pmem driver & virtio for region discovery:
>> >   -----------------------------------------------------
>> >   Use existing pmem driver which is tightly coupled with concepts of
>> >   namespaces, labels etc
>> >   from ACPI region discovery and re-implement these concepts with virtio so
>> >   that existing
>> >   pmem driver can understand it. In addition to this, task of pmem driver
>> >   to send flush command
>> >   using virtio.
>>
>> It's not tightly coupled. The whole point of libnvdimm is to be
>> agnostic to ACPI, e820 or any other range discovery. The only work to
>> do beyond identifying the address range is teaching libnvdimm to pass
>> along a flush control interface to the pmem driver.
>
> o.k that means we can configure libnvdimm with virtio as well and use existing pmem
> driver. AFAICU it uses nvdimm bus?
>
> Do we need other features which ACPI provides?

No, to keep it simple use nvdimm_pmem_region_create without
registering any DIMM devices. I'd start with the e820 driver as a bus
driver reference (drivers/nvdimm/e820.c) rather than try to unwind the
complexity of the nfit driver.
