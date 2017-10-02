Received: from eggs.gnu.org ([2001:4830:134:3::10]:44541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz0DP-0004vI-Co
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz0DL-00074u-CA
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:52:55 -0400
Date: Mon, 2 Oct 2017 14:52:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171002125230.GB4362@localhost.localdomain>
References: <20170815081854.14568-1-el13635@mail.ntua.gr>
	<20170815081854.14568-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815081854.14568-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block: add filter driver to
 block/write-threshold.c
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Am 15.08.2017 um 10:18 hat Manos Pitsidianakis geschrieben:
> With runtime insertion and removal of filters, write-threshold.c can
> provide more flexible deliveries of BLOCK_WRITE_THRESHOLD events. After
> the event trigger, the filter nodes are no longer useful and must be
> removed.
> The existing write-threshold cannot be easily converted to using the
> filter driver, so it is not affected.
> 
> This is part of deprecating before write notifiers, which are hard coded
> into the block layer. Block filter drivers are inserted into the graph
> only when a feature is needed. This makes the block layer more modular
> and reuses the block driver abstraction that is already present.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/qapi.c                    |   2 +-
>  block/write-threshold.c         | 264 +++++++++++++++++++++++++++++++++++-----
>  include/block/write-threshold.h |  22 ++--
>  qapi/block-core.json            |  19 ++-
>  tests/test-write-threshold.c    |  40 +++---
>  5 files changed, 281 insertions(+), 66 deletions(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index 2be44a6758..fe6cf2eae5 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -122,7 +122,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>          info->group = g_strdup(throttle_group_get_name(tgm));
>      }
>  
> -    info->write_threshold = bdrv_write_threshold_get(bs);
> +    info->write_threshold = bdrv_write_threshold_get_legacy(bs);
>  
>      bs0 = bs;
>      p_image_info = &info->image;
> diff --git a/block/write-threshold.c b/block/write-threshold.c
> index 0bd1a01c86..4a67188ea3 100644
> --- a/block/write-threshold.c
> +++ b/block/write-threshold.c
> @@ -2,9 +2,11 @@
>   * QEMU System Emulator block write threshold notification
>   *
>   * Copyright Red Hat, Inc. 2014
> + * Copyright 2017 Manos Pitsidianakis
>   *
>   * Authors:
>   *  Francesco Romani <fromani@redhat.com>
> + *  Manos Pitsidianakis <el13635@mail.ntua.gr>
>   *
>   * This work is licensed under the terms of the GNU LGPL, version 2 or later.
>   * See the COPYING.LIB file in the top-level directory.
> @@ -19,46 +21,35 @@
>  #include "qmp-commands.h"
>  
>  
> -uint64_t bdrv_write_threshold_get(const BlockDriverState *bs)
> +uint64_t bdrv_write_threshold_get_legacy(const BlockDriverState *bs)
>  {
>      return bs->write_threshold_offset;
>  }
>  
> -bool bdrv_write_threshold_is_set(const BlockDriverState *bs)
> +bool bdrv_write_threshold_is_set_legacy(const BlockDriverState *bs)
>  {
>      return bs->write_threshold_offset > 0;
>  }
>  
> -static void write_threshold_disable(BlockDriverState *bs)
> +static void write_threshold_disable_legacy(BlockDriverState *bs)
>  {
> -    if (bdrv_write_threshold_is_set(bs)) {
> +    if (bdrv_write_threshold_is_set_legacy(bs)) {
>          notifier_with_return_remove(&bs->write_threshold_notifier);
>          bs->write_threshold_offset = 0;
>      }
>  }
>  
> -uint64_t bdrv_write_threshold_exceeded(const BlockDriverState *bs,
> -                                       const BdrvTrackedRequest *req)
> -{
> -    if (bdrv_write_threshold_is_set(bs)) {
> -        if (req->offset > bs->write_threshold_offset) {
> -            return (req->offset - bs->write_threshold_offset) + req->bytes;
> -        }
> -        if ((req->offset + req->bytes) > bs->write_threshold_offset) {
> -            return (req->offset + req->bytes) - bs->write_threshold_offset;
> -        }
> -    }
> -    return 0;
> -}
> -
>  static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
>                                              void *opaque)
>  {
>      BdrvTrackedRequest *req = opaque;
>      BlockDriverState *bs = req->bs;
>      uint64_t amount = 0;
> +    uint64_t threshold = bdrv_write_threshold_get_legacy(bs);
> +    uint64_t offset = req->offset;
> +    uint64_t bytes = req->bytes;
>  
> -    amount = bdrv_write_threshold_exceeded(bs, req);
> +    amount = bdrv_write_threshold_exceeded(threshold, offset, bytes);
>      if (amount > 0) {
>          qapi_event_send_block_write_threshold(
>              bs->node_name,
> @@ -67,7 +58,7 @@ static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
>              &error_abort);
>  
>          /* autodisable to avoid flooding the monitor */
> -        write_threshold_disable(bs);
> +        write_threshold_disable_legacy(bs);
>      }
>  
>      return 0; /* should always let other notifiers run */
> @@ -79,25 +70,26 @@ static void write_threshold_register_notifier(BlockDriverState *bs)
>      bdrv_add_before_write_notifier(bs, &bs->write_threshold_notifier);
>  }
>  
> -static void write_threshold_update(BlockDriverState *bs,
> -                                   int64_t threshold_bytes)
> +static void write_threshold_update_legacy(BlockDriverState *bs,
> +                                          int64_t threshold_bytes)
>  {
>      bs->write_threshold_offset = threshold_bytes;
>  }
>  
> -void bdrv_write_threshold_set(BlockDriverState *bs, uint64_t threshold_bytes)
> +void bdrv_write_threshold_set_legacy(BlockDriverState *bs,
> +                                     uint64_t threshold_bytes)
>  {
> -    if (bdrv_write_threshold_is_set(bs)) {
> +    if (bdrv_write_threshold_is_set_legacy(bs)) {
>          if (threshold_bytes > 0) {
> -            write_threshold_update(bs, threshold_bytes);
> +            write_threshold_update_legacy(bs, threshold_bytes);
>          } else {
> -            write_threshold_disable(bs);
> +            write_threshold_disable_legacy(bs);
>          }
>      } else {
>          if (threshold_bytes > 0) {
>              /* avoid multiple registration */
>              write_threshold_register_notifier(bs);
> -            write_threshold_update(bs, threshold_bytes);
> +            write_threshold_update_legacy(bs, threshold_bytes);
>          }
>          /* discard bogus disable request */
>      }
> @@ -119,7 +111,223 @@ void qmp_block_set_write_threshold(const char *node_name,
>      aio_context = bdrv_get_aio_context(bs);
>      aio_context_acquire(aio_context);
>  
> -    bdrv_write_threshold_set(bs, threshold_bytes);
> +    bdrv_write_threshold_set_legacy(bs, threshold_bytes);
>  
>      aio_context_release(aio_context);
>  }
> +
> +
> +/* The write-threshold filter drivers delivers a one-time BLOCK_WRITE_THRESHOLD
> + * event when a passing write request exceeds the configured write threshold
> + * offset of the filter.
> + *
> + * This is useful to transparently resize thin-provisioned drives without
> + * the guest OS noticing.
> + */
> +
> +#define QEMU_OPT_WRITE_THRESHOLD "write-threshold"
> +static BlockDriver write_threshold;

This forward declaration is unnecessary, the variable is never used
before the actual definition.

> +static QemuOptsList write_threshold_opts = {
> +    .name = "write-threshold",
> +    .head = QTAILQ_HEAD_INITIALIZER(write_threshold_opts.head),
> +    .desc = {
> +        {
> +            .name = QEMU_OPT_WRITE_THRESHOLD,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "configured threshold for the block device, bytes. Use 0"
> +                    "to disable the threshold",
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +static bool bdrv_write_threshold_is_set(const BlockDriverState *bs)
> +{
> +    uint64_t threshold = *(uint64_t *)bs->opaque;

I think I would prefer using a struct for bs->opaque, even if it only
contains a single uint64_t for now.

> +    return threshold > 0;
> +}

> +static int64_t coroutine_fn write_threshold_co_get_block_status(
> +                                                       BlockDriverState *bs,
> +                                                       int64_t sector_num,
> +                                                       int nb_sectors,
> +                                                       int *pnum,
> +                                                       BlockDriverState **file)
> +{
> +    assert(child_bs(bs));
> +    *pnum = nb_sectors;
> +    *file = child_bs(bs);
> +    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
> +           (sector_num << BDRV_SECTOR_BITS);
> +}

This is bdrv_co_get_block_status_from_file() again.

Kevin
