Received: from eggs.gnu.org ([2001:4830:134:3::10]:46830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1ewqf4-00083i-GN
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1ewqf3-0002r1-Oy
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:48:50 -0400
MIME-Version: 1.0
In-Reply-To: <20180316144307.31073-1-nia.alarie@gmail.com>
References: <20180316144307.31073-1-nia.alarie@gmail.com>
From: nee <nia.alarie@gmail.com>
Date: Fri, 16 Mar 2018 14:48:47 +0000
Message-ID: <CA+k8WDph7XGyZQ2BY31rpRWpVq_zLCqunt0eqGiH7N_2kEkeRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/xen_disk: Convert atoi use to
 qemu_strtol to allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Nia Alarie <nia.alarie@gmail.com>

On Fri, Mar 16, 2018 at 2:43 PM, Nia Alarie <nia.alarie@gmail.com> wrote:
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> ---
>  hw/block/xen_disk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index f74fcd42d1..a9ec0ad6eb 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -32,6 +32,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qemu/cutils.h"
>  #include "trace.h"
>
>  /* ------------------------------------------------------------- */
> @@ -1010,7 +1011,10 @@ static int blk_init(struct XenDevice *xendev)
>          blkdev->devtype = xenstore_read_be_str(&blkdev->xendev, "device-type");
>      }
>      directiosafe = xenstore_read_be_str(&blkdev->xendev, "direct-io-safe");
> -    blkdev->directiosafe = (directiosafe && atoi(directiosafe));
> +
> +    if (directiosafe && qemu_strtoi(directiosafe, NULL, 10, &blkdev->directiosafe)) {
> +        goto out_error;
> +    }
>
>      /* do we have all we need? */
>      if (blkdev->params == NULL ||
> --
> 2.16.2
>

I've just realised that this patch is slightly wrong and doesn't match
the original code exactly. Please disregard.
