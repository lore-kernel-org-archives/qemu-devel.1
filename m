Received: from eggs.gnu.org ([2001:4830:134:3::10]:42065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3MsA-00033q-VV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Ms7-000870-1n
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:20:46 -0400
Date: Wed, 26 Apr 2017 21:20:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170426132028.GC9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-20-famz@redhat.com>
	<20170426125714.GG4538@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426125714.GG4538@noname.str.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, 04/26 14:57, Kevin Wolf wrote:
> Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> > They are wrappers of POSIX fcntl "file private locking", with a
> > convenient "try lock" wrapper implemented with F_OFD_GETLK.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  include/qemu/osdep.h |  3 +++
> >  util/osdep.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> > 
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 122ff06..1c9f5e2 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -341,6 +341,9 @@ int qemu_close(int fd);
> >  #ifndef _WIN32
> >  int qemu_dup(int fd);
> >  #endif
> > +int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
> > +int qemu_unlock_fd(int fd, int64_t start, int64_t len);
> > +int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
> 
> For the record: On IRC, I proposed adding something like the following:
> 
>     #ifndef F_OFD_SETLK
>     #define F_OFD_SETLK F_SETLK
>     #define F_OFD_GETLK F_GETLK
>     #endif
> 
> F_OFD_* are still relatively new and e.g. RHEL 7 doesn't support it yet.
> Using process-based locks is suboptimal because we can easily lose them
> earlier than we want, but it's still better than nothing and covers the
> common simple cases.

Yes, we should add that. But I'd prefer:

    #ifdef F_OFD_SETLK
    #define QEMU_SETLK F_OFD_SETLK
    #define QEMU_GETLK F_OFD_GETLK
    #else
    #define QEMU_SETLK F_SETLK
    #define QEMU_GETLK F_GETLK
    #endif

to avoid "abusing" the macro name.

Another question is whether we should print a warning to make users aware? Even
the test case in patch 21 can see three "lock losses" on RHEL with posix lock,
and there are way more corner cases, I believe.

We can print a warning to stderr in raw_open_common when F_OFD_GETLK is not
available, I think.

Fam
