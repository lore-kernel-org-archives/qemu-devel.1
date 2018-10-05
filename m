Received: from eggs.gnu.org ([2001:4830:134:3::10]:54896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g8ZVX-00009O-Je
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g8ZVU-0000ZI-C0
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:27:43 -0400
References: <20181005133012.26490-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66552e20-08c2-a0e2-bb28-e7669c548fe7@redhat.com>
Date: Sat, 6 Oct 2018 01:22:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181005133012.26490-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/display/bcm2835_fb: Silence Coverity
 warning about multiply overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 05/10/2018 15:30, Peter Maydell wrote:
> Coverity complains (CID 1395628) that the multiply in the calculation
> of the framebuffer base is performed as 32x32 but then used in a
> context that takes a 64-bit hwaddr. This can't actually ever
> overflow the 32-bit result, because of the constraints placed on
> the s->config values in bcm2835_fb_validate_config(). But we
> can placate Coverity anyway, by explicitly casting one of the
> inputs to a hwaddr, so the whole expression is calculated with
> 64-bit arithmetic.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is one of those cases where I was 50/50 about whether to just
> mark the coverity issue as a false-positive.

Agreed, but in the end it's not too much noise, so

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

>  hw/display/bcm2835_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
> index d534d00a65f..599863e4e17 100644
> --- a/hw/display/bcm2835_fb.c
> +++ b/hw/display/bcm2835_fb.c
> @@ -190,7 +190,7 @@ static void fb_update_display(void *opaque)
>      }
>  
>      if (s->invalidate) {
> -        hwaddr base = s->config.base + xoff + yoff * src_width;
> +        hwaddr base = s->config.base + xoff + (hwaddr)yoff * src_width;
>          framebuffer_update_memory_section(&s->fbsection, s->dma_mr,
>                                            base,
>                                            s->config.yres, src_width);
> 
