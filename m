Received: from eggs.gnu.org ([2001:4830:134:3::10]:53394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJgoQ-0004fi-Mn
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJgoN-0003dO-Ha
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:29:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gJgoN-0003ai-9H
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:29:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so3869143wmw.0
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:29:07 -0800 (PST)
References: <20181105151132.13884-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1ff507fd-fb35-50d5-ae45-cf96d077e0b3@redhat.com>
Date: Mon, 5 Nov 2018 16:29:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181105151132.13884-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/arm/exynos4210: Zero memory
 allocated for Exynos4210State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Igor Mitsyanko <i.mitsyanko@gmail.com>

Hi Peter,

On 5/11/18 16:11, Peter Maydell wrote:
> In exynos4210_init() we allocate memory for an Exynos4210State
> struct. Generally devices can assume that the memory allocated
> for their state struct is zero-initialized; we broke that
> assumption here by using g_new(). Use g_new0() instead.
> (In particular, some code assumes that the various irq arrays
> in the Exynos4210Irq sub-struct are zero-initialized.)
> 
> In the longer term, this code should be QOMified, and then
> the struct memory will be allocated elsewhere and by functions
> which always zero-initalize it; but for 3.1 this is a
> simple fix.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I suggested this fix the other day:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00135.html
> so here it is as an actual patch.

I did the same patch as you suggested but continued more soft-freeze 
testing and planed to send it today, sorry.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Probably we should go through other uses of g_new() in
> board/device code at some point.
> 
>   hw/arm/exynos4210.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 827318a0036..af82e955421 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -162,7 +162,7 @@ static uint64_t exynos4210_calc_affinity(int cpu)
>   
>   Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
>   {
> -    Exynos4210State *s = g_new(Exynos4210State, 1);
> +    Exynos4210State *s = g_new0(Exynos4210State, 1);
>       qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
>       SysBusDevice *busdev;
>       DeviceState *dev;
> 
