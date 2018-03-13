Received: from eggs.gnu.org ([2001:4830:134:3::10]:55274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evhDV-0004Lx-N2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evhDR-0001P5-FX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:31:37 -0400
Date: Tue, 13 Mar 2018 10:30:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180313103056.GB3545@work-vm>
References: <20180207155837.92351-1-vsementsov@virtuozzo.com>
	<20180207155837.92351-6-vsementsov@virtuozzo.com>
	<20180312153020.GI3219@work-vm>
	<af82d663-f37c-2857-214c-83e348a5f52a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af82d663-f37c-2857-214c-83e348a5f52a@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v10 05/12] migration: introduce
 postcopy-only pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 12.03.2018 18:30, Dr. David Alan Gilbert wrote:
> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > There would be savevm states (dirty-bitmap) which can migrate only in
> > > postcopy stage. The corresponding pending is introduced here.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > ---
> 
> [...]
> 
> > >   static MigIterateState migration_iteration_run(MigrationState *s)
> > >   {
> > > -    uint64_t pending_size, pend_post, pend_nonpost;
> > > +    uint64_t pending_size, pend_pre, pend_compat, pend_post;
> > >       bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
> > > -    qemu_savevm_state_pending(s->to_dst_file, s->threshold_size,
> > > -                              &pend_nonpost, &pend_post);
> > > -    pending_size = pend_nonpost + pend_post;
> > > +    qemu_savevm_state_pending(s->to_dst_file, s->threshold_size, &pend_pre,
> > > +                              &pend_compat, &pend_post);
> > > +    pending_size = pend_pre + pend_compat + pend_post;
> > >       trace_migrate_pending(pending_size, s->threshold_size,
> > > -                          pend_post, pend_nonpost);
> > > +                          pend_pre, pend_compat, pend_post);
> > >       if (pending_size && pending_size >= s->threshold_size) {
> > >           /* Still a significant amount to transfer */
> > >           if (migrate_postcopy() && !in_postcopy &&
> > > -            pend_nonpost <= s->threshold_size &&
> > > -            atomic_read(&s->start_postcopy)) {
> > > +            pend_pre <= s->threshold_size &&
> > > +            (atomic_read(&s->start_postcopy) ||
> > > +             (pend_pre + pend_compat <= s->threshold_size)))
> > This change does something different from the description;
> > it causes a postcopy_start even if the user never ran the postcopy-start
> > command; so sorry, we can't do that; because postcopy for RAM is
> > something that users can enable but only switch into when they've given
> > up on it completing normally.
> > 
> > However, I guess that leaves you with a problem; which is what happens
> > to the system when you've run out of pend_pre+pend_compat but can't
> > complete because pend_post is non-0; so I don't know the answer to that.
> > 
> > 
> 
> Hmm. Here, we go to postcopy only if "pend_pre + pend_compat <=
> s->threshold_size". Pre-patch, in this case we will go to
> migration_completion(). So, precopy stage is finishing anyway.

Right.

> So, we want
> in this case to finish ram migration like it was finished by
> migration_completion(), and then, run postcopy, which will handle only dirty
> bitmaps, yes?

It's a bit tricky; the first important thing is that we can't change the
semantics of the migration without the 'dirty bitmaps'.

So then there's the question of how  a migration with both
postcopy-ram+dirty bitmaps should work;  again I don't think we should
enter the postcopy-ram phase until start-postcopy is issued.

Then there's the 3rd case; dirty-bitmaps but no postcopy-ram; in that
case I worry less about the semantics of how you want to do it.

> Hmm2. Looked through migration_completion(), I don't understand, how it
> finishes ram migration without postcopy. It calls
> qemu_savevm_state_complete_precopy(), which skips states with
> has_postcopy=true, which is ram...

Because savevm_state_complete_precopy only skips has_postcopy=true in
the in_postcopy case:

            (in_postcopy && se->ops->has_postcopy &&
             se->ops->has_postcopy(se->opaque)) ||

so when we call it in migration_completion(), if we've not entered
postcopy yet, then that test doesn't trigger.

(Apologies for not spotting this earlier; but I thought this patch was
a nice easy one just adding the postcopy_only_pending - I didn't realise it changed
existing semantics until I spotted that)

Dave

> -- 
> Best regards,
> Vladimir
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
