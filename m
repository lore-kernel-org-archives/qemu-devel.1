Received: from eggs.gnu.org ([2001:4830:134:3::10]:37707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ecGXQ-0005VW-6U
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1ecGXP-0005dN-6c
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:11:52 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:33738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1ecGXP-0005Zn-0y
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:11:51 -0500
Received: by mail-oi0-x230.google.com with SMTP id y141so16619045oia.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:11:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7b0c4b68-2b37-b20c-b20d-7de35e50ad2a@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<d1df875c-5b64-67d9-2b3c-4ec14c03b85b@gmail.com>
	<CAPcyv4ip6m6e9Bh7weJNB3m3kpDpRkhHDZf0JYyr5UbkD41oLg@mail.gmail.com>
	<654f8935-258e-22ef-fae4-3e14e91e8fae@redhat.com>
	<336152896.34452750.1511527207457.JavaMail.zimbra@redhat.com>
	<f1ca60cc-5506-a161-b473-f0de363b7e95@redhat.com>
	<CAPcyv4j9b6ARvKcJkE25eNHatWACscMJTN_kCLSM6D+bfu_msA@mail.gmail.com>
	<72839100-7fdf-693c-e9c2-348a5add8a56@redhat.com>
	<1419599412.1747020.1516301689815.JavaMail.zimbra@redhat.com>
	<CAPcyv4hso5FYCyxYBHRhHvsU+M_wrkQBwVKurK-i6BQYzQduPw@mail.gmail.com>
	<7b0c4b68-2b37-b20c-b20d-7de35e50ad2a@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Jan 2018 12:11:47 -0800
Message-ID: <CAPcyv4g_x0Q6eT-SbX-gmy5yWwWrWHCc6vzw3u2SmYYuCMn7gA@mail.gmail.com>
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
Cc: Pankaj Gupta <pagupta@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>, Rik van Riel <riel@surriel.com>

On Thu, Jan 18, 2018 at 11:51 AM, David Hildenbrand <david@redhat.com> wrote:
>
>>> 1] Existing pmem driver & virtio for region discovery:
>>>   -----------------------------------------------------
>>>   Use existing pmem driver which is tightly coupled with concepts of namespaces, labels etc
>>>   from ACPI region discovery and re-implement these concepts with virtio so that existing
>>>   pmem driver can understand it. In addition to this, task of pmem driver to send flush command
>>>   using virtio.
>>
>> It's not tightly coupled. The whole point of libnvdimm is to be
>> agnostic to ACPI, e820 or any other range discovery. The only work to
>> do beyond identifying the address range is teaching libnvdimm to pass
>> along a flush control interface to the pmem driver.
>>
>>>
>>> 2] Existing pmem driver & ACPI NFIT for region discovery:
>>>   ----------------------------------------------------------------
>>> - If we use NFIT ACPI, we need to teach existing ACPI driver to add this new memory
>>>   type and teach existing pmem driver to handle this new memory type. Still we need
>>>   an asynchronous(virtio) way to send flush commands. We need virtio device/driver
>>>   or arbitrary key/value like pair just to send commands from guest to host using virtio.
>>>
>>> 3] New Virtio pmem driver & paravirt device:
>>>  ----------------------------------------
>>>   Third way is new virtio pmem driver with less work to support existing features of different protocols,
>>>   and with asynchronous way of sending flush commands.
>>>
>>>   But this needs to duplicate some of the work which existing pmem driver does but as discussed
>>>   previously we can separate common code from existing pmem driver and reuse it.
>>>
>>> Among these approaches I also prefer 3].
>>
>> I disagree, the reason we went down this ACPI path was to limit the
>> needless duplication of most of the pmem driver.
>>
>
> I have way to little insight to make qualified statements to different
> approaches here. :)
>
> All I am interesting in is making this as independent of architecture
> specific technologies (e.g. ACPI) as possible. We will want this e.g.
> for s390x too. Rather sooner than later. So trying to couple this
> (somehow) to ACPI just for the sake of less code to copy will not pay of
> in the long run.
>
> Better have a clean virtio interface / design right from the start.
>
> So I hope my words will be heard :)

I think that's reasonable. Once we have the virtio based discovery I
think the incremental changes to libnvdimm core and the pmem driver
are small.
