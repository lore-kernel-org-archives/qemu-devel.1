Received: from eggs.gnu.org ([2001:4830:134:3::10]:32789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4arJ-0003OG-W0
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4arJ-0007xe-3Z
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:58 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4arI-0007xQ-V5
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:57 -0400
Received: by mail-qt0-x241.google.com with SMTP id o36so12760320qtb.2
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 15:28:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
	<20170429104937.31341-8-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9c6db3c-6837-eb87-fa14-f24e000a66ae@amsat.org>
Date: Sat, 29 Apr 2017 19:28:52 -0300
MIME-Version: 1.0
In-Reply-To: <20170429104937.31341-8-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 7/9] hw/timer: QOM'ify slavio_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au

On 04/29/2017 07:49 AM, xiaoqiang zhao wrote:
> rename slavio_timer_init1 to slavio_timer_init and assign
> it to slavio_timer_info.instance_init, then we drop the
> SysBusDeviceClass::init
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/timer/slavio_timer.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index bfee1f3027..a8cc9c0148 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -373,9 +373,10 @@ static void slavio_timer_reset(DeviceState *d)
>      s->cputimer_mode = 0;
>  }
>
> -static int slavio_timer_init1(SysBusDevice *dev)
> +static void slavio_timer_init(Object *obj)
>  {
> -    SLAVIO_TIMERState *s = SLAVIO_TIMER(dev);
> +    SLAVIO_TIMERState *s = SLAVIO_TIMER(obj);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>      QEMUBH *bh;
>      unsigned int i;
>      TimerContext *tc;
> @@ -394,14 +395,12 @@ static int slavio_timer_init1(SysBusDevice *dev)
>
>          size = i == 0 ? SYS_TIMER_SIZE : CPU_TIMER_SIZE;
>          snprintf(timer_name, sizeof(timer_name), "timer-%i", i);
> -        memory_region_init_io(&tc->iomem, OBJECT(s), &slavio_timer_mem_ops, tc,
> +        memory_region_init_io(&tc->iomem, obj, &slavio_timer_mem_ops, tc,
>                                timer_name, size);
>          sysbus_init_mmio(dev, &tc->iomem);
>
>          sysbus_init_irq(dev, &s->cputimer[i].irq);
>      }
> -
> -    return 0;
>  }
>
>  static Property slavio_timer_properties[] = {
> @@ -412,9 +411,7 @@ static Property slavio_timer_properties[] = {
>  static void slavio_timer_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = slavio_timer_init1;
>      dc->reset = slavio_timer_reset;
>      dc->vmsd = &vmstate_slavio_timer;
>      dc->props = slavio_timer_properties;
> @@ -424,6 +421,7 @@ static const TypeInfo slavio_timer_info = {
>      .name          = TYPE_SLAVIO_TIMER,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(SLAVIO_TIMERState),
> +    .instance_init = slavio_timer_init,
>      .class_init    = slavio_timer_class_init,
>  };
>
>
