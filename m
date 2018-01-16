Received: from eggs.gnu.org ([2001:4830:134:3::10]:45816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebJ20-0003pt-Gu
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebJ1x-0001N2-Ds
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:39:28 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-8-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <188bcda9-1a5c-e837-f80b-1d484d42e195@amsat.org>
Date: Tue, 16 Jan 2018 01:39:21 -0300
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-8-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 07/14] i.MX: Add i.MX7 GPT variant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

On 01/15/2018 10:37 PM, Andrey Smirnov wrote:
> Add minimal code needed to allow upstream Linux guest to boot.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/timer/imx_gpt.c         | 25 +++++++++++++++++++++++++
>  include/hw/timer/imx_gpt.h |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
> index 4b9b54bf2e..65e4ee6bcf 100644
> --- a/hw/timer/imx_gpt.c
> +++ b/hw/timer/imx_gpt.c
> @@ -113,6 +113,17 @@ static const IMXClk imx6_gpt_clocks[] = {
>      CLK_HIGH,      /* 111 reference clock */
>  };
>  
> +static const IMXClk imx7_gpt_clocks[] = {
> +    CLK_NONE,      /* 000 No clock source */
> +    CLK_IPG,       /* 001 ipg_clk, 532MHz*/
> +    CLK_IPG_HIGH,  /* 010 ipg_clk_highfreq */
> +    CLK_EXT,       /* 011 External clock */
> +    CLK_32k,       /* 100 ipg_clk_32k */
> +    CLK_HIGH,      /* 101 reference clock */
> +    CLK_NONE,      /* 110 not defined */
> +    CLK_NONE,      /* 111 not defined */
> +};
> +
>  static void imx_gpt_set_freq(IMXGPTState *s)
>  {
>      uint32_t clksrc = extract32(s->cr, GPT_CR_CLKSRC_SHIFT, 3);
> @@ -512,6 +523,13 @@ static void imx6_gpt_init(Object *obj)
>      s->clocks = imx6_gpt_clocks;
>  }
>  
> +static void imx7_gpt_init(Object *obj)
> +{
> +    IMXGPTState *s = IMX_GPT(obj);
> +
> +    s->clocks = imx7_gpt_clocks;
> +}
> +
>  static const TypeInfo imx25_gpt_info = {
>      .name = TYPE_IMX25_GPT,
>      .parent = TYPE_SYS_BUS_DEVICE,
> @@ -532,11 +550,18 @@ static const TypeInfo imx6_gpt_info = {
>      .instance_init = imx6_gpt_init,
>  };
>  
> +static const TypeInfo imx7_gpt_info = {
> +    .name = TYPE_IMX7_GPT,
> +    .parent = TYPE_IMX25_GPT,

ideally there should be an abstract TYPE_IMX_GPT you'd use as parent
rather than the TYPE_IMX25_GPT, anyway out of the scope of this series.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    .instance_init = imx7_gpt_init,
> +};
> +
>  static void imx_gpt_register_types(void)
>  {
>      type_register_static(&imx25_gpt_info);
>      type_register_static(&imx31_gpt_info);
>      type_register_static(&imx6_gpt_info);
> +    type_register_static(&imx7_gpt_info);
>  }
>  
>  type_init(imx_gpt_register_types)
> diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
> index eac59b2a70..20ccb327c4 100644
> --- a/include/hw/timer/imx_gpt.h
> +++ b/include/hw/timer/imx_gpt.h
> @@ -77,6 +77,7 @@
>  #define TYPE_IMX25_GPT "imx25.gpt"
>  #define TYPE_IMX31_GPT "imx31.gpt"
>  #define TYPE_IMX6_GPT "imx6.gpt"
> +#define TYPE_IMX7_GPT "imx7.gpt"
>  
>  #define TYPE_IMX_GPT TYPE_IMX25_GPT
>  
> 
