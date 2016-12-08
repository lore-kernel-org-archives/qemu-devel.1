Received: from eggs.gnu.org ([2001:4830:134:3::10]:40573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cEsaL-0005n8-MV
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 01:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cEsaK-0008KM-Rm
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 01:53:41 -0500
Date: Thu, 8 Dec 2016 14:53:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161208065332.GA2045@lemon>
References: <1477928314-11184-1-git-send-email-famz@redhat.com>
	<1477928314-11184-2-git-send-email-famz@redhat.com>
	<29e8c31e-a05f-79b0-df81-ec84317496b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e8c31e-a05f-79b0-df81-ec84317496b9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/14] osdep: Add qemu_lock_fd and
 qemu_unlock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

On Fri, 12/02 01:30, Max Reitz wrote:
> On 31.10.2016 16:38, Fam Zheng wrote:
> > They are wrappers of POSIX fcntl "file private locking".
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  include/qemu/osdep.h |  2 ++
> >  util/osdep.c         | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 0e3c330..f15e122 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -294,6 +294,8 @@ int qemu_close(int fd);
> >  #ifndef _WIN32
> >  int qemu_dup(int fd);
> >  #endif
> > +int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
> > +int qemu_unlock_fd(int fd, int64_t start, int64_t len);
> >  
> >  #if defined(__HAIKU__) && defined(__i386__)
> >  #define FMT_pid "%ld"
> > diff --git a/util/osdep.c b/util/osdep.c
> > index 06fb1cf..b85a490 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -140,6 +140,35 @@ static int qemu_parse_fdset(const char *param)
> >  {
> >      return qemu_parse_fd(param);
> >  }
> > +
> > +static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type)
> > +{
> > +#ifdef F_OFD_SETLK
> > +    int ret;
> > +    struct flock fl = {
> > +        .l_whence = SEEK_SET,
> > +        .l_start  = start,
> > +        .l_len    = len,
> > +        .l_type   = fl_type,
> > +    };
> > +    do {
> > +        ret = fcntl(fd, F_OFD_SETLK, &fl);
> > +    } while (ret == -1 && errno == EINTR);
> 
> As I've asked in the last version: Can EINTR happen at all? My man page
> tells me it's possible only with F(_OFD)_SETLKW.

I think you are right, let's drop the condition.

Fam

> 
> Max
> 
> > +    return ret == -1 ? -errno : 0;
> > +#else
> > +    return -ENOTSUP;
> > +#endif
> > +}
> > +
> > +int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive)
> > +{
> > +    return qemu_lock_fcntl(fd, start, len, exclusive ? F_WRLCK : F_RDLCK);
> > +}
> > +
> > +int qemu_unlock_fd(int fd, int64_t start, int64_t len)
> > +{
> > +    return qemu_lock_fcntl(fd, start, len, F_UNLCK);
> > +}
> >  #endif
> >  
> >  /*
> > 
> 
> 
