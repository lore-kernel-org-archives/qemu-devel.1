Received: from eggs.gnu.org ([2001:4830:134:3::10]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dspoQ-0006u3-UP
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dspoP-00030r-NZ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:33:38 -0400
Date: Fri, 15 Sep 2017 14:33:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170915123327.GD4077@localhost.localdomain>
References: <20170913164424.32129-1-awg@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913164424.32129-1-awg@digitalocean.com>
Subject: Re: [Qemu-devel] [PATCH] rbd: Detect rbd image resizes and
 propagate them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adam Wolfe Gordon <awg@digitalocean.com>
Cc: qemu-block@nongnu.org, Josh Durgin <jdurgin@redhat.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Am 13.09.2017 um 18:44 hat Adam Wolfe Gordon geschrieben:
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
> +        return;
> +    }
> +
> +    /* NOTE: This assumes there's only one layer between us and the
> +       block-backend. Is this always true? */
> +    parent = bs->inherits_from;

There's more wrong about this than just making assumptions about the
graph layout above our own node (which would be wrong enough already).

Other assumptions that you are making here and that don't hold true
generally are that there is only one parent node (no reason why the
image couldn't be used by two different users) and that we always
inherit from a parent. If this node was created explicitly by the user
with its own -blockdev (or -drive) option, it doesn't inherit options
from any of its parents.

Basically, a block driver shouldn't care about its users and it can't
access them in a clean way. This is intentional.

> +    if (parent == NULL) {
> +        error_report("bs %s does not have parent", bdrv_get_device_or_node_name(bs));
> +        return;
> +    }
> +
> +    /* Force parents to re-read our size. */
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

This is the right approach that you should use consistently instead.

You don't only notify BlockBackends here (you do so if there is no layer
between rbd and the BlockBackend, i.e. rbd is the root node), but you
also notify any parent nodes (BlockDriverStates), which can react to
this.

child_file/child_format don't currently handle .resize, so if you have
any layers between rbd and the BB, this code doesn't do anything at the
moment.

However, you could introduce an implementation of .resize. An important
point here is that it depends on the specific block driver what to do
with this notification. Maybe we need a new BlockDriver callback. Raw
images will just propagate this and call .resize on all of their
parents. For qcow2 images, the size change of the image file doesn't
make a difference for the virtual disk that the driver exposes, so it
will silently ignore the notification.

Kevin
