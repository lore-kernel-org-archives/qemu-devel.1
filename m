Received: from eggs.gnu.org ([2001:4830:134:3::10]:44214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6t5O-0006Si-F4
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 03:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6t5L-0005FU-AH
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 03:57:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g6t5K-00058Y-Sp
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 03:57:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id a13-v6so2039233wrt.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 00:57:34 -0700 (PDT)
References: <20181001063803.22330-1-clg@kaod.org>
	<20181001063803.22330-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <174bdeb4-bca2-fa61-f9e2-9ba793657133@redhat.com>
Date: Mon, 1 Oct 2018 09:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181001063803.22330-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/11] net: etraxfs_eth: convert SysBus
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On 10/1/18 8:37 AM, Cédric Le Goater wrote:
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/net/etraxfs_eth.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
> index a6932432b164..64ab3df1ae38 100644
> --- a/hw/net/etraxfs_eth.c
> +++ b/hw/net/etraxfs_eth.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "net/net.h"
>  #include "hw/cris/etraxfs.h"
> @@ -584,14 +585,14 @@ static NetClientInfo net_etraxfs_info = {
>      .link_status_changed = eth_set_link,
>  };
>  
> -static int fs_eth_init(SysBusDevice *sbd)
> +static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      ETRAXFSEthState *s = ETRAX_FS_ETH(dev);
>  
>      if (!s->dma_out || !s->dma_in) {
> -        error_report("Unconnected ETRAX-FS Ethernet MAC");
> -        return -1;
> +        error_setg(errp, "Unconnected ETRAX-FS Ethernet MAC");
> +        return;
>      }
>  
>      s->dma_out->client.push = eth_tx_push;
> @@ -611,7 +612,6 @@ static int fs_eth_init(SysBusDevice *sbd)
>  
>      tdk_init(&s->phy);
>      mdio_attach(&s->mdio_bus, &s->phy, s->phyaddr);
> -    return 0;
>  }
>  
>  static Property etraxfs_eth_properties[] = {
> @@ -625,9 +625,8 @@ static Property etraxfs_eth_properties[] = {
>  static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = fs_eth_init;
> +    dc->realize = etraxfs_eth_realize;
>      dc->props = etraxfs_eth_properties;
>      /* Reason: pointer properties "dma_out", "dma_in" */
>      dc->user_creatable = false;
> 
