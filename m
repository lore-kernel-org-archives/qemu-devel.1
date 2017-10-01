Received: from eggs.gnu.org ([2001:4830:134:3::10]:47402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dyUUQ-00048N-Gu
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 23:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dyUUP-0000CF-Ek
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 23:00:22 -0400
Date: Sat, 30 Sep 2017 23:00:11 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171001030011.GD4313@localhost.localdomain>
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930195345.23338-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170930195345.23338-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/4] qemu-io: Add -C for
 opening with copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Sat, Sep 30, 2017 at 02:53:42PM -0500, Eric Blake wrote:
> Make it easier to enable copy-on-read during iotests, by
> exposing a new bool option to main and open.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

Reviewed-by: Jeff Cody <jcody@redhat.com>


>  qemu-io.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-io.c b/qemu-io.c
> index 265445ad89..c70bde3eb1 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -102,6 +102,7 @@ static void open_help(void)
>  " Opens a file for subsequent use by all of the other qemu-io commands.\n"
>  " -r, -- open file read-only\n"
>  " -s, -- use snapshot file\n"
> +" -C, -- use copy-on-read\n"
>  " -n, -- disable host cache, short for -t none\n"
>  " -U, -- force shared permissions\n"
>  " -k, -- use kernel AIO implementation (on Linux only)\n"
> @@ -120,7 +121,7 @@ static const cmdinfo_t open_cmd = {
>      .argmin     = 1,
>      .argmax     = -1,
>      .flags      = CMD_NOFILE_OK,
> -    .args       = "[-rsnkU] [-t cache] [-d discard] [-o options] [path]",
> +    .args       = "[-rsCnkU] [-t cache] [-d discard] [-o options] [path]",
>      .oneline    = "open the file specified by path",
>      .help       = open_help,
>  };
> @@ -145,7 +146,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
>      QDict *opts;
>      bool force_share = false;
> 
> -    while ((c = getopt(argc, argv, "snro:kt:d:U")) != -1) {
> +    while ((c = getopt(argc, argv, "snCro:kt:d:U")) != -1) {
>          switch (c) {
>          case 's':
>              flags |= BDRV_O_SNAPSHOT;
> @@ -154,6 +155,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
>              flags |= BDRV_O_NOCACHE;
>              writethrough = false;
>              break;
> +        case 'C':
> +            flags |= BDRV_O_COPY_ON_READ;
> +            break;
>          case 'r':
>              readonly = 1;
>              break;
> @@ -251,6 +255,7 @@ static void usage(const char *name)
>  "  -r, --read-only      export read-only\n"
>  "  -s, --snapshot       use snapshot file\n"
>  "  -n, --nocache        disable host cache, short for -t none\n"
> +"  -C, --copy-on-read   enable copy-on-read\n"
>  "  -m, --misalign       misalign allocations for O_DIRECT\n"
>  "  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
>  "  -t, --cache=MODE     use the given cache mode for the image\n"
> @@ -439,7 +444,7 @@ static QemuOptsList file_opts = {
>  int main(int argc, char **argv)
>  {
>      int readonly = 0;
> -    const char *sopt = "hVc:d:f:rsnmkt:T:U";
> +    const char *sopt = "hVc:d:f:rsnCmkt:T:U";
>      const struct option lopt[] = {
>          { "help", no_argument, NULL, 'h' },
>          { "version", no_argument, NULL, 'V' },
> @@ -448,6 +453,7 @@ int main(int argc, char **argv)
>          { "read-only", no_argument, NULL, 'r' },
>          { "snapshot", no_argument, NULL, 's' },
>          { "nocache", no_argument, NULL, 'n' },
> +        { "copy-on-read", no_argument, NULL, 'C' },
>          { "misalign", no_argument, NULL, 'm' },
>          { "native-aio", no_argument, NULL, 'k' },
>          { "discard", required_argument, NULL, 'd' },
> @@ -492,6 +498,9 @@ int main(int argc, char **argv)
>              flags |= BDRV_O_NOCACHE;
>              writethrough = false;
>              break;
> +        case 'C':
> +            flags |= BDRV_O_COPY_ON_READ;
> +            break;
>          case 'd':
>              if (bdrv_parse_discard_flags(optarg, &flags) < 0) {
>                  error_report("Invalid discard option: %s", optarg);
> -- 
> 2.13.6
> 
> 
