Received: from eggs.gnu.org ([2001:4830:134:3::10]:46778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmfw1-0006ER-TE
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmfvy-0003UO-1k
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:48:01 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1501597152-25342-4-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-4-git-send-email-anton.nefedov@virtuozzo.com>
Date: Tue, 29 Aug 2017 14:47:53 +0200
Message-ID: <w51y3q2fsli.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 03/15] block: introduce
 BDRV_REQ_ALLOCATE flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com

On Tue 01 Aug 2017 04:19:00 PM CEST, Anton Nefedov wrote:
> The flag is supposed to indicate that the region of the disk image has
> to be sufficiently allocated so it reads as zeroes. The call with the flag
> set has to return -ENOTSUP if allocation cannot be done efficiently
> (i.e. without falling back to writing actual buffers)
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

> +    /* allocation request with qiov provided doesn't make much sense */
> +    assert(!(qiov && flags & BDRV_REQ_ALLOCATE));

> +    assert(!(flags & BDRV_REQ_MAY_UNMAP && flags & BDRV_REQ_ALLOCATE));
> +
> +    if (flags & BDRV_REQ_ALLOCATE &&
> +        !(child->bs->supported_zero_flags & BDRV_REQ_ALLOCATE))

I find it more readable with parentheses like this:

  assert(!(qiov && (flags & BDRV_REQ_ALLOCATE)));
  assert(!((flags & BDRV_REQ_MAY_UNMAP) && (flags & BDRV_REQ_ALLOCATE)));
  if ((flags & BDRV_REQ_ALLOCATE) &&
      !(child->bs->supported_zero_flags & BDRV_REQ_ALLOCATE))

but your code is correct as it is.

Berto
