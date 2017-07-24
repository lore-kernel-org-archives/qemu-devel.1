Received: from eggs.gnu.org ([2001:4830:134:3::10]:36380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1dZc7u-0000af-Cs
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1dZc7r-00033P-73
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:06:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1dZc7q-00030l-Tl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:06:15 -0400
Date: Mon, 24 Jul 2017 08:06:07 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170724102330.GE652@quack2.suse.cz>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<20170721155848.GO18014@stefanha-x1.localdomain>
	<CAPcyv4gtWYpzbmggsbdLocPiMzU2rVt-ee+kL24gbrPxKd5Eyw@mail.gmail.com>
	<1500818683.4073.31.camel@redhat.com>
	<CAPcyv4h5O4D2kp6SJhWiz4V=dOLDa_Q3pk2B=u-x7hKKQqdXsQ@mail.gmail.com>
	<1500833428.4073.36.camel@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>, Rik van Riel <riel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>


> On Sun 23-07-17 13:10:34, Dan Williams wrote:
> > On Sun, Jul 23, 2017 at 11:10 AM, Rik van Riel <riel@redhat.com> wrote:
> > > On Sun, 2017-07-23 at 09:01 -0700, Dan Williams wrote:
> > >> [ adding Ross and Jan ]
> > >>
> > >> On Sun, Jul 23, 2017 at 7:04 AM, Rik van Riel <riel@redhat.com>
> > >> wrote:
> > >> >
> > >> > The goal is to increase density of guests, by moving page
> > >> > cache into the host (where it can be easily reclaimed).
> > >> >
> > >> > If we assume the guests will be backed by relatively fast
> > >> > SSDs, a "whole device flush" from filesystem journaling
> > >> > code (issued where the filesystem issues a barrier or
> > >> > disk cache flush today) may be just what we need to make
> > >> > that work.
> > >>
> > >> Ok, apologies, I indeed had some pieces of the proposal confused.
> > >>
> > >> However, it still seems like the storage interface is not capable of
> > >> expressing what is needed, because the operation that is needed is a
> > >> range flush. In the guest you want the DAX page dirty tracking to
> > >> communicate range flush information to the host, but there's no
> > >> readily available block i/o semantic that software running on top of
> > >> the fake pmem device can use to communicate with the host. Instead
> > >> you
> > >> want to intercept the dax_flush() operation and turn it into a queued
> > >> request on the host.
> > >>
> > >> In 4.13 we have turned this dax_flush() operation into an explicit
> > >> driver call. That seems a better interface to modify than trying to
> > >> map block-storage flush-cache / force-unit-access commands to this
> > >> host request.
> > >>
> > >> The additional piece you would need to consider is whether to track
> > >> all writes in addition to mmap writes in the guest as DAX-page-cache
> > >> dirtying events, or arrange for every dax_copy_from_iter()
> > >> operation()
> > >> to also queue a sync on the host, but that essentially turns the host
> > >> page cache into a pseudo write-through mode.
> > >
> > > I suspect initially it will be fine to not offer DAX
> > > semantics to applications using these "fake DAX" devices
> > > from a virtual machine, because the DAX APIs are designed
> > > for a much higher performance device than these fake DAX
> > > setups could ever give.
> > 
> > Right, we don't need DAX, per se, in the guest.
> > 
> > >
> > > Having userspace call fsync/msync like done normally, and
> > > having those coarser calls be turned into somewhat efficient
> > > backend flushes would be perfectly acceptable.
> > >
> > > The big question is, what should that kind of interface look
> > > like?
> > 
> > To me, this looks much like the dirty cache tracking that is done in
> > the address_space radix for the DAX case, but modified to coordinate
> > queued / page-based flushing when the guest  wants to persist data.
> > The similarity to DAX is not storing guest allocated pages in the
> > radix but entries that track dirty guest physical addresses.
> 
> Let me check whether I understand the problem correctly. So we want to
> export a block device (essentially a page cache of this block device) to a
> guest as PMEM and use DAX in the guest to save guest's page cache. The

that's correct.

> natural way to make the persistence work would be to make ->flush callback
> of the PMEM device to do an upcall to the host which could then fdatasync()
> appropriate image file range however the performance would suck in such
> case since ->flush gets called for at most one page ranges from DAX.

Discussion is : sync a range using paravirt device or flush hit addresses 
vs block device flush.

> 
> So what you could do instead is to completely ignore ->flush calls for the
> PMEM device and instead catch the bio with REQ_PREFLUSH flag set on the
> PMEM device (generated by blkdev_issue_flush() or the journalling
> machinery) and fdatasync() the whole image file at that moment - in fact
> you must do that for metadata IO to hit persistent storage anyway in your
> setting. This would very closely follow how exporting block devices with
> volatile cache works with KVM these days AFAIU and the performance will be
> the same.

yes 'blkdev_issue_flush' does set 'REQ_OP_WRITE | REQ_PREFLUSH' flags.
As per suggestions looks like block flushing device is way ahead. 

If we do an asynchronous block flush at guest side(put current task in wait queue 
till host side fdatasync completes) can solve the purpose? Or do we need another paravirt
device for this?

> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
