Received: from eggs.gnu.org ([2001:4830:134:3::10]:59724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZBis-0000tK-12
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZBin-0007Dk-LK
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:26:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZBin-0007Ct-Bg
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:26:53 -0500
Date: Wed, 10 Jan 2018 16:26:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110082639.GH5984@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-8-peterx@redhat.com>
	<ab1775ac-be60-31cb-3c7c-c698c2adb1e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab1775ac-be60-31cb-3c7c-c698c2adb1e8@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 07/27] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jan 09, 2018 at 05:13:40PM -0600, Eric Blake wrote:
> On 12/19/2017 02:45 AM, Peter Xu wrote:
> > There are many places for monitor init its globals, at least:
> 
> Reads awkwardly; maybe:
> 
> ...many places where the monitor initializes its globals,...

Fixed.

> 
> > 
> > - monitor_init_qmp_commands() at the very beginning
> > - single function to init monitor_lock
> > - in the first entry of monitor_init() using "is_first_init"
> > 
> > Unify them a bit.
> > 
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> > +void monitor_init_globals(void)
> > +{
> > +    monitor_init_qmp_commands();
> > +    monitor_qapi_event_init();
> > +    sortcmdlist();
> > +    qemu_mutex_init(&monitor_lock);
> > +}
> > +
> >  /* These functions just adapt the readline interface in a typesafe way.  We
> >   * could cast function pointers but that discards compiler checks.
> >   */
> > @@ -4074,23 +4082,10 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap)
> >      }
> >  }
> >  
> > -static void __attribute__((constructor)) monitor_lock_init(void)
> > -{
> > -    qemu_mutex_init(&monitor_lock);
> > -}
> 
> The later initialization of the monitor_lock mutex is a potential
> semantic change.  Please beef up the commit message to document why it
> is safe.  In fact, I requested this back on my review of v1, but it
> still hasn't been done. :(
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05421.html

Sorry for that! I thought you helped proved that somehow (which I
really appreciate)...

> 
> If my read of history is correct, I think it is sufficient to point to
> commit 05875687 as a place where we no longer care about constructor
> semantics because we are no longer dealing with module_call_init().  But
> you may find a better place to point to.  You already found that
> d622cb587 was what introduced the constructor in the first place, but I
> didn't spend time today auditing the state of qemu back at that time to
> see if the constructor was really necessary back then or just a
> convenience for lack of a better initialization point.
> 
> Alternatively, if you can't find a good commit message to point to, at
> least document how you (and I) tested things, using gdb watchpoints, to
> prove it is a safe delay.

I did that by observing all users of the lock in current repository:

*** monitor.c:
monitor_qmp_response_pop_one[457] qemu_mutex_lock(&monitor_lock);
monitor_qmp_response_pop_one[466] qemu_mutex_unlock(&monitor_lock);
monitor_qapi_event_queue[529]  qemu_mutex_lock(&monitor_lock);
monitor_qapi_event_queue[574]  qemu_mutex_unlock(&monitor_lock);
monitor_qapi_event_handler[588] qemu_mutex_lock(&monitor_lock);
monitor_qapi_event_handler[604] qemu_mutex_unlock(&monitor_lock);
monitor_qmp_requests_pop_one[4116] qemu_mutex_lock(&monitor_lock);
monitor_qmp_requests_pop_one[4136] qemu_mutex_unlock(&monitor_lock);
monitor_init[4559]             qemu_mutex_lock(&monitor_lock);
monitor_init[4561]             qemu_mutex_unlock(&monitor_lock);
monitor_cleanup[4596]          qemu_mutex_lock(&monitor_lock);
monitor_cleanup[4603]          qemu_mutex_unlock(&monitor_lock);

monitor_init() and monitor_cleanup() are called after global init, so
it should be fine (monitor_init() is called right after the global
init).

For the rest of the functions:

    monitor_qmp_response_pop_one
    monitor_qapi_event_queue
    monitor_qapi_event_handler
    monitor_qmp_requests_pop_one

AFAIK all of them are called even after monitor_init(), in other
words, they are all after global init too.

As a conclusion, we should be safe here.  Again, I may be wrong
somewhere, please correct me if so.

> 
> Only if you improve the commit message, you may add:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Besides the English fix, how about I add one more paragraph to talk
about monitor_lock in commit message:

  monitor_lock won't be used before monitor_init().  So as long as we
  initialize the monitor globals before the first call to
  monitor_init(), we will be safe.

With that, could I take your r-b?

Thanks,

> 
> > +++ b/vl.c
> > @@ -3099,7 +3099,6 @@ int main(int argc, char **argv, char **envp)
> >      qemu_init_exec_dir(argv[0]);
> >  
> >      module_call_init(MODULE_INIT_QOM);
> > -    monitor_init_qmp_commands();
> >  
> >      qemu_add_opts(&qemu_drive_opts);
> >      qemu_add_drive_opts(&qemu_legacy_drive_opts);
> > @@ -4645,6 +4644,12 @@ int main(int argc, char **argv, char **envp)
> >      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
> >      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> >  
> > +    /*
> > +     * Note: qtest_enabled() (which used in monitor_qapi_event_init())
> 
> s/which/which is/
> 
> > +     * depend on configure_accelerator() above.
> 
> s/depend/depends/
> 
> > +     */
> > +    monitor_init_globals();
> > +
> >      if (qemu_opts_foreach(qemu_find_opts("mon"),
> >                            mon_init_func, NULL, NULL)) {
> >          exit(1);
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 




-- 
Peter Xu
