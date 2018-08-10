Received: from eggs.gnu.org ([2001:4830:134:3::10]:36120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzhr-0006bg-Ig
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzhm-0000KA-P9
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:11:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-14-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <71afdf15-b38a-b93e-bec9-2b28fff9a273@amsat.org>
Date: Fri, 10 Aug 2018 02:11:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180809130115.28951-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 13/16] hw/dma/pl080: Provide
 device reset function
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

On 08/09/2018 10:01 AM, Peter Maydell wrote:
> The PL080/PL081 model is missing a reset function; implement it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/pl080.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
> index 8f9f3e08d9a..a7aacad74f0 100644
> --- a/hw/dma/pl080.c
> +++ b/hw/dma/pl080.c
> @@ -348,6 +348,30 @@ static const MemoryRegionOps pl080_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> +static void pl080_reset(DeviceState *dev)
> +{
> +    PL080State *s = PL080(dev);
> +    int i;
> +
> +    s->tc_int = 0;
> +    s->tc_mask = 0;
> +    s->err_int = 0;
> +    s->err_mask = 0;
> +    s->conf = 0;
> +    s->sync = 0;
> +    s->req_single = 0;
> +    s->req_burst = 0;
> +    s->running = 0;
> +
> +    for (i = 0; i < s->nchannels; i++) {
> +        s->chan[i].src = 0;
> +        s->chan[i].dest = 0;
> +        s->chan[i].lli = 0;
> +        s->chan[i].ctrl = 0;
> +        s->chan[i].conf = 0;
> +    }
> +}
> +
>  static void pl080_init(Object *obj)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> @@ -393,6 +417,7 @@ static void pl080_class_init(ObjectClass *oc, void *data)
>      dc->vmsd = &vmstate_pl080;
>      dc->realize = pl080_realize;
>      dc->props = pl080_properties;
> +    dc->reset = pl080_reset;
>  }
>  
>  static const TypeInfo pl080_info = {
> 
