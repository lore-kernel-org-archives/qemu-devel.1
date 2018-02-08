Received: from eggs.gnu.org ([2001:4830:134:3::10]:33002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejvdc-0001IY-2r
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejvda-0001cV-RM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 18:29:56 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78712c7a-a8f0-5d7b-d1f5-d37fcb178655@redhat.com>
Date: Thu, 8 Feb 2018 17:29:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/27] qcow2: Pass BlockdevCreateOptions to
 qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> All of the simple options are now passed to qcow2_create2() in a
> BlockdevCreateOptions object. Still missing: node-name and the
> encryption options.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 152 insertions(+), 38 deletions(-)
> 

> -static size_t qcow2_opt_get_cluster_size_del(QemuOpts *opts, Error **errp)
> +static bool validate_cluster_size(size_t cluster_size, Error **errp)
>   {
> -    size_t cluster_size;
> -    int cluster_bits;
> -
> -    cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
> -                                         DEFAULT_CLUSTER_SIZE);
> -    cluster_bits = ctz32(cluster_size);
> +    int cluster_bits = ctz32(cluster_size);
>       if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits > MAX_CLUSTER_BITS ||
>           (1 << cluster_bits) != cluster_size)

Pre-existing, but why are we manually calling ctz32() instead of using 
is_power_of_2()?

> @@ -2720,10 +2726,92 @@ static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
>        */
>       BlockBackend *blk;
>       QCowHeader *header;
> +    size_t cluster_size;
> +    int version;
> +    int refcount_order;
>       uint64_t* refcount_table;
>       Error *local_err = NULL;
>       int ret;
>   
> +    /* Validate options and set default values */
> +    assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
> +    qcow2_opts = &create_options->u.qcow2;
> +
> +    if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
> +        error_setg(errp, "Image size must be a multiple of 512 bytes");
> +        ret = -EINVAL;
> +        goto out;
> +    }

This check looks new.  Does it really belong in this patch?  And it does 
NOT match what qemu-img can currently do, nor the fact that qcow2 
supports byte-based addressing:

$ qemu-img create -f qcow2 tmp 12345
Formatting 'tmp', fmt=qcow2 size=12345 cluster_size=65536 
lazy_refcounts=off refcount_bits=16

> +    if (!qcow2_opts->has_lazy_refcounts) {
> +        qcow2_opts->lazy_refcounts = false;
> +    }
> +    if (version < 3 && qcow2_opts->lazy_refcounts) {
> +        error_setg(errp, "Lazy refcounts only supported with compatibility "
> +                   "level 1.1 and above (use compat=1.1 or greater)");

Do we want to reword this error message at all, now that QMP spells it 
'v3'?  Should qemu-img be taught to accept 'compat=v3' as a synonym to 
'compat=1.1'?

> +        return -EINVAL;
> +    }
> +
> +    if (!qcow2_opts->has_refcount_bits) {
> +        qcow2_opts->refcount_bits = 16;
> +    }
> +    if (qcow2_opts->refcount_bits > 64 ||
> +        !is_power_of_2(qcow2_opts->refcount_bits))
> +    {
> +        error_setg(errp, "Refcount width must be a power of two and may not "
> +                   "exceed 64 bits");
> +        return -EINVAL;
> +    }
> +    if (version < 3 && qcow2_opts->refcount_bits != 16) {
> +        error_setg(errp, "Different refcount widths than 16 bits require "
> +                   "compatibility level 1.1 or above (use compat=1.1 or "
> +                   "greater)");

and again

> @@ -2978,9 +3068,33 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
>       }
>   
>       /* Create the qcow2 image (format layer) */
> -    ret = qcow2_create2(bs, size, backing_file, backing_fmt, flags,
> -                        cluster_size, prealloc, opts, version, refcount_order,
> -                        encryptfmt, errp);
> +    create_options = (BlockdevCreateOptions) {
> +        .driver         = BLOCKDEV_DRIVER_QCOW2,
> +        .u.qcow2        = {
> +            .file               = &(BlockdevRef) {
> +                .type               = QTYPE_QSTRING,
> +                .u.reference        = bs->node_name,
> +            },
> +            .size               = size,
> +            .has_version        = true,
> +            .version            = version == 2
> +                                  ? BLOCKDEV_QCOW2_VERSION_V2
> +                                  : BLOCKDEV_QCOW2_VERSION_V3,
> +            .has_backing_file   = (backing_file != NULL),
> +            .backing_file       = backing_file,
> +            .has_backing_fmt    = (backing_fmt != NULL),

I might have spelled it '= !!backing_fmt', but your way is fine too.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
