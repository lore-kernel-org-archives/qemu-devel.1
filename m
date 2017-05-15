Received: from eggs.gnu.org ([2001:4830:134:3::10]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dADaL-0000Oa-En
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dADaK-0003dJ-Ip
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:50:41 -0400
Date: Mon, 15 May 2017 18:50:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170515105032.GD23262@lemon.lan>
References: <1494842563-6534-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494842563-6534-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [RFC PATCH] qemu-io: add drain/undrain cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Mon, 05/15 12:02, Peter Lieven wrote:
> Hi Block developers,
> 
> I would like to add a feature to Qemu to drain all traffic from a block so that
> I can take external snaphosts without the risk to that in the middle of a write
> operation. Its meant for cases where where QGA freeze/thaw is not available.
> 
> For me its enough to have this through qemu-io, but Kevin asked me to check
> if its not worth to have a stable API for it and present it via QMP/HMP.
> 
> What are your thoughts?

For debugging purpose or a "hacky" usage where you know what you are doing, it
may be fine to have this. The only issue is it should be a separate flag, like
BlockJob.user_paused.

What happens from guest perspective? In the case of virtio, the request queue is
not handled and -ETIMEDOUT may happen. With IDE, I/O commands are still handled,
the command is not effective (or rather the implementation is not complete).

Fam

> 
> Thanks,
> Peter
> 
> ---
>  qemu-io-cmds.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 312fc6d..49d82fe 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1565,6 +1565,82 @@ static const cmdinfo_t flush_cmd = {
>      .oneline    = "flush all in-core file state to disk",
>  };
>  
> +static const cmdinfo_t drain_cmd;
> +
> +static int drain_f(BlockBackend *blk, int argc, char **argv)
> +{
> +    BlockDriverState *bs = blk_bs(blk);
> +    bool flush = false;
> +    int c;
> +
> +    while ((c = getopt(argc, argv, "f")) != -1) {
> +        switch (c) {
> +        case 'f':
> +            flush = true;
> +            break;
> +        default:
> +            return qemuio_command_usage(&drain_cmd);
> +        }
> +    }
> +
> +    if (optind != argc) {
> +        return qemuio_command_usage(&drain_cmd);
> +    }
> +
> +
> +    if (bs->quiesce_counter) {
> +        printf("drain failed: device is already drained!\n");
> +        return 1;
> +    }
> +
> +    bdrv_drained_begin(bs); /* complete I/O */
> +    if (flush) {
> +        bdrv_flush(bs);
> +        bdrv_drain(bs); /* in case flush left pending I/O */
> +        printf("flushed all pending I/O\n");
> +    }
> +    printf("drain successful\n");
> +    return 0;
> +}
> +
> +static void drain_help(void)
> +{
> +    printf(
> +"\n"
> +" Drains all external I/O from the device\n"
> +"\n"
> +" -f, -- flush all in-core file state to disk\n"
> +"\n");
> +}
> +
> +static const cmdinfo_t drain_cmd = {
> +    .name       = "drain",
> +    .cfunc      = drain_f,
> +    .args       = "[-f]",
> +    .argmin     = 0,
> +    .argmax     = -1,
> +    .oneline    = "cease to send I/O to the device",
> +    .help       = drain_help
> +};
> +
> +static int undrain_f(BlockBackend *blk, int argc, char **argv)
> +{
> +    BlockDriverState *bs = blk_bs(blk);
> +    if (!bs->quiesce_counter) {
> +        printf("undrain failed: device is not drained!\n");
> +        return 1;
> +    }
> +    bdrv_drained_end(bs);
> +    printf("undrain successful\n");
> +    return 0;
> +}
> +
> +static const cmdinfo_t undrain_cmd = {
> +    .name       = "undrain",
> +    .cfunc      = undrain_f,
> +    .oneline    = "continue I/O to a drained device",
> +};
> +
>  static int truncate_f(BlockBackend *blk, int argc, char **argv)
>  {
>      int64_t offset;
> @@ -2296,6 +2372,8 @@ static void __attribute((constructor)) init_qemuio_commands(void)
>      qemuio_add_command(&aio_write_cmd);
>      qemuio_add_command(&aio_flush_cmd);
>      qemuio_add_command(&flush_cmd);
> +    qemuio_add_command(&drain_cmd);
> +    qemuio_add_command(&undrain_cmd);
>      qemuio_add_command(&truncate_cmd);
>      qemuio_add_command(&length_cmd);
>      qemuio_add_command(&info_cmd);
> -- 
> 1.9.1
> 
> 
