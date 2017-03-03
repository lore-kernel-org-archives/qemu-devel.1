Received: from eggs.gnu.org ([2001:4830:134:3::10]:43534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imhy.yang@gmail.com>) id 1cjnz6-0000r4-Du
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imhy.yang@gmail.com>) id 1cjnz4-0006jx-Vg
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:15:04 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:34008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <imhy.yang@gmail.com>) id 1cjnz4-0006ir-O6
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:15:02 -0500
Received: by mail-it0-x22e.google.com with SMTP id 207so1126672ita.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 06:15:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b0de5de-aec7-0388-0a68-cf9e02b48b1d@redhat.com>
References: <33183CC9F5247A488A2544077AF19020DA1D01C2@DGGEMA505-MBX.china.huawei.com>
	<20170303120054.GB2439@work-vm>
	<10d66d73-a269-acb4-bc3d-2250793cba8e@redhat.com>
	<20170303131150.GC2439@work-vm>
	<bcaabb9b-44a6-ee7d-14b9-eade207e1538@redhat.com>
	<20170303132653.GD2439@work-vm>
	<4b0de5de-aec7-0388-0a68-cf9e02b48b1d@redhat.com>
From: Yang Hongyang <imhy.yang@gmail.com>
Date: Fri, 3 Mar 2017 22:15:01 +0800
Message-ID: <CAN+wFuLLRhTvAdVvPe0xS1_tX95MJMYu9BMGbXahb_=eRkhFVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug?] BQL about live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>

Hi Paolo,

On Fri, Mar 3, 2017 at 9:33 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 03/03/2017 14:26, Dr. David Alan Gilbert wrote:
> > * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >>
> >>
> >> On 03/03/2017 14:11, Dr. David Alan Gilbert wrote:
> >>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >>>>
> >>>>
> >>>> On 03/03/2017 13:00, Dr. David Alan Gilbert wrote:
> >>>>> Ouch that's pretty nasty; I remember Paolo explaining to me a while
> ago that
> >>>>> their were times when run_on_cpu would have to drop the BQL and I
> worried about it,
> >>>>> but this is the 1st time I've seen an error due to it.
> >>>>>
> >>>>> Do you know what the migration state was at that point? Was it
> MIGRATION_STATUS_CANCELLING?
> >>>>> I'm thinking perhaps we should stop 'cont' from continuing while
> migration is in
> >>>>> MIGRATION_STATUS_CANCELLING.  Do we send an event when we hit
> CANCELLED - so that
> >>>>> perhaps libvirt could avoid sending the 'cont' until then?
> >>>>
> >>>> No, there's no event, though I thought libvirt would poll until
> >>>> "query-migrate" returns the cancelled state.  Of course that is a
> small
> >>>> consolation, because a segfault is unacceptable.
> >>>
> >>> I think you might get an event if you set the new migrate capability
> called
> >>> 'events' on!
> >>>
> >>> void migrate_set_state(int *state, int old_state, int new_state)
> >>> {
> >>>     if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
> >>>         trace_migrate_set_state(new_state);
> >>>         migrate_generate_event(new_state);
> >>>     }
> >>> }
> >>>
> >>> static void migrate_generate_event(int new_state)
> >>> {
> >>>     if (migrate_use_events()) {
> >>>         qapi_event_send_migration(new_state, &error_abort);
> >>>     }
> >>> }
> >>>
> >>> That event feature went in sometime after 2.3.0.
> >>>
> >>>> One possibility is to suspend the monitor in qmp_migrate_cancel and
> >>>> resume it (with add_migration_state_change_notifier) when we hit the
> >>>> CANCELLED state.  I'm not sure what the latency would be between the
> end
> >>>> of migrate_fd_cancel and finally reaching CANCELLED.
> >>>
> >>> I don't like suspending monitors; it can potentially take quite a
> significant
> >>> time to do a cancel.
> >>> How about making 'cont' fail if we're in CANCELLING?
> >>
> >> Actually I thought that would be the case already (in fact CANCELLING is
> >> internal only; the outside world sees it as "active" in query-migrate).
> >>
> >> Lei, what is the runstate?  (That is, why did cont succeed at all)?
> >
> > I suspect it's RUN_STATE_FINISH_MIGRATE - we set that before we do the
> device
> > save, and that's what we get at the end of a migrate and it's legal to
> restart
> > from there.
>
> Yeah, but I think we get there at the end of a failed migrate only.  So
> perhaps we can introduce a new state RUN_STATE_FAILED_MIGRATE


I think we do not need to introduce a new state here. If we hit 'cont' and
the run state is RUN_STATE_FINISH_MIGRATE, we could assume that
migration failed because 'RUN_STATE_FINISH_MIGRATE' only exists on
source side, means we are finishing migration, a 'cont' at the meantime
indicates that we are rolling back, otherwise source side should be
destroyed.


> and forbid
> "cont" from finish-migrate (only allow it from failed-migrate)?
>

The problem of forbid 'cont' here is that it will result in a failed
migration and the source
side will remain paused. We actually expect a usable guest when rollback.
Is there a way to kill migration thread when we're under main thread, if
there is, we
could do the following to solve this problem:
1. 'cont' received during runstate RUN_STATE_FINISH_MIGRATE
2. kill migration thread
3. vm_start()

But this only solves 'cont' problem. As Dave said before, other things could
happen during the small windows while we are finishing migration, that's
what I was worried about...


> Paolo
>
> >> Paolo
> >>
> >>> I'd really love to see the 'run_on_cpu' being more careful about the
> BQL;
> >>> we really need all of the rest of the devices to stay quiesced at
> times.
> >>
> >> That's not really possible, because of how condition variables work. :(
> >
> > *Really* we need to find a solution to that - there's probably lots of
> > other things that can spring up in that small window other than the
> > 'cont'.
> >
> > Dave
> >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>
>
