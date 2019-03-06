Received: from eggs.gnu.org ([209.51.188.92]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1RmK-0007NQ-1k
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1RmJ-0002z6-9V
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:19:52 -0500
References: <20190306030601.21986-1-david@gibson.dropbear.id.au>
	<20190306030601.21986-4-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2e599367-6b3e-4933-5b18-f79e14ec41ec@redhat.com>
Date: Wed, 6 Mar 2019 09:19:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190306030601.21986-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] virtio-balloon: Restore MADV_WILLNEED
 hint on balloon deflate
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

On 06.03.19 04:06, David Gibson wrote:
> Prior to f6deb6d9 "virtio-balloon: Remove unnecessary MADV_WILLNEED on
> deflate", the balloon device issued an madvise() MADV_WILLNEED on
> pages removed from the balloon.  That would hint to the host kernel
> that the pages were likely to be needed by the guest in the near
> future.
> 
> It's unclear if this is actually valuable or not, and so f6deb6d9
> removed this, essentially ignoring balloon deflate requests.  However,
> concerns have been raised that this might cause a performance
> regression by causing extra latency for the guest in certain
> configurations.
> 
> So, until we can get actual benchmark data to see if that's the case,
> this restores the old behaviour, issuing a MADV_WILLNEED when a page is
> removed from the balloon.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/virtio/virtio-balloon.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 7412bf8c85..ac36988605 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -118,6 +118,8 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>      RAMBlock *rb;
>      size_t rb_page_size;
>      ram_addr_t ram_offset, host_page_base;
> +    void *host_addr;
> +    int ret;
>  
>      /* XXX is there a better way to get to the RAMBlock than via a
>       * host address? */
> @@ -146,6 +148,17 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>              balloon->pbp = NULL;
>          }
>      }
> +
> +    host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
> +
> +    /* When a page is deflated, we hint the whole host page it lives
> +     * on, since we can't do anything smaller */
> +    ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
> +    if (ret != 0) {
> +        warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
> +                    strerror(errno));
> +        /* Otherwise ignore, failing to page hint shouldn't be fatal */
> +    }

As far as I understand the man page, only MADV_DONTNEED will complain
about locked, huge or VM_PFNMAP pages. So I guess MADV_WILLNEED will
work for these cases (in the worst case be a NOP).

-- 

Thanks,

David / dhildenb
