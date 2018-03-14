Received: from eggs.gnu.org ([2001:4830:134:3::10]:46650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew99M-0001BH-P8
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew99H-0002Wr-Uu
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:21:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew99H-0002WK-Q0
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:21:07 -0400
Date: Wed, 14 Mar 2018 16:20:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180314162058.GF3006@work-vm>
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
	<1520426065-40265-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520426065-40265-2-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/4] bitmap: bitmap_count_one_with_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> Count the number of 1s in a bitmap starting from an offset.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/qemu/bitmap.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index 509eedd..e3f31f1 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -228,6 +228,19 @@ static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
>      }
>  }
>  
> +static inline long bitmap_count_one_with_offset(const unsigned long *bitmap,
> +                                                long offset, long nbits)
> +{
> +    long aligned_offset = QEMU_ALIGN_DOWN(offset, BITS_PER_LONG);
> +    long redundant_bits = offset - aligned_offset;
> +    long bits_to_count = nbits + redundant_bits;
> +    const unsigned long *bitmap_start = bitmap +
> +                                        aligned_offset / BITS_PER_LONG;
> +
> +    return bitmap_count_one(bitmap_start, bits_to_count) -
> +           bitmap_count_one(bitmap_start, redundant_bits);
> +}
> +
>  void bitmap_set(unsigned long *map, long i, long len);
>  void bitmap_set_atomic(unsigned long *map, long i, long len);
>  void bitmap_clear(unsigned long *map, long start, long nr);
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
