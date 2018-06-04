Received: from eggs.gnu.org ([2001:4830:134:3::10]:59101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fPfZU-00067C-PM
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 22:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fPfZP-0004Hg-Qa
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 22:50:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fPfZP-0004Gj-Kn
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 22:50:07 -0400
Date: Mon, 4 Jun 2018 10:49:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180604024958.GA15534@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-4-git-send-email-wei.w.wang@intel.com>
	<20180601040049.GG14867@xz-mi> <5B10F761.60509@intel.com>
	<20180601100617.GK14867@xz-mi> <5B113CDB.2090109@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B113CDB.2090109@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/5] migration: API to clear bits of
 guest free pages from the dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Fri, Jun 01, 2018 at 08:32:27PM +0800, Wei Wang wrote:
> On 06/01/2018 06:06 PM, Peter Xu wrote:
> > On Fri, Jun 01, 2018 at 03:36:01PM +0800, Wei Wang wrote:
> > > On 06/01/2018 12:00 PM, Peter Xu wrote:
> > > > On Tue, Apr 24, 2018 at 02:13:46PM +0800, Wei Wang wrote:
> > > > >    /*
> > > > > + * This function clears bits of the free pages reported by the caller from the
> > > > > + * migration dirty bitmap. @addr is the host address corresponding to the
> > > > > + * start of the continuous guest free pages, and @len is the total bytes of
> > > > > + * those pages.
> > > > > + */
> > > > > +void qemu_guest_free_page_hint(void *addr, size_t len)
> > > > > +{
> > > > > +    RAMBlock *block;
> > > > > +    ram_addr_t offset;
> > > > > +    size_t used_len, start, npages;
> > > > Do we need to check here on whether a migration is in progress?  Since
> > > > if not I'm not sure whether this hint still makes any sense any more,
> > > > and more importantly it seems to me that block->bmap below at [1] is
> > > > only valid during a migration.  So I'm not sure whether QEMU will
> > > > crash if this function is called without a running migration.
> > > OK. How about just adding comments above to have users noted that this
> > > function should be used during migration?
> > > 
> > > If we want to do a sanity check here, I think it would be easier to just
> > > check !block->bmap here.
> > I think the faster way might be that we check against the migration
> > state.
> > 
> 
> Sounds good. We can do a sanity check:
> 
>     MigrationState *s = migrate_get_current();
>     if (!migration_is_setup_or_active(s->state))
>         return;

Yes.

> 
> 
> 
> > > 
> > > > > +
> > > > > +    for (; len > 0; len -= used_len) {
> > > > > +        block = qemu_ram_block_from_host(addr, false, &offset);
> > > > > +        if (unlikely(!block)) {
> > > > > +            return;
> > > > We should never reach here, should we?  Assuming the callers of this
> > > > function should always pass in a correct host address. If we are very
> > > > sure that the host addr should be valid, could we just assert?
> > > Probably not the case, because of the corner case that the memory would be
> > > hot unplugged after the free page is reported to QEMU.
> > Question: Do we allow to do hot plug/unplug for memory during
> > migration?
> 
> I think so. From the code, I don't find where it forbids memory hotplug
> during migration.

I don't play with that much; do we need to do "device_add" after all?

  (qemu) object_add memory-backend-file,id=mem1,size=1G,mem-path=/mnt/hugepages-1GB
  (qemu) device_add pc-dimm,id=dimm1,memdev=mem1

If so, we may not allow that since in qdev_device_add() we don't allow
that:

    if (!migration_is_idle()) {
        error_setg(errp, "device_add not allowed while migrating");
        return NULL;
    }

> 
> > > 
> > > 
> > > > > +        }
> > > > > +
> > > > > +        /*
> > > > > +         * This handles the case that the RAMBlock is resized after the free
> > > > > +         * page hint is reported.
> > > > > +         */
> > > > > +        if (unlikely(offset > block->used_length)) {
> > > > > +            return;
> > > > > +        }
> > > > > +
> > > > > +        if (len <= block->used_length - offset) {
> > > > > +            used_len = len;
> > > > > +        } else {
> > > > > +            used_len = block->used_length - offset;
> > > > > +            addr += used_len;
> > > > > +        }
> > > > > +
> > > > > +        start = offset >> TARGET_PAGE_BITS;
> > > > > +        npages = used_len >> TARGET_PAGE_BITS;
> > > > > +
> > > > > +        qemu_mutex_lock(&ram_state->bitmap_mutex);
> > > > So now I think I understand the lock can still be meaningful since
> > > > this function now can be called outside the migration thread (e.g., in
> > > > vcpu thread).  But still it would be nice to mention it somewhere on
> > (Actually after read the next patch I think it's in iothread, so I'd
> >   better reply with all the series read over next time :)
> 
> That's fine actually :) Whether it is called by an iothread or a vcpu thread
> doesn't affect our discussion here.
> 
> I think we could just focus on the interfaces here and the usage in live
> migration. I can explain more when needed.

Ok.  Thanks!

-- 
Peter Xu
