Received: from eggs.gnu.org ([2001:4830:134:3::10]:34246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f66Hb-0005Il-4f
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f66HX-00087s-Tn
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:18:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f66HX-00087e-NL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:18:47 -0400
Date: Wed, 11 Apr 2018 11:18:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180411031826.GA13887@xz-mi>
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-2-peterx@redhat.com>
	<63211daf-4cda-163c-cb45-6fa3ac7e3cc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63211daf-4cda-163c-cb45-6fa3ac7e3cc5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-thread: always keep the posix
 wrapper layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Apr 10, 2018 at 08:35:40AM -0500, Eric Blake wrote:
> On 04/10/2018 07:49 AM, Peter Xu wrote:
> > We will conditionally have a wrapper layer depending on whether the host
> > has the PTHREAD_SETNAME capability.  It complicates stuff.  Let's just
> > keep the wrapper there, meanwhile we opt out the pthread_setname_np()
> > call only.  The layer can be helpful in future patches to pass data from
> > the parent thread to the child thread.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  util/qemu-thread-posix.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> > 
> > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > index b789cf32e9..3ae96210d6 100644
> > --- a/util/qemu-thread-posix.c
> > +++ b/util/qemu-thread-posix.c
> > @@ -482,7 +482,6 @@ static void __attribute__((constructor)) qemu_thread_atexit_init(void)
> >  }
> >  
> 
> More context:
> 
> static bool name_threads;
> 
> void qemu_thread_naming(bool enable)
> {
>     name_threads = enable;
> 
> #ifndef CONFIG_THREAD_SETNAME_BYTHREAD
>     /* This is a debugging option, not fatal */
>     if (enable) {
>         fprintf(stderr, "qemu: thread naming not supported on this host\n");
>     }
> #endif
> }
> 
> 
> >  
> > -#ifdef CONFIG_PTHREAD_SETNAME_NP
> 
> Why are we using CONFIG_THREAD_SETNAME_BYTHREAD in one place, and
> CONFIG_PTHREAD_SETNAME_NP in another?
> 
> /me checks configure - oh:
> 
> # Hold two types of flag:
> #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
> #                                     a thread we have a handle to
> #   CONFIG_PTHREAD_SETNAME_NP       - A way of doing it on a particular
> #                                     platform
> 
> even though, right now, we only either set both flags at once or leave
> both clear, since we don't (yet?) have any other platform-specific ways
> to do it.

It seems so.  I'm not sure whether they could be useful in the future
and I'm fine with them, hence I keep it as is.

> 
> >  typedef struct {
> >      void *(*start_routine)(void *);
> >      void *arg;
> > @@ -498,13 +497,15 @@ static void *qemu_thread_start(void *args)
> >      /* Attempt to set the threads name; note that this is for debug, so
> >       * we're not going to fail if we can't set it.
> >       */
> > -    pthread_setname_np(pthread_self(), qemu_thread_args->name);
> > +#ifdef CONFIG_PTHREAD_SETNAME_NP
> > +    if (qemu_thread_args->name) {
> > +        pthread_setname_np(pthread_self(), qemu_thread_args->name);
> 
> Post-patch, this (attempts to) set the thread name if a non-NULL name is
> present...
> 
> 
> >  
> > -#ifdef CONFIG_PTHREAD_SETNAME_NP
> > -    if (name_threads) {
> > -        QemuThreadArgs *qemu_thread_args;
> > -        qemu_thread_args = g_new0(QemuThreadArgs, 1);
> > -        qemu_thread_args->name = g_strdup(name);
> 
> ...but pre-patch, qemu_thread_args->name was left NULL unless
> name_threads was true, because someone had called
> qemu_thread_naming(true)...
> 
> > -        qemu_thread_args->start_routine = start_routine;
> > -        qemu_thread_args->arg = arg;
> > -
> > -        err = pthread_create(&thread->thread, &attr,
> > -                             qemu_thread_start, qemu_thread_args);
> > -    } else
> > -#endif
> > -    {
> > -        err = pthread_create(&thread->thread, &attr,
> > -                             start_routine, arg);
> > -    }
> > +    qemu_thread_args = g_new0(QemuThreadArgs, 1);
> > +    qemu_thread_args->name = g_strdup(name);
> 
> ...so you have changed semantics - you are now unconditionally trying to
> set the thread name, instead of honoring qemu_thread_naming().  Do we
> still need qemu_thread_naming() (tied to opt debug-threads)?
> 
> You need to either fix your code to remain conditional on whether
> name_threads is set, or document the semantic change as intentional in
> the commit message.

Indeed, thanks for catching that. What I really wanted is probably
this:

static void *qemu_thread_start(void *args)
{
    ...
#ifdef CONFIG_PTHREAD_SETNAME_NP
    if (name_threads && qemu_thread_args->name) {
        pthread_setname_np(pthread_self(), qemu_thread_args->name);
    }
#endif
    ...
}

I'll fix that up in next version.

> 
> However, the idea for refactoring to always use the shim makes sense.

Thanks,

-- 
Peter Xu
