Received: from eggs.gnu.org ([2001:4830:134:3::10]:39312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fbKAU-0000OA-5k
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fbKAT-0003ic-HI
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:24:34 -0400
Date: Fri, 6 Jul 2018 14:24:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180706062422.GB18916@lemon.usersys.redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-2-famz@redhat.com>
	<20180705110822.GH3309@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705110822.GH3309@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 1/9] block: Add copy offloading trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 07/05 13:08, Kevin Wolf wrote:
> Am 05.07.2018 um 09:36 hat Fam Zheng geschrieben:
> > A few trace points that can help reveal what is happening in a copy
> > offloading I/O path.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/file-posix.c | 2 ++
> >  block/io.c         | 2 ++
> >  block/iscsi.c      | 3 +++
> >  block/trace-events | 6 ++++++
> >  4 files changed, 13 insertions(+)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 829ee538d8..d3b1609410 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1488,6 +1488,8 @@ static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
> >          ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
> >                                        aiocb->aio_fd2, &out_off,
> >                                        bytes, 0);
> > +        trace_copy_file_range(aiocb->bs, aiocb->aio_fildes, in_off,
> > +                              aiocb->aio_fd2, out_off, bytes, 0, ret);
> 
> I think it's preferable to have a common prefix for all trace points in
> a driver, so they can be enabled with a glob.
> 
> paio_* is the existing one for thread pool based file-posix trace
> points. Not sure if we like it or want to replace it with something
> else.

Yes, I think it makes sense to add a "file_" prefix.

Fam
