Received: from eggs.gnu.org ([2001:4830:134:3::10]:32912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dZ0Ak-00019P-9L
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 15:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dZ0Aj-0001I5-6h
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 15:34:42 -0400
Received: from mail-yw0-x231.google.com ([2607:f8b0:4002:c05::231]:35540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dZ0Ai-0001Gr-W4
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 15:34:41 -0400
Received: by mail-yw0-x231.google.com with SMTP id h189so8974818ywf.2
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 12:34:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721155848.GO18014@stefanha-x1.localdomain>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
	<20170721121241.GA18014@stefanha-x1.localdomain>
	<46101617.33460557.1500643755247.JavaMail.zimbra@redhat.com>
	<20170721155848.GO18014@stefanha-x1.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 22 Jul 2017 12:34:36 -0700
Message-ID: <CAPcyv4gtWYpzbmggsbdLocPiMzU2rVt-ee+kL24gbrPxKd5Eyw@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Rik van Riel <riel@redhat.com>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On Fri, Jul 21, 2017 at 8:58 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Fri, Jul 21, 2017 at 09:29:15AM -0400, Pankaj Gupta wrote:
>>
>> > > A] Problems to solve:
>> > > ------------------
>> > >
>> > > 1] We are considering two approaches for 'fake DAX flushing interface'.
>> > >
>> > >  1.1] fake dax with NVDIMM flush hints & KVM async page fault
>> > >
>> > >      - Existing interface.
>> > >
>> > >      - The approach to use flush hint address is already nacked upstream.
>> > >
>> > >      - Flush hint not queued interface for flushing. Applications might
>> > >        avoid to use it.
>> >
>> > This doesn't contradicts the last point about async operation and vcpu
>> > control.  KVM async page faults turn the Address Flush Hints write into
>> > an async operation so the guest can get other work done while waiting
>> > for completion.
>> >
>> > >
>> > >      - Flush hint address traps from guest to host and do an entire fsync
>> > >        on backing file which itself is costly.
>> > >
>> > >      - Can be used to flush specific pages on host backing disk. We can
>> > >        send data(pages information) equal to cache-line size(limitation)
>> > >        and tell host to sync corresponding pages instead of entire disk
>> > >        sync.
>> >
>> > Are you sure?  Your previous point says only the entire device can be
>> > synced.  The NVDIMM Adress Flush Hints interface does not involve
>> > address range information.
>>
>> Just syncing entire block device should be simple but costly. Using flush
>> hint address to write data which contains list/info of dirty pages to
>> flush requires more thought. This calls mmio write callback at Qemu side.
>> As per Intel (ACPI spec 6.1, Table 5-135) there is limit to max length
>> of data guest can write and is equal to cache line size.
>>
>> >
>> > >
>> > >      - This will be an asynchronous operation and vCPU control is returned
>> > >        quickly.
>> > >
>> > >
>> > >  1.2] Using additional para virt device in addition to pmem device(fake dax
>> > >  with device flush)
>> >
>> > Perhaps this can be exposed via ACPI as part of the NVDIMM standards
>> > instead of a separate KVM-only paravirt device.
>>
>> Same reason as above. If we decide on sending list of dirty pages there is
>> limit to send max size of data to host using flush hint address.
>
> I understand now: you are proposing to change the semantics of the
> Address Flush Hints interface.  You want the value written to have
> meaning (the address range that needs to be flushed).
>
> Today the spec says:
>
>   The content of the data is not relevant to the functioning of the
>   flush hint mechanism.
>
> Maybe the NVDIMM folks can comment on this idea.

I think it's unworkable to use the flush hints as a guest-to-host
fsync mechanism. That mechanism was designed to flush small memory
controller buffers, not large swaths of dirty memory. What about
running the guests in a writethrough cache mode to avoid needing dirty
cache management altogether? Either way I think you need to use
device-dax on the host, or one of the two work-in-progress filesystem
mechanisms (synchronous-faults or S_IOMAP_FROZEN) to avoid need any
metadata coordination between guests and the host.
