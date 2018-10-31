Received: from eggs.gnu.org ([2001:4830:134:3::10]:42281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHuSU-0002Nq-9f
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHuSR-0002yN-RR
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:39:09 -0400
Date: Wed, 31 Oct 2018 17:38:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181031173833.GB2402@work-vm>
References: <1541004440-182262-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1541004440-182262-2-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541004440-182262-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] The discard flag for block stream
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

* Andrey Shinkevich (andrey.shinkevich@virtuozzo.com) wrote:
> Adding a parameter to QMP block-stream command to allow discarding
> blocks in the backing chain while blocks are being copied to the
> active layer.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/stream.c            | 2 +-
>  blockdev.c                | 8 +++++++-
>  hmp-commands.hx           | 4 ++--
>  hmp.c                     | 4 +++-
>  include/block/block_int.h | 2 +-
>  qapi/block-core.json      | 5 ++++-
>  6 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index 81a7ec8..db81df4 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -221,7 +221,7 @@ static const BlockJobDriver stream_job_driver = {
>  
>  void stream_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *base, const char *backing_file_str,
> -                  int creation_flags, int64_t speed,
> +                  int creation_flags, int64_t speed, bool discard,
>                    BlockdevOnError on_error, Error **errp)
>  {
>      StreamBlockJob *s;
> diff --git a/blockdev.c b/blockdev.c
> index 574adbc..04aecf5 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3122,6 +3122,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>                        bool has_base_node, const char *base_node,
>                        bool has_backing_file, const char *backing_file,
>                        bool has_speed, int64_t speed,
> +                      bool has_discard, bool discard,
>                        bool has_on_error, BlockdevOnError on_error,
>                        bool has_auto_finalize, bool auto_finalize,
>                        bool has_auto_dismiss, bool auto_dismiss,
> @@ -3138,6 +3139,10 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>          on_error = BLOCKDEV_ON_ERROR_REPORT;
>      }
>  
> +    if (!has_discard) {
> +        discard = false;
> +    }
> +
>      bs = bdrv_lookup_bs(device, device, errp);
>      if (!bs) {
>          return;
> @@ -3202,7 +3207,8 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>      }
>  
>      stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
> -                 job_flags, has_speed ? speed : 0, on_error, &local_err);
> +                 job_flags, has_speed ? speed : 0,
> +                 discard, on_error, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto out;
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index db0c681..b455e0d 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -95,8 +95,8 @@ ETEXI
>  
>      {
>          .name       = "block_stream",
> -        .args_type  = "device:B,speed:o?,base:s?",
> -        .params     = "device [speed [base]]",
> +        .args_type  = "device:B,speed:o?,base:s?,discard:o?",

I think that 'o?' is wrong - see the table at the top of monitor.c, 'o'
is octets, ? is optional - so speed here is an optional byte count, I
think your 'discard' is just an optional flag.
So I think you'd be better with a flag, like the -f on block_job_cancel.  

> +        .params     = "device [speed [base]] [discard]",
>          .help       = "copy data from a backing file into a block device",
>          .cmd        = hmp_block_stream,
>      },
> diff --git a/hmp.c b/hmp.c
> index 7828f93..c63e806 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1920,9 +1920,11 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
>      const char *device = qdict_get_str(qdict, "device");
>      const char *base = qdict_get_try_str(qdict, "base");
>      int64_t speed = qdict_get_try_int(qdict, "speed", 0);
> +    bool discard = qdict_get_try_bool(qdict, "discard", false);
>  
>      qmp_block_stream(true, device, device, base != NULL, base, false, NULL,
> -                     false, NULL, qdict_haskey(qdict, "speed"), speed, true,
> +                     false, NULL, qdict_haskey(qdict, "speed"), speed,
> +                     qdict_haskey(qdict, "discard"), discard, true,

Since you've got the default 'false' on the bool discard =   above, I
wonder if that can just be   true, discard, true    ?

Dave

>                       BLOCKDEV_ON_ERROR_REPORT, false, false, false, false,
>                       &error);
>  
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 92ecbd8..e531d03 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -970,7 +970,7 @@ int is_windows_drive(const char *filename);
>   */
>  void stream_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *base, const char *backing_file_str,
> -                  int creation_flags, int64_t speed,
> +                  int creation_flags, int64_t speed, bool discard,
>                    BlockdevOnError on_error, Error **errp);
>  
>  /**
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index cfb37f8..3f50b88 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2329,6 +2329,9 @@
>  #
>  # @speed:  the maximum speed, in bytes per second
>  #
> +# @discard: true to delete blocks duplicated in old backing files.
> +#           (default: false). Since 3.1.
> +#
>  # @on-error: the action to take on an error (default report).
>  #            'stop' and 'enospc' can only be used if the block device
>  #            supports io-status (see BlockInfo).  Since 1.3.
> @@ -2361,7 +2364,7 @@
>  { 'command': 'block-stream',
>    'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>              '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
> -            '*on-error': 'BlockdevOnError',
> +            '*discard': 'bool', '*on-error': 'BlockdevOnError',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>  
>  ##
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
