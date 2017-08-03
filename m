Received: from eggs.gnu.org ([2001:4830:134:3::10]:35891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ddIwp-0002Ad-8w
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ddIwo-00028I-BL
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:26:07 -0400
Date: Thu, 3 Aug 2017 12:25:58 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170803162558.GH22129@localhost.localdomain>
References: <20170803150301.10177-1-kwolf@redhat.com>
	<20170803150301.10177-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170803150301.10177-5-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 4/5] qemu-io: Allow
 reopen read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, Aug 03, 2017 at 05:03:00PM +0200, Kevin Wolf wrote:
> This allows qemu-iotests to test the switch between read-only and
> read-write mode for block devices.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-io-cmds.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 3eb42c6728..2811a89099 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1920,6 +1920,7 @@ static void reopen_help(void)
>  " 'reopen -o lazy-refcounts=on' - activates lazy refcount writeback on a qcow2 image\n"
>  "\n"
>  " -r, -- Reopen the image read-only\n"
> +" -w, -- Reopen the image read-write\n"
>  " -c, -- Change the cache mode to the given value\n"
>  " -o, -- Changes block driver options (cf. 'open' command)\n"
>  "\n");
> @@ -1942,7 +1943,7 @@ static const cmdinfo_t reopen_cmd = {
>         .argmin         = 0,
>         .argmax         = -1,
>         .cfunc          = reopen_f,
> -       .args           = "[-r] [-c cache] [-o options]",
> +       .args           = "[(-r|-w)] [-c cache] [-o options]",
>         .oneline        = "reopens an image with new options",
>         .help           = reopen_help,
>  };
> @@ -1955,11 +1956,12 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
>      int c;
>      int flags = bs->open_flags;
>      bool writethrough = !blk_enable_write_cache(blk);
> +    bool has_rw_option = false;
>  
>      BlockReopenQueue *brq;
>      Error *local_err = NULL;
>  
> -    while ((c = getopt(argc, argv, "c:o:r")) != -1) {
> +    while ((c = getopt(argc, argv, "c:o:rw")) != -1) {
>          switch (c) {
>          case 'c':
>              if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
> @@ -1974,7 +1976,20 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
>              }
>              break;
>          case 'r':
> +            if (has_rw_option) {
> +                error_report("Only one -r/-w option may be given");
> +                return 0;
> +            }
>              flags &= ~BDRV_O_RDWR;
> +            has_rw_option = true;
> +            break;
> +        case 'w':
> +            if (has_rw_option) {
> +                error_report("Only one -r/-w option may be given");
> +                return 0;
> +            }
> +            flags |= BDRV_O_RDWR;
> +            has_rw_option = true;
>              break;
>          default:
>              qemu_opts_reset(&reopen_opts);
> -- 
> 2.13.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
