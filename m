Received: from eggs.gnu.org ([2001:4830:134:3::10]:42754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcDeH-0006Cw-HQ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcDeE-0006Ds-T0
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:34:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcDeE-0006CJ-Ly
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:34:26 -0400
Date: Mon, 31 Jul 2017 17:34:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170731163414.GB2122@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 01/29] migration: fix incorrect postcopy
 recved_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> The bitmap setup during postcopy is incorrectly when the pgaes are huge
> pages. Fix it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/postcopy-ram.c | 2 +-
>  migration/ram.c          | 8 ++++++++
>  migration/ram.h          | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 276ce12..952b73a 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -578,7 +578,7 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
>          ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
>      }
>      if (!ret) {
> -        ramblock_recv_bitmap_set(host_addr, rb);
> +        ramblock_recv_bitmap_set_range(rb, host_addr, pagesize / getpagesize());

isn't that   pagesize / qemu_target_page_size() ?

Other than that it looks OK.

>      }
>      return ret;
>  }
> diff --git a/migration/ram.c b/migration/ram.c
> index 107ee9d..c93973c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -168,6 +168,14 @@ void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb)
>      set_bit_atomic(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
>  }
>  
> +void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr,
> +                                    size_t len)
> +{
> +    bitmap_set(rb->receivedmap,
> +               ramblock_recv_bitmap_offset(host_addr, rb),
> +               len);
> +}
> +
>  void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb)
>  {
>      clear_bit(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
> diff --git a/migration/ram.h b/migration/ram.h
> index b711552..84e8623 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -55,6 +55,8 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
>  
>  int ramblock_recv_bitmap_test(void *host_addr, RAMBlock *rb);
>  void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb);
> +void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr,
> +                                    size_t len);
>  void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb);
>  
>  #endif
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
