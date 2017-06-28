Received: from eggs.gnu.org ([2001:4830:134:3::10]:33790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQDF0-0005Hf-Pt
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQDEw-00014T-TY
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:42:46 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170623124700.1389-7-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-7-el13635@mail.ntua.gr>
Date: Wed, 28 Jun 2017 15:42:41 +0200
Message-ID: <w51efu41b5a.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 6/8] block: add options parameter to
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 23 Jun 2017 02:46:58 PM CEST, Manos Pitsidianakis wrote:
>  BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
> -                                       int flags, Error **errp)
> +                                       int flags, QDict *options, Error **errp)
>  {
>      BlockDriverState *bs;
>      int ret;
>  
>      bs = bdrv_new();
>      bs->open_flags = flags;
> -    bs->explicit_options = qdict_new();
> -    bs->options = qdict_new();
> +    if (options) {
> +        bs->explicit_options = qdict_clone_shallow(options);
> +        bs->options = qdict_clone_shallow(options);
> +    } else {
> +        bs->explicit_options = qdict_new();
> +        bs->options = qdict_new();
> +    }
>      bs->opaque = NULL;
>  
>      update_options_from_flags(bs->options, flags);
>  
> -    ret = bdrv_open_driver(bs, drv, node_name, bs->options, flags, errp);
> +    ret = bdrv_open_driver(bs, drv, node_name, options, flags, errp);

Why this last change? In the default case you're now passing NULL
instead of the QDict created with qdict_new().

Berto
