Received: from eggs.gnu.org ([209.51.188.92]:50605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ggrcq-0007rv-TG
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ggrcp-00056O-89
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:40:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181218075707.12006-10-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
	<20181218075707.12006-10-anton.nefedov@virtuozzo.com>
Date: Tue, 08 Jan 2019 14:40:49 +0100
Message-ID: <w51d0p7uv1a.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 09/10] qcow2: skip writing zero buffers
 to empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Tue 18 Dec 2018 08:57:45 AM CET, Anton Nefedov wrote:
> @@ -2126,24 +2202,33 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>              goto fail;
>          }
>  
> +        qemu_co_mutex_unlock(&s->lock);
> +
> +        ret = handle_alloc_space(bs, l2meta);
> +        if (ret < 0) {
> +            qemu_co_mutex_lock(&s->lock);
> +            goto fail;
> +        }

I think you could add a brief comment before the handle_alloc_space()
call to indicate what it does.

The patch looks good to me else, but since it seems you're changing it
in the next revision I'll wait for it.

Berto
