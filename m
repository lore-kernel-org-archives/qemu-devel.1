Received: from eggs.gnu.org ([209.51.188.92]:49703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hBmkc-0007og-1G
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 16:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hBmkY-0007rC-5F
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 16:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hBmkM-0007JE-IR
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 16:44:43 -0400
References: <20190329200445.28512-1-chen.zhang@intel.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cca666f7-3cc7-92bc-8360-660c673df739@redhat.com>
Date: Wed, 3 Apr 2019 16:44:28 -0400
MIME-Version: 1.0
In-Reply-To: <20190329200445.28512-1-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] bitops.h: Remove unused bitops function
 test_and_change_bit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-dev <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>



On 3/29/19 4:04 PM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> In current codes we use change_bit() to finish the job.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  include/qemu/bitmap.h |  1 -
>  include/qemu/bitops.h | 15 ---------------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index 5c313346b9..6b71ef631c 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -52,7 +52,6 @@
>   * test_bit(bit, addr)			Is bit set in *addr?
>   * test_and_set_bit(bit, addr)		Set bit and return old value
>   * test_and_clear_bit(bit, addr)	Clear bit and return old value
> - * test_and_change_bit(bit, addr)	Change bit and return old value
>   * find_first_zero_bit(addr, nbits)	Position first zero bit in *addr
>   * find_first_bit(addr, nbits)		Position first set bit in *addr
>   * find_next_zero_bit(addr, nbits, bit)	Position next zero bit in *addr >= bit
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 3f0926cf40..1f98ffcdc0 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -109,21 +109,6 @@ static inline int test_and_clear_bit(long nr, unsigned long *addr)
>      return (old & mask) != 0;
>  }
>  
> -/**
> - * test_and_change_bit - Change a bit and return its old value
> - * @nr: Bit to change
> - * @addr: Address to count from
> - */
> -static inline int test_and_change_bit(long nr, unsigned long *addr)
> -{
> -    unsigned long mask = BIT_MASK(nr);
> -    unsigned long *p = addr + BIT_WORD(nr);
> -    unsigned long old = *p;
> -
> -    *p = old ^ mask;
> -    return (old & mask) != 0;
> -}
> -
>  /**
>   * test_bit - Determine whether a bit is set
>   * @nr: bit number to test
> 

I personally don't see the harm in keeping this, but it is indeed
unused, so:

Reviewed-by: John Snow <jsnow@redhat.com>


As for merging other sibling functions, I guess the desire is a small
decrease in SLOC; I'm not sure if you'll run into any uses where the
changed signatures for a combined function causes issues. I am not sure
it's worth the hassle.
