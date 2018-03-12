Received: from eggs.gnu.org ([2001:4830:134:3::10]:53381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLoU-0003B2-C9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLoS-0004Je-Ss
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:40:22 -0400
Date: Mon, 12 Mar 2018 11:40:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312114009.GI3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172713.26318-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] luks: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Fri, Mar 09, 2018 at 06:27:10PM +0100, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to luks, which enables
> image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 17 ++++++++++++++++-
>  block/crypto.c       | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 524d51567a..07039bfe9c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3452,6 +3452,21 @@
>              '*preallocation':   'PreallocMode' } }
>  
>  ##
> +# @BlockdevCreateOptionsLUKS:
> +#
> +# Driver specific image creation options for LUKS.
> +#
> +# @file             Node to create the image format on
> +# @size             Size of the virtual disk in bytes
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsLUKS',
> +  'data': { 'file':             'BlockdevRef',
> +            'qcrypto':          'QCryptoBlockCreateOptionsLUKS',
> +            'size':             'size' } }

s/qcrypto/crypto/ in this field.


I do wonder about whether instead of embedding QCryptoBlockCreateOptionsLUKS
as a field, we could instead use QCryptoBlockCreateOptionsLUKS as the
base struct and just inherit from it to add file/size.

I'm not really fussed, but I wonder if you/Eric have any thoughts on the pros
or cons of inheritance vs embedding in this case.

> +
> +##
>  # @BlockdevCreateOptionsNfs:
>  #
>  # Driver specific image creation options for NFS.
> @@ -3643,7 +3658,7 @@
>        'http':           'BlockdevCreateNotSupported',
>        'https':          'BlockdevCreateNotSupported',
>        'iscsi':          'BlockdevCreateNotSupported',
> -      'luks':           'BlockdevCreateNotSupported',
> +      'luks':           'BlockdevCreateOptionsLUKS',
>        'nbd':            'BlockdevCreateNotSupported',
>        'nfs':            'BlockdevCreateOptionsNfs',
>        'null-aio':       'BlockdevCreateNotSupported',
> diff --git a/block/crypto.c b/block/crypto.c
> index b0a4cb3388..2035f9ab13 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -543,6 +543,39 @@ static int block_crypto_open_luks(BlockDriverState *bs,
>                                       bs, options, flags, errp);
>  }
>  
> +static int coroutine_fn
> +block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
> +{
> +    BlockdevCreateOptionsLUKS *luks_opts;
> +    BlockDriverState *bs = NULL;
> +    QCryptoBlockCreateOptions create_opts;
> +    int ret;
> +
> +    assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
> +    luks_opts = &create_options->u.luks;
> +
> +    bs = bdrv_open_blockdev_ref(luks_opts->file, errp);
> +    if (bs == NULL) {
> +        return -EIO;
> +    }
> +
> +    create_opts = (QCryptoBlockCreateOptions) {
> +        .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
> +        .u.luks = *luks_opts->qcrypto,
> +    };
> +
> +    ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
> +                                         errp);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    ret = 0;
> +fail:
> +    bdrv_unref(bs);
> +    return ret;
> +}
> +
>  static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
>                                                           QemuOpts *opts,
>                                                           Error **errp)
> @@ -647,6 +680,7 @@ BlockDriver bdrv_crypto_luks = {
>      .bdrv_open          = block_crypto_open_luks,
>      .bdrv_close         = block_crypto_close,
>      .bdrv_child_perm    = bdrv_format_default_perms,
> +    .bdrv_co_create     = block_crypto_co_create_luks,
>      .bdrv_co_create_opts = block_crypto_co_create_opts_luks,
>      .bdrv_truncate      = block_crypto_truncate,
>      .create_opts        = &block_crypto_create_opts_luks,
> -- 
> 2.13.6
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
