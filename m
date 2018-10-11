Received: from eggs.gnu.org ([2001:4830:134:3::10]:39403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAUUa-0006Vh-Nr
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAUUW-00069G-TR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAUUV-00067F-Rj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 02:30:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180928075832.18586-1-w.bumiller@proxmox.com>
	<20180928075832.18586-3-w.bumiller@proxmox.com>
	<CAJ+F1CL4S8aLm6ayu7GfKMfySTBTuUS3j2cuni-+ErEp5Y8VLQ@mail.gmail.com>
	<20180928095543.GN9560@xz-x1>
Date: Thu, 11 Oct 2018 08:30:24 +0200
In-Reply-To: <20180928095543.GN9560@xz-x1> (Peter Xu's message of "Fri, 28 Sep
	2018 17:55:43 +0800")
Message-ID: <87r2gx8073.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] monitor: delay monitor iothread
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, w.bumiller@proxmox.com, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Fri, Sep 28, 2018 at 01:00:26PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>=20
>> On Fri, Sep 28, 2018 at 12:02 PM Wolfgang Bumiller
>> <w.bumiller@proxmox.com> wrote:
>> >
>> > Commit d32749deb615 moved the call to monitor_init_globals()
>> > to before os_daemonize(), making it an unsuitable place to
>> > spawn the monitor iothread as it won't be inherited over the
>> > fork() in os_daemonize().
>> >
>> > We now spawn the thread the first time we instantiate a
>> > monitor which actually has use_io_thread =3D=3D true. Therefore
>> > mon_iothread initialization is protected by monitor_lock.
>> >
>> > We still need to create the qmp_dispatcher_bh when not using
>> > iothreads, so this now still happens via
>> > monitor_init_globals().
>> >
>> > Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
>> > Fixes: d32749deb615 ("monitor: move init global earlier")
>> > ---
>> > Changes to v1:
>> >  - move mon_iothread declaration down to monitor_lock's declaration
>> >    (updating monitor_lock's coverage comment)
>> >  - in monitor_data_init() assert() that mon_iothread is not NULL or
>> >    not used instead of initializing it there, as its usage pattern is
>> >    so that it is a initialized once before being used, or never used
>> >    at all.
>> >  - in monitor_iothread_init(), protect mon_iothread initialization
>> >    with monitor_lock
>> >  - in monitor_init(): run monitor_ithread_init() in the `use_oob`
>> >    branch.
>> >    Note that I currently also test for mon_iothread being NULL there,
>> >    which we could leave this out as spawning new monitors isn't
>> >    something that happens a lot, but I like the idea of avoiding
>> >    taking a lock when not required.
>> >    Otherwise, I can send a v3 with this removed.
>> >
>> >  monitor.c | 49 ++++++++++++++++++++++++++++++-------------------
>> >  1 file changed, 30 insertions(+), 19 deletions(-)
>> >
>> > diff --git a/monitor.c b/monitor.c
>> > index d47e4259fd..870584a548 100644
>> > --- a/monitor.c
>> > +++ b/monitor.c
>> > @@ -239,9 +239,6 @@ struct Monitor {
>> >      int mux_out;
>> >  };
>> >
>> > -/* Shared monitor I/O thread */
>> > -IOThread *mon_iothread;
>> > -
>> >  /* Bottom half to dispatch the requests received from I/O thread */
>> >  QEMUBH *qmp_dispatcher_bh;
>> >
>> > @@ -262,10 +259,11 @@ typedef struct QMPRequest QMPRequest;
>> >  /* QMP checker flags */
>> >  #define QMP_ACCEPT_UNKNOWNS 1
>> >
>> > -/* Protects mon_list, monitor_qapi_event_state.  */
>> > +/* Protects mon_list, monitor_qapi_event_state and mon_iothread. */
>> >  static QemuMutex monitor_lock;
>> >  static GHashTable *monitor_qapi_event_state;
>> >  static QTAILQ_HEAD(mon_list, Monitor) mon_list;
>> > +IOThread *mon_iothread; /* Shared monitor I/O thread */
>> >
>> >  /* Protects mon_fdsets */
>> >  static QemuMutex mon_fdsets_lock;
>> > @@ -710,6 +708,7 @@ static void handle_hmp_command(Monitor *mon, const=
 char *cmdline);
>> >  static void monitor_data_init(Monitor *mon, bool skip_flush,
>> >                                bool use_io_thread)
>> >  {
>> > +    assert(!use_io_thread || mon_iothread);
>> >      memset(mon, 0, sizeof(Monitor));
>> >      qemu_mutex_init(&mon->mon_lock);
>> >      qemu_mutex_init(&mon->qmp.qmp_queue_lock);
>> > @@ -4453,16 +4452,11 @@ static AioContext *monitor_get_aio_context(voi=
d)
>> >
>> >  static void monitor_iothread_init(void)
>> >  {
>> > -    mon_iothread =3D iothread_create("mon_iothread", &error_abort);
>> > -
>> > -    /*
>> > -     * The dispatcher BH must run in the main loop thread, since we
>> > -     * have commands assuming that context.  It would be nice to get
>> > -     * rid of those assumptions.
>> > -     */
>> > -    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
>> > -                                   monitor_qmp_bh_dispatcher,
>> > -                                   NULL);
>> > +    qemu_mutex_lock(&monitor_lock);
>> > +    if (!mon_iothread) {
>> > +        mon_iothread =3D iothread_create("mon_iothread", &error_abort=
);
>> > +    }
>> > +    qemu_mutex_unlock(&monitor_lock);
>> >  }
>> >
>> >  void monitor_init_globals(void)
>> > @@ -4472,7 +4466,15 @@ void monitor_init_globals(void)
>> >      sortcmdlist();
>> >      qemu_mutex_init(&monitor_lock);
>> >      qemu_mutex_init(&mon_fdsets_lock);
>> > -    monitor_iothread_init();
>> > +
>> > +    /*
>> > +     * The dispatcher BH must run in the main loop thread, since we
>> > +     * have commands assuming that context.  It would be nice to get
>> > +     * rid of those assumptions.
>> > +     */
>> > +    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
>> > +                                   monitor_qmp_bh_dispatcher,
>> > +                                   NULL);
>> >  }
>> >
>> >  /* These functions just adapt the readline interface in a typesafe wa=
y.  We
>> > @@ -4535,6 +4537,9 @@ static void monitor_qmp_setup_handlers_bh(void *=
opaque)
>> >      monitor_list_append(mon);
>> >  }
>> >
>> > +/*
>> > + * This expects to be run in the main thread.
>> > + */
>>=20
>> I read that Markus suggested that comment, but I don't really get why.
>>=20
>> It means that callers (chardev new) should also be restricted to main th=
read.
>
> My understanding is that Markus mentioned about uncertainty on the
> chardev creation paths.  Though AFAIU if we're with the lock then we
> don't need this comment at all, do we?

