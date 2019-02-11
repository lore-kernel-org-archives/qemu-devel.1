Received: from eggs.gnu.org ([209.51.188.92]:41780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtFmf-0006sZ-UK
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtFmf-0004eU-4L
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:54:21 -0500
Date: Mon, 11 Feb 2019 18:54:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190211175410.GI8135@linux.fritz.box>
References: <20181221165341.23736-1-vsementsov@virtuozzo.com>
	<20181221165341.23736-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221165341.23736-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qapi: move to QOM path for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, pizhenwei@bytedance.com

Am 21.12.2018 um 17:53 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Move to way of device selecting, however fall back to device name if
> path is not found.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json |  4 ++--
>  blockdev.c           | 22 +++++++++++++++-------
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 762000f31f..bb70c51a57 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -489,7 +489,7 @@
>  # If only @device parameter is specified, remove all present latency histograms
>  # for the device. Otherwise, add/reset some of (or all) latency histograms.
>  #
> -# @device: device name to set latency histogram for.
> +# @id: The QOM path or name of the guest device.
>  #
>  # @boundaries: list of interval boundary values (see description in
>  #              BlockLatencyHistogramInfo definition). If specified, all
> @@ -547,7 +547,7 @@
>  # <- { "return": {} }
>  ##
>  { 'command': 'x-block-latency-histogram-set',
> -  'data': {'device': 'str',
> +  'data': {'id': 'str',
>             '*boundaries': ['uint64'],
>             '*boundaries-read': ['uint64'],
>             '*boundaries-write': ['uint64'],
> diff --git a/blockdev.c b/blockdev.c
> index a6f71f9d83..ff0d8ded5e 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -4397,21 +4397,29 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
>  }
>  
>  void qmp_x_block_latency_histogram_set(
> -    const char *device,
> +    const char *id,
>      bool has_boundaries, uint64List *boundaries,
>      bool has_boundaries_read, uint64List *boundaries_read,
>      bool has_boundaries_write, uint64List *boundaries_write,
>      bool has_boundaries_flush, uint64List *boundaries_flush,
>      Error **errp)
>  {
> -    BlockBackend *blk = blk_by_name(device);
>      BlockAcctStats *stats;
>      int ret;
> +    Error *local_err = NULL;
> +    BlockBackend *blk = blk_by_qdev_id(id, &local_err);
>  
>      if (!blk) {
> -        error_setg(errp, "Device '%s' not found", device);
> -        return;
> +        blk = blk_by_name(id);
> +        if (!blk) {
> +            error_propagate(errp, local_err);
> +            return;
> +        } else {
> +            error_free(local_err);
> +            local_err = NULL;
> +        }
>      }

Why don't you use qmp_get_blk() here?

Kevin
