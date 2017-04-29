Received: from eggs.gnu.org ([2001:4830:134:3::10]:34723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4b1k-00084S-UL
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4b1k-0002LF-2b
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:39:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-2-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <092c17fb-3b2b-1779-8ea0-df6329adb4fe@amsat.org>
Date: Sat, 29 Apr 2017 19:39:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170429191419.30051-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 1/9] qemu-io: Improve alignment checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 04/29/2017 04:14 PM, Eric Blake wrote:
> Several copy-and-pasted alignment checks exist in qemu-io, which
> could use some minor improvements:
>
> - Manual comparison against 0x1ff is not as clean as using our
> alignment macros (QEMU_IS_ALIGNED) from osdep.h.
>
> - The error messages aren't quite grammatically correct.
>
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v11: retitle [was "qemu-io: Don't open-code QEMU_IS_ALIGNED"], improve
> error messages
> v10: new patch
> ---
>  qemu-io-cmds.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 21af9e6..6a0024b 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -740,13 +740,13 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>      }
>
>      if (bflag) {
> -        if (offset & 0x1ff) {
> -            printf("offset %" PRId64 " is not sector aligned\n",
> +        if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> +            printf("%" PRId64 " is not a sector-aligned value for 'offset'\n",
>                     offset);
>              return 0;
>          }
> -        if (count & 0x1ff) {
> -            printf("count %"PRId64" is not sector aligned\n",
> +        if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
> +            printf("%"PRId64" is not a sector-aligned value for 'count'\n",
>                     count);
>              return 0;
>          }
> @@ -1050,14 +1050,14 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
>      }
>
>      if (bflag || cflag) {
> -        if (offset & 0x1ff) {
> -            printf("offset %" PRId64 " is not sector aligned\n",
> +        if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> +            printf("%" PRId64 " is not a sector-aligned value for 'offset'\n",
>                     offset);
>              return 0;
>          }
>
> -        if (count & 0x1ff) {
> -            printf("count %"PRId64" is not sector aligned\n",
> +        if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
> +            printf("%"PRId64" is not a sector-aligned value for 'count'\n",
>                     count);
>              return 0;
>          }
> @@ -1769,8 +1769,8 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
>      if (offset < 0) {
>          print_cvtnum_err(offset, argv[1]);
>          return 0;
> -    } else if (offset & 0x1ff) {
> -        printf("offset %" PRId64 " is not sector aligned\n",
> +    } else if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> +        printf("%" PRId64 " is not a sector-aligned value for 'offset'\n",
>                 offset);
>          return 0;
>      }
>
