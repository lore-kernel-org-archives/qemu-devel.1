Received: from eggs.gnu.org ([2001:4830:134:3::10]:56821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ewBtY-0002tz-DB
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ewBtV-0003sm-4Q
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:17:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ewBtU-0003sI-Vq
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:17:01 -0400
Date: Wed, 14 Mar 2018 21:16:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180314211302-mutt-send-email-mst@kernel.org>
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-3-git-send-email-wei.w.wang@intel.com>
	<20180314181137.GG3006@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314181137.GG3006@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Wed, Mar 14, 2018 at 06:11:37PM +0000, Dr. David Alan Gilbert wrote:
> > +            used_len = block->used_length - offset;
> > +            addr += used_len;
> > +        }
> > +
> > +        start = offset >> TARGET_PAGE_BITS;
> > +        npages = used_len >> TARGET_PAGE_BITS;
> > +        ram_state->migration_dirty_pages -=
> > +                      bitmap_count_one_with_offset(block->bmap, start, npages);
> > +        bitmap_clear(block->bmap, start, npages);
> 
> If this is happening while the migration is running, this isn't safe -
> the migration code could clear a bit at about the same point this
> happens, so that the count returned by bitmap_count_one_with_offset
> wouldn't match the word that was cleared by bitmap_clear.
> 
> The only way I can see to fix it is to run over the range using
> bitmap_test_and_clear_atomic, using the return value to decrement
> the number of dirty pages.
> But you also need to be careful with the update of the
> migration_dirty_pages value itself, because that's also being read
> by the migration thread.
> 
> Dave

I see that there's migration_bitmap_sync but it does not seem to be
taken on all paths. E.g. migration_bitmap_clear_dirty and
migration_bitmap_find_dirty are called without that lock sometimes.
Thoughts?

-- 
MST
