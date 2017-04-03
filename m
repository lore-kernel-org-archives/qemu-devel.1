Received: from eggs.gnu.org ([2001:4830:134:3::10]:54463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7EO-0000DY-HB
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv7EI-0005Oh-My
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:01:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-6-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <73833e92-2eeb-b40b-ab38-fe5979687218@amsat.org>
Date: Mon, 3 Apr 2017 16:01:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170403160936.28293-6-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 05/16] block/file-posix: Small
 fixes in raw_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 04/03/2017 01:09 PM, Max Reitz wrote:
> Variables should be declared at the start of a block, and if a certain
> parameter value is not supported it may be better to return -ENOTSUP
> instead of -EINVAL.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/file-posix.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 3e9c416668..cab77db963 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1693,6 +1693,8 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
>  #endif
>      case PREALLOC_MODE_FULL:
>      {
> +        int64_t num = 0, left = total_size;
> +
>          /*
>           * Knowing the final size from the beginning could allow the file
>           * system driver to do less allocations and possibly avoid
> @@ -1704,7 +1706,6 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
>              goto out_close;
>          }
>
> -        int64_t num = 0, left = total_size;
>          buf = g_malloc0(65536);
>
>          while (left > 0) {
> @@ -1736,7 +1737,7 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
>          }
>          break;
>      default:
> -        result = -EINVAL;
> +        result = -ENOTSUP;
>          error_setg(errp, "Unsupported preallocation mode: %s",
>                     PreallocMode_lookup[prealloc]);
>          break;
>
