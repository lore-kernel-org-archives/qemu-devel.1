Received: from eggs.gnu.org ([209.51.188.92]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtcbm-0002ZT-Oo
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtcOY-0003Tq-6G
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:02:59 -0500
Date: Tue, 12 Feb 2019 19:02:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190212180231.GJ5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<61bbfa3721938326edb03db58a6a246b384f3260.1547739122.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61bbfa3721938326edb03db58a6a246b384f3260.1547739122.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 09/13] block: Add 'runtime_opts' and
 'mutable_opts' fields to BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 17.01.2019 um 16:34 hat Alberto Garcia geschrieben:
> This patch adds two new fields to BlockDriver:
> 
>    - runtime_opts: list of runtime options for a particular block
>      driver. We'll use this list later to detect what options are
>      missing when we try to reopen a block device.
> 
>    - mutable_opts: names of the runtime options that can be reset to
>      their default value after a block device has been added. This way
>      an option can not be reset by omitting it during reopen unless we
>      explicitly allow it.
> 
> This also sets runtime_opts (and mutable_opts where appropriate) in
> all drivers that allow reopening.

qcow2 most certainly does support reopening, and is probably one of the
few drivers that actually allow changing things at runtime. Still, it's
missing from this patch.

> Most of those drivers don't actually
> support changing any of their options. If the user specifies a new
> value for an option that can't be changed then we already detect that
> and forbid it (in bdrv_reopen_prepare()). But if the user omits an
> option in order to try to reset it to its default value we need to
> detect that, so we'll use these two new fields for that.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index fd0e88d17a..e680dda86b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -345,6 +345,13 @@ struct BlockDriver {
>  
>      /* List of options for creating images, terminated by name == NULL */
>      QemuOptsList *create_opts;
> +    /* Runtime options for a block device, terminated by name == NULL */
> +    QemuOptsList *runtime_opts;

I'm not sure if using a QemuOptsList here is a good idea. Currently, we
use QemuOptsLists for most options, but there are some drivers that use
it only for part of their options, or not at all, using direct QDict
accesses or QAPI objects for the rest.

Especially the part with the QAPI objects is something that I'd hope to
see more in the future, and tying things to QemuOpts might make this
conversion harder.

> +    /*
> +     * Names of the runtime options that can be reset by omitting
> +     * their value on reopen, NULL-terminated.
> +     */
> +    const char *const *mutable_opts;
>  
>      /*
>       * Returns 0 for completed check, -errno for internal errors.
> diff --git a/block/rbd.c b/block/rbd.c
> index 8a1a9f4b6e..6de6112ce8 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1231,6 +1231,7 @@ static QemuOptsList qemu_rbd_create_opts = {
>  static BlockDriver bdrv_rbd = {
>      .format_name            = "rbd",
>      .instance_size          = sizeof(BDRVRBDState),
> +    .runtime_opts           = &runtime_opts,
>      .bdrv_parse_filename    = qemu_rbd_parse_filename,
>      .bdrv_refresh_limits    = qemu_rbd_refresh_limits,
>      .bdrv_file_open         = qemu_rbd_open,

rbd is one of these drivers. In fact, its runtime_opts seems to be
completely unused before this patch.

It has a comemnt 'server.* extracted manually, see qemu_rbd_mon_host()',
but if you compare it to the schema, more options that have been added
since are not covered in runtime_opts.

> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 90ab43baa4..6dd66d0b99 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -3288,6 +3288,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
>      .bdrv_attach_aio_context      = sd_attach_aio_context,
>  
>      .create_opts                  = &sd_create_opts,
> +    .runtime_opts                 = &runtime_opts,
>  };

Sheepdog is another driver where runtime_opts is incomplete (the
'server' struct is missing).

Kevin
