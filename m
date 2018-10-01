Received: from eggs.gnu.org ([2001:4830:134:3::10]:45078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6t8q-0007Nx-Cd
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g6t8i-0007Y5-4s
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g6t8h-0007Ph-Q8
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:01:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so7682417wmq.4
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 01:01:00 -0700 (PDT)
References: <20181001063803.22330-1-clg@kaod.org>
	<20181001063803.22330-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <252a33d1-a924-41af-48bc-3072180b0dfa@redhat.com>
Date: Mon, 1 Oct 2018 10:00:58 +0200
MIME-Version: 1.0
In-Reply-To: <20181001063803.22330-3-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/11] net: etraxfs_eth: add a reset
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/1/18 8:37 AM, Cédric Le Goater wrote:
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/net/etraxfs_eth.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
> index 64ab3df1ae38..36855804dba0 100644
> --- a/hw/net/etraxfs_eth.c
> +++ b/hw/net/etraxfs_eth.c
> @@ -127,7 +127,7 @@ tdk_write(struct qemu_phy *phy, unsigned int req, unsigned int data)
>  }
>  
>  static void
> -tdk_init(struct qemu_phy *phy)
> +tdk_reset(struct qemu_phy *phy)
>  {
>      phy->regs[0] = 0x3100;
>      /* PHY Id.  */
> @@ -136,9 +136,6 @@ tdk_init(struct qemu_phy *phy)
>      /* Autonegotiation advertisement reg.  */
>      phy->regs[4] = 0x01E1;
>      phy->link = 1;
> -
> -    phy->read = tdk_read;
> -    phy->write = tdk_write;
>  }
>  
>  struct qemu_mdio
> @@ -585,6 +582,27 @@ static NetClientInfo net_etraxfs_info = {
>      .link_status_changed = eth_set_link,
>  };
>  
> +static void etraxfs_eth_reset(DeviceState *dev)
> +{
> +    ETRAXFSEthState *s = ETRAX_FS_ETH(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    memset(s->macaddr, 0, sizeof(s->macaddr));
> +    s->duplex_mismatch = 0;
> +
> +    s->mdio_bus.mdc = 0;
> +    s->mdio_bus.mdio = 0;
> +    s->mdio_bus.state = 0;
> +    s->mdio_bus.drive = 0;
> +    s->mdio_bus.cnt = 0;
> +    s->mdio_bus.addr = 0;
> +    s->mdio_bus.opc = 0;
> +    s->mdio_bus.req = 0;
> +    s->mdio_bus.data = 0;
> +
> +    tdk_reset(&s->phy);
> +}
> +
>  static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> @@ -609,8 +627,8 @@ static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
>                            object_get_typename(OBJECT(s)), dev->id, s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>  
> -
> -    tdk_init(&s->phy);
> +    s->phy.read = tdk_read;
> +    s->phy.write = tdk_write;
>      mdio_attach(&s->mdio_bus, &s->phy, s->phyaddr);
>  }
>  
> @@ -627,6 +645,7 @@ static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->realize = etraxfs_eth_realize;
> +    dc->reset = etraxfs_eth_reset;
>      dc->props = etraxfs_eth_properties;
>      /* Reason: pointer properties "dma_out", "dma_in" */
>      dc->user_creatable = false;
> 
