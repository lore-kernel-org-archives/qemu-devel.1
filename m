Received: from eggs.gnu.org ([2001:4830:134:3::10]:48799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUrkk-0004ul-6D
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUrkj-0004wO-C3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:46:46 -0400
Date: Tue, 11 Jul 2017 11:46:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711094634.GG4335@noname.str.redhat.com>
References: <20170705102231.20711-1-stefanha@redhat.com>
	<20170705102231.20711-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705102231.20711-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: rename .bdrv_create() to
 .bdrv_co_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org

Am 05.07.2017 um 12:22 hat Stefan Hajnoczi geschrieben:
> BlockDriver->bdrv_create() has been called from coroutine context since
> commit 5b7e1542cfa41a281af9629d31cef03704d976e6 ("block: make
> bdrv_create adopt coroutine").
> 
> Make this explicit by renaming to .bdrv_co_create() and add the
> coroutine_fn annotation.  This makes it obvious to block driver authors
> that they may yield, use CoMutex, or other coroutine_fn APIs.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/block/file-win32.c b/block/file-win32.c
> index ef2910b..424f862 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -544,7 +544,8 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
>      return st.st_size;
>  }
>  
> -static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
> +static int coroutine_fn raw_create(const char *filename, QemuOpts *opts,
> +                                   Error **errp)
>  {
>      int fd;
>      int64_t total_size = 0;

This isn't complete, we need a _co in the name like everywhere else.

/mnt/qemu/block/file-win32.c:594:5: error: unknown field 'bdrv_create' specified in initializer
     .bdrv_create        = raw_create,

There is also one more reference left to .bdrv_create in a comment
in block/block-backend.c, which you may want to update.

Kevin
