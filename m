Received: from eggs.gnu.org ([2001:4830:134:3::10]:53862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQEN8-0004P0-1W
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQEN4-0004nb-RT
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:32:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQEN4-0004lH-L8
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:31:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id 125so12485772wmh.0
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:31:58 -0800 (PST)
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-3-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5b528c2a-c3f3-25f3-daec-c613049d5d3a@redhat.com>
Date: Fri, 23 Nov 2018 17:31:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181123153040.18933-3-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/21] block/noenand: Convert sysbus
 init function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>, qemu-block@nongnu.org, mreitz@redhat.com

On 23/11/18 16:30, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> onenand_class_init().
> 
> Cc: kwolf@redhat.com
> Cc: mreitz@redhat.com
> Cc: qemu-block@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/block/onenand.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/block/onenand.c b/hw/block/onenand.c
> index 2b48609776..f11118a687 100644
> --- a/hw/block/onenand.c
> +++ b/hw/block/onenand.c
> @@ -772,9 +772,9 @@ static const MemoryRegionOps onenand_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> -static int onenand_initfn(SysBusDevice *sbd)
> +static void onenand_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      OneNANDState *s = ONE_NAND(dev);
>      uint32_t size = 1 << (24 + ((s->id.dev >> 4) & 7));
>      void *ram;
> @@ -794,14 +794,14 @@ static int onenand_initfn(SysBusDevice *sbd)
>                            0xff, size + (size >> 5));
>      } else {
>          if (blk_is_read_only(s->blk)) {
> -            error_report("Can't use a read-only drive");
> -            return -1;
> +            error_setg(errp, "Can't use a read-only drive");
> +            return;
>          }
>          blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
>                       BLK_PERM_ALL, &local_err);
>          if (local_err) {
> -            error_report_err(local_err);
> -            return -1;
> +            error_propagate(errp, local_err);
> +            return;
>          }
>          s->blk_cur = s->blk;
>      }
> @@ -826,7 +826,6 @@ static int onenand_initfn(SysBusDevice *sbd)
>                       | ((s->id.dev & 0xff) << 8)
>                       | (s->id.ver & 0xff),
>                       &vmstate_onenand, s);
> -    return 0;
>  }
>  
>  static Property onenand_properties[] = {
> @@ -841,9 +840,8 @@ static Property onenand_properties[] = {
>  static void onenand_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = onenand_initfn;
> +    dc->realize = onenand_realize;
>      dc->reset = onenand_system_reset;
>      dc->props = onenand_properties;
>  }
> 
