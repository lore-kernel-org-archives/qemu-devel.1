Received: from eggs.gnu.org ([2001:4830:134:3::10]:56087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNjrJ-00057S-G7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNjrG-0002ep-9j
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:00:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fNjrF-0002eQ-RI
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:00:33 -0400
Date: Tue, 29 May 2018 20:00:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180529190027.GE2575@work-vm>
References: <20180521084249.10640-1-peterx@redhat.com>
	<8ef2c984-7817-a54f-ebae-a1f14e453b6a@redhat.com>
	<20180522033954.GC17282@xz-mi> <87y3g9a5th.fsf@dusky.pond.sub.org>
	<20180524073428.GC12122@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524073428.GC12122@xz-mi>
Subject: Re: [Qemu-devel] [RFC] monitor: turn on Out-Of-Band by default again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, May 24, 2018 at 09:08:58AM +0200, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Mon, May 21, 2018 at 09:13:06AM -0500, Eric Blake wrote:
> > >> On 05/21/2018 03:42 AM, Peter Xu wrote:
> > >> > We turned Out-Of-Band feature of monitors off for 2.12 release.  Now we
> > >> > try to turn that on again.
> > >> 
> > >> "try to turn" sounds weak, like you aren't sure of this patch.  If you
> > >> aren't sure, then why should we feel safe in applying it?  This text is
> > >> going in the permanent git history, so sound bold, rather than hesitant!
> > >
> > > Yeah I am not really strong at turn that on by default, that's why I
> > > marked the patch as RFC.  I wanted to hear from your opinions.  For
> > > now IMHO even with x-oob, postcopy can start to work with network
> > > recovery, then the requirement from my part is done.  However I'm
> > > thinking maybe we should still turn that on for all the people.  One
> > > reason is that we already have the QMP capability negotiation so it
> > > seems redundant (as you mentioned before), meanwhile exposing it to
> > > broader users can let broader users to leverage this new bits directly
> > > (meanwhile easier to expose potential issues for OOB too).
> > >
> > > Meanwhile I'm not confident too on that there can be other test cases
> > > that has not yet been run with Out-Of-Band, so even if we solved all
> > > existing problems I can't be sure that no further test will broke.
> > > However I don't see it a problem for merging, since AFAIU I can't
> > > really know what will break again (if there is) unless we apply that
> > > to master again... :)
> > 
> > The time to switch it on is now.  I don't think we can find remaining
> > issues (if any) unless we do.
> > 
> > The time for doubts is the day before rc0 ;)
> 
> Haha. I bet you are right. :)
> 
> > 
> > >> "We have resolved the issues from last time (commit 3fd2457d reverted by
> > >> commit a4f90923):
> > >> - issue 1 ...
> > >> - issue 2 ...
> > >> So now we are ready to enable advertisement of the feature by default"
> > >> 
> > >> with better descriptions of the issues that you fixed (I can think of at
> > >> least the fixes adding thread-safety to the current monitor, and fixing
> > >> early use of the monitor before qmp_capabilities completes; there may also
> > >> be other issues that you want to call out).
> > >
> > > Some of the monitor patches are not really related to previous OOB
> > > breakage, the only one that really matters should be the ARM+Libvirt
> > > one, which I will definitely mention in my next post.  The rest
> > > (including per-thread cur_mon, monitor thread-safety, etc.) should
> > > mostly for future new commands of Out-Of-Band but not for now.  For
> > > example, current OOB commands are rare, now they don't use the
> > > get_fd()/set_fd() interface, then the mon_fdsets won't need to be
> > > protected at all.
> > 
> > A lock works only when all its critical sections are guaranteed to
> > execute quickly!  Remember, for OOB to work, all OOB commands must
> > execute quickly, always.  Rule of thumb: treat OOB command code like
> > realtime code.
> 
> Yes indeed I suspect the realtime work will have similar requirements.
> It's a funny experience that we do realtime-alike considerations in
> QEMU's control path. :)
> 
> I believe that's why Dave pointed out that when taking the mon_fdsets
> lock (in the other patchset) we can't call close().  That's a good
> lesson.

