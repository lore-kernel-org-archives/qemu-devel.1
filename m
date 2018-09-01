Received: from eggs.gnu.org ([2001:4830:134:3::10]:34695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fvwiQ-0007z2-Rf
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 23:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fvwiM-0002wa-S4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 23:36:50 -0400
Date: Fri, 31 Aug 2018 23:31:07 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180901033106.GB416857@localhost.localdomain>
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831222907.16257-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/15] block/mirror: add block job
 creation flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Aug 31, 2018 at 06:28:54PM -0400, John Snow wrote:
> Add support for taking and passing forward job creaton flags.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/mirror.c            | 5 +++--
>  blockdev.c                | 3 ++-
>  include/block/block_int.h | 5 ++++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index b8941db6c1..cba555b4ef 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1639,7 +1639,8 @@ fail:
>  
>  void mirror_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *target, const char *replaces,
> -                  int64_t speed, uint32_t granularity, int64_t buf_size,
> +                  int creation_flags, int64_t speed,
> +                  uint32_t granularity, int64_t buf_size,
>                    MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
>                    BlockdevOnError on_source_error,
>                    BlockdevOnError on_target_error,
> @@ -1655,7 +1656,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>      }
>      is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
>      base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
> -    mirror_start_job(job_id, bs, JOB_DEFAULT, target, replaces,
> +    mirror_start_job(job_id, bs, creation_flags, target, replaces,
>                       speed, granularity, buf_size, backing_mode,
>                       on_source_error, on_target_error, unmap, NULL, NULL,
>                       &mirror_job_driver, is_none_mode, base, false,

This is another one of those comments that do not pertain directly to this
patch, so it doesn't affect my r-b.  So let's get that out of the way:

Reviewed-by: Jeff Cody <jcody@redhat.com>

Some of the block job functions have an impressive number of arguments now
(and have for a while, this isn't all that new).  I don't know if it is a
sign that our data design is a bit out of whack, or what.  But for instance,
mirror_start_job() takes 22 (!) parameters.  Seems like something worth
examining at some point.

-Jeff


> diff --git a/blockdev.c b/blockdev.c
> index c15a1e624b..6574356708 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3590,6 +3590,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>                                     bool has_copy_mode, MirrorCopyMode copy_mode,
>                                     Error **errp)
>  {
> +    int job_flags = JOB_DEFAULT;
>  
>      if (!has_speed) {
>          speed = 0;
> @@ -3642,7 +3643,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>       * and will allow to check whether the node still exist at mirror completion
>       */
>      mirror_start(job_id, bs, target,
> -                 has_replaces ? replaces : NULL,
> +                 has_replaces ? replaces : NULL, job_flags,
>                   speed, granularity, buf_size, sync, backing_mode,
>                   on_source_error, on_target_error, unmap, filter_node_name,
>                   copy_mode, errp);
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index ffab0b4d3e..b40f0bfc9b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1029,6 +1029,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
>   * @target: Block device to write to.
>   * @replaces: Block graph node name to replace once the mirror is done. Can
>   *            only be used when full mirroring is selected.
> + * @creation_flags: Flags that control the behavior of the Job lifetime.
> + *                  See @BlockJobCreateFlags
>   * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
>   * @granularity: The chosen granularity for the dirty bitmap.
>   * @buf_size: The amount of data that can be in flight at one time.
> @@ -1050,7 +1052,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
>   */
>  void mirror_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *target, const char *replaces,
> -                  int64_t speed, uint32_t granularity, int64_t buf_size,
> +                  int creation_flags, int64_t speed,
> +                  uint32_t granularity, int64_t buf_size,
>                    MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
>                    BlockdevOnError on_source_error,
>                    BlockdevOnError on_target_error,
> -- 
> 2.14.4
> 
