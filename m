Received: from eggs.gnu.org ([2001:4830:134:3::10]:56066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1elFeh-00075T-Lw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1elFee-0000IC-Uu
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:04:31 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1518441241-32557-3-git-send-email-anton.nefedov@virtuozzo.com>
References: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1518441241-32557-3-git-send-email-anton.nefedov@virtuozzo.com>
Date: Mon, 12 Feb 2018 16:03:49 +0100
Message-ID: <w51sha68d2i.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block: fix write with zero flag set
 and iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, eblake@redhat.com

On Mon 12 Feb 2018 02:14:01 PM CET, Anton Nefedov wrote:
> The normal bdrv_co_pwritev() use is either
>   - BDRV_REQ_ZERO_WRITE clear and iovector provided
>   - BDRV_REQ_ZERO_WRITE set and iovector == NULL
>
> while
>   - the flag clear and iovector == NULL is an assertion failure
>     in bdrv_co_do_zero_pwritev()
>   - the flag set and iovector provided is in fact allowed
>     (the flag prevails and zeroes are written)
>
> However the alignment logic does not support the latter case so the
> padding areas get overwritten with zeroes.

Oh, so this doesn't simply write zeroes in [offset, offset+bytes), but
also in the head and tail areas, instead of keeping the previous
contents.

This is a pretty serious bug, but I assume it can't be triggered
(bdrv_pwrite_zeroes() is used in complete clusters). Did you check if
there was any other scenario where this could happen?

> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
