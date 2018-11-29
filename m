Received: from eggs.gnu.org ([2001:4830:134:3::10]:59266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gSEaz-0007Qf-NJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 00:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gSEaw-0005Ps-0T
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 00:10:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gSEaq-0005HC-WE
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 00:10:30 -0500
Date: Thu, 29 Nov 2018 13:10:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181129051014.GC29246@xz-x1>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-6-git-send-email-wei.w.wang@intel.com>
	<20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com>
	<20181128052655.GC12839@xz-x1> <5BFE596B.1080807@intel.com>
	<20181128093220.GF12839@xz-x1> <5BFF5FC9.2020402@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5BFF5FC9.2020402@intel.com>
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

On Thu, Nov 29, 2018 at 11:40:57AM +0800, Wei Wang wrote:
> On 11/28/2018 05:32 PM, Peter Xu wrote:
> > 
> > So what I am worrying here are corner cases where we might forget to
> > stop the hinting.  I'm fabricating one example sequence of events:
> > 
> >    (start migration)
> >    START_MIGRATION
> >    BEFORE_SYNC
> >    AFTER_SYNC
> >    ...
> >    BEFORE_SYNC
> >    AFTER_SYNC
> >    (some SaveStateEntry failed rather than RAM, then
> >     migration_detect_error returned MIG_THR_ERR_FATAL so we need to
> >     fail the migration, however when running the previous
> >     ram_save_iterate for RAM's specific SaveStateEntry we didn't see
> >     any error so no ERROR event detected)
> > 
> > Then it seems the hinting will last forever.  Considering that now I'm
> > not sure whether this can be done ram-only, since even if you capture
> > ram_save_complete() and at the same time you introduce PRECOPY_END you
> > may still miss the PRECOPY_END event since AFAIU ram_save_complete()
> > won't be called at all in this case.
> > 
> > Could this happen?
> 
> Thanks, indeed this case could happen if we add PRECOPY_END in
> ram_save_complete.
> 
> How about putting PRECOPY_END in ram_save_cleanup?
> I think it would be called in any case.

Sounds good.

> 
> I'm also thinking probably we don't need PRECOPY_ERR when we have
> PRECOPY_END,
> and what do you think of the notifier names below:
> 
> +typedef enum PrecopyNotifyReason {
> +    PRECOPY_NOTIFY_RAM_SAVE_END = 0,
> +    PRECOPY_NOTIFY_RAM_SAVE_START = 1,
> +    PRECOPY_NOTIFY_RAM_SAVE_BEFORE_SYNC_BITMAP = 2,
> +    PRECOPY_NOTIFY_RAM_SAVE_AFTER_SYNC_BITMAP = 3,
> +    PRECOPY_NOTIFY_RAM_SAVE_MAX = 4,
> +} PrecopyNotifyReason;

(please see below [1]...)

> 
> 
> > 
> > > 
> > > > [1]
> > > > 
> > > > > > Another thing to mention about the "reasons" (though I see it more
> > > > > > like "events"): have you thought about adding a PRECOPY_NOTIFY_END?
> > > > > > It might help in some cases:
> > > > > > 
> > > > > >      - then you don't need to trickily export the migrate_postcopy()
> > > > > >        since you'll notify that before postcopy starts
> > > > > I'm thinking probably we don't need to export migrate_postcopy even now.
> > > > > It's more like a sanity check, and not needed because now we have the
> > > > > notifier registered to the precopy specific callchain, which has ensured
> > > > > that
> > > > > it is invoked via precopy.
> > > > But postcopy will always start with precopy, no?
> > > Yes, but I think we could add the check in precopy_notify()
> > I'm not sure that's good.  If the notifier could potentially have
> > other user, they might still work with postcopy, and they might expect
> > e.g. BEFORE_SYNC to be called for every sync, even if it's at the
> > precopy stage of a postcopy.
> 
> I think this precopy notifier callchain is expected to be used only for
> the precopy mode. Postcopy has its dedicated notifier callchain that
> users could use.
> 
> How about changing the migrate_postcopy() check to "ms->start_postcopy":
> 
> bool migration_postcopy_start(void)
> {
>     MigrationState *s;
> 
>     s = migrate_get_current();
> 
>     return atomic_read(&s->start_postcopy);
> }
> 
> 
> static void precopy_notify(PrecopyNotifyReason reason)
> {
>     if (migration_postcopy_start())
>         return;
> 
>     notifier_list_notify(&precopy_notifier_list, &reason);
> }
> 
> If postcopy started with precopy, the precopy optimization feature
> could still be used until it switches to the postcopy mode.

I'm not sure we can use start_postcopy.  It's a variable being set in
the QMP handler but it does not mean postcopy has started.  I'm afraid
there can be race where it's still precopy but the variable is set so
event could be missed...

IMHO the problem is not that complicated.  How about this proposal:

[1]

  typedef enum PrecopyNotifyReason {
    PRECOPY_NOTIFY_RAM_START,
    PRECOPY_NOTIFY_RAM_BEFORE_SYNC,
    PRECOPY_NOTIFY_RAM_AFTER_SYNC,
    PRECOPY_NOTIFY_COMPLETE,
    PRECOPY_NOTIFY_RAM_CLEANUP,
  };

The first three keep the same as your old ones.  Notify RAM_CLEANUP in
ram_save_cleanup() to make sure it'll always be cleaned up (the same
as PRECOPY_END, just another name).  Notify COMPLETE in
qemu_savevm_state_complete_precopy() to show that precopy is
completed.  Meanwhile on balloon side you should stop the hinting for
either RAM_CLEANUP or COMPLETE event.  Then either:

  - precopy is switching to postcopy, or
  - precopy completed, or
  - precopy failed/cancelled

You should always get at least a notification to stop the balloon.
Though you could also get one RAM_CLEANUP after one COMPLETE, but
the balloon should easily handle it (stop the hinting twice).

Here maybe you can even remove the "RAM_" in both RAM_START and
RAM_CLEANUP if we're going to have COMPLETE since after all it'll be
not only limited to RAM.

Another suggestion is that you can add an Error into the notify hooks,
please refer to the postcopy one:

  int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp);

So the hook functions have a way to even stop the migration (though
for balloon hinting it'll be always optional so no error should be
reported...), then the two interfaces are matched.

> 
> 
> 
> > In that sense I still feel the
> > PRECOPY_END is better (so contantly call it at the end of precopy, no
> > matter whether there's another postcopy afterwards).  It sounds like a
> > cleaner interface.
> 
> Probably I still haven't got the point how PRECOPY_END could help above yet.

Please have a look at above proposal.  Thanks,

-- 
Peter Xu
