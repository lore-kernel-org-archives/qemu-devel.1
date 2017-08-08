Received: from eggs.gnu.org ([2001:4830:134:3::10]:58375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1df5Wv-0006ga-9t
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1df5Wu-0007Z5-9A
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:30:45 -0400
Date: Tue, 8 Aug 2017 22:30:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170808143022.GD2454@lemon>
References: <20170808122251.29815-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808122251.29815-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: handle blk_getlength() errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

On Tue, 08/08 13:22, Stefan Hajnoczi wrote:
> If blk_getlength() fails in virtio_blk_update_config() consider the disk
> image length to be 0 bytes.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/virtio-blk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index b750bd8b53..a16ac75090 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -730,6 +730,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      BlockConf *conf = &s->conf.conf;
>      struct virtio_blk_config blkcfg;
>      uint64_t capacity;
> +    int64_t length;
>      int blk_size = conf->logical_block_size;
>  
>      blk_get_geometry(s->blk, &capacity);
> @@ -752,7 +753,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>       * divided by 512 - instead it is the amount of blk_size blocks
>       * per track (cylinder).
>       */
> -    if (blk_getlength(s->blk) /  conf->heads / conf->secs % blk_size) {
> +    length = blk_getlength(s->blk);
> +    if (length > 0 && length / conf->heads / conf->secs % blk_size) {
>          blkcfg.geometry.sectors = conf->secs & ~s->sector_mask;
>      } else {
>          blkcfg.geometry.sectors = conf->secs;
> -- 
> 2.13.3
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
