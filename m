Received: from eggs.gnu.org ([209.51.188.92]:37234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gzLs3-0001aY-Eb
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gzLs2-00021A-Hz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:37:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gzLs2-0001z0-5l
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:37:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so23384116qtg.12
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 05:37:02 -0800 (PST)
Date: Thu, 28 Feb 2019 08:36:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190228083317-mutt-send-email-mst@kernel.org>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214043916.22128-2-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>

On Thu, Feb 14, 2019 at 03:39:12PM +1100, David Gibson wrote:
> When the balloon is inflated, we discard memory place in it using madvise()
> with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
> sounds like it makes sense but is actually unnecessary.
> 
> The misleadingly named MADV_DONTNEED just discards the memory in question,
> it doesn't set any persistent state on it in-kernel; all that's necessary
> to bring the memory back is to touch it.  MADV_WILLNEED in contrast
> specifically says that the memory will be used soon and faults it in.
> 
> This patch simplify's the balloon operation by dropping the madvise()
> on deflate.  This might have an impact on performance - it will move a
> delay at deflate time until that memory is actually touched, which
> might be more latency sensitive.  However:
> 
>   * Memory that's being given back to the guest by deflating the
>     balloon *might* be used soon, but it equally could just sit around
>     in the guest's pools until needed (or even be faulted out again if
>     the host is under memory pressure).
> 
>   * Usually, the timescale over which you'll be adjusting the balloon
>     is long enough that a few extra faults after deflation aren't
>     going to make a difference.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I'm having second thoughts about this. It might affect performance but
probably won't but we have no idea.  Might cause latency jitter after
deflate where it previously didn't happen.  This kind of patch should
really be accompanied by benchmarking results, not philosophy.

> ---
>  hw/virtio/virtio-balloon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a12677d4d5..43af521884 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -35,9 +35,8 @@
>  
>  static void balloon_page(void *addr, int deflate)
>  {
> -    if (!qemu_balloon_is_inhibited()) {
> -        qemu_madvise(addr, BALLOON_PAGE_SIZE,
> -                deflate ? QEMU_MADV_WILLNEED : QEMU_MADV_DONTNEED);
> +    if (!qemu_balloon_is_inhibited() && !deflate) {
> +        qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
>      }
>  }
>  
> -- 
> 2.20.1
