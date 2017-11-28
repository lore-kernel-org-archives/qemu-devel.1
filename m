Received: from eggs.gnu.org ([2001:4830:134:3::10]:47431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eJpec-0001hw-Op
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eJpeZ-0002A2-Kr
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:51:06 -0500
References: <20171128121055.6954-1-den@openvz.org>
	<20171128121055.6954-3-den@openvz.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <c3b6f42e-25b2-205f-b8ad-822321ef0645@redhat.com>
Date: Tue, 28 Nov 2017 18:50:57 -0500
MIME-Version: 1.0
In-Reply-To: <20171128121055.6954-3-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 11/28/2017 07:10 AM, Denis V. Lunev wrote:
> There is the following crash reported from the field in QEMU 2.9:
>     bdrv_inc_in_flight (bs=bs@entry=0x0)
>     blk_aio_prwv
>     blk_aio_preadv
>     ide_buffered_readv
>     cd_read_sector

Is ide_atapi_cmd_reply_end missing from the call stack here for some
reason? ide_data_readw /should/ have end_transfer_func set to that if it
was processing an ATAPI command; otherwise it shouldn't be able to get
here under normal circumstances...

>     ide_data_readw

How do we get here? ide_is_pio_out ought to be false here; do you know
what command was being processed? Do you have a reproducer?

Knowing both the ATA and ATAPI commands under consideration here would
be helpful.

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

The thing that looks to be incongruent here is that we appear to be
servicing a ATAPI reply; that reply is either the kind that uses
preformatted data in a buffer, or the kind that buffers a read.

If it buffers a read, it should require CHECK_READY which requires a medium.

If it does not buffer a read, it should not be able to invoke
cd_read_sector or any bdrv function from ide_data_readw.

If it neither serves preformatted data nor buffers a read, it should not
allow ide_data_readw to perform any action at all.

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
>  
>  static void cd_read_sector_cb(void *opaque, int ret)
> @@ -174,9 +183,15 @@ static void cd_read_sector_cb(void *opaque, int ret)
>  
>  static int cd_read_sector(IDEState *s)
>  {
> +    int err;
> +
>      if (s->cd_sector_size != 2048 && s->cd_sector_size != 2352) {
> -        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
> -        return -EINVAL;
> +        err = -EINVAL;
> +        goto fail;
> +    }
> +    if (!blk_is_available(s->blk)) {
> +        err = -ENOMEDIUM;
> +        goto fail;
>      }
>  
>      s->iov.iov_base = (s->cd_sector_size == 2352) ?
> @@ -195,6 +210,10 @@ static int cd_read_sector(IDEState *s)
>  
>      s->status |= BUSY_STAT;
>      return 0;
> +
> +fail:
> +    block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
> +    return err;
>  }
>  
>  void ide_atapi_cmd_ok(IDEState *s)
> @@ -404,6 +423,11 @@ static void ide_atapi_cmd_read_dma_cb(void *opaque, int ret)
>          goto eot;
>      }
>  
> +    if (!blk_is_available(s->blk)) {
> +        ide_atapi_cmd_read_dma_cb(s, -ENOMEDIUM);
> +        return;
> +    }
> +

I'm not sure this is OK, because it's an error but not setting the sense
code or raising an IRQ; it's only calling ide_set_inactive, so this
might be a problem. Normally the error code from the data read is
handled earlier in the call by ide_handle_rw_error which can set the
proper codes.

>      s->io_buffer_index = 0;
>      if (s->cd_sector_size == 2352) {
>          n = 1;
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 471d0c928b..71780fc9d1 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -758,7 +758,7 @@ static void ide_sector_read(IDEState *s)
>  
>      trace_ide_sector_read(sector_num, n);
>  
> -    if (!ide_sect_range_ok(s, sector_num, n)) {
> +    if (!ide_sect_range_ok(s, sector_num, n) || !blk_is_available(s->blk)) {
>          ide_rw_error(s);
>          block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
>          return;
> @@ -1023,7 +1023,7 @@ static void ide_sector_write(IDEState *s)
>  
>      trace_ide_sector_write(sector_num, n);
>  
> -    if (!ide_sect_range_ok(s, sector_num, n)) {
> +    if (!ide_sect_range_ok(s, sector_num, n) || !blk_is_available(s->blk)) {
>          ide_rw_error(s);
>          block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_WRITE);
>          return;
> 

Since it's not a new regression (this is being reported against 2.9) I
am somewhat hesitant to rush it into 2.11-rc3 without a little more info.

That said, here's a list of the ATAPI commands we service that either
return or CAN return data, but do not enforce CHECK_READY:

    [ 0x03 ] = { cmd_request_sense,                 ALLOW_UA },
    [ 0x12 ] = { cmd_inquiry,                       ALLOW_UA },
    [ 0x46 ] = { cmd_get_configuration,             ALLOW_UA },
    [ 0x4a ] = { cmd_get_event_status_notification, ALLOW_UA },
    [ 0x5a ] = { cmd_mode_sense, /* (10) */         0 },
    [ 0xbd ] = { cmd_mechanism_status,              0 },

These six all invoke ide_atapi_cmd_reply in some way (which allows the
guest to begin reading the reply via PIO mechanisms if DMA is not set):

cmd_request_sense:     ide_atapi_cmd_reply(s, 18, max_len);
cmd_inquiry:           ide_atapi_cmd_reply(s, idx, max_len);
cmd_get_configuration: ide_atapi_cmd_reply(s, len, max_len);
cmd_get_event_status_notification:
                       ide_atapi_cmd_reply(s, used_len, max_len);
cmd_mode_sense:        ide_atapi_cmd_reply(s, 16, max_len);
                       ide_atapi_cmd_reply(s, 24, max_len);
                       ide_atapi_cmd_reply(s, 30, max_len);
cmd_mechanism_status:  ide_atapi_cmd_reply(s, 8, max_len);

ide_atapi_cmd_reply itself sets lba to -1, which should inform
ide_atapi_cmd_reply_end not to attempt to buffer any new data. These
*should* be safe. The reply sizes are also all small enough that they
are almost certainly getting buffered in one single transfer without
attempting to buffer more data.

In the normative PIO case then, reads will consume from this buffer
until empty, then we'll call ide_atapi_cmd_reply_end through
end_transfer_func and hit the end of transfer logic.

I'm not sure I see how this crash is happening; it doesn't look like
this path allows for invoking the block read functions and everything
else is guarded by NONDATA or CHECK_READY.

Unless this is an interesting interaction with ide_atapi_cmd_reply
setting the DRQ bit which may trick the pio read function to allow PIO
reads to come in during this time?

Hypothetically:

cmd_packet sets end_transfer_func to ide_atapi_cmd so it can process
further once that PIO is completed. (The PIO may be emulated
synchronously, in the case of AHCI.) In the true PIO case, it may be
asynchronous.

Now, in the AHCI case, the guest has control back and the CDROM is now
executing a command to, perhaps, read data via DMA. Then,
simultaneously, the guest issues a PIO read and because the DRQ bit is
set for DMA, the PIO read also goes through.

This still requires a media, though... and a very broken guest doing
something naughty on purpose.

I can't quite connect the dots to see how this crash is possible in
general... it'd help to have:

- The ATAPI command being processed at the time
- The IDE command being processed at the time
- s->status

as a minimum, and then perhaps optionally some of the ATAPI loop
variables, like packet_transfer_size, elementary_transfer_size, and
io_buffer_index. Or a reproducer!

Sorry I'm not more help and I wrote too much again :(
