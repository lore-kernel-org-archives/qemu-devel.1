Received: from eggs.gnu.org ([2001:4830:134:3::10]:33369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cORHn-00071m-IV
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cORHk-0002TL-CB
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:46:03 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1cORHk-0002TC-3n
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:46:00 -0500
Received: by mail-lf0-x244.google.com with SMTP id x140so28422950lfa.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 07:45:58 -0800 (PST)
Date: Tue, 3 Jan 2017 16:45:55 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170103154555.GU9606@toto>
References: <20161023070653.1665-1-zxq_yx_007@163.com>
	<20161023070653.1665-3-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161023070653.1665-3-zxq_yx_007@163.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/net: QOM'ify etraxfs_eth.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>
Cc: qemu-devel@nongnu.org

On Sun, Oct 23, 2016 at 03:06:53PM +0800, xiaoqiang zhao wrote:
> * Split the old SysBus init into an instance_init and a
>   DeviceClass::realize function
> * Drop the old SysBus init function and use instance_init

some of tdk_init should probably go into a reset function but
I think that should be done in a separate patch so:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---
>  hw/net/etraxfs_eth.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
> index efaa49f..9bb814f 100644
> --- a/hw/net/etraxfs_eth.c
> +++ b/hw/net/etraxfs_eth.c
> @@ -27,6 +27,7 @@
>  #include "net/net.h"
>  #include "hw/cris/etraxfs.h"
>  #include "qemu/error-report.h"
> +#include "qapi/error.h"
>  
>  #define D(x)
>  
> @@ -584,14 +585,25 @@ static NetClientInfo net_etraxfs_info = {
>      .link_status_changed = eth_set_link,
>  };
>  
> -static int fs_eth_init(SysBusDevice *sbd)
> +static void fs_eth_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    ETRAXFSEthState *s = ETRAX_FS_ETH(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &eth_ops, s,
> +                          "etraxfs-eth", 0x5c);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    tdk_init(&s->phy);
> +}
> +
> +static void fs_eth_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev = DEVICE(sbd);
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
> @@ -599,19 +611,11 @@ static int fs_eth_init(SysBusDevice *sbd)
>      s->dma_in->client.opaque = s;
>      s->dma_in->client.pull = NULL;
>  
> -    memory_region_init_io(&s->mmio, OBJECT(dev), &eth_ops, s,
> -                          "etraxfs-eth", 0x5c);
> -    sysbus_init_mmio(sbd, &s->mmio);
> -
>      qemu_macaddr_default_if_unset(&s->conf.macaddr);
>      s->nic = qemu_new_nic(&net_etraxfs_info, &s->conf,
> -                          object_get_typename(OBJECT(s)), dev->id, s);
> +                          object_get_typename(OBJECT(dev)), dev->id, s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> -
> -
> -    tdk_init(&s->phy);
>      mdio_attach(&s->mdio_bus, &s->phy, s->phyaddr);
> -    return 0;
>  }
>  
>  static Property etraxfs_eth_properties[] = {
> @@ -625,18 +629,18 @@ static Property etraxfs_eth_properties[] = {
>  static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = fs_eth_init;
>      dc->props = etraxfs_eth_properties;
>      /* Reason: pointer properties "dma_out", "dma_in" */
>      dc->cannot_instantiate_with_device_add_yet = true;
> +    dc->realize = fs_eth_realize;
>  }
>  
>  static const TypeInfo etraxfs_eth_info = {
>      .name          = TYPE_ETRAX_FS_ETH,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(ETRAXFSEthState),
> +    .instance_init = fs_eth_init,
>      .class_init    = etraxfs_eth_class_init,
>  };
>  
> -- 
> 2.9.3
> 
> 
