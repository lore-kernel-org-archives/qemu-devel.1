Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRY08-0007lK-6F
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRY04-0000FY-88
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:41:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gRY03-0000FH-Vr
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:41:40 -0500
Date: Tue, 27 Nov 2018 15:41:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181127074127.GD3205@xz-x1>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-4-git-send-email-wei.w.wang@intel.com>
	<20181127054056.GA3205@xz-x1> <5BFCDE07.20707@intel.com>
	<5BFCE052.8070705@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5BFCE052.8070705@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v9 3/8] migration: use
 bitmap_mutex in migration_bitmap_clear_dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On Tue, Nov 27, 2018 at 02:12:34PM +0800, Wei Wang wrote:
> On 11/27/2018 02:02 PM, Wei Wang wrote:
> > On 11/27/2018 01:40 PM, Peter Xu wrote:
> > > On Thu, Nov 15, 2018 at 06:07:59PM +0800, Wei Wang wrote:
> > > > The bitmap mutex is used to synchronize threads to update the dirty
> > > > bitmap and the migration_dirty_pages counter. For example, the free
> > > > page optimization clears bits of free pages from the bitmap in an
> > > > iothread context. This patch makes migration_bitmap_clear_dirty update
> > > > the bitmap and counter under the mutex.
> > > > 
> > > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > CC: Juan Quintela <quintela@redhat.com>
> > > > CC: Michael S. Tsirkin <mst@redhat.com>
> > > > CC: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >   migration/ram.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index 7e7deec..ef69dbe 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -1556,11 +1556,14 @@ static inline bool
> > > > migration_bitmap_clear_dirty(RAMState *rs,
> > > >   {
> > > >       bool ret;
> > > >   +    qemu_mutex_lock(&rs->bitmap_mutex);
> > > >       ret = test_and_clear_bit(page, rb->bmap);
> > > >         if (ret) {
> > > >           rs->migration_dirty_pages--;
> > > >       }
> > > > +    qemu_mutex_unlock(&rs->bitmap_mutex);
> > > > +
> > > >       return ret;
> > > >   }
> > > It seems fine to me, but have you thought about
> > > test_and_clear_bit_atomic()?  Note that we just had
> > > test_and_set_bit_atomic() a few months ago.
> > 
> > Thanks for sharing. I think we might also need to
> > mutex migration_dirty_pages.
> > 
> > > 
> > > And not related to this patch: I'm unclear on why we have had
> > > bitmap_mutex before, since it seems unnecessary.
> > 
> > OK. This is because with the optimization we have a thread
> > which clears bits (of free pages) from the bitmap and updates
> > migration_dirty_pages. So we need to synchronization between
> > the migration thread and the optimization thread.
> > 
> 
> And before this feature, I think yes, that bitmap_mutex is not needed.
> It was left there due to some historical reasons.
> I remember Dave previous said he was about to remove it. But the new
> feature will need it again.

Ok then I'm fine with it.  Though you could update the comments too if
you like:

    /* protects modification of the bitmap and migration_dirty_pages */
    QemuMutex bitmap_mutex;

And it's tricky that sometimes we don't take the lock when reading
this variable "migration_dirty_pages".  I don't see obvious issue so
far, hope it's true (at least I skipped the colo ones...).

ram_bytes_remaining[333]       return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
migration_bitmap_clear_dirty[1562] rs->migration_dirty_pages--;
migration_bitmap_sync_range[1570] rs->migration_dirty_pages +=
postcopy_chunk_hostpages_pass[2809] rs->migration_dirty_pages += !test_and_set_bit(page, bitmap);
ram_state_init[3037]           (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
ram_state_resume_prepare[3112] rs->migration_dirty_pages = pages;
ram_save_pending[3344]         remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
ram_save_pending[3353]         remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
colo_cache_from_block_offset[3468] ram_state->migration_dirty_pages++;
colo_init_ram_cache[3716]      ram_state->migration_dirty_pages = 0;
colo_flush_ram_cache[3997]     trace_colo_flush_ram_cache_begin(ram_state->migration_dirty_pages);

Regards,

-- 
Peter Xu
