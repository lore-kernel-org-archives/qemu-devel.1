Received: from eggs.gnu.org ([2001:4830:134:3::10]:38441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb27r-00034Q-JS
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb27q-0003FD-L0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:08:39 -0400
Date: Thu, 5 Jul 2018 13:08:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705110822.GH3309@localhost.localdomain>
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705073701.10558-2-famz@redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 05.07.2018 um 09:36 hat Fam Zheng geschrieben:
> A few trace points that can help reveal what is happening in a copy
> offloading I/O path.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 2 ++
>  block/io.c         | 2 ++
>  block/iscsi.c      | 3 +++
>  block/trace-events | 6 ++++++
>  4 files changed, 13 insertions(+)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 829ee538d8..d3b1609410 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1488,6 +1488,8 @@ static ssize_t handle_aiocb_copy_range(RawPosixAIOData *aiocb)
>          ssize_t ret = copy_file_range(aiocb->aio_fildes, &in_off,
>                                        aiocb->aio_fd2, &out_off,
>                                        bytes, 0);
> +        trace_copy_file_range(aiocb->bs, aiocb->aio_fildes, in_off,
> +                              aiocb->aio_fd2, out_off, bytes, 0, ret);

I think it's preferable to have a common prefix for all trace points in
a driver, so they can be enabled with a glob.

paio_* is the existing one for thread pool based file-posix trace
points. Not sure if we like it or want to replace it with something
else.

Kevin
