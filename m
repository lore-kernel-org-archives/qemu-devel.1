Received: from eggs.gnu.org ([2001:4830:134:3::10]:57832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egu3E-0003hZ-38
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egu37-0004gi-Kd
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:11:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
Date: Wed, 31 Jan 2018 16:11:06 +0100
Message-ID: <w51y3kexdv9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 4/9] block: treat BDRV_REQ_ALLOCATE as
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

On Thu 18 Jan 2018 06:49:02 PM CET, Anton Nefedov wrote:

> -static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
> +static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self,
> +                                                   bool nowait)

It's a bit confusing to have a function called wait_foo() with a
parameter that says "don't wait"...

How about

     check_serialising_requests(BdrvTrackedRequest *self, bool wait)

> -    waited = wait_serialising_requests(req);
> +    waited = wait_serialising_requests(req, flags & BDRV_REQ_ALLOCATE);
> +    if (waited && flags & BDRV_REQ_ALLOCATE) {
> +        return -EAGAIN;
> +    }

I find this more readable (even if not strictly necessary):

       if (waited && (flags & BDRV_REQ_ALLOCATE)) {

None of my two comments are blockers, though, so

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
