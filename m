Received: from eggs.gnu.org ([209.51.188.92]:54776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hKMgB-0002m3-1S
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 08:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hKMg9-0005bl-1b
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 08:43:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hKMg8-0005Ze-RC
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 08:43:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so5324996edd.13
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 05:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190427113625.46594-1-sgarzare@redhat.com>
In-Reply-To: <20190427113625.46594-1-sgarzare@redhat.com>
Reply-To: dillaman@redhat.com
From: Jason Dillaman <jdillama@redhat.com>
Date: Sat, 27 Apr 2019 08:43:26 -0400
Message-ID: <CA+aFP1BtbjrzitLz7PW_b-kuYU7WSOiMs5jVfUBC=M3zEuBcew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/rbd: add preallocation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On Sat, Apr 27, 2019 at 7:37 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> This patch adds the support of preallocation (off/full) for the RBD
> block driver.
> If available, we use rbd_writesame() to quickly fill the image when
> full preallocation is required.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
>  qapi/block-core.json |   4 +-
>  2 files changed, 136 insertions(+), 17 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..29dd1bb040 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -13,6 +13,7 @@
>
>  #include "qemu/osdep.h"
>
> +#include "qemu/units.h"
>  #include <rbd/librbd.h>
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> @@ -331,6 +332,110 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
>      }
>  }
>
> +static int qemu_rbd_do_truncate(rbd_image_t image, int64_t offset,
> +                                PreallocMode prealloc, Error **errp)
> +{
> +    uint64_t current_length;
> +    char *buf = NULL;
> +    int ret;
> +
> +    ret = rbd_get_size(image, &current_length);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to get file length");
> +        goto out;
> +    }
> +
> +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> +        error_setg(errp, "Cannot use preallocation for shrinking files");
> +        ret = -ENOTSUP;
> +        goto out;
> +    }
> +
> +    switch (prealloc) {
> +    case PREALLOC_MODE_FULL: {
> +        uint64_t current_offset = current_length;
> +        int buf_size = 64 * KiB;

This should probably be 512B or 4KiB (which is the smallest striped
unit size). Not only will this avoid sending unnecessary zeroes to the
backing cluster, writesame silently turns into a standard write if
your buffer isn't properly aligned with the min(object size, stripe
unit size).

> +        ssize_t bytes;
> +
> +        buf = g_malloc(buf_size);
> +        /*
> +         * Some versions of rbd_writesame() discards writes of buffers with
> +         * all zeroes. In order to avoid this behaviour, we set the first byte
> +         * to one.
> +         */
> +        buf[0] = 1;

You could also use "rados_conf_set(cluster,
"rbd_discard_on_zeroed_write_same", "false").

