Received: from eggs.gnu.org ([2001:4830:134:3::10]:53228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH2Lg-00039g-08
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fH2Lf-00018P-6s
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:20:15 -0400
Date: Fri, 11 May 2018 15:20:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180511072005.GB28054@lemon.usersys.redhat.com>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-5-famz@redhat.com>
	<20180510085019.GF1296@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510085019.GF1296@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 4/9] file-posix: Implement
 bdrv_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

On Thu, 05/10 09:50, Stefan Hajnoczi wrote:
> On Wed, May 09, 2018 at 10:58:10PM +0800, Fam Zheng wrote:
> > +static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> > +                             off_t *out_off, size_t len, unsigned int flags)
> > +{
> > +#ifdef __NR_copy_file_range
> > +    return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
> > +                   out_off, len, flags);
> > +#else
> > +    errno = ENOSYS;
> > +    return -1;
> > +#endif
> > +}
> > +
> > +static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
> > +{
> > +    uint64_t bytes = aiocb->aio_nbytes;
> > +    off_t in_off = aiocb->aio_offset;
> > +    off_t out_off = aiocb->aio_offset2;
> > +
> > +    while (bytes) {
> > +        ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
> > +                                      aiocb->aio_fd2, &out_off,
> > +                                      bytes, 0);
> > +        if (ret == -EINTR) {
> > +            continue;
> > +        }
> > +        if (ret < 0) {
> > +            return -errno;
> 
> Convert ENOSYS to ENOTSUP?

Sounds good.
