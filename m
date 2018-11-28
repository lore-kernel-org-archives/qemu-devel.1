Received: from eggs.gnu.org ([2001:4830:134:3::10]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRwCy-00029r-44
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRwCu-0005pE-W1
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:32:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gRwCu-0005oQ-P3
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:32:32 -0500
Date: Wed, 28 Nov 2018 17:32:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181128093220.GF12839@xz-x1>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-6-git-send-email-wei.w.wang@intel.com>
	<20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com>
	<20181128052655.GC12839@xz-x1> <5BFE596B.1080807@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5BFE596B.1080807@intel.com>
Subject: Re: [Qemu-devel] [PATCH v9 5/8] migration/ram.c: add a notifier
 chain for precopy
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

On Wed, Nov 28, 2018 at 05:01:31PM +0800, Wei Wang wrote:
> On 11/28/2018 01:26 PM, Peter Xu wrote:
> > 
> > Ok thanks.  Please just make sure you will capture all the error
> > cases, e.g., I also see path like this (a few lines below):
> > 
> >          if (pages < 0) {
> >              qemu_file_set_error(f, pages);
> >              break;
> >          }
> > 
> > It seems that you missed that one.
> 
> I think that one should be fine. This notification is actually put at the
> bottom of ram_save_iterate. All the above error will bail out to the "out:"
> path and then go to call precopy_notify(PRECOPY_NOTIFY_ERR).

Ok, maybe I was pointing to a wrong one. :)

> 
> > 
> > I would even suggest that you capture the error with higher level.
> > E.g., in migration_iteration_run() after qemu_savevm_state_iterate().
> > Or we can just check the return value of qemu_savevm_state_iterate(),
> > which we have had ignored so far.
> 
> Not very sure about the higher level, because other SaveStateEntry may cause
> errors that this feature don't need to care, I think we may only need it in
> ram_save.

So what I am worrying here are corner cases where we might forget to
stop the hinting.  I'm fabricating one example sequence of events:

  (start migration)
  START_MIGRATION
  BEFORE_SYNC
  AFTER_SYNC
  ...
  BEFORE_SYNC
  AFTER_SYNC
  (some SaveStateEntry failed rather than RAM, then
   migration_detect_error returned MIG_THR_ERR_FATAL so we need to
   fail the migration, however when running the previous
   ram_save_iterate for RAM's specific SaveStateEntry we didn't see
   any error so no ERROR event detected)

Then it seems the hinting will last forever.  Considering that now I'm
not sure whether this can be done ram-only, since even if you capture
ram_save_complete() and at the same time you introduce PRECOPY_END you
may still miss the PRECOPY_END event since AFAIU ram_save_complete()
won't be called at all in this case.

Could this happen?

> 
> 
> > [1]
> > 
> > > 
> > > > Another thing to mention about the "reasons" (though I see it more
> > > > like "events"): have you thought about adding a PRECOPY_NOTIFY_END?
> > > > It might help in some cases:
> > > > 
> > > >     - then you don't need to trickily export the migrate_postcopy()
> > > >       since you'll notify that before postcopy starts
> > > I'm thinking probably we don't need to export migrate_postcopy even now.
> > > It's more like a sanity check, and not needed because now we have the
> > > notifier registered to the precopy specific callchain, which has ensured
> > > that
> > > it is invoked via precopy.
> > But postcopy will always start with precopy, no?
> 
> Yes, but I think we could add the check in precopy_notify()

I'm not sure that's good.  If the notifier could potentially have
other user, they might still work with postcopy, and they might expect
e.g. BEFORE_SYNC to be called for every sync, even if it's at the
precopy stage of a postcopy.  In that sense I still feel the
PRECOPY_END is better (so contantly call it at the end of precopy, no
matter whether there's another postcopy afterwards).  It sounds like a
cleaner interface.

Or you can check it in the balloon specific callback and ignore the
event if postcopy is on, but then we're going backward to need to
export the API so it seems meaningless.

Regards,

-- 
Peter Xu
