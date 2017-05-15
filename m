Received: from eggs.gnu.org ([2001:4830:134:3::10]:55611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dAFCg-0003v8-F0
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dAFCf-0002j1-Hz
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:34:22 -0400
Date: Mon, 15 May 2017 14:34:08 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170515123408.htpfkq742xmiegem@eukaryote>
References: <20170515093424.28954-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515093424.28954-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] stream: fix crash in stream_start() when
 block_job_create() fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, May 15, 2017 at 12:34:24PM +0300, Alberto Garcia wrote:
> The code that tries to reopen a BlockDriverState in stream_start()
> when the creation of a new block job fails crashes because it attempts
> to dereference a pointer that is known to be NULL.
> 
> This is a regression introduced in a170a91fd3eab6155da39e740381867e,
> likely because the code was copied from stream_complete().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 0113710845..52d329f5c6 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -280,6 +280,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>  
>  fail:
>      if (orig_bs_flags != bdrv_get_flags(bs)) {
> -        bdrv_reopen(bs, s->bs_flags, NULL);
> +        bdrv_reopen(bs, orig_bs_flags, NULL);

Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

Yep, this fixes it.

It gracefully throws an error when a 'job-id' was not specified:

-----------------------------------------------------------------------
(QEMU) block-stream device=#block890 base=disk1.qcow2
{
    "execute": "block-stream", 
    "arguments": {
        "device": "#block890", 
        "base": "disk1.qcow2"
    }
}
{
    "error": {
        "class": "GenericError", 
        "desc": "An explicit job ID is required for this node"
    }
}
(QEMU) block-stream device=#block890 base=disk1.qcow2 job-id=job0
{
    "execute": "block-stream", 
    "arguments": {
        "device": "#block890", 
        "job-id": "job0", 
        "base": "disk1.qcow2"
    }
}
{
    "return": {}
}
(QEMU) 
-----------------------------------------------------------------------

[...]

-- 
/kashyap
