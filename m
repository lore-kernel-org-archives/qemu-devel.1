Received: from eggs.gnu.org ([209.51.188.92]:56331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h0kv7-0007lh-K3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h0kv6-0004qh-NR
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:34:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1h0kv6-0004oP-Dv
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:34:04 -0500
Date: Mon, 4 Mar 2019 11:33:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190304103353.GA6059@localhost.localdomain>
References: <155074704329.32129.17530905097298071558.stgit@pasha-VirtualBox>
	<155074715265.32129.1158027635780211224.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155074715265.32129.1158027635780211224.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH v13 19/25] replay: add BH oneshot event for
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Am 21.02.2019 um 12:05 hat Pavel Dovgalyuk geschrieben:
> Replay is capable of recording normal BH events, but sometimes
> there are single use callbacks scheduled with aio_bh_schedule_oneshot
> function. This patch enables recording and replaying such callbacks.
> Block layer uses these events for calling the completion function.
> Replaying these calls makes the execution deterministic.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> --
> 
> v6:
>  - moved stub function to the separate file for fixing linux-user build
> v10:
>  - replaced all block layer aio_bh_schedule_oneshot calls
> ---
>  block/block-backend.c    |    8 +++++---
>  block/io.c               |    4 ++--
>  block/iscsi.c            |    5 +++--
>  block/nfs.c              |    5 +++--
>  block/null.c             |    4 +++-
>  block/nvme.c             |    6 ++++--
>  block/rbd.c              |    5 +++--
>  block/vxhs.c             |    5 +++--
>  include/sysemu/replay.h  |    3 +++
>  replay/replay-events.c   |   16 ++++++++++++++++
>  replay/replay-internal.h |    1 +
>  replay/replay.c          |    2 +-
>  stubs/Makefile.objs      |    1 +
>  stubs/replay-user.c      |    9 +++++++++
>  14 files changed, 57 insertions(+), 17 deletions(-)
>  create mode 100644 stubs/replay-user.c

This still doesn't catch all instances, e.g. everything that goes
through aio_co_schedule() is missing.

But I fully expect this to get broken anyway all the time because nobody
understands which function to use, and if it works for your special case
now and we'll fix other stuff as you encouter it, maybe that's good
enough for you.

> @@ -1349,8 +1351,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
>  
>      acb->has_returned = true;
>      if (acb->rwco.ret != NOT_DONE) {
> -        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
> -                                blk_aio_complete_bh, acb);
> +        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> +                                         blk_aio_complete_bh, acb);
>      }

This, and a few other places that you convert, are in fast paths and add
some calls that are unnecessary for non-replay cases.

I wonder if we could make replay optional in ./configure and then make
replay_bh_schedule_oneshot_event() a static inline function that can get
optimised away at compile time if the feature is disabled.

Kevin
