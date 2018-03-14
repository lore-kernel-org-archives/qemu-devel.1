Received: from eggs.gnu.org ([2001:4830:134:3::10]:36482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewCIt-0003nW-1c
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewCIp-00082s-R6
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:43:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewCIp-00082b-NK
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:43:11 -0400
Date: Wed, 14 Mar 2018 19:42:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180314194258.GI3006@work-vm>
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-3-git-send-email-wei.w.wang@intel.com>
	<20180314181137.GG3006@work-vm>
	<20180314211302-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314211302-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] migration: API to clear bits of
 guest free pages from the dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Wed, Mar 14, 2018 at 06:11:37PM +0000, Dr. David Alan Gilbert wrote:
> > > +            used_len = block->used_length - offset;
> > > +            addr += used_len;
> > > +        }
> > > +
> > > +        start = offset >> TARGET_PAGE_BITS;
> > > +        npages = used_len >> TARGET_PAGE_BITS;
> > > +        ram_state->migration_dirty_pages -=
> > > +                      bitmap_count_one_with_offset(block->bmap, start, npages);
> > > +        bitmap_clear(block->bmap, start, npages);
> > 
> > If this is happening while the migration is running, this isn't safe -
> > the migration code could clear a bit at about the same point this
> > happens, so that the count returned by bitmap_count_one_with_offset
> > wouldn't match the word that was cleared by bitmap_clear.
> > 
> > The only way I can see to fix it is to run over the range using
> > bitmap_test_and_clear_atomic, using the return value to decrement
> > the number of dirty pages.
> > But you also need to be careful with the update of the
> > migration_dirty_pages value itself, because that's also being read
> > by the migration thread.
> > 
> > Dave
> 
> I see that there's migration_bitmap_sync but it does not seem to be

Do you mean bitmap_mutex?

> taken on all paths. E.g. migration_bitmap_clear_dirty and
> migration_bitmap_find_dirty are called without that lock sometimes.
> Thoughts?

Hmm, that doesn't seem to protect much at all!  It looks like it was
originally added to handle hotplug causing the bitmaps to be resized;
that extension code was removed in 66103a5 so that lock can probably go.

I don't see how the lock would help us though; the migration thread is
scanning it most of the time so would have to have the lock held
most of the time.

Dave

> -- 
> MST
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
