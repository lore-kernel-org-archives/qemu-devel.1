Received: from eggs.gnu.org ([2001:4830:134:3::10]:49546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv5Ns-0005tk-55
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv5Np-0001gy-CM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:35:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dv5Np-0001fZ-3v
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:35:29 -0400
Date: Thu, 21 Sep 2017 18:35:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170921173520.GD3401@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 03/33] bitmap: provide to_le/from_le
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Provide helpers to convert bitmaps to little endian format. It can be
> used when we want to send one bitmap via network to some other hosts.
> 
> One thing to mention is that, these helpers only solve the problem of
> endianess, but it does not solve the problem of different word size on
> machines (the bitmaps managing same count of bits may contains different
> size when malloced). So we need to take care of the size alignment issue
> on the callers for now.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qemu/bitmap.h |  7 +++++++
>  util/bitmap.c         | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index a13bd28..4481975 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -39,6 +39,8 @@
>   * bitmap_clear(dst, pos, nbits)		Clear specified bit area
>   * bitmap_test_and_clear_atomic(dst, pos, nbits)    Test and clear area
>   * bitmap_find_next_zero_area(buf, len, pos, n, mask)	Find bit free area
> + * bitmap_to_le(dst, src, nbits)      Convert bitmap to little endian
> + * bitmap_from_le(dst, src, nbits)    Convert bitmap from little endian
>   */
>  
>  /*
> @@ -247,4 +249,9 @@ static inline unsigned long *bitmap_zero_extend(unsigned long *old,
>      return new;
>  }
>  
> +void bitmap_to_le(unsigned long *dst, const unsigned long *src,
> +                  long nbits);
> +void bitmap_from_le(unsigned long *dst, const unsigned long *src,
> +                    long nbits);
> +
>  #endif /* BITMAP_H */
> diff --git a/util/bitmap.c b/util/bitmap.c
> index 3446d72..f7aad58 100644
> --- a/util/bitmap.c
> +++ b/util/bitmap.c
> @@ -370,3 +370,35 @@ long slow_bitmap_count_one(const unsigned long *bitmap, long nbits)
>  
>      return result;
>  }
> +
> +static void bitmap_to_from_le(unsigned long *dst,
> +                              const unsigned long *src, long nbits)
> +{
> +    long len = BITS_TO_LONGS(nbits);
> +
> +#ifdef HOST_WORDS_BIGENDIAN
> +    long index;
> +
> +    for (index = 0; index < len; index++) {
> +# if __WORD_SIZE == 64

I think the right constant to use here is HOST_LONG_BITS

> +        dst[index] = bswap64(src[index]);
> +# else
> +        dst[index] = bswap32(src[index]);
> +# endif
> +    }
> +#else
> +    memcpy(dst, src, len * sizeof(unsigned long));
> +#endif
> +}
> +
> +void bitmap_from_le(unsigned long *dst, const unsigned long *src,
> +                    long nbits)
> +{
> +    bitmap_to_from_le(dst, src, nbits);
> +}
> +
> +void bitmap_to_le(unsigned long *dst, const unsigned long *src,
> +                  long nbits)
> +{
> +    bitmap_to_from_le(dst, src, nbits);
> +}
> -- 
> 2.7.4

Other than that;

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Maybe adding a bswapl with that ifdef would be easier
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
