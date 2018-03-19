Received: from eggs.gnu.org ([2001:4830:134:3::10]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1extHP-0004It-TZ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1extHN-0003XS-BV
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 07:48:43 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1520849818-6915-6-git-send-email-anton.nefedov@virtuozzo.com>
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1520849818-6915-6-git-send-email-anton.nefedov@virtuozzo.com>
Date: Mon, 19 Mar 2018 12:02:24 +0100
Message-ID: <w51po408h1b.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 5/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
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

On Mon 12 Mar 2018 11:16:54 AM CET, Anton Nefedov wrote:
> The idea is that ALLOCATE requests may overlap with other requests.
> Reuse the existing block layer infrastructure for serialising requests.
> Use the following approach:
>   - mark ALLOCATE serialising, so subsequent requests to the area wait
>   - ALLOCATE request itself must never wait if another request is in flight
>     already. Return EAGAIN, let the caller reconsider.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

> @@ -1498,8 +1507,13 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>      max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
>                                     align);
>  
> -    waited = wait_serialising_requests(req);
> -    assert(!waited || !req->serialising);
> +    found = find_or_wait_serialising_requests(req,
> +                                              !(flags & BDRV_REQ_ALLOCATE));
> +    if (found && (flags & BDRV_REQ_ALLOCATE)) {
> +        return -EAGAIN;
> +    }
> +

Another alternative (perhaps a bit more readable):

    if (flags & BDRV_REQ_ALLOCATE) {
        if (find_or_wait_serialising_requests(req, false)) {
            return -EAGAIN;
        }
    } else {
        bool found = wait_serialising_requests(req);
        assert(!found || !req->serialising);
    }

but yours is fine, so keep it if you prefer.

Berto
