Received: from eggs.gnu.org ([209.51.188.92]:45144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDraB-0007fR-PU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDraA-0002r1-OB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:18:39 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Tue, 09 Apr 2019 16:18:32 +0200
Message-ID: <w517ec345zb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block: include base when checking
 image chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On Mon 08 Apr 2019 08:22:19 PM CEST, Andrey Shinkevich wrote:
>   * Return true if (a prefix of) the given range is allocated in any image
> - * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
> + * between BASE and TOP (TOP included). To check the BASE image, set the
> + * 'include_base' to 'true'. The BASE can be NULL to check if the given
>   * offset is allocated in any image of the chain.  Return false otherwise,
>   * or negative errno on failure.

I'm not a native speaker but that sounds a bit odd to me.

Alternative: 

  * Return true if (a prefix of) the given range is allocated in any image
  * between BASE and TOP (BASE is only included if include_base is set).
  * BASE can be NULL to check if the given offset is allocated in any
  * image of the chain.  Return false otherwise, or negative errno on
  * failure.

> -    while (intermediate && intermediate != base) {
> +    while (include_base || intermediate != base) {
>          int64_t pnum_inter;
>          int64_t size_inter;
>  
> @@ -2360,6 +2364,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>              n = pnum_inter;
>          }
>  
> +        if (intermediate == base) {
> +            break;
> +        }
> +
>          intermediate = backing_bs(intermediate);

I find that the new condition + the break make things a bit less
readable. I think it would be simpler with something like this:

   BlockDriverState *stop_at = include_base ? backing_bs(base) : base;

   while (intermediate != stop_at) {
      ...
   }

(stop_at is a terrible name, but I can't think of anything better at the
moment)

Berto
