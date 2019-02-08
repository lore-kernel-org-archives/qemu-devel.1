Received: from eggs.gnu.org ([209.51.188.92]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs5yY-00073R-PY
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gs5yW-0005l5-Qy
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 08:13:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1548244464-633186-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1548244464-633186-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Fri, 08 Feb 2019 14:13:32 +0100
Message-ID: <w51o97m8ltv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 1/1] Stream block job
 involves copy-on-read filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jcody@redhat.com, mreitz@redhat.com, den@openvz.org

On Wed 23 Jan 2019 12:54:24 PM CET, Andrey Shinkevich wrote:
> +static BlockDriverState *insert_filter(BlockDriverState *bs, Error **errp)
> +{
> +    BlockDriverState *cor_filter_bs;
> +    Error *local_err = NULL;
> +
> +    cor_filter_bs = create_filter_node(bs, errp);
> +    if (cor_filter_bs == NULL) {
> +        error_prepend(errp, "Could not create filter node: ");
> +        return NULL;
> +    }
> +
> +    bdrv_set_aio_context(cor_filter_bs, bdrv_get_aio_context(bs));
> +
> +    bdrv_drained_begin(bs);
> +    bdrv_replace_node(bs, cor_filter_bs, &local_err);
> +    bdrv_drained_end(bs);

I think this was already discussed in the previous version of this
patch: if you insert a copy-on-read filter here then all guest reads
will copy the data from the backing chain, but you don't want to copy
anything below the 'base' node, so the copy-on-read filter needs a
'base' parameter.

Berto
