Received: from eggs.gnu.org ([2001:4830:134:3::10]:57777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dZND3-0008Ot-Hi
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1dZND2-0002RB-Gv
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:10:37 -0400
Received: from mail-yb0-x229.google.com ([2607:f8b0:4002:c09::229]:38260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1dZND2-0002Qb-B6
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:10:36 -0400
Received: by mail-yb0-x229.google.com with SMTP id g144so6106527yba.5
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 13:10:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500833428.4073.36.camel@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
	<20170721121241.GA18014@stefanha-x1.localdomain>
	<46101617.33460557.1500643755247.JavaMail.zimbra@redhat.com>
	<20170721155848.GO18014@stefanha-x1.localdomain>
	<CAPcyv4gtWYpzbmggsbdLocPiMzU2rVt-ee+kL24gbrPxKd5Eyw@mail.gmail.com>
	<1500818683.4073.31.camel@redhat.com>
	<CAPcyv4h5O4D2kp6SJhWiz4V=dOLDa_Q3pk2B=u-x7hKKQqdXsQ@mail.gmail.com>
	<1500833428.4073.36.camel@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 23 Jul 2017 13:10:34 -0700
Message-ID: <CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
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
To: Rik van Riel <riel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Zwisler,
	Ross" <ross.zwisler@intel.com>, Jan Kara <jack@suse.cz>

On Sun, Jul 23, 2017 at 11:10 AM, Rik van Riel <riel@redhat.com> wrote:
> On Sun, 2017-07-23 at 09:01 -0700, Dan Williams wrote:
>> [ adding Ross and Jan ]
>>
>> On Sun, Jul 23, 2017 at 7:04 AM, Rik van Riel <riel@redhat.com>
>> wrote:
>> >
>> > The goal is to increase density of guests, by moving page
>> > cache into the host (where it can be easily reclaimed).
>> >
>> > If we assume the guests will be backed by relatively fast
>> > SSDs, a "whole device flush" from filesystem journaling
>> > code (issued where the filesystem issues a barrier or
>> > disk cache flush today) may be just what we need to make
>> > that work.
>>
>> Ok, apologies, I indeed had some pieces of the proposal confused.
>>
>> However, it still seems like the storage interface is not capable of
>> expressing what is needed, because the operation that is needed is a
>> range flush. In the guest you want the DAX page dirty tracking to
>> communicate range flush information to the host, but there's no
>> readily available block i/o semantic that software running on top of
>> the fake pmem device can use to communicate with the host. Instead
>> you
>> want to intercept the dax_flush() operation and turn it into a queued
>> request on the host.
>>
>> In 4.13 we have turned this dax_flush() operation into an explicit
>> driver call. That seems a better interface to modify than trying to
>> map block-storage flush-cache / force-unit-access commands to this
>> host request.
>>
>> The additional piece you would need to consider is whether to track
>> all writes in addition to mmap writes in the guest as DAX-page-cache
>> dirtying events, or arrange for every dax_copy_from_iter()
>> operation()
>> to also queue a sync on the host, but that essentially turns the host
>> page cache into a pseudo write-through mode.
>
> I suspect initially it will be fine to not offer DAX
> semantics to applications using these "fake DAX" devices
> from a virtual machine, because the DAX APIs are designed
> for a much higher performance device than these fake DAX
> setups could ever give.

Right, we don't need DAX, per se, in the guest.

>
> Having userspace call fsync/msync like done normally, and
> having those coarser calls be turned into somewhat efficient
> backend flushes would be perfectly acceptable.
>
> The big question is, what should that kind of interface look
> like?

To me, this looks much like the dirty cache tracking that is done in
the address_space radix for the DAX case, but modified to coordinate
queued / page-based flushing when the guest  wants to persist data.
The similarity to DAX is not storing guest allocated pages in the
radix but entries that track dirty guest physical addresses.
