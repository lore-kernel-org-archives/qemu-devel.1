Received: from eggs.gnu.org ([2001:4830:134:3::10]:34364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eM4HY-0004s0-LI
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eM4HU-0000fp-M5
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 22:52:32 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1512154296-5652-1-git-send-email-peter.maydell@linaro.org>
	<1512154296-5652-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eee95b3d-8d94-c9d7-4fc2-e9ecbcb8e89d@amsat.org>
Date: Tue, 5 Dec 2017 00:52:23 -0300
MIME-Version: 1.0
In-Reply-To: <1512154296-5652-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] nvic: Make
 nvic_sysreg_ns_ops work with any MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 12/01/2017 03:51 PM, Peter Maydell wrote:
> Generalize nvic_sysreg_ns_ops so that we can pass it an
> arbitrary MemoryRegion which it will use as the underlying
> register implementation to apply the NS-alias behaviour
> to. We'll want this so we can do the same with systick.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/armv7m_nvic.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 5d9c883..63f2743 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1786,10 +1786,12 @@ static MemTxResult nvic_sysreg_ns_write(void *opaque, hwaddr addr,
>                                          uint64_t value, unsigned size,
>                                          MemTxAttrs attrs)
>  {
> +    MemoryRegion *mr = opaque;
> +
>      if (attrs.secure) {
>          /* S accesses to the alias act like NS accesses to the real region */
>          attrs.secure = 0;
> -        return nvic_sysreg_write(opaque, addr, value, size, attrs);
> +        return memory_region_dispatch_write(mr, addr, value, size, attrs);
>      } else {
>          /* NS attrs are RAZ/WI for privileged, and BusFault for user */
>          if (attrs.user) {
> @@ -1803,10 +1805,12 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, hwaddr addr,
>                                         uint64_t *data, unsigned size,
>                                         MemTxAttrs attrs)
>  {
> +    MemoryRegion *mr = opaque;
> +
>      if (attrs.secure) {
>          /* S accesses to the alias act like NS accesses to the real region */
>          attrs.secure = 0;
> -        return nvic_sysreg_read(opaque, addr, data, size, attrs);
> +        return memory_region_dispatch_read(mr, addr, data, size, attrs);
>      } else {
>          /* NS attrs are RAZ/WI for privileged, and BusFault for user */
>          if (attrs.user) {
> @@ -2075,7 +2079,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>  
>      if (arm_feature(&s->cpu->env, ARM_FEATURE_V8)) {
>          memory_region_init_io(&s->sysreg_ns_mem, OBJECT(s),
> -                              &nvic_sysreg_ns_ops, s,
> +                              &nvic_sysreg_ns_ops, &s->sysregmem,
>                                "nvic_sysregs_ns", 0x1000);
>          memory_region_add_subregion(&s->container, 0x20000, &s->sysreg_ns_mem);
>      }
> 
