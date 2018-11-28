Received: from eggs.gnu.org ([2001:4830:134:3::10]:52654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gS2Hh-0002VM-E4
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gS2Hb-0008V6-Dq
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:01:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gS2Hb-0008U6-67
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:01:47 -0500
Date: Wed, 28 Nov 2018 17:01:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181128160141.GD4222@dhcp-200-186.str.redhat.com>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133511.24538.70006.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010133511.24538.70006.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH v7 17/19] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

Am 10.10.2018 um 15:35 hat Pavel Dovgalyuk geschrieben:
> Replay is capable of recording normal BH events, but sometimes
> there are single use callbacks scheduled with aio_bh_schedule_oneshot
> function. This patch enables recording and replaying such callbacks.
> Block layer uses these events for calling the completion function.
> Replaying these calls makes the execution deterministic.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

What are the rules for using aio_bh_schedule_oneshot() vs.
replay_bh_schedule_oneshot_event()? You are modifying one place, but if
I grep for aio_bh_schedule_oneshot(), I find many other places that
use it. Why is this one place special?

> --
> 
> v6:
>  - moved stub function to the separate file for fixing linux-user build
> ---
>  block/block-backend.c    |    3 ++-
>  include/sysemu/replay.h  |    3 +++
>  replay/replay-events.c   |   16 ++++++++++++++++
>  replay/replay-internal.h |    1 +
>  replay/replay.c          |    2 +-
>  stubs/Makefile.objs      |    1 +
>  stubs/replay-user.c      |    9 +++++++++
>  7 files changed, 33 insertions(+), 2 deletions(-)
>  create mode 100644 stubs/replay-user.c
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index dc0cd57..04f5554 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -17,6 +17,7 @@
>  #include "block/throttle-groups.h"
>  #include "sysemu/blockdev.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/replay.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-block.h"
>  #include "qemu/id.h"
> @@ -1379,7 +1380,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
>  
>      acb->has_returned = true;
>      if (acb->rwco.ret != NOT_DONE) {
> -        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
> +        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
>                                  blk_aio_complete_bh, acb);

Indentation is off.

Kevin
