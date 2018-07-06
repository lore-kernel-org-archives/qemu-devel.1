Received: from eggs.gnu.org ([2001:4830:134:3::10]:38308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYv6-0002dz-SO
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYv5-0005i9-Uf
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:09:40 -0400
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-9-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc82c67c-0907-c727-e881-2f4622aa1d96@redhat.com>
Date: Fri, 6 Jul 2018 17:09:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180705073701.10558-9-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/9] block: Fix bdrv_co_truncate overlap
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 07/05/2018 02:37 AM, Fam Zheng wrote:
> If we are growing the image and potentially using preallocation for the
> new area, we need to make sure that no write requests are made to the
> "preallocated" area which [@old_size, @offset), not [@offset, offset * 2

s/which/which is/

> - @old_size).
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   block/io.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/io.c b/block/io.c
> index d07849fa96..ed18eb0ca3 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3070,7 +3070,8 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
>       }
>   
>       bdrv_inc_in_flight(bs);
> -    tracked_request_begin(&req, bs, offset, new_bytes, BDRV_TRACKED_TRUNCATE);
> +    tracked_request_begin(&req, bs, offset - new_bytes, new_bytes,
> +                          BDRV_TRACKED_TRUNCATE);

Is it any more legible to do s/offset - new_bytes/old_size/, since those 
are equivalent?

>   
>       /* If we are growing the image and potentially using preallocation for the
>        * new area, we need to make sure that no write requests are made to it
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
