Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fmwaI-0005Fw-VF
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fmwaF-0002Wl-SL
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:39:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fmwaF-0002Vh-Md
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:39:11 -0400
Date: Tue, 7 Aug 2018 15:39:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180807073905.GA7265@xz-mi>
References: <1533031278-5615-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1533031278-5615-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: fix BITMAP_LAST_WORD_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com

On Tue, Jul 31, 2018 at 06:01:18PM +0800, Wei Wang wrote:
> When "nbits = 0", which means no bits to mask, this macro is expected to
> return 0, instead of 0xffffffff. This patch changes the macro to return
> 0 when there is no bit needs to be masked.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Peter Xu <peterx@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Is there any existing path that can trigger this nbits==0?

> ---
>  include/qemu/bitmap.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> v1->v2 ChangeLog:
> - fix the macro directly, instead of fixing the callers one by one.
> 
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index 509eedd..9372423 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -60,7 +60,10 @@
>   */
>  
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> -#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> +#define BITMAP_LAST_WORD_MASK(nbits)                       \
> +(                                                          \
> +    nbits ? (~0UL >> (-(nbits) & (BITS_PER_LONG - 1))) : 0 \
> +)
>  
>  #define DECLARE_BITMAP(name,bits)                  \
>          unsigned long name[BITS_TO_LONGS(bits)]
> -- 
> 2.7.4
> 

Regards,

-- 
Peter Xu
