Received: from eggs.gnu.org ([2001:4830:134:3::10]:35849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlGtb-0004vx-42
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlGtW-0001D2-DY
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:51:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dlGtW-0001C2-5O
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:51:38 -0400
Date: Fri, 25 Aug 2017 16:51:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170825155128.GK2090@work-vm>
References: <20170825141940.20740-1-dgilbert@redhat.com>
	<20170825141940.20740-2-dgilbert@redhat.com>
	<CAFEAcA9kOQ-WYaDSatWKYX82FM=zGb1LJ1a0iu9C2-nu3S=o+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9kOQ-WYaDSatWKYX82FM=zGb1LJ1a0iu9C2-nu3S=o+A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Reset rather than destroy
 main_thread_load_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, shorne@gmail.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 25 August 2017 at 15:19, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > migration_incoming_state_destroy doesn't really destroy, it cleans up.
> > After a loadvm it's called, but the loadvm command can be run twice,
> > and so destroying an init-once mutex breaks on the second loadvm.
> >
> > Reported-by: Stafford Horne <shorne@gmail.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/migration.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index c3fe0ed9ca..a625551ce5 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -167,7 +167,7 @@ void migration_incoming_state_destroy(void)
> >          mis->from_src_file = NULL;
> >      }
> >
> > -    qemu_event_destroy(&mis->main_thread_load_event);
> > +    qemu_event_reset(&mis->main_thread_load_event);
> >  }
> 
> Is it worth doing more here?

In the longer-term, yes;  it seemed right just to get
this bug fixed first though.

> For instance:
>  * rename the function to something that better reflects
>    what it's doing
>  * make sure it actually goes back to the state it's in
>    after you first call migration_incoming_get_current()
>    (eg setting mis_current.state, zeroing various fields)
>  * maybe instead of a "get current state" that does a
>    reset if it's not been called before and a "destroy"
>    that does cleanup stuff (like telling the source we've
>    stopped) and also resetting back to clean state, we
>    could structure this with a function that does
>    "give me a clean completely reset state" which you
>    must call first, then use get_current() purely to
>    get the current state with no 'reset on first call'
>    semantics, and finally a "complete" function that just
>    does the "tell source we've stopped" and close
>    resources we no longer need  ?

Yes; an init/current/clean does make sense;  one of my comments
on one of Peter's patchsets was to point out the
migration_incoming_get_current isn't thread safe if you're
not sure you've already called it, so it could do with fixing.

There has also been a few things that have wanted to gather stats
that are available after the end of an incoming migration;
so we don't really want to destroy that state, we just want
to get rid of anything temporary.

You could argue that this thread_load_event is best init'd
at the start of the incoming migration and then destroyed at the
end.

> PS, in migration_incoming_get_current() we do
>         mis_current.state = MIGRATION_STATUS_NONE;
>         memset(&mis_current, 0, sizeof(MigrationIncomingState));
> 
> and the first line there is pointless because the memset
> blasts zeroes over it anyway.

Hmm yes.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
