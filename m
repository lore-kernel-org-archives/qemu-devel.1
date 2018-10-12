Received: from eggs.gnu.org ([2001:4830:134:3::10]:40455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAs3p-0006vj-Re
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAs3k-0006hc-0J
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:40:37 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <964b7f71-3fc9-83b4-3d5d-4cae592eef7d@redhat.com>
Date: Fri, 12 Oct 2018 09:40:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181012032431.32693-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: David Gibson <david@gibson.dropbear.id.au>, dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 12/10/2018 05:24, David Gibson wrote:
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
> 
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
> 

Care to rename the function and drop the deflate parameter?
(call it only when actually inflating)

apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
