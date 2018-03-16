Received: from eggs.gnu.org ([2001:4830:134:3::10]:49951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewn6j-0004jX-RU
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewn6f-0003od-KA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:01:09 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1520849818-6915-5-git-send-email-anton.nefedov@virtuozzo.com>
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1520849818-6915-5-git-send-email-anton.nefedov@virtuozzo.com>
Date: Fri, 16 Mar 2018 12:01:02 +0100
Message-ID: <w51k1ucp9n5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 4/9] block: introduce BDRV_REQ_ALLOCATE
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Mon 12 Mar 2018 11:16:53 AM CET, Anton Nefedov wrote:
> The flag is supposed to indicate that the region of the disk image has
> to be sufficiently allocated so it reads as zeroes.
>
> The call with the flag set must return -ENOTSUP if allocation cannot
> be done efficiently.
> This has to be made sure of by both
>   - the drivers that support the flag
>   - and the common block layer (so it will not fall back to any slowpath
>     (like writing zero buffers) in case the driver does not support
>     the flag).
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Hmm... this is not the patch that I reviewed, please remove the R-b
lines when you submit a modified patch.

> +    /* The BDRV_REQ_ALLOCATE flag is used to indicate that the driver has to
> +     * efficiently allocate the space so it reads as zeroes, or return an error.
> +     * Must be used together with BDRV_REQ_ZERO_WRITE.

I guess it's understandable from the context but it's not immediately
obvious that you can set BDRV_REQ_ZERO_WRITE but not this one.

Perhaps it could be rephrased as something like "If this is set then
BDRV_REQ_ZERO_WRITE must also be set".

> +     * Contradictory to BDRV_REQ_MAY_UNMAP so the two must not be used together.

Or simply "This flag cannot be set together with BDRV_REQ_MAY_UNMAP".

> +     */
> +    BDRV_REQ_ALLOCATE           = 0x40,

Berto
