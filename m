Received: from eggs.gnu.org ([2001:4830:134:3::10]:40976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eC1cv-0008An-DJ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:01:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eC1cq-00054o-Es
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:01:05 -0500
References: <20171107030236.23633-1-eblake@redhat.com>
	<20171107030236.23633-4-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f8868da-db64-b203-130d-d3fce3bd5ba2@redhat.com>
Date: Tue, 7 Nov 2017 12:00:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171107030236.23633-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] raw: Reflect read-only protocol layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

On 07/11/2017 04:02, Eric Blake wrote:
> We forbid operations like a zero-length write zero or a discard
> at the protocol layer when it is marked read-only, but those
> same operations were succeeding at the format layer because the
> raw format was not reflecting the underlying read-only status
> to the block layer, which then took short circuit paths on
> zero-length operations.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/raw-format.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/raw-format.c b/block/raw-format.c
> index 830243a8e4..717b8eff65 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -418,6 +418,12 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>          bs->file->bs->supported_write_flags;
>      bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
>          bs->file->bs->supported_zero_flags;
> +    if (bdrv_is_read_only(bs->file->bs)) {
> +        ret = bdrv_set_read_only(bs, true, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> 
>      if (bs->probed && !bdrv_is_read_only(bs)) {
>          fprintf(stderr,
> 

Kevin, perhaps this should be done straight in block.c?

Thanks,

Paolo
