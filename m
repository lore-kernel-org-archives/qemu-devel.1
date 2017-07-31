Received: from eggs.gnu.org ([2001:4830:134:3::10]:44276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcExV-0005zk-2S
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcExS-0004lT-1w
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcExR-0004kq-Rj
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:58:21 -0400
Date: Mon, 31 Jul 2017 18:58:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170731175815.GF2122@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-6-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-6-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 05/29] bitmap: introduce bitmap_count_one()
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
> Count how many bits set in the bitmap.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qemu/bitmap.h | 10 ++++++++++
>  util/bitmap.c         | 15 +++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index 460d899..9c18da0 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -83,6 +83,7 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
>  int slow_bitmap_intersects(const unsigned long *bitmap1,
>                             const unsigned long *bitmap2, long bits);
>  void slow_bitmap_invert(unsigned long *bitmap, long nbits);
> +long slow_bitmap_count_one(const unsigned long *bitmap, long nbits);
>  
>  static inline unsigned long *bitmap_try_new(long nbits)
>  {
> @@ -226,6 +227,15 @@ static inline void bitmap_invert(unsigned long *bitmap, long nbits)
>      }
>  }
>  
> +static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
> +{
> +    if (small_nbits(nbits)) {
> +        return (ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits)));
> +    } else {
> +        return slow_bitmap_count_one(bitmap, nbits);
> +    }
> +}
> +
>  void bitmap_set(unsigned long *map, long i, long len);
>  void bitmap_set_atomic(unsigned long *map, long i, long len);
>  void bitmap_clear(unsigned long *map, long start, long nr);
> diff --git a/util/bitmap.c b/util/bitmap.c
> index 9b7408c..73a1063 100644
> --- a/util/bitmap.c
> +++ b/util/bitmap.c
> @@ -368,3 +368,18 @@ void slow_bitmap_invert(unsigned long *bitmap, long nbits)
>          bitmap[k] ^= BITMAP_LAST_WORD_MASK(nbits);
>      }
>  }
> +
> +long slow_bitmap_count_one(const unsigned long *bitmap, long nbits)
> +{
> +    long k, lim = nbits/BITS_PER_LONG, result = 0;
> +
> +    for (k = 0; k < lim; k++) {
> +        result += ctpopl(bitmap[k]);
> +    }
> +
> +    if (nbits % BITS_PER_LONG) {
> +        result += ctpopl(bitmap[k] & BITMAP_LAST_WORD_MASK(nbits));
> +    }
> +
> +    return result;
> +}

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I checked what happens with BITMAP_LAST_WORD_MASK(0) interestingly it's
all 1 - so you do need that if)

> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
