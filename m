Received: from eggs.gnu.org ([2001:4830:134:3::10]:58816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPgW-0005hn-6b
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPgV-0000we-7B
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:59:12 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-12-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab90d9c1-ea99-9a21-7303-e26af2796d22@redhat.com>
Date: Thu, 15 Feb 2018 13:58:50 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/27] block: x-blockdev-create QMP command
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
> This adds a synchronous x-blockdev-create QMP command that can create
> qcow2 images on a given node name.
> 
> We don't want to block while creating an image, so this is not the final
> interface in all aspects, but BlockdevCreateOptionsQcow2 and
> .bdrv_co_create() are what they actually might look like in the end. In
> any case, this should be good enough to test whether we interpret
> BlockdevCreateOptions as we should.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> @@ -3442,6 +3442,18 @@
>     } }
>   
>   ##
> +# @x-blockdev-create:
> +#
> +# Create an image format on a given node.
> +# TODO Replace with something asynchronous (block job?)

We've learned our lesson - don't commit to the final name on an 
interface that we have not yet experimented with.

> +#
> +# Since: 2.12
> +##
> +{ 'command': 'x-blockdev-create',
> +  'data': 'BlockdevCreateOptions',
> +  'boxed': true }
> +

Lots of code packed in that little description ;)


> +++ b/include/block/block_int.h
> @@ -130,6 +130,8 @@ struct BlockDriver {
>       int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
>                             Error **errp);
>       void (*bdrv_close)(BlockDriverState *bs);
> +    int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
> +                                       Error **errp);

I know we haven't been very good in the past, but can you add a comment 
here on the contract that drivers are supposed to obey when implementing 
this callback?

> +++ b/block.c
> @@ -369,7 +369,7 @@ BlockDriver *bdrv_find_format(const char *format_name)
>       return bdrv_do_find_format(format_name);
>   }
>   
> -static int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)
> +int bdrv_is_whitelisted(BlockDriver *drv, bool read_only)

Worth mentioning that bdrv_is_whitelisted had to be exported as part of 
the commit message?  (Or even promoting it to public in a separate commit?)

> +++ b/block/create.c
> @@ -0,0 +1,75 @@
> +/*
> + * Block layer code related to image creation
> + *
> + * Copyright (c) 2018 Kevin Wolf <kwolf@redhat.com>

The question came up in another thread, but I didn't hear your answer 
there; I know Red Hat permits you to claim personal copyright while 
still using a redhat.com address for code written on personal time, but 
should this claim belong to Red Hat instead of you?

> +    /* Call callback if it exists */
> +    if (!drv->bdrv_co_create) {
> +        error_setg(errp, "Driver does not support blockdev-create");

Should this error message refer to 'x-blockdev-create' in the short term?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