The conversation (Message-ID: <87d0sz86f8.fsf@dusky.pond.sub.org>) was:

    Peter Xu <peterx@redhat.com> writes:

    > On Thu, Sep 27, 2018 at 10:46:34AM +0200, Markus Armbruster wrote:
    [...]
    >> Should we put @mon_iothread under @monitor_lock?
    >
    > IMHO we can when we create the thread.  I guess we don't need that
    > lock when reading @mon_iothread, after all it's a very special
    > variable in that:
    >
    >  - it is only set once, or never
    >
    >  - when reading @mon_iothread only, we must have it set or it should
    >    be a programming error, so it's more like an assert(mon_iothread)
    >    not a contention
    >
    >>=20
    >> Could we accept this patch without doing that, on the theory that it
    >> doesn't make things worse than they already are?
    >
    > If this bothers us that much, how about we just choose the option that
    > Wolfgang offered at [1] above to create the iothread after daemonize
    > (so we pick that out from monitor_global_init)?

    I'd prefer this patch's approach, because it keeps the interface
    simpler.

v2 uses this approach.

    I can accept this patch as is, or with my incremental patch squashed
    in.  A comment explaining monitor_init() expects to run in the main
    thread would be nice.

Acceptable alternative 1, with a few optional variations.

The comment makes sense because if monitor_init can run in other
threads, the creation of @iothread is racy.  Acceptable since it's
really no worse than before (see the full message for why).

    I'd also accept a patch that wraps

            if (!mon_iothread) {
                monitor_iothread_init();
            }

    in a critical section.  Using @monitor_lock is fine.  A new lock feels
    unnecessarily fine-grained.  If using @monitor_lock, move the definition
    of @mon_iothread next to @monitor_lock, and update the comment there.

Acceptable alternative 2.

v2 appears to combine both alternatives.  Not what I asked for.  I
figure the comment still makes sense, since @iothread creation is just
one of the issues, and protecting it with a lock leaves the other issues
unaddressed.

If we actually run it in other threads, the comment needs to be
augmented with a suitable FIXME stating the problem.

Marc-Andr=C3=A9, does this make sense?

>>=20
>> >  void monitor_init(Chardev *chr, int flags)
>> >  {
>> >      Monitor *mon =3D g_malloc(sizeof(*mon));
>> > @@ -4551,6 +4556,9 @@ void monitor_init(Chardev *chr, int flags)
>> >              error_report("Monitor out-of-band is only supported by QM=
P");
>> >              exit(1);
>> >          }
>> > +        if (!mon_iothread) {
>> > +            monitor_iothread_init();
>> > +        }
>>=20
>> I would call it unconditonnally, to avoid TOCTOU.
>
> Yeh agree that the "if" could be omitted; though there shouldn't be
> toctou since the function will check it again.

Really?

[...]
>> >      }
>> >
>> >      monitor_data_init(mon, false, use_oob);
>> > @@ -4607,7 +4615,9 @@ void monitor_cleanup(void)
>> >       * we need to unregister from chardev below in
>> >       * monitor_data_destroy(), and chardev is not thread-safe yet
>> >       */
>> > -    iothread_stop(mon_iothread);
>> > +    if (mon_iothread) {
>> > +        iothread_stop(mon_iothread);
>> > +    }
>> >
>>=20
>> here the monitor_lock isn't taken, is there a reason worth a comment?

I don't know.  What I know is that locking something only some of the
times (not counting a single-threaded initial stretch of initialization
code) is usually wrong.

>> >      /* Flush output buffers and destroy monitors */
>> >      qemu_mutex_lock(&monitor_lock);
[...]

Since the bug is inconveniencing people, should I merge v1 for now?  We
can then figure out how to improve on it.
