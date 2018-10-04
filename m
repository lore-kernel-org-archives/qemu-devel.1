Received: from eggs.gnu.org ([2001:4830:134:3::10]:32934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g835s-0005yY-0w
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g835l-0002wI-3z
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:51:03 -0400
Date: Thu, 4 Oct 2018 14:50:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181004125035.GD6009@localhost.localdomain>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-15-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001102928.20533-15-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 14/18] block/fleecing-hook: internal api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, den@openvz.org

Am 01.10.2018 um 12:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Add some functions to use fleecing-hook internally from backup job in
> further commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block.h |  9 ++++++++
>  block/fleecing-hook.c | 51 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 4edc1e8afa..018751b6ea 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -710,4 +710,13 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
>                                      BdrvChild *dst, uint64_t dst_offset,
>                                      uint64_t bytes, BdrvRequestFlags read_flags,
>                                      BdrvRequestFlags write_flags);
> +
> +
> +BlockDriverState *bdrv_fleecing_hook_append(BlockDriverState *source,
> +                                            BlockDriverState *target,
> +                                            const char *copy_bitmap_name,
> +                                            Error **errp);
> +void bdrv_fleecing_hook_drop(BlockDriverState *hook);
> +uint64_t bdrv_fleecing_hook_progress(BlockDriverState *hook);

Public block.h interfaces that are specific to a single driver are bad
design. If at all possible, the generic block layer shouldn't know
anything about specific drivers.

Luckily, if you make the driver more consistent with what mirror and
commit are doing, you won't need public interfaces any more and the
functions will just become part of the backup job driver. (The backup
driver can still be split into multiple source files if necessary, and
then use a separate internal header; I'm not sure if this is the case
here, though.)

Kevin
