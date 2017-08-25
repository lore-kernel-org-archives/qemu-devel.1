Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dl6BE-0002qs-6d
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dl6BB-0006Kt-0n
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dl6BA-0006Ic-O5
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:25:08 -0400
Date: Fri, 25 Aug 2017 12:25:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170825042502.GD14174@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<20170823173534.GF2648@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170823173534.GF2648@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 2/8] monitor: allow monitor to create
 thread to poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Aug 23, 2017 at 06:35:35PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Firstly, introduce Monitor.use_thread, and set it for monitors that are
> > using non-mux typed backend chardev.  We only do this for monitors, so
> > mux-typed chardevs are not suitable (when it connects to, e.g., serials
> > and the monitor together).
> > 
> > When use_thread is set, we create standalone thread to poll the monitor
> > events, isolated from the main loop thread.  Here we still need to take
> > the BQL before dispatching the tasks since some of the monitor commands
> > are not allowed to execute without the protection of BQL.  Then this
> > gives us the chance to avoid taking the BQL for some monitor commands in
> > the future.
> > 
> > * Why this change?
> > 
> > We need these per-monitor threads to make sure we can have at least one
> > monitor that will never stuck (that can receive further monitor
> > commands).
> > 
> > * So when will monitors stuck?  And, how do they stuck?
> 
> (Minor: 'stuck' is past tense, 'stick' is probably the right word; however
> 'block' is probably what you actually want)

Yet another English error.  Thanks! :-)

(I guess "monitors get stuck" should also work?)

> 
> > After we have postcopy and remote page faults, it's simple to achieve a
> > stuck in the monitor (which is also a stuck in main loop thread):
> > 
> > (1) Monitor deadlock on BQL
> > 
> > As we may know, when postcopy is running on destination VM, the vcpu
> > threads can stuck merely any time as long as it tries to access an
> > uncopied guest page.  Meanwhile, when the stuck happens, it is possible
> > that the vcpu thread is holding the BQL.  If the page fault is not
> > handled quickly, you'll find that monitors stop working, which is trying
> > to take the BQL.
> > 
> > If the page fault cannot be handled correctly (one case is a paused
> > postcopy, when network is temporarily down), monitors will hang
> > forever.  Without current patch, that means the main loop hanged.  We'll
> > never find a way to talk to VM again.
> > 
> > (2) Monitor tries to run codes page-faulted vcpus
> > 
> > The HMP command "info cpus" is one of the good example - it tries to
> > kick all the vcpus and sync status from them.  However, if there is any
> > vcpu that stuck at an unhandled page fault, it can never achieve the
> > sync, then the HMP hangs.  Again, it hangs the main loop thread as well.
> > 
> > After either (1) or (2), we can see the deadlock problem:
> > 
> > - On one hand, if monitor hangs, we cannot do the postcopy recovery,
> >   because postcopy recovery needs user to specify new listening port on
> >   destination monitor.
> > 
> > - On the other hand, if we cannot recover the paused postcopy, then page
> >   faults cannot be serviced, and the monitors will possibly hang
> >   forever then.
> > 
> > * How this patch helps?
> > 
> > - Firstly, we'll have our own thread for each dedicated monitor (or say,
> >   the backend chardev is only used for monitor), so even main loop
> >   thread hangs (it is always possible), this monitor thread may still
> >   survive.
> > 
> > - Not all monitor commands need the BQL.  We can selectively take the
> >   BQL (depends on which command we are running) to avoid waiting on a
> >   page-faulted vcpu thread that has taken the BQL (this will be done in
> >   following up patches).
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> A few high level things:
>   a) I think this patch probably wants to split into
>      1) A patch that decides whether to create a new thread and
>      initialises it
>      2) One that starts to fix up the locking

Sure.

> 
>   b) I think you also need to take the bql around any of the custom
>      completion functions; (maybe in monitor_find_completion ?)
>      since they do things like walk the lists of devices.

Ah, yes.  Actually IMHO those completions should be protected by
smaller locks as well.  Considering this only affects HMP, how about
this: when "without-bql" is set for a command, it should mean that the
whole command does not need BQL, this should include not only the
command execution part, but also the command auto completion routine.
So I take the BQL in the completion only for those whose "without-bql"
is unset, like the trick played for the command execution part.

For the only command "migrate_incoming", it does not have completion
routine, so "without-bql=true" still applies.

Or would you prefer I just take the lock unconditionally?

> 
>   c) As mentioned on irc there's fun to be had with cur_mon and error
>      handling - in my local world I have cur_mon declared as __thread
>      but never got around to thinking aobut what should set it up.
>      There's also 'wavcapture: Convert to error_report' that I posted
>      in March that got rid of some uses of cur_mon in wavcapture.c
>      for error_report.

Yeh.  I at least also see a positive ACK from Markus in the other
thread for per-thread cur_mon, sounds like this is the right way to
go.

To setup cur_mon, what I can think of is create wrapper for
pthread_create() in qemu_thread_create().  I see that we have done
similar thing in util/qemu-thread-win32.c for Windows.  With that we
can setup the cur_mon before going into real thread function but in
the right context, though we may need one more parameter for current
qemu_thread_create():

void qemu_thread_create(QemuThread *thread, const char *name,
                       void *(*start_routine)(void*),
                       void *arg, int mode, Monitor *mon);

Then we can specify monitor for any new thread (default to cur_mon).
For per-monitor threads, I think we need to pass in that specific mon.

Is this doable?

> But there's some interesting stuff to be checked
>      with where error_reporting goes.

Do you mean the case when e.g. we only have one HMP and that HMP is
threaded?  If so, I guess the error_report()s will be directed mostly
to stderr.

I believe it'll break some HMP users, but IIUC HMP behavior is allowed
to be changed and after all people can still catch the error message
somewhere, though outside that HMP console.  So I think it might be ok.

> 
>   d) I wonder if it's better to have thread as a flag, so that you have
>      to explicitly ask for a monitor to have it's own thread.

This should be doable.  Would a new parameter for "-qmp" and "-hmp"
suffice?

-- 
Peter Xu
