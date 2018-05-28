Received: from eggs.gnu.org ([2001:4830:134:3::10]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNFlY-0002vD-FH
	for qemu-devel@nongnu.org; Mon, 28 May 2018 06:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNFlX-0003DN-Gh
	for qemu-devel@nongnu.org; Mon, 28 May 2018 06:52:40 -0400
Date: Mon, 28 May 2018 12:52:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180528105232.GD4580@localhost.localdomain>
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425183223.580566-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] qcow: Switch get_cluster_offset to be
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:qcow" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 25.04.2018 um 20:32 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the internal helper function
> get_cluster_offset(), by changing n_start and n_end to by byte
> offsets rather than sector indices within the cluster being
> allocated.
> 
> A later patch will then switch the qcow driver as a whole over
> to byte-based operation.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/block/qcow.c b/block/qcow.c
> index dd042b8ddbe..32730a8dd91 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -345,8 +345,8 @@ static int qcow_reopen_prepare(BDRVReopenState *state,
>   *
>   * 0 to not allocate.
>   *
> - * 1 to allocate a normal cluster (for sector indexes 'n_start' to
> - * 'n_end')
> + * 1 to allocate a normal cluster (for byte offsets 'n_start' to
> + * 'n_end' within the cluster)
>   *
>   * 2 to allocate a compressed cluster of size
>   * 'compressed_size'. 'compressed_size' must be > 0 and <
> @@ -442,7 +442,7 @@ static int get_cluster_offset(BlockDriverState *bs,
>          BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
>          /* allocate a new cluster */
>          if ((cluster_offset & QCOW_OFLAG_COMPRESSED) &&
> -            (n_end - n_start) < s->cluster_sectors) {
> +            (n_end - n_start) < s->cluster_size) {
>              /* if the cluster is already compressed, we must
>                 decompress it in the case it is not completely
>                 overwritten */
> @@ -480,16 +480,15 @@ static int get_cluster_offset(BlockDriverState *bs,
>                  /* if encrypted, we must initialize the cluster
>                     content which won't be written */
>                  if (bs->encrypted &&
> -                    (n_end - n_start) < s->cluster_sectors) {
> -                    uint64_t start_sect;
> +                    (n_end - n_start) < s->cluster_size) {
> +                    uint64_t start_offset;
>                      assert(s->crypto);
> -                    start_sect = (offset & ~(s->cluster_size - 1)) >> 9;
> -                    for(i = 0; i < s->cluster_sectors; i++) {
> +                    start_offset = offset & ~(s->cluster_size - 1);
> +                    for (i = 0; i < s->cluster_size; i += BDRV_SECTOR_SIZE) {
>                          if (i < n_start || i >= n_end) {
> -                            memset(s->cluster_data, 0x00, 512);
> +                            memset(s->cluster_data, 0x00, BDRV_SECTOR_SIZE);
>                              if (qcrypto_block_encrypt(s->crypto,
> -                                                      (start_sect + i) *
> -                                                      BDRV_SECTOR_SIZE,
> +                                                      start_offset + i,
>                                                        s->cluster_data,
>                                                        BDRV_SECTOR_SIZE,
>                                                        NULL) < 0) {

This code is still working in blocks of BDRV_SECTOR_SIZE here - which
you do need to keep at least partially because that's the block size
that qcrypto_block_encrypt() works with. qcrypto_block_qcow_encrypt()
even asserts it.

However, this means that even though n_start and n_end are byte-based
now, the code only works correctly with encrypted images if they are
multiples of BDRV_SECTOR_SIZE. This is currently true and we could
assert it, but it would kind of defeat the purpose of the patch.

I suppose you could make unaligned n_start/n_end work if you round down
n_start and round up n_end to the next sector boundary for the
comparison with i. For unaligned requests, we would then write a bit
more than is actually necessary, but I think that's okay because we're
initialising a previously unallocated cluster, so we don't overwrite
valid data.

Kevin
