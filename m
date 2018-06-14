Received: from eggs.gnu.org ([2001:4830:134:3::10]:39451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTRxV-0007FU-77
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTRxU-0007MP-7N
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:06:37 -0400
Date: Thu, 14 Jun 2018 15:06:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180614130613.GE8564@localhost.localdomain>
References: <20180608192027.284601-1-vsementsov@virtuozzo.com>
	<20180608192027.284601-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608192027.284601-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qcow2: refactor data compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@gmail.com, pl@kamp.de, den@openvz.org

Am 08.06.2018 um 21:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Make a separate function for compression to be parallelized later.
>  - use .avail_aut field instead of .next_out to calculate size of

s/avail_aut/avail_out/

>    compressed data. It looks more natural and it allows to keep dest to
>    be void pointer
>  - set avail_out to be at least one byte less than input, to be sure
>    avoid inefficient compression earlier
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>  block/qcow2.c | 74 +++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 27 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 549fee9b69..d4dbe329ab 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -22,11 +22,13 @@
>   * THE SOFTWARE.
>   */
>  
> +#define ZLIB_CONST
> +#include <zlib.h>

The first #include must always be "qemu/osdep.h". If you want to
separate zlib.h from the internal headers, you can move it down instead.

>  #include "qemu/osdep.h"
>  #include "block/block_int.h"
>  #include "sysemu/block-backend.h"
>  #include "qemu/module.h"
> -#include <zlib.h>
>  #include "qcow2.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -3674,6 +3676,45 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
>      return 0;
>  }
>  
> +/* qcow2_compress()

The first line of the comment should contain only the /*

> + *
> + * @dest - destination buffer, at least of @size-1 bytes
> + * @src - source buffer, @size bytes
> + *
> + * Returns: compressed size on success
> + *          -1 if compression is inefficient
> + *          -2 on any other error
> + */

The logic looks fine.

Initially I intended to request splitting the code motion from the
changes, but I see that this would probably only make things more
complicated, so I'm okay with leaving that as it is.

Kevin
