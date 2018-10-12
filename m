Received: from eggs.gnu.org ([2001:4830:134:3::10]:50147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gB1oY-0001Ac-3w
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gB1oP-00035C-N0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:05:26 -0400
Date: Fri, 12 Oct 2018 14:05:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181012140306-mutt-send-email-mst@kernel.org>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012032431.32693-2-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
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
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Fri, Oct 12, 2018 at 02:24:27PM +1100, David Gibson wrote:
> When the balloon is inflated, we discard memory place in it using madvise()
> with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
> sounds like it makes sense but is actually unnecessary.
> 
> The misleadingly named MADV_DONTNEED just discards the memory in question,
> it doesn't set any persistent state on it in-kernel; all that's necessary
> to bring the memory back is to touch it.  MADV_WILLNEED in contrast
> specifically says that the memory will be used soon and faults it in.
> 
> Memory that's being given back to the guest by deflating the balloon
> *might* be used soon, but it equally could just sit around in the guest's
> pools until it actually needs it.  And, over the general timescale that
> memory ballooning operates, it seems unlikely that one extra fault for the
> guest will be a vast performance issue.

Thinking about it, it might be for RT guests.

So I suspect if you want to drop MADV_WILLNEED you need a flag
telling qemu that's not the usecase.




> So, simplify the balloon's operation by dropping the madvise() on deflate.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/virtio/virtio-balloon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 1728e4f83a..6ec4bcf4e1 100644
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
> 2.17.1
