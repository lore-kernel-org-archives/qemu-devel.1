Received: from eggs.gnu.org ([2001:4830:134:3::10]:41163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fAzZV-00018X-Nk
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fAzZU-0000Kf-KG
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:09:33 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180421132929.21610-2-mreitz@redhat.com>
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-2-mreitz@redhat.com>
Date: Tue, 24 Apr 2018 17:08:46 +0200
Message-ID: <w51in8g63r5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Sat 21 Apr 2018 03:29:21 PM CEST, Max Reitz wrote:
> This adds a simple copy-on-read filter driver.  It relies on the already
> existing COR functionality in the central block layer code, which may be
> moved here once we no longer need it there.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>


> +#define PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
> +                          | BLK_PERM_WRITE \
> +                          | BLK_PERM_RESIZE)
> +#define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
> +
> +static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                           const BdrvChildRole *role,
> +                           BlockReopenQueue *reopen_queue,
> +                           uint64_t perm, uint64_t shared,
> +                           uint64_t *nperm, uint64_t *nshared)
> +{
> +    if (c == NULL) {
> +        *nperm = (perm & PERM_PASSTHROUGH) | BLK_PERM_WRITE_UNCHANGED;
> +        *nshared = (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
> +        return;
> +    }
> +
> +    *nperm = (perm & PERM_PASSTHROUGH) |
> +             (c->perm & PERM_UNCHANGED);

I admit I'm not completely familiar with this, but don't you need to add
BLK_PERM_WRITE_UNCHANGED to *nperm ?

> +    *nshared = (shared & PERM_PASSTHROUGH) |
> +               (c->shared_perm & PERM_UNCHANGED);
> +}

Berto
