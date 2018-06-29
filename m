Received: from eggs.gnu.org ([2001:4830:134:3::10]:34067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYp1R-0007y7-O0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYp1Q-0000KM-TC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:44:53 -0400
Date: Fri, 29 Jun 2018 10:44:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629084444.GC15588@localhost.localdomain>
References: <20180628190723.276458-1-eblake@redhat.com>
	<20180628190723.276458-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628190723.276458-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/6] qcow2: Reduce REFT_OFFSET_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, berto@igalia.com

Am 28.06.2018 um 21:07 hat Eric Blake geschrieben:
> Match our code to the spec change in the previous patch - there's
> no reason for the refcount table to allow larger offsets than the
> L1/L2 tables.

What about internal snapshots? And anyway, because of the metadata
overhead, the physical image size of a fully allocated image is always
going to be at least minimally larger than the virtual disk size.

I'm not necessarily opposed to making the change if there is a good
reason to make it, but I don't see a real need for it and the
justification used here and also in the previous patch is incorrect.

Kevin

> In practice, no image has more than 64PB of
> allocated clusters anyways, as anything beyond that can't be
> expressed via L2 mappings to host offsets.
> 
> Suggested-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> 
> ---
> v4: new patch
> ---
>  block/qcow2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 01b5250415f..3774229ef9c 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -439,7 +439,7 @@ typedef enum QCow2MetadataOverlap {
>  #define L2E_OFFSET_MASK 0x00fffffffffffe00ULL
>  #define L2E_COMPRESSED_OFFSET_SIZE_MASK 0x3fffffffffffffffULL
> 
> -#define REFT_OFFSET_MASK 0xfffffffffffffe00ULL
> +#define REFT_OFFSET_MASK 0x00fffffffffffe00ULL
> 
>  static inline int64_t start_of_cluster(BDRVQcow2State *s, int64_t offset)
>  {
> -- 
> 2.14.4
> 
