Received: from eggs.gnu.org ([2001:4830:134:3::10]:58737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJjC1-000320-QU
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJjBx-0005KP-RV
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:57:09 -0500
Date: Tue, 28 Nov 2017 17:56:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171128165655.GH3703@localhost.localdomain>
References: <20171128121055.6954-1-den@openvz.org>
	<20171128121055.6954-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128121055.6954-3-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] ide: fix crash in IDE cdrom read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 28.11.2017 um 13:10 hat Denis V. Lunev geschrieben:
> There is the following crash reported from the field in QEMU 2.9:
>     bdrv_inc_in_flight (bs=bs@entry=0x0)
>     blk_aio_prwv
>     blk_aio_preadv
>     ide_buffered_readv
>     cd_read_sector
>     ide_data_readw
>     portio_read
>     memory_region_read_accessor
>     access_with_adjusted_size
>     memory_region_dispatch_read1
>     memory_region_dispatch_read
>     address_space_read_continue
>     address_space_read_full
>     address_space_read
>     address_space_rw
>     kvm_handle_io
>     kvm_cpu_exec
>     qemu_kvm_cpu_thread_fn
>     start_thread
>     clone
> Indeed, the CDROM device without media has blk->bs == NULL. We should
> check that the media is really available for the device like has been done
> in SCSI code.
> 
> May be the patch adds a bit more check than necessary, but this is not be
> the problem. We should always stay on the safe side.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: John Snow <jsnow@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/ide/atapi.c | 32 ++++++++++++++++++++++++++++----
>  hw/ide/core.c  |  4 ++--
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index c0509c8bf5..fa50c0ccf6 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -119,6 +119,11 @@ cd_read_sector_sync(IDEState *s)
>  
>      trace_cd_read_sector_sync(s->lba);
>  
> +    if (!blk_is_available(s->blk)) {
> +        ret = -ENOMEDIUM;
> +        goto fail;
> +    }
> +
>      switch (s->cd_sector_size) {
>      case 2048:
>          ret = blk_pread(s->blk, (int64_t)s->lba << ATAPI_SECTOR_BITS,
> @@ -132,8 +137,8 @@ cd_read_sector_sync(IDEState *s)
>          }
>          break;
>      default:
> -        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
> -        return -EIO;
> +        ret = -EIO;
> +        goto fail;
>      }
>  
>      if (ret < 0) {
> @@ -145,6 +150,10 @@ cd_read_sector_sync(IDEState *s)
>      }
>  
>      return ret;
> +
> +fail:
> +    block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
> +    return ret;
>  }

I'm not sure if we can do anything about blk_aio_* in the short time
that we have until 2.11, so maybe we need to fix some callers like IDE
(we won't catch all of them anyway), but at least the synchronous one
should be easily handled in blk_prwv() by returning -ENOMEDIUM before we
access blk_bs(blk).

AIO is trickier because we need to schedule a BH, and blk_drain() can't
execute that BH yet unless we increase bs->in_flight - which we
obviously can't do for a NULL bs->in_flight. The proper solution
involves a separate blk->in_flight counter for the BB and a blk_drain()
implementation that considers it.

Kevin
