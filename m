Received: from eggs.gnu.org ([2001:4830:134:3::10]:41542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d0687-0002oO-Mv
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 08:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d0685-0008MV-5P
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 08:51:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170413160625.27719-1-mreitz@redhat.com>
	<20170413160625.27719-2-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f7840f6-d59f-2533-aeea-1ea6c1baf910@amsat.org>
Date: Mon, 17 Apr 2017 09:51:36 -0300
MIME-Version: 1.0
In-Reply-To: <20170413160625.27719-2-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/2] block: An empty filename
 counts as no filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, qemu-devel@nongnu.org

Hi Max,

On 04/13/2017 01:06 PM, Max Reitz wrote:
> Reproducer:
>     $ ./qemu-img info ''
>     qemu-img: ./block.c:1008: bdrv_open_driver: Assertion
>         `!drv->bdrv_needs_filename || bs->filename[0]' failed.
>     [1]    26105 abort (core dumped)  ./qemu-img info ''
>
> This patch fixes this to be:
>     $ ./qemu-img info ''
>     qemu-img: Could not open '': The 'file' block driver requires a file
>     name
>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block.c b/block.c
> index 1fbbb8d606..46da908c93 100644
> --- a/block.c
> +++ b/block.c
> @@ -1167,7 +1167,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
>          filename = qdict_get_try_str(options, "filename");
>      }
>
> -    if (drv->bdrv_needs_filename && !filename) {
> +    if (drv->bdrv_needs_filename && (!filename || !filename[0])) {

What do you think about adding an inline function in "qemu/option.h" 
like "is_valid_[option_]filename()" to avoid this bug template?

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          error_setg(errp, "The '%s' block driver requires a file name",
>                     drv->format_name);
>          ret = -EINVAL;
>
