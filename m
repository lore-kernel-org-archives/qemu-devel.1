Received: from eggs.gnu.org ([2001:4830:134:3::10]:60983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3YPm-0006Jl-V6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3YPl-0001Vr-Ue
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:40:14 -0400
Date: Thu, 27 Apr 2017 09:40:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427014005.GF9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-20-famz@redhat.com>
	<20170426125714.GG4538@noname.str.redhat.com>
	<20170426132028.GC9205@lemon.lan>
	<20170426142928.GB18933@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426142928.GB18933@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 19/21] osdep: Add qemu_lock_fd and
 qemu_unlock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, 04/26 15:29, Daniel P. Berrange wrote:
> On Wed, Apr 26, 2017 at 09:20:28PM +0800, Fam Zheng wrote:
> > On Wed, 04/26 14:57, Kevin Wolf wrote:
> > > Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> > > > They are wrappers of POSIX fcntl "file private locking", with a
> > > > convenient "try lock" wrapper implemented with F_OFD_GETLK.
> > > > 
> > > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > > > ---
> > > >  include/qemu/osdep.h |  3 +++
> > > >  util/osdep.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 51 insertions(+)
> > > > 
> > > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > > index 122ff06..1c9f5e2 100644
> > > > --- a/include/qemu/osdep.h
> > > > +++ b/include/qemu/osdep.h
> > > > @@ -341,6 +341,9 @@ int qemu_close(int fd);
> > > >  #ifndef _WIN32
> > > >  int qemu_dup(int fd);
> > > >  #endif
> > > > +int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
> > > > +int qemu_unlock_fd(int fd, int64_t start, int64_t len);
> > > > +int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
> > > 
> > > For the record: On IRC, I proposed adding something like the following:
> > > 
> > >     #ifndef F_OFD_SETLK
> > >     #define F_OFD_SETLK F_SETLK
> > >     #define F_OFD_GETLK F_GETLK
> > >     #endif
> > > 
> > > F_OFD_* are still relatively new and e.g. RHEL 7 doesn't support it yet.
> > > Using process-based locks is suboptimal because we can easily lose them
> > > earlier than we want, but it's still better than nothing and covers the
> > > common simple cases.
> > 
> > Yes, we should add that. But I'd prefer:
> > 
> >     #ifdef F_OFD_SETLK
> >     #define QEMU_SETLK F_OFD_SETLK
> >     #define QEMU_GETLK F_OFD_GETLK
> >     #else
> >     #define QEMU_SETLK F_SETLK
> >     #define QEMU_GETLK F_GETLK
> >     #endif
> > 
> > to avoid "abusing" the macro name.
> > 
> > Another question is whether we should print a warning to make users aware? Even
> > the test case in patch 21 can see three "lock losses" on RHEL with posix lock,
> > and there are way more corner cases, I believe.
> 
> Is it possible to use F_GETLK to detect when we have a missing lock, then
> add assertions in various key places that call F_GETLK to validate hat
> the lock still exists & print an warning.

Possibly, but it's ugly to do, and probably isn't worth the effort in finding
all the places where losses happen and where locks should be checked against
losses. Besides, maybe I'm missing something, it's also hard to use F_GETLK to
find lost locks, because either it's lost or not, it can return F_UNLCK.

> 
> I don't like the idea that downstream would be running with locking enabled,
> but silently loosing locks with no indication at all that this happened,
> especially when upstream development won't be testing this since those devs
> will use the F_OFD_SETLK instead.

Yes, see my reply to Kevin on the last patch: we could default to disabled if
there is no OFD lock (via documented locking=auto, no magic), and avoid
surprising users.

Fam
