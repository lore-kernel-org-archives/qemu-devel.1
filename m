Received: from eggs.gnu.org ([2001:4830:134:3::10]:55064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUOm3-0005dz-N0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 21:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUOlz-0002B5-Od
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 21:17:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cUOlz-0002Ao-Ja
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 21:17:51 -0500
Date: Fri, 20 Jan 2017 10:17:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170120021745.GB29561@lemon>
References: <1484844230-24490-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484844230-24490-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH] bitmap: assert that start and nr are non
 negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Thu, 01/19 17:43, Peter Lieven wrote:
> commit e1123a3b introduced a data corruption regression
> in the iscsi driver because it passed -1 as nr to bitmap_set
> and bitmap_clear. Add an assertion to catch such flaws earlier.
> 
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  util/bitmap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/util/bitmap.c b/util/bitmap.c
> index 43ed011..c1a84ca 100644
> --- a/util/bitmap.c
> +++ b/util/bitmap.c
> @@ -164,6 +164,8 @@ void bitmap_set(unsigned long *map, long start, long nr)
>      int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>      unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>  
> +    assert(start >= 0 && nr >= 0);
> +
>      while (nr - bits_to_set >= 0) {
>          *p |= mask_to_set;
>          nr -= bits_to_set;
> @@ -184,6 +186,8 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>      int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>      unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>  
> +    assert(start >= 0 && nr >= 0);
> +
>      /* First word */
>      if (nr - bits_to_set > 0) {
>          atomic_or(p, mask_to_set);
> @@ -221,6 +225,8 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>      int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>      unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>  
> +    assert(start >= 0 && nr >= 0);
> +
>      while (nr - bits_to_clear >= 0) {
>          *p &= ~mask_to_clear;
>          nr -= bits_to_clear;
> @@ -243,6 +249,8 @@ bool bitmap_test_and_clear_atomic(unsigned long *map, long start, long nr)
>      unsigned long dirty = 0;
>      unsigned long old_bits;
>  
> +    assert(start >= 0 && nr >= 0);
> +
>      /* First word */
>      if (nr - bits_to_clear > 0) {
>          old_bits = atomic_fetch_and(p, ~mask_to_clear);
> -- 
> 1.9.1
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
