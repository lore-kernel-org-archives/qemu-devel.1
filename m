Received: from eggs.gnu.org ([209.51.188.92]:43949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtZn4-0000mY-Ia
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtZn3-0004Ju-Q0
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 10:16:06 -0500
Date: Tue, 12 Feb 2019 16:15:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190212151558.GE5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<5c04485949b8cc3f63c6500b2bf6f70f4faaba4a.1547739122.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c04485949b8cc3f63c6500b2bf6f70f4faaba4a.1547739122.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 04/13] block: Freeze the backing chain for
 the duration of the stream job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 17.01.2019 um 16:33 hat Alberto Garcia geschrieben:
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/stream.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 7a49ac0992..39a2e10892 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -54,6 +54,14 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
>      return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
>  }
>  
> +static void stream_abort(Job *job)
> +{
> +    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
> +    BlockJob *bjob = &s->common;
> +
> +    bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
> +}

Like in commit, you can get a double unfreeze here if .abort is called
after .prepare returned an error.

Kevin
