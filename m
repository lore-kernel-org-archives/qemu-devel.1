Received: from eggs.gnu.org ([2001:4830:134:3::10]:40090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cerVp-0002Jy-Ft
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 18:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cerVo-0006W9-QL
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 18:00:25 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487266008-13492-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <920b1c87-c1d8-9f73-6dad-cd6debafadd3@amsat.org>
Date: Fri, 17 Feb 2017 20:00:16 -0300
MIME-Version: 1.0
In-Reply-To: <1487266008-13492-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] lm32: milkymist-tmu2: fix a
 third integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Walle <michael@walle.cc>, patches@linaro.org

On 02/16/2017 02:26 PM, Peter Maydell wrote:
> Don't truncate the multiplication and do a 64 bit one instead
> because the result is stored in a 64 bit variable.
>
> This fixes a similar coverity warning to commits 237a8650d640 and
> 4382fa655498, in a similar way, and is the final third of the fix for
> coverity CID 1167561 (hopefully!).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Third time lucky -- I checked and this is the last of these
> multiply lines.
>
>  hw/display/milkymist-tmu2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
> index 7528665..59120dd 100644
> --- a/hw/display/milkymist-tmu2.c
> +++ b/hw/display/milkymist-tmu2.c
> @@ -293,7 +293,7 @@ static void tmu2_start(MilkymistTMU2State *s)
>      cpu_physical_memory_unmap(mesh, mesh_len, 0, mesh_len);
>
>      /* Write back the OpenGL framebuffer to the QEMU framebuffer */
> -    fb_len = 2 * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
> +    fb_len = 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
>      fb = cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 1);
>      if (fb == NULL) {
>          glDeleteTextures(1, &texture);
>
