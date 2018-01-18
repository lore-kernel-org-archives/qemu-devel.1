Received: from eggs.gnu.org ([2001:4830:134:3::10]:32921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ecGDu-0004vB-2S
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ecGDq-0001r9-5Y
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:51:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ecGDp-0001qk-St
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:51:38 -0500
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
From: David Hildenbrand <david@redhat.com>
Message-ID: <7b0c4b68-2b37-b20c-b20d-7de35e50ad2a@redhat.com>
Date: Thu, 18 Jan 2018 20:51:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hso5FYCyxYBHRhHvsU+M_wrkQBwVKurK-i6BQYzQduPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Dan Williams <dan.j.williams@intel.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>, Rik van Riel <riel@surriel.com>


>> 1] Existing pmem driver & virtio for region discovery:
>>   -----------------------------------------------------
>>   Use existing pmem driver which is tightly coupled with concepts of namespaces, labels etc
>>   from ACPI region discovery and re-implement these concepts with virtio so that existing
>>   pmem driver can understand it. In addition to this, task of pmem driver to send flush command
>>   using virtio.
> 
> It's not tightly coupled. The whole point of libnvdimm is to be
> agnostic to ACPI, e820 or any other range discovery. The only work to
> do beyond identifying the address range is teaching libnvdimm to pass
> along a flush control interface to the pmem driver.
> 
>>
>> 2] Existing pmem driver & ACPI NFIT for region discovery:
>>   ----------------------------------------------------------------
>> - If we use NFIT ACPI, we need to teach existing ACPI driver to add this new memory
>>   type and teach existing pmem driver to handle this new memory type. Still we need
>>   an asynchronous(virtio) way to send flush commands. We need virtio device/driver
>>   or arbitrary key/value like pair just to send commands from guest to host using virtio.
>>
>> 3] New Virtio pmem driver & paravirt device:
>>  ----------------------------------------
>>   Third way is new virtio pmem driver with less work to support existing features of different protocols,
>>   and with asynchronous way of sending flush commands.
>>
>>   But this needs to duplicate some of the work which existing pmem driver does but as discussed
>>   previously we can separate common code from existing pmem driver and reuse it.
>>
>> Among these approaches I also prefer 3].
> 
> I disagree, the reason we went down this ACPI path was to limit the
> needless duplication of most of the pmem driver.
> 

I have way to little insight to make qualified statements to different
approaches here. :)

All I am interesting in is making this as independent of architecture
specific technologies (e.g. ACPI) as possible. We will want this e.g.
for s390x too. Rather sooner than later. So trying to couple this
(somehow) to ACPI just for the sake of less code to copy will not pay of
in the long run.

Better have a clean virtio interface / design right from the start.

So I hope my words will be heard :)

-- 

Thanks,

David / dhildenb
