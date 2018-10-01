Received: from eggs.gnu.org ([2001:4830:134:3::10]:45209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6t94-0007Re-BU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6t90-0007iA-Gf
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g6t8w-0007dD-Jy
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id j15-v6so12745788wrt.8
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 01:01:19 -0700 (PDT)
References: <20181001063803.22330-1-clg@kaod.org>
	<20181001063803.22330-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <61d7c915-0e76-888a-1500-6ed7d21a4980@redhat.com>
Date: Mon, 1 Oct 2018 10:01:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181001063803.22330-4-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/11] net: lan9118: convert SysBus init
 method to a realize method
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

On 10/1/18 8:37 AM, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/net/lan9118.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
> index b9032dac595f..a6269d9463b1 100644
> --- a/hw/net/lan9118.c
> +++ b/hw/net/lan9118.c
> @@ -1320,9 +1320,9 @@ static NetClientInfo net_lan9118_info = {
>      .link_status_changed = lan9118_set_link,
>  };
>  
> -static int lan9118_init1(SysBusDevice *sbd)
> +static void lan9118_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      lan9118_state *s = LAN9118(dev);
>      QEMUBH *bh;
>      int i;
> @@ -1349,8 +1349,6 @@ static int lan9118_init1(SysBusDevice *sbd)
>      s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
>      ptimer_set_freq(s->timer, 10000);
>      ptimer_set_limit(s->timer, 0xffff, 1);
> -
> -    return 0;
>  }
>  
>  static Property lan9118_properties[] = {
> @@ -1362,12 +1360,11 @@ static Property lan9118_properties[] = {
>  static void lan9118_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = lan9118_init1;
>      dc->reset = lan9118_reset;
>      dc->props = lan9118_properties;
>      dc->vmsd = &vmstate_lan9118;
> +    dc->realize = lan9118_realize;
>  }
>  
>  static const TypeInfo lan9118_info = {
> 