> +        ret = rbd_resize(image, offset);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to resize file");
> +            goto out;
> +        }
> +
> +#ifdef LIBRBD_SUPPORTS_WRITESAME
> +        while (offset - current_offset > buf_size) {
> +            /*
> +             * rbd_writesame() supports only request where the size of the
> +             * operation is multiple of buffer size and it must be less or
> +             * equal to INT_MAX.
> +             */
> +            bytes = MIN(offset - current_offset, INT_MAX);
> +            bytes -= bytes % buf_size;

Using the default object size of 4MiB, this write size would result in
up to 512 concurrent ops to the backing cluster. Perhaps the size
should be bounded such that only a dozen or so concurrent requests are
issued per write, always rounded next largest object / stripe period
size. librbd and the rbd CLI usually try to bound themselves to the
value in the "rbd_concurrent_management_ops" configuration setting
(currently defaults to 10).

> +            bytes = rbd_writesame(image, current_offset, bytes, buf, buf_size,
> +                                  0);
> +            if (bytes < 0) {
> +                ret = bytes;
> +                error_setg_errno(errp, -ret,
> +                                 "Failed to write for preallocation");
> +                goto out;
> +            }
> +
> +            current_offset += bytes;
> +        }
> +#endif /* LIBRBD_SUPPORTS_WRITESAME */
> +
> +        while (current_offset < offset) {
> +            bytes = rbd_write(image, current_offset,
> +                              MIN(offset - current_offset, buf_size), buf);
> +            if (bytes < 0) {
> +                ret = bytes;
> +                error_setg_errno(errp, -ret,
> +                                 "Failed to write for preallocation");
> +                goto out;
> +            }
> +
> +            current_offset += bytes;
> +        }
> +
> +        ret = rbd_flush(image);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to flush the file");
> +            goto out;
> +        }
> +
> +        break;
> +    }
> +    case PREALLOC_MODE_OFF:
> +        ret = rbd_resize(image, offset);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to resize file");
> +            goto out;
> +        }
> +        break;
> +    default:
> +        error_setg(errp, "Unsupported preallocation mode: %s",
> +                   PreallocMode_str(prealloc));
> +        ret = -ENOTSUP;
> +        goto out;
> +    }
> +
> +    ret = 0;
> +
> +out:
> +    g_free(buf);
> +    return ret;
> +}
> +
>  static QemuOptsList runtime_opts = {
>      .name = "rbd",
>      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> @@ -376,6 +481,7 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *options,
>      BlockdevCreateOptionsRbd *opts = &options->u.rbd;
>      rados_t cluster;
>      rados_ioctx_t io_ctx;
> +    rbd_image_t image;
>      int obj_order = 0;
>      int ret;
>
> @@ -404,13 +510,21 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *options,
>          return ret;
>      }
>
> -    ret = rbd_create(io_ctx, opts->location->image, opts->size, &obj_order);
> +    ret = rbd_create(io_ctx, opts->location->image, 0, &obj_order);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "error rbd create");
>          goto out;
>      }
>
> -    ret = 0;
> +    ret = rbd_open(io_ctx, opts->location->image, &image, NULL);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "error rbd open");
> +        goto out;
> +    }
> +
> +    ret = qemu_rbd_do_truncate(image, opts->size, opts->preallocation, errp);
> +
> +    rbd_close(image);
>  out:
>      rados_ioctx_destroy(io_ctx);
>      rados_shutdown(cluster);
> @@ -431,6 +545,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
>      BlockdevOptionsRbd *loc;
>      Error *local_err = NULL;
>      const char *keypairs, *password_secret;
> +    char *prealloc;
>      QDict *options = NULL;
>      int ret = 0;
>
> @@ -449,6 +564,16 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
>                                                     BLOCK_OPT_CLUSTER_SIZE, 0);
>      rbd_opts->has_cluster_size = (rbd_opts->cluster_size != 0);
>
> +    prealloc = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> +    rbd_opts->preallocation = qapi_enum_parse(&PreallocMode_lookup, prealloc,
> +                                              PREALLOC_MODE_OFF, &local_err);
> +    g_free(prealloc);
> +    if (local_err) {
> +        ret = -EINVAL;
> +        error_propagate(errp, local_err);
> +        goto exit;
> +    }
> +
>      options = qdict_new();
>      qemu_rbd_parse_filename(filename, options, &local_err);
>      if (local_err) {
> @@ -1052,21 +1177,8 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               Error **errp)
>  {
>      BDRVRBDState *s = bs->opaque;
> -    int r;
> -
> -    if (prealloc != PREALLOC_MODE_OFF) {
> -        error_setg(errp, "Unsupported preallocation mode '%s'",
> -                   PreallocMode_str(prealloc));
> -        return -ENOTSUP;
> -    }
> -
> -    r = rbd_resize(s->image, offset);
> -    if (r < 0) {
> -        error_setg_errno(errp, -r, "Failed to resize file");
> -        return r;
> -    }
>
> -    return 0;
> +    return qemu_rbd_do_truncate(s->image, offset, prealloc, errp);
>  }
>
>  static int qemu_rbd_snap_create(BlockDriverState *bs,
> @@ -1219,6 +1331,11 @@ static QemuOptsList qemu_rbd_create_opts = {
>              .type = QEMU_OPT_SIZE,
>              .help = "RBD object size"
>          },
> +        {
> +            .name = BLOCK_OPT_PREALLOC,
> +            .type = QEMU_OPT_STRING,
> +            .help = "Preallocation mode (allowed values: off, full)"
> +        },
>          {
>              .name = "password-secret",
>              .type = QEMU_OPT_STRING,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..db25a4065b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4277,13 +4277,15 @@
>  #                   point to a snapshot.
>  # @size             Size of the virtual disk in bytes
>  # @cluster-size     RBD object size
> +# @preallocation    Preallocation mode (allowed values: off, full)
>  #
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsRbd',
>    'data': { 'location':         'BlockdevOptionsRbd',
>              'size':             'size',
> -            '*cluster-size' :   'size' } }
> +            '*cluster-size' :   'size',
> +            '*preallocation':   'PreallocMode' } }
>
>  ##
>  # @BlockdevVmdkSubformat:
> --
> 2.20.1
>
>


-- 
Jason