I don't worry too much about the length of time; what I worry about 
is things that might actually hang (OK, a TCP timeout is too long
a length of time!); so things like close and other things that work
on sockets are just asking for trouble.
I wish there was a way we could annotate code called from OOB
context and get some tools to automatically spot problems!

Dave

> (and I just noticed I forgot to CC Dave for this...; adding in)
> 
> > 
> > >                    But we can't guarantee that new OOB commands won't
> > > use them too, so we still need to protect them with locks.
> > 
> > When creating or modifying an OOB command, you need to be extra careful
> > about shared state: you may have to add suitable synchronization.
> > 
> > Please add suitable warnings about use of allow-oob to
> > docs/qapi-code-gen.txt.  Perhaps even a separate document on OOB,
> > pointed to by qapi-code-gen.txt.
> 
> Maybe append another bullet to existing?
> 
> ==================
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index b9b6eabd08..13f86095d1 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -680,6 +680,9 @@ OOB command handlers must satisfy the following conditions:
>  - It does not invoke system calls that may block,
>  - It does not access guest RAM that may block when userfaultfd is
>    enabled for postcopy live migration.
> +- It needs to protect possible shared states, since as long as a
> +  command supports Out-Of-Band it means the handler can be run in
> +  parallel with the same handler running in the other thread.
>  
>  If in doubt, do not implement OOB execution support.
> ==================
> 
> > 
> > >> > 
> > >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > >> > --
> > >> > Now OOB should be okay with all known tests (except iotest qcow2, since
> > >> > it is still broken on master),
> > >> 
> > >> Which tests are still failing for you?  Ideally, you can still demonstrate
> > >> that the tests not failing without this patch continue to pass with this
> > >> patch, even if you call out the tests that have known issues to still be
> > >> resolved.
> > >
> > > I didn't remember.  We can first settle down on whether we'd like to
> > > turn on this default value, then I can perform this test for my next
> > > post to make sure good tests won't break.
> > >
> > >> 
> > >> > and AFAIK now we should also be okay with
> > >> > ARM+Libvirt (not testsed, but Eric Auger helped to verify that before
> > >> > the release).  So I think it's now safe to turn OOB on again.  Please
> > >> > feel free to test this against any of existing testsuites to see whether
> > >> > it'll still break any stuff.  Thanks,
> > >> > 
> > >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > >> > ---
> > >> >   monitor.c        | 13 +++----------
> > >> >   tests/qmp-test.c |  2 +-
> > >> >   vl.c             |  9 ++++-----
> > >> >   3 files changed, 8 insertions(+), 16 deletions(-)
> > >> > 
> > >> > diff --git a/monitor.c b/monitor.c
> > >> > index 46814af533..ce5cc5e34e 100644
> > >> > --- a/monitor.c
> > >> > +++ b/monitor.c
> > >> > @@ -4560,16 +4560,9 @@ void monitor_init(Chardev *chr, int flags)
> > >> >       bool use_readline = flags & MONITOR_USE_READLINE;
> > >> >       bool use_oob = flags & MONITOR_USE_OOB;
> > >> > -    if (use_oob) {
> > >> > -        if (CHARDEV_IS_MUX(chr)) {
> > >> > -            error_report("Monitor Out-Of-Band is not supported with "
> > >> > -                         "MUX typed chardev backend");
> > >> > -            exit(1);
> > >> > -        }
> > >> > -        if (use_readline) {
> > >> > -            error_report("Monitor Out-Of-band is only supported by QMP");
> > >> > -            exit(1);
> > >> > -        }
> > >> > +    if (CHARDEV_IS_MUX(chr)) {
> > >> > +        /* MUX is still not supported for Out-Of-Band */
> > >> > +        use_oob = false;
> > >> 
> > >> This isn't a mere reinstatement of 3fd2457d, but is now advertising OOB when
> > >> using readline (which presumably is a synonym for using HMP).
> > 
> > It effectively is a synonm now, but exploiting it would be unclean.  The
> > clean test for HMP is !(flags & MONITOR_USE_CONTROL).
> > 
> > >>                                                                Is that
> > >> intentional?  If so, the commit message should mention it.
> > >
> > > At [1] below I directly moved the chunk into "mode=control" path, so
> > > the QMP check is already there.  Here I turn OOB off explicitly for
> > > MUX no matter HMP/QMP.  It should have the same affect as 3fd2457d.
> > 
> > Switching off OOB silently for mux'ed chardev is ugly.  But I don't have
> > better ideas.
> > 
> > What's keeping us from supporting OOB there?
> 
> Monitor is only a single chardev frontend.  The whole OOB work allows
> monitor frontend to run isolatedly, but it never applies to any other
> frontend.  Considering that MUX can support arbitrary frontends to
> share the single backend chardev, I suppose "supporting OOB for MUX"
> basically means to support OOB for every existing chardev frontend...
> 
> > 
> > Is anyone using QMP over a mux'ed chardev in anger?  I guess we don't
> > know.
> 
> IMHO it will be fine even for anyone who likes MUXed - he/she just
> needs an extra QMP channel only for OOB.
> 
> (Or would the anger be a good driving force to push someone to add
>  complete support for Out-Of-Band?  I confess, I am not angry
>  enough... :)
> 
> > 
> > >> >       }
> > >> >       monitor_data_init(mon, false, use_oob);
> > >> > diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> > >> > index 88f867f8c0..c85a3964d9 100644
> > >> > --- a/tests/qmp-test.c
> > >> > +++ b/tests/qmp-test.c
> > >> > @@ -89,7 +89,7 @@ static void test_qmp_protocol(void)
> > >> >       g_assert(q);
> > >> >       test_version(qdict_get(q, "version"));
> > >> >       capabilities = qdict_get_qlist(q, "capabilities");
> > >> > -    g_assert(capabilities && qlist_empty(capabilities));
> > >> > +    g_assert(capabilities);
> > >> >       qobject_unref(resp);
> > >> >       /* Test valid command before handshake */
> > 
> > Let's check contents of @capabilities matches expectations.
> 
> It'll be checked in the other OOB specified test (test_qmp_oob).
> 
> > 
> > >> > diff --git a/vl.c b/vl.c
> > >> > index 3b39bbd7a8..b71fb8eb25 100644
> > >> > --- a/vl.c
> > >> > +++ b/vl.c
> > >> > @@ -2394,6 +2394,10 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
> > >> >           flags = MONITOR_USE_READLINE;
> > >> >       } else if (strcmp(mode, "control") == 0) {
> > >> >           flags = MONITOR_USE_CONTROL;
> > >> > +        /* Out-Of-Band is on by default */
> > >> > +        if (qemu_opt_get_bool(opts, "x-oob", 1)) {
> > >> > +            flags |= MONITOR_USE_OOB;
> > >> > +        }
> > >
> > > [1]
> > >
> > >> 
> > >> Do we really still need the x-oob property, vs. outright deletion of this
> > >> bandaid?  Then again, I guess keeping it for one more release makes it
> > >> easier to forcefully turn things off for temporary testing when isolating
> > >> whether OOB is a culprit in something breaking.
> > >
> > > Yes, since we already have it, I didn't have strong opinion to remove
> > > it, so I kept it.  Actually now we can't turn OOB off completely
> > > already - it's fully embeded in QMP internal logic (e.g., now we'll
> > > always have completely isolated parser, dispatcher, responder; we
> > > can't go back to the old func-call ways any more).  So maybe I can
> > > remove that parameter directly next time.
> > 
> > I'm leaning towards removing it, because:
> > 
> > * There's no test coverage for x-oob=off
> > 
> > * We already have a way to disable OOB: the QMP client can decline the
> >   capability
> > 
> > * MONITOR_USE_OOB makes monitor flags even uglier: of the four flag
> >   bits' sixteen combinations, only a few actually occur:
> > 
> >     MONITOR_USE_READLINE  on   off
> >     MONITOR_USE_CONTROL   off  on
> >     MONITOR_USE_PRETTY    N/A  either
> >     MONITOR_USE_OOB       N/A  on unless mux'ed
> > 
> >   That's just three genuine configurations (HMP, QMP, pretty QMP), if we
> >   ignore the "mux'ed can't do OOB, yet" bit.
> > 
> >   Without x-oob, we can drop MONITOR_USE_OOB, I think.
> 
> Yes, let me remove it.
> 
> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
