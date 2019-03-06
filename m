Received: from eggs.gnu.org ([209.51.188.92]:35659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1RaI-0004Rr-Bm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1RaC-0002cD-7a
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:07:26 -0500
References: <20190306030601.21986-1-david@gibson.dropbear.id.au>
	<20190306030601.21986-2-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0835c2ca-5936-f2ce-0956-574a27e8a73a@redhat.com>
Date: Wed, 6 Mar 2019 09:07:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190306030601.21986-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] virtio-balloon: Don't mismatch
 g_malloc()/free (CID 1399146)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Michael Tsirkin <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06.03.19 04:05, David Gibson wrote:
> ed48c59875b6 "virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host
> page size" introduced a new temporary data structure which tracks 4kiB
> chunks which have been inserted into the balloon by the guest but
> don't yet form a full host page which we can discard.
> 
> Unfortunately, I had a thinko and allocated that structure with
> g_malloc0() but freed it with a plain free() rather than g_free().
> This corrects the problem.
> 
> Fixes: ed48c59875b6
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/virtio/virtio-balloon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index d3f2913a85..127289ae0e 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -81,7 +81,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>          /* We've partially ballooned part of a host page, but now
>           * we're trying to balloon part of a different one.  Too hard,
>           * give up on the old partial page */
> -        free(balloon->pbp);
> +        g_free(balloon->pbp);
>          balloon->pbp = NULL;
>      }
>  
> @@ -106,7 +106,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>           * has already reported them, and failing to discard a balloon
>           * page is not fatal */
>  
> -        free(balloon->pbp);
> +        g_free(balloon->pbp);
>          balloon->pbp = NULL;
>      }
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
