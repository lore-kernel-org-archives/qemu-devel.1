Received: from eggs.gnu.org ([2001:4830:134:3::10]:54667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gXRyW-0003sJ-KS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gXRyS-0000nL-DU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:28:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gXRyS-0000mi-7T
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:28:24 -0500
Date: Thu, 13 Dec 2018 14:28:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181213142800.GO2313@work-vm>
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com>
	<1544516693-5395-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544516693-5395-2-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/7] bitmap: fix bitmap_count_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> BITMAP_LAST_WORD_MASK(nbits) returns 0xffffffff when "nbits=0", which
> makes bitmap_count_one fail to handle the "nbits=0" case. It appears to be
> preferred to remain BITMAP_LAST_WORD_MASK identical to the kernel
> implementation that it is ported from.
> 
> So this patch fixes bitmap_count_one to handle the nbits=0 case.

OK; it's a little odd that it's only bitmap_count_one that's being fixed
for this case; but OK.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Inital Discussion Link:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg554316.html
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> ---
>  include/qemu/bitmap.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index 509eedd..679f1bd 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -221,6 +221,10 @@ static inline int bitmap_intersects(const unsigned long *src1,
>  
>  static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
>  {
> +    if (unlikely(!nbits)) {
> +        return 0;
> +    }
> +
>      if (small_nbits(nbits)) {
>          return ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits));
>      } else {
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
