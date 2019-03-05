Received: from eggs.gnu.org ([209.51.188.92]:58008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1DSm-00039x-8d
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1DSk-0003LE-TO
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:02:43 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h1DSk-00039C-O2
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:02:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so9674522qta.7
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:02:33 -0800 (PST)
Date: Tue, 5 Mar 2019 12:02:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190305120131-mutt-send-email-mst@kernel.org>
References: <20190305051134.27930-1-david@gibson.dropbear.id.au>
	<20190305051134.27930-3-david@gibson.dropbear.id.au>
	<00e325d4-b23c-7239-46e6-a55fd1f9d5f4@redhat.com>
	<20190305110201-mutt-send-email-mst@kernel.org>
	<921c1cde-59bc-09d0-c026-26e939e7b6ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921c1cde-59bc-09d0-c026-26e939e7b6ee@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/2] virtio-balloon: Restore MADV_WILLNEED
 hint on balloon deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, Mar 05, 2019 at 05:10:42PM +0100, David Hildenbrand wrote:
> On 05.03.19 17:03, Michael S. Tsirkin wrote:
> > On Tue, Mar 05, 2019 at 03:15:38PM +0100, David Hildenbrand wrote:
> >> On 05.03.19 06:11, David Gibson wrote:
> >>> Prior to f6deb6d9 "virtio-balloon: Remove unnecessary MADV_WILLNEED on
> >>> deflate", the balloon device issued an madvise() MADV_WILLNEED on
> >>> pages removed from the balloon.  That would hint to the host kernel
> >>> that the pages were likely to be needed by the guest in the near
> >>> future.
> >>>
> >>> It's unclear if this is actually valuable or not, and so f6deb6d9
> >>> removed this, essentially ignoring balloon deflate requests.  However,
> >>> concerns have been raised that this might cause a performance
> >>> regression by causing extra latency for the guest in certain
> >>> configurations.
> >>
> >> I mean, it will mainly create page tables as far as I know. Any write to
> >> a page will have an overhead either way (COW zero page). Reads *might*
> >> be faster.
> >>
> >> As we are working on 4k granularity in the balloon (and doing
> >> MADV_DONTNEED on 4k granularity!), there will most probably be page
> >> tables already either way. A page table could only be zapped if all
> >> pages of that page table are MADV_DONTNEED'ed (or I assume never were
> >> touched), and I am not sure if "random MADV_DONTNEED'ing of 4k pages"
> >> will actually get rid of page tables (my assumption would be: only if a
> >> complete range is zapped at once). I haven't looked into the details,
> >> though (plenty of other stuff to do).
> >>
> >> I am not sure if I share the concerns. Real-time workload should never
> >> use the virtio-balloon in a way that anything like that would be possible.
> >>
> >>>
> >>> So, until we can get actual benchmark data to see if that's the case,
> >>> this restores (by default) the old behaviour, issuing a MADV_WILLNEED
> >>> when a page is removed from the balloon.  A new property on the
> >>> balloon device "hint-on-deflate" can be set to false to remove this
> >>> behaviour for testing.
> >>
> >> This is certainly a good approach for you to finally be able to leave
> >> the ugly land of virtio-balloon :)
> >>
> >> But at least to me, this looks completely useless. I'll be happy to be
> >> proven wrong as always :)
> > 
> > Point is if we don't intend to extend balloon any further then let's
> > not make random untested changes to its behaviour.
> 
> Agreed, but than I'd much rather want to avoid the original change
> instead of adding a new property that most probably nobody will ever use.

OK, I don't mind either way.

> -- 
> 
> Thanks,
> 
> David / dhildenb
