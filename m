Received: from eggs.gnu.org ([2001:4830:134:3::10]:60912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4aqn-00036S-Kr
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4aqk-0007tb-HW
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:25 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4aqk-0007tS-Cs
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:28:22 -0400
Received: by mail-qk0-x241.google.com with SMTP id h123so181713qke.2
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 15:28:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
	<20170429104937.31341-2-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df941cad-595d-ecca-b4d0-c13d31321423@amsat.org>
Date: Sat, 29 Apr 2017 19:28:17 -0300
MIME-Version: 1.0
In-Reply-To: <20170429104937.31341-2-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/9] hw/misc: QOM'ify eccmemctl.c
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
> * Split the old SysBus init into an instance_init and a
>   DeviceClass::realize function
> * Drop the old SysBus init function and use instance_init
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/eccmemctl.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
> index a0071f3eae..bb7cc52b5e 100644
> --- a/hw/misc/eccmemctl.c
> +++ b/hw/misc/eccmemctl.c
> @@ -295,22 +295,29 @@ static void ecc_reset(DeviceState *d)
>      s->regs[ECC_ECR1] = 0;
>  }
>
> -static int ecc_init1(SysBusDevice *dev)
> +static void ecc_init(Object *obj)
>  {
> -    ECCState *s = ECC_MEMCTL(dev);
> +    ECCState *s = ECC_MEMCTL(obj);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>
>      sysbus_init_irq(dev, &s->irq);
> -    s->regs[0] = s->version;
> -    memory_region_init_io(&s->iomem, OBJECT(dev), &ecc_mem_ops, s, "ecc", ECC_SIZE);
> +
> +    memory_region_init_io(&s->iomem, obj, &ecc_mem_ops, s, "ecc", ECC_SIZE);
>      sysbus_init_mmio(dev, &s->iomem);
> +}
> +
> +static void ecc_realize(DeviceState *dev, Error **errp)
> +{
> +    ECCState *s = ECC_MEMCTL(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    s->regs[0] = s->version;
>
>      if (s->version == ECC_MCC) { // SS-600MP only
>          memory_region_init_io(&s->iomem_diag, OBJECT(dev), &ecc_diag_mem_ops, s,
>                                "ecc.diag", ECC_DIAG_SIZE);
> -        sysbus_init_mmio(dev, &s->iomem_diag);
> +        sysbus_init_mmio(sbd, &s->iomem_diag);
>      }
> -
> -    return 0;
>  }
>
>  static Property ecc_properties[] = {
> @@ -321,9 +328,8 @@ static Property ecc_properties[] = {
>  static void ecc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = ecc_init1;
> +    dc->realize = ecc_realize;
>      dc->reset = ecc_reset;
>      dc->vmsd = &vmstate_ecc;
>      dc->props = ecc_properties;
> @@ -333,6 +339,7 @@ static const TypeInfo ecc_info = {
>      .name          = TYPE_ECC_MEMCTL,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(ECCState),
> +    .instance_init = ecc_init,
>      .class_init    = ecc_class_init,
>  };
>
>
