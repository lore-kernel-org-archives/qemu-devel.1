Received: from eggs.gnu.org ([209.51.188.92]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glg9V-00061U-8N
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glg9R-0004I1-J0
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:26:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glg9M-0004Cw-0i
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:26:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so12080218wmj.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:26:23 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3990ef56-7eb2-7385-8d18-56b854de4b09@redhat.com>
Date: Mon, 21 Jan 2019 21:26:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/23] armv7m: Don't assume the NVIC's CPU
 is CPU 0
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

On 1/21/19 7:50 PM, Peter Maydell wrote:
> Currently the ARMv7M NVIC object's realize method assumes that the
> CPU the NVIC is attached to is CPU 0, because it thinks there can
> only ever be one CPU in the system. To allow a dual-Cortex-M33
> setup we need to remove this assumption; instead the armv7m
> wrapper object tells the NVIC its CPU, in the same way that it
> already tells the CPU what the NVIC is.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/armv7m.c       | 6 ++++--
>  hw/intc/armv7m_nvic.c | 3 +--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index f4446528307..f9aa83d20ef 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -178,10 +178,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -    /* Tell the CPU where the NVIC is; it will fail realize if it doesn't
> -     * have one.
> +    /*
> +     * Tell the CPU where the NVIC is; it will fail realize if it doesn't
> +     * have one. Similarly, tell the NVIC where its CPU is.
>       */
>      s->cpu->env.nvic = &s->nvic;
> +    s->nvic.cpu = s->cpu;
>  
>      object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
>      if (err != NULL) {
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 0beefb05d44..790a3d95849 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -2274,8 +2274,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>      Error *err = NULL;
>      int regionlen;
>  
> -    s->cpu = ARM_CPU(qemu_get_cpu(0));
> -
> +    /* The armv7m container object will have set our CPU pointer */
>      if (!s->cpu || !arm_feature(&s->cpu->env, ARM_FEATURE_M)) {
>          error_setg(errp, "The NVIC can only be used with a Cortex-M CPU");
>          return;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
