Received: from eggs.gnu.org ([2001:4830:134:3::10]:38330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUYDE-00031g-6O
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUYDB-0003UD-3j
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:22:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUYDA-0003Ts-To
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:22:33 -0500
References: <1484844230-24490-1-git-send-email-pl@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4dacdcb-34b7-6f48-363d-62a8c14dda8b@redhat.com>
Date: Fri, 20 Jan 2017 13:22:29 +0100
MIME-Version: 1.0
In-Reply-To: <1484844230-24490-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: famz@redhat.com



On 19/01/2017 17:43, Peter Lieven wrote:
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
> 

Queued, thanks.

Paolo
