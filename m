Received: from eggs.gnu.org ([2001:4830:134:3::10]:38631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpnoL-0001fv-3Q
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpnoF-0005BA-UE
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:53:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36475)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpnoE-00059V-LK
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:53:27 -0400
Date: Wed, 15 Aug 2018 00:53:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180815045323.GA7585@flamenco>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-2-cota@braap.org>
	<20180815030942.GA14092@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815030942.GA14092@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Aug 15, 2018 at 11:09:42 +0800, Fam Zheng wrote:
> On Mon, 08/13 13:11, Emilio G. Cota wrote:
> > +  --enable-sync-profiler) sync_profiler="yes"
> > +  ;;
> 
> Curious, not asking for a change: can this be made a runtime option instead of
> compile time, since there's no library dependencies? That should make this
> somewhat easier to use.

Good point. I'll do some profiling tomorrow to see how the latency
of the locking primitives could be minimized (ideally, not using
the profiler should just add a well-predicted branch).

> > +
> > +#define QSP_GEN_VOID(type_, qsp_t_, func_, impl_)                       \
> > +    void func_(type_ *obj, const char *file, unsigned line)             \
> > +    {                                                                   \
> > +        struct qsp_entry *e = qsp_entry_get(obj, file, line, qsp_t_);   \
> > +        int64_t t;                                                      \
> > +                                                                        \
> 
> No qsp_init()?
> 
> > +        t = get_clock();                                                \
> > +        impl_(obj, file, line);                                         \
> > +        atomic_set(&e->ns, e->ns + get_clock() - t);                    \
> > +        atomic_set(&e->n_acqs, e->n_acqs + 1);                          \
> > +    }
> > +
> > +#define QSP_GEN_RET1(type_, qsp_t_, func_, impl_)                       \
> > +    int func_(type_ *obj, const char *file, unsigned line)              \
> > +    {                                                                   \
> > +        struct qsp_entry *e = qsp_entry_get(obj, file, line, qsp_t_);   \
> > +        int64_t t;                                                      \
> > +        int err;                                                        \
> > +                                                                        \
> 
> Same here.

qsp_init is called by qsp_get_entry.

(snip)
> > +void qsp_cond_wait(QemuCond *cond, QemuMutex *mutex, const char *file,
> > +                   unsigned line)
> > +{
> > +    struct qsp_entry *e;
> > +    int64_t t;
> > +
> > +    qsp_init();
> > +
> > +    e = qsp_entry_get(cond, file, line, QSP_CONDVAR);
> > +    t = get_clock();
> > +    qemu_cond_wait_impl(cond, mutex, file, line);
> > +    atomic_set(&e->ns, e->ns + get_clock() - t);
> > +    atomic_set(&e->n_acqs, e->n_acqs + 1);
> 
> Why not atomic_add (both here and in above macros)? Because fetching e->ns and
> then updating it is not "atomic" this way.

This isn't a read-modify-write op; atomic_set is used here as
"write_once".

Note that struct qsp_entry is only ever modified by the current
thread (thread_ptr is part of the struct; yes this uses a lot
more memory but that's the price of scalability). The struct might
be read anytime by other threads though, so we have to use atomic_set
to avoid undefined behaviour (e.g. torn reads/writes).

Thanks,

		Emilio
