Received: from eggs.gnu.org ([2001:4830:134:3::10]:54066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5SYj-00009B-Ls
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5SYj-0006M5-13
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:53:53 -0400
Date: Mon, 9 Apr 2018 16:53:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180409085341.GA24101@lemon.usersys.redhat.com>
References: <20180329110914.20888-1-famz@redhat.com>
	<20180329110914.20888-5-famz@redhat.com>
	<20180404132012.GQ4467@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404132012.GQ4467@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 4/8] file-posix: Implement
 bdrv_co_copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com

On Wed, 04/04 14:20, Stefan Hajnoczi wrote:
> On Thu, Mar 29, 2018 at 07:09:10PM +0800, Fam Zheng wrote:
> > +static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
> > +{
> > +#ifndef HAS_COPY_FILE_RANGE
> > +    return -ENOTSUP;
> > +#else
> > +    uint64_t bytes = aiocb->aio_nbytes;
> > +    off_t in_off = aiocb->aio_offset;
> > +    off_t out_off = aiocb->offset2;
> > +
> > +    while (bytes) {
> > +        ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
> > +                                      aiocb->fd2, &out_off,
> > +                                      bytes, 0);
> > +        if (ret < 0) {
> > +            return -errno;
> > +        }
> 
> EINTR should retry.

Will add (it is not listed in the manpage so I wasn't sure if it is necessary.)

Fam
