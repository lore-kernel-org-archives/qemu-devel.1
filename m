Received: from eggs.gnu.org ([2001:4830:134:3::10]:45330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6t9I-0007Zi-LY
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6t9F-00083s-GU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g6t9F-00082b-8G
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so2188019wmt.2
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 01:01:45 -0700 (PDT)
References: <20181001063803.22330-1-clg@kaod.org>
	<20181001063803.22330-9-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc0c6ebd-f860-dd99-73b4-ad089ce259d5@redhat.com>
Date: Mon, 1 Oct 2018 10:01:43 +0200
MIME-Version: 1.0
In-Reply-To: <20181001063803.22330-9-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/11] net: smc91c111: convert SysBus
 init method to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/1/18 8:38 AM, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/net/smc91c111.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index d2fd2040e81c..99da2d92973e 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -766,9 +766,9 @@ static NetClientInfo net_smc91c111_info = {
>      .receive = smc91c111_receive,
>  };
>  
> -static int smc91c111_init1(SysBusDevice *sbd)
> +static void smc91c111_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      smc91c111_state *s = SMC91C111(dev);
>  
>      memory_region_init_io(&s->mmio, OBJECT(s), &smc91c111_mem_ops, s,
> @@ -780,7 +780,6 @@ static int smc91c111_init1(SysBusDevice *sbd)
>                            object_get_typename(OBJECT(dev)), dev->id, s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>      /* ??? Save/restore.  */
> -    return 0;
>  }
>  
>  static Property smc91c111_properties[] = {
> @@ -791,9 +790,8 @@ static Property smc91c111_properties[] = {
>  static void smc91c111_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = smc91c111_init1;
> +    dc->realize = smc91c111_realize;
>      dc->reset = smc91c111_reset;
>      dc->vmsd = &vmstate_smc91c111;
>      dc->props = smc91c111_properties;
> 
