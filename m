Received: from eggs.gnu.org ([209.51.188.92]:48959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3LNz-0003bP-A3
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3LCp-0001gV-IK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3LCp-0001g6-7F
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:43:03 -0400
References: <20190311054252.6094-1-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32619343-ad9b-4610-13f2-7c7bc4dec70e@redhat.com>
Date: Mon, 11 Mar 2019 14:42:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190311054252.6094-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] exec.c: refactor function
 flatview_add_to_dispatch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net

On 11/03/19 06:42, Wei Yang wrote:
> flatview_add_to_dispatch() registers page based on the condition of
> *section*, which may looks like this:
> 
>     |s|PPPPPPP|s|
> 
> where s stands for subpage and P for page.
> 
> The procedure of this function could be described as:
> 
>     - register first subpage
>     - register page
>     - register last subpage
> 
> This means the procedure could be simplified into these three steps
> instead of a loop iteration.
> 
> This patch refactors the function into three corresponding steps and
> adds some comment to clarify it.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> v3:
>   * pass int128_make64() instead of 0 to int128_gt()
> v2:
>   * removes the loop iteration as suggested by Paolo
> ---
>  exec.c | 50 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 0959b00c06..79cd561b3b 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1598,34 +1598,50 @@ static void register_multipage(FlatView *fv,
>      phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
>  }
>  
> +/*
> + * The range in *section* may look like this:
> + *
> + *      |s|PPPPPPP|s|
> + *
> + * where s stands for subpage and P for page.
> + *
> + * The procedure in following function could be described as:
> + *
> + * - register first subpage
> + * - register page
> + * - register last subpage

The last paragraph is a duplicate of the comments in the function, so it
can be deleted.  I did that and queued the patch.

Paolo

> + */
>  void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
>  {
> -    MemoryRegionSection now = *section, remain = *section;
> +    MemoryRegionSection now, remain = *section;
>      Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
>  
> -    if (now.offset_within_address_space & ~TARGET_PAGE_MASK) {
> -        uint64_t left = TARGET_PAGE_ALIGN(now.offset_within_address_space)
> -                       - now.offset_within_address_space;
> +    /* register first subpage */
> +    if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
> +        uint64_t left = TARGET_PAGE_ALIGN(remain.offset_within_address_space)
> +                        - remain.offset_within_address_space;
>  
> +        now = remain;
>          now.size = int128_min(int128_make64(left), now.size);
> +        remain.size = int128_sub(remain.size, now.size);
> +        remain.offset_within_address_space += int128_get64(now.size);
> +        remain.offset_within_region += int128_get64(now.size);
>          register_subpage(fv, &now);
> -    } else {
> -        now.size = int128_zero();
>      }
> -    while (int128_ne(remain.size, now.size)) {
> +
> +    /* register page */
> +    if (int128_ge(remain.size, page_size)) {
> +        now = remain;
> +        now.size = int128_and(now.size, int128_neg(page_size));
>          remain.size = int128_sub(remain.size, now.size);
>          remain.offset_within_address_space += int128_get64(now.size);
>          remain.offset_within_region += int128_get64(now.size);
> -        now = remain;
> -        if (int128_lt(remain.size, page_size)) {
> -            register_subpage(fv, &now);
> -        } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
> -            now.size = page_size;
> -            register_subpage(fv, &now);
> -        } else {
> -            now.size = int128_and(now.size, int128_neg(page_size));
> -            register_multipage(fv, &now);
> -        }
> +        register_multipage(fv, &now);
> +    }
> +
> +    /* register last subpage */
> +    if (int128_gt(remain.size, int128_make64(0))) {
> +        register_subpage(fv, &remain);
>      }
>  }
>  
> 
