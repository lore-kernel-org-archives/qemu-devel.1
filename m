Received: from eggs.gnu.org ([2001:4830:134:3::10]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7NN-0006aP-2b
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP7NM-0002zU-7Z
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:51:40 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP7NM-0002zE-2G
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:51:40 -0500
Received: by mail-oi1-x244.google.com with SMTP id u18so1669689oie.10
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:51:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181119120820.29878-15-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-15-maozhongyi@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:51:19 +0000
Message-ID: <CAFEAcA9puTQZfZEK3R+LKUa_zwoEe+KyH1GEok9wiS9fZq0+5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/22] nvram/ds1225y: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 19 November 2018 at 12:08, Mao Zhongyi
<maozhongyi@cmss.chinamobile.com> wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> nvram_sysbus_class_init().
>
> Cc: pbonzini@redhat.com
> Cc: marcandre.lureau@redhat.com
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> ---
>  hw/nvram/ds1225y.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
> index ad7345f288..b6ef463db0 100644
> --- a/hw/nvram/ds1225y.c
> +++ b/hw/nvram/ds1225y.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
>  #include "trace.h"
> +#include "qemu/error-report.h"
>
>  typedef struct {
>      MemoryRegion iomem;
> @@ -113,7 +114,7 @@ typedef struct {
>      NvRamState nvram;
>  } SysBusNvRamState;
>
> -static int nvram_sysbus_initfn(SysBusDevice *dev)
> +static void nvram_sysbus_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusNvRamState *sys = DS1225Y(dev);
>      NvRamState *s = &sys->nvram;
> @@ -123,20 +124,18 @@ static int nvram_sysbus_initfn(SysBusDevice *dev)
>
>      memory_region_init_io(&s->iomem, OBJECT(s), &nvram_ops, s,
>                            "nvram", s->chip_size);
> -    sysbus_init_mmio(dev, &s->iomem);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>
>      /* Read current file */
>      file = s->filename ? fopen(s->filename, "rb") : NULL;
>      if (file) {
>          /* Read nvram contents */
>          if (fread(s->contents, s->chip_size, 1, file) != 1) {
> -            printf("nvram_sysbus_initfn: short read\n");
> +            error_report("nvram_sysbus_realize: short read");

It seems a bit odd that we don't make this cause the
device to fail its realize method, though I suppose
it was not previously.

>          }
>          fclose(file);
>      }
>      nvram_post_load(s, 0);
> -
> -    return 0;
>  }
>
>  static Property nvram_sysbus_properties[] = {
> @@ -148,9 +147,8 @@ static Property nvram_sysbus_properties[] = {
>  static void nvram_sysbus_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = nvram_sysbus_initfn;
> +    dc->realize = nvram_sysbus_realize;
>      dc->vmsd = &vmstate_nvram;
>      dc->props = nvram_sysbus_properties;
>  }
> --
> 2.17.1
>

thanks
-- PMM
