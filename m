Received: from eggs.gnu.org ([2001:4830:134:3::10]:44341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSPK7-0003fv-Iw
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSPK6-0001Vg-QE
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:01:07 -0400
Date: Tue, 4 Jul 2017 17:00:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704150057.GI4253@noname.str.redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/20] stream: Switch stream_run() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 27.06.2017 um 21:24 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Change the internal
> loop iteration of streaming to track by bytes instead of sectors
> (although we are still guaranteed that we iterate by steps that
> are sector-aligned).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> ---
> v2: no change
> ---
>  block/stream.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 746d525..2f9618b 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -108,12 +108,11 @@ static void coroutine_fn stream_run(void *opaque)
>      BlockBackend *blk = s->common.blk;
>      BlockDriverState *bs = blk_bs(blk);
>      BlockDriverState *base = s->base;
> -    int64_t sector_num = 0;
> -    int64_t end = -1;

Here, end was initialised to -1. This made a differnce for early 'goto
out' paths because otherwise data->reached_end would incorrectly be true
in stream_complete.

Because we also check data->ret, I think the only case where it actually
makes a difference is for the !bs->backing case: This used to result in
data->reached_end == false, but now it ends up as true. This is because
s->common.len hasn't been set yet, so it is still 0.

Kevin
