Received: from eggs.gnu.org ([2001:4830:134:3::10]:33754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=69586b2aa=anthony.perard@citrix.com>)
	id 1fT4E9-0007qC-4z
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=69586b2aa=anthony.perard@citrix.com>)
	id 1fT4E6-0004Zw-38
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:46:13 -0400
Date: Wed, 13 Jun 2018 12:46:02 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180613114602.GC2165@perard.uk.xensource.com>
References: <20180612235103.12633-1-brogers@suse.com>
	<20180612235103.12633-2-brogers@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180612235103.12633-2-brogers@suse.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] xen: add xen disk naming for use in
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, sstabellini@kernel.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com

On Tue, Jun 12, 2018 at 05:51:02PM -0600, Bruce Rogers wrote:
> Provide monitor naming of xen disks, including associating an
> attached dev_id for a BlockBackend which has legacy_dev set.
> Currently, only xen disks have legacy_dev set to true.
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  block/block-backend.c |  5 ++++-
>  hw/block/xen_disk.c   | 15 +++++++++++++++
>  include/hw/xen/xen.h  |  2 ++
>  stubs/xen-common.c    |  5 +++++
>  4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index d55c328736..db39dfe867 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -23,6 +23,7 @@
>  #include "qemu/option.h"
>  #include "trace.h"
>  #include "migration/misc.h"
> +#include "hw/xen/xen.h"
>  
>  /* Number of coroutines to reserve per attached device model */
>  #define COROUTINE_POOL_RESERVATION 64
> @@ -895,7 +896,9 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
>  {
>      DeviceState *dev;
>  
> -    assert(!blk->legacy_dev);
> +    if (blk->legacy_dev) {
> +        return xen_blk_get_attached_dev_id(blk->dev);
> +    }
>      dev = blk->dev;
>  
>      if (!dev) {

Hi Bruce,

Thanks for your patches!

But I don't think that the right way to go. We probably needs to
qdevifie xen_disk instead. This is point out by the numerous TODO about
"qdevified", and this very old mail:
https://lists.nongnu.org/archive/html/qemu-devel/2016-09/msg07902.html

Thanks,

-- 
Anthony PERARD
