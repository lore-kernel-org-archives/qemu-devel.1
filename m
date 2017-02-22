Received: from eggs.gnu.org ([2001:4830:134:3::10]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgU5s-0000F4-FM
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgU5r-0005ct-9G
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:24:20 -0500
Date: Wed, 22 Feb 2017 11:24:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222102411.GD4112@noname.str.redhat.com>
References: <20170131115728.5244.21690.stgit@PASHA-ISP>
	<20170131115740.5244.87406.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170131115740.5244.87406.stgit@PASHA-ISP>
Subject: Re: [Qemu-devel] [PATCH 2/3] blkreplay: create temporary overlay
 for underlaying devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Am 31.01.2017 um 12:57 hat Pavel Dovgalyuk geschrieben:
> This patch allows using '-snapshot' behavior in record/replay mode.
> blkreplay layer creates temporary overlays on top of underlaying
> disk images. It is needed, because creating an overlay over blkreplay
> breaks the determinism.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Is replacing the '-snapshot' behaviour (which was automatically enabled
before this patch) with custom code what this patch really does? In
other words, does it fix that the old behaviour didn't work correctly
rather than adding a new feature? If so, the commit message is prone to
misunderstanding, I think.

> diff --git a/block/blkreplay.c b/block/blkreplay.c
> index 8a03d62..172642f 100644
> --- a/block/blkreplay.c
> +++ b/block/blkreplay.c
> @@ -14,12 +14,76 @@
>  #include "block/block_int.h"
>  #include "sysemu/replay.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qstring.h"
>  
>  typedef struct Request {
>      Coroutine *co;
>      QEMUBH *bh;
>  } Request;
>  
> +static BlockDriverState *blkreplay_append_snapshot(BlockDriverState *bs,
> +                                                   Error **errp)
> +{
> +    int ret;
> +    BlockDriverState *bs_snapshot;
> +    int64_t total_size;
> +    QemuOpts *opts = NULL;
> +    char tmp_filename[PATH_MAX + 1];
> +    QDict *snapshot_options = qdict_new();
> +
> +    /* Prepare options QDict for the overlay file */
> +    qdict_put(snapshot_options, "file.driver",
> +              qstring_from_str("file"));
> +    qdict_put(snapshot_options, "driver",
> +              qstring_from_str("qcow2"));

Both of these statements fit each in a single line.

> +    /* Create temporary file */
> +    ret = get_tmp_filename(tmp_filename, PATH_MAX + 1);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Could not get temporary filename");
> +        goto out;
> +    }
> +    qdict_put(snapshot_options, "file.filename",
> +              qstring_from_str(tmp_filename));
> +
> +    /* Get the required size from the image */
> +    total_size = bdrv_getlength(bs);
> +    if (total_size < 0) {
> +        error_setg_errno(errp, -total_size, "Could not get image size");
> +        goto out;
> +    }
> +
> +    opts = qemu_opts_create(bdrv_qcow2.create_opts, NULL, 0, &error_abort);
> +    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, total_size, &error_abort);
> +    ret = bdrv_create(&bdrv_qcow2, tmp_filename, opts, errp);
> +    qemu_opts_del(opts);
> +    if (ret < 0) {
> +        error_prepend(errp, "Could not create temporary overlay '%s': ",
> +                      tmp_filename);
> +        goto out;
> +    }
> +
> +    bs_snapshot = bdrv_open(NULL, NULL, snapshot_options,
> +                            BDRV_O_RDWR | BDRV_O_TEMPORARY, errp);
> +    snapshot_options = NULL;
> +    if (!bs_snapshot) {
> +        ret = -EINVAL;

The value of ret is unused, so why set it here?

> +        goto out;
> +    }
> +
> +    /* bdrv_append() consumes a strong reference to bs_snapshot (i.e. it will
> +     * call bdrv_unref() on it), so in order to be able to return one, we have
> +     * to increase bs_snapshot's refcount here */
> +    bdrv_ref(bs_snapshot);
> +    bdrv_append(bs_snapshot, bs);

Actually, your case is exactly what bdrv_append() is designed for: You
don't need to return a strong reference here, the caller just checks for
NULL and that's it. So:

1. bdrv_open() return a strong reference (refcount = 1)
2. You do bdrv_ref() (refcount = 2)
3. bdrv_append() takes a reference and uses it for bs->file
...
4. bdrv_close() calls blkreplay_close(), which does a bdrv_unref()
   (refcount = 1)
5. bdrv_close() unrefs all child nodes (refcount = 0 --> delete)

You can simplify this by just not doing the extra bdrv_ref/unref (i.e.
remove steps 2 and 4). The correct reference counting is already taken
care of by bdrv_append() and bdrv_close().

> +    return bs_snapshot;
> +
> +out:
> +    QDECREF(snapshot_options);
> +    return NULL;
> +}

Kevin
