Received: from eggs.gnu.org ([2001:4830:134:3::10]:37904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1da16b-0005pp-L2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1da16a-0003PE-Bn
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:46:37 -0400
Received: from mail-yw0-x22f.google.com ([2607:f8b0:4002:c05::22f]:36652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1da16a-0003Ol-5x
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:46:36 -0400
Received: by mail-yw0-x22f.google.com with SMTP id u207so9110142ywc.3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:46:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<1500818683.4073.31.camel@redhat.com>
	<CAPcyv4h5O4D2kp6SJhWiz4V=dOLDa_Q3pk2B=u-x7hKKQqdXsQ@mail.gmail.com>
	<1500833428.4073.36.camel@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Jul 2017 07:46:33 -0700
Message-ID: <CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
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
Cc: Jan Kara <jack@suse.cz>, Rik van Riel <riel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On Tue, Jul 25, 2017 at 7:27 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
>
>> Subject: Re: KVM "fake DAX" flushing interface - discussion
>>
>> On Mon 24-07-17 08:06:07, Pankaj Gupta wrote:
>> >
>> > > On Sun 23-07-17 13:10:34, Dan Williams wrote:
>> > > > On Sun, Jul 23, 2017 at 11:10 AM, Rik van Riel <riel@redhat.com> wrote:
>> > > > > On Sun, 2017-07-23 at 09:01 -0700, Dan Williams wrote:
>> > > > >> [ adding Ross and Jan ]
>> > > > >>
>> > > > >> On Sun, Jul 23, 2017 at 7:04 AM, Rik van Riel <riel@redhat.com>
>> > > > >> wrote:
>> > > > >> >
>> > > > >> > The goal is to increase density of guests, by moving page
>> > > > >> > cache into the host (where it can be easily reclaimed).
>> > > > >> >
>> > > > >> > If we assume the guests will be backed by relatively fast
>> > > > >> > SSDs, a "whole device flush" from filesystem journaling
>> > > > >> > code (issued where the filesystem issues a barrier or
>> > > > >> > disk cache flush today) may be just what we need to make
>> > > > >> > that work.
>> > > > >>
>> > > > >> Ok, apologies, I indeed had some pieces of the proposal confused.
>> > > > >>
>> > > > >> However, it still seems like the storage interface is not capable of
>> > > > >> expressing what is needed, because the operation that is needed is a
>> > > > >> range flush. In the guest you want the DAX page dirty tracking to
>> > > > >> communicate range flush information to the host, but there's no
>> > > > >> readily available block i/o semantic that software running on top of
>> > > > >> the fake pmem device can use to communicate with the host. Instead
>> > > > >> you
>> > > > >> want to intercept the dax_flush() operation and turn it into a
>> > > > >> queued
>> > > > >> request on the host.
>> > > > >>
>> > > > >> In 4.13 we have turned this dax_flush() operation into an explicit
>> > > > >> driver call. That seems a better interface to modify than trying to
>> > > > >> map block-storage flush-cache / force-unit-access commands to this
>> > > > >> host request.
>> > > > >>
>> > > > >> The additional piece you would need to consider is whether to track
>> > > > >> all writes in addition to mmap writes in the guest as DAX-page-cache
>> > > > >> dirtying events, or arrange for every dax_copy_from_iter()
>> > > > >> operation()
>> > > > >> to also queue a sync on the host, but that essentially turns the
>> > > > >> host
>> > > > >> page cache into a pseudo write-through mode.
>> > > > >
>> > > > > I suspect initially it will be fine to not offer DAX
>> > > > > semantics to applications using these "fake DAX" devices
>> > > > > from a virtual machine, because the DAX APIs are designed
>> > > > > for a much higher performance device than these fake DAX
>> > > > > setups could ever give.
>> > > >
>> > > > Right, we don't need DAX, per se, in the guest.
>> > > >
>> > > > >
>> > > > > Having userspace call fsync/msync like done normally, and
>> > > > > having those coarser calls be turned into somewhat efficient
>> > > > > backend flushes would be perfectly acceptable.
>> > > > >
>> > > > > The big question is, what should that kind of interface look
>> > > > > like?
>> > > >
>> > > > To me, this looks much like the dirty cache tracking that is done in
>> > > > the address_space radix for the DAX case, but modified to coordinate
>> > > > queued / page-based flushing when the guest  wants to persist data.
>> > > > The similarity to DAX is not storing guest allocated pages in the
>> > > > radix but entries that track dirty guest physical addresses.
>> > >
>> > > Let me check whether I understand the problem correctly. So we want to
>> > > export a block device (essentially a page cache of this block device) to
>> > > a
>> > > guest as PMEM and use DAX in the guest to save guest's page cache. The
>> >
>> > that's correct.
>> >
>> > > natural way to make the persistence work would be to make ->flush
>> > > callback
>> > > of the PMEM device to do an upcall to the host which could then
>> > > fdatasync()
>> > > appropriate image file range however the performance would suck in such
>> > > case since ->flush gets called for at most one page ranges from DAX.
>> >
>> > Discussion is : sync a range using paravirt device or flush hit addresses
>> > vs block device flush.
>> >
>> > >
>> > > So what you could do instead is to completely ignore ->flush calls for
>> > > the
>> > > PMEM device and instead catch the bio with REQ_PREFLUSH flag set on the
>> > > PMEM device (generated by blkdev_issue_flush() or the journalling
>> > > machinery) and fdatasync() the whole image file at that moment - in fact
>> > > you must do that for metadata IO to hit persistent storage anyway in your
>> > > setting. This would very closely follow how exporting block devices with
>> > > volatile cache works with KVM these days AFAIU and the performance will
>> > > be
>> > > the same.
>> >
>> > yes 'blkdev_issue_flush' does set 'REQ_OP_WRITE | REQ_PREFLUSH' flags.
>> > As per suggestions looks like block flushing device is way ahead.
>> >
>> > If we do an asynchronous block flush at guest side(put current task in
>> > wait queue till host side fdatasync completes) can solve the purpose? Or
>> > do we need another paravirt device for this?
>>
>> Well, even currently if you have PMEM device, you still have also a block
>> device and a request queue associated with it and metadata IO goes through
>> that path. So in your case you will have the same in the guest as a result
>> of exposing virtual PMEM device to the guest and you just need to make sure
>> this virtual block device behaves the same way as traditional virtualized
>> block devices in KVM in respose to 'REQ_OP_WRITE | REQ_PREFLUSH' requests.
>
> Looks like only way to send flush(blk dev) from guest to host with nvdimm
> is using flush hint addresses. Is this the correct interface I am looking?
>
> blkdev_issue_flush
>  submit_bio_wait
>   submit_bio
>     generic_make_request
>       pmem_make_request
>       ...
>            if (bio->bi_opf & REQ_FLUSH)
>                 nvdimm_flush(nd_region);

I would inject a paravirtualized version of pmem_make_request() that
sends an async flush operation over virtio to the host. Don't try to
use flush hint addresses for this, they don't have the proper
semantics. The guest should be allowed to issue the flush and receive
the completion asynchronously rather than taking a vm exist and
blocking on that request.
