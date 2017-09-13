Received: from eggs.gnu.org ([2001:4830:134:3::10]:38494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1dsF5t-0005lQ-7m
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1dsF5p-0005Fm-5j
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:21:13 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:48716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1dsF5p-0005En-0q
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:21:09 -0400
Received: by mail-qk0-f170.google.com with SMTP id a128so3578022qkc.5
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 14:21:07 -0700 (PDT)
Message-ID: <1505337665.15211.3.camel@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Reply-To: dillaman@redhat.com
Date: Wed, 13 Sep 2017 17:21:05 -0400
In-Reply-To: <20170913164424.32129-1-awg@digitalocean.com>
References: <20170913164424.32129-1-awg@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] rbd: Detect rbd image resizes
 and propagate them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adam Wolfe Gordon <awg@digitalocean.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Wed, 2017-09-13 at 10:44 -0600, Adam Wolfe Gordon wrote:
> Register a watcher with rbd so that we get notified when an image is
> resized. Propagate resizes to parent block devices so that guest devices
> get resized without user intervention.
> 
> Signed-off-by: Adam Wolfe Gordon <awg@digitalocean.com>
> ---
> Hello!
> 
> We are using this patch in production at DigitalOcean and have tested it fairly
> extensively. However, we use the same block device configuration everywhere, so
> I'd be interested to get an answer to the question I've left in the code:
> 
> > /* NOTE: This assumes there's only one layer between us and the
> >    block-backend. Is this always true? */
> 
> If that isn't true, this patch will need a bit of work to traverse up the block
> device tree and find the block-backend.
> 
> Of course, any other feedback would be welcome too - this is my first foray into
> the qemu code.
> 
> Regards,
> Adam
> 
>  block/rbd.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index 144f350e1f..1c9fcbec1f 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -96,6 +96,8 @@ typedef struct BDRVRBDState {
>      rbd_image_t image;
>      char *image_name;
>      char *snap;
> +    uint64_t watcher_handle;
> +    uint64_t size_bytes;
>  } BDRVRBDState;
>  
>  static char *qemu_rbd_next_tok(char *src, char delim, char **p)
> @@ -540,6 +542,67 @@ out:
>      return rados_str;
>  }
>  
> +/* BH for when rbd notifies us of an update. */
> +static void qemu_rbd_update_bh(void *arg)
> +{
> +    BlockDriverState *parent, *bs = arg;
> +    BDRVRBDState *s = bs->opaque;
> +    bool was_variable_length;
> +    uint64_t new_size_bytes;
> +    int64_t new_parent_len;
> +    BdrvChild *c;
> +    int r;
> +
> +    r = rbd_get_size(s->image, &new_size_bytes);
> +    if (r < 0) {
> +        error_report("error reading size for %s: %s", s->name, strerror(-r));
> +        return;
> +    }
> +
> +    /* Avoid no-op resizes on non-resize notifications. */
> +    if (new_size_bytes == s->size_bytes) {
> +        error_printf("skipping non-resize rbd cb\n");

Image update callbacks can be invoked for any number of reasons, not
just resize events. Therefore, you probably don't want to have an error
message printed out here.

> +        return;
> +    }
> +
> +    /* NOTE: This assumes there's only one layer between us and the
> +       block-backend. Is this always true? */

I don't think that can be assumed to be true.

> +    parent = bs->inherits_from;
> +    if (parent == NULL) {
> +        error_report("bs %s does not have parent", bdrv_get_device_or_node_name(bs));
> +        return;
> +    }
> +
> +    /* Force parents to re-read our size. */

Can you just invoke blk_truncate instead? 

> +    was_variable_length = bs->drv->has_variable_length;
> +    bs->drv->has_variable_length = true;
> +    new_parent_len = bdrv_getlength(parent);
> +    if (new_parent_len < 0) {
> +        error_report("getlength failed on parent %s", bdrv_get_device_or_node_name(parent));
> +        bs->drv->has_variable_length = was_variable_length;
> +        return;
> +    }
> +    bs->drv->has_variable_length = was_variable_length;
> +
> +    /* Notify block backends that that we have resized.
> +       Copied from bdrv_parent_cb_resize. */
> +    QLIST_FOREACH(c, &parent->parents, next_parent) {
> +        if (c->role->resize) {
> +            c->role->resize(c);
> +        }
> +    }
> +
> +    s->size_bytes = new_size_bytes;
> +}
> +
> +/* Called from non-qemu thread - careful! */
> +static void qemu_rbd_update_cb(void *arg)
> +{
> +    BlockDriverState *bs = arg;
> +
> +    aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), qemu_rbd_update_bh, bs);
> +}
> +
>  static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>                           Error **errp)
>  {
> @@ -672,9 +735,25 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>          }
>      }
>  
> +    r = rbd_update_watch(s->image, &s->watcher_handle, qemu_rbd_update_cb, bs);

This API method was only added in the Ceph Jewel release just over a
year ago. This should probably gracefully degrade if compiled against an
older version of the librbd API.

> +    if (r < 0) {
> +        error_setg_errno(errp, -r, "error registering watcher on %s", s->name);
> +        goto failed_watch;
> +    }
> +
> +    r = rbd_get_size(s->image, &s->size_bytes);
> +    if (r < 0) {
> +        error_setg_errno(errp, -r, "error reading size for %s", s->name);
> +        goto failed_sz;
> +    }
> +
>      qemu_opts_del(opts);
>      return 0;
>  
> +failed_sz:
> +    rbd_update_unwatch(s->image, s->watcher_handle);
> +failed_watch:
> +    rbd_close(s->image);
>  failed_open:
>      rados_ioctx_destroy(s->io_ctx);
>  failed_shutdown:
> @@ -712,6 +791,7 @@ static void qemu_rbd_close(BlockDriverState *bs)
>  {
>      BDRVRBDState *s = bs->opaque;
>  
> +    rbd_update_unwatch(s->image, s->watcher_handle);
>      rbd_close(s->image);
>      rados_ioctx_destroy(s->io_ctx);
>      g_free(s->snap);
