Received: from eggs.gnu.org ([209.51.188.92]:60989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL4Lz-0007bi-FX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL4Ly-0008HU-Ii
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:21:47 -0400
Date: Mon, 29 Apr 2019 13:21:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190429112140.GF8492@localhost.localdomain>
References: <20190429105741.31033-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429105741.31033-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with
 external data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org

Am 29.04.2019 um 12:57 hat Kevin Wolf geschrieben:
> make_completely_empty() is an optimisated path for bdrv_make_empty()
> where completely new metadata is created inside the image file instead
> of going through all clusters and discarding them. For an external data
> file, however, we actually need to do discard operations on the data
> file; just overwriting the qcow2 file doesn't get rid of the data.
> 
> The necessary slow path with an explicit discard operation already
> exists for other cases. Use it for external data files, too.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7fbef97aab..097fde56f9 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4384,7 +4384,8 @@ static int qcow2_make_empty(BlockDriverState *bs)
>  
>      if (s->qcow_version >= 3 && !s->snapshots && !s->nb_bitmaps &&
>          3 + l1_clusters <= s->refcount_block_size &&
> -        s->crypt_method_header != QCOW_CRYPT_LUKS) {
> +        s->crypt_method_header != QCOW_CRYPT_LUKS &&
> +        !has_data_file(bs)) {
>          /* The following function only works for qcow2 v3 images (it
>           * requires the dirty flag) and only as long as there are no
>           * features that reserve extra clusters (such as snapshots,

Oops, I hadn't everything committed yet. I'll add a comment change as
well:

          * LUKS header, or persistent bitmaps), because it completely
          * empties the image.  Furthermore, the L1 table and three
          * additional clusters (image header, refcount table, one
-         * refcount block) have to fit inside one refcount block. */
+         * refcount block) have to fit inside one refcount block. It
+         * only resets the image file, i.e. does not work with an
+         * external data file. */
         return make_completely_empty(bs);
     }

Kevin
